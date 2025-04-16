#!/usr/bin/env node
/**
 * Build script for /tg/station 13 codebase.
 *
 * This script uses Juke Build, read the docs here:
 * https://github.com/stylemistake/juke-build
 */

import fs from "fs";
import Juke from "./juke/index.js";
import { DreamDaemon, DreamMaker } from "./lib/byond.js";
import { yarn } from "./lib/yarn.js";

Juke.chdir("../..", import.meta.url);
Juke.setup({ file: import.meta.url }).then((code) => {
  // We're using the currently available quirk in Juke Build, which
  // prevents it from exiting on Windows, to wait on errors.
  if (code !== 0 && process.argv.includes("--wait-on-error")) {
    Juke.logger.error("Please inspect the error and close the window.");
    return;
  }
  process.exit(code);
});

const DME_NAME = "vanderlin";

export const DefineParameter = new Juke.Parameter({
  type: "string[]",
  alias: "D",
});

export const PortParameter = new Juke.Parameter({
  type: "string",
  alias: "p",
});

export const CiParameter = new Juke.Parameter({ type: "boolean" });

export const WarningParameter = new Juke.Parameter({
  type: "string[]",
  alias: "W",
});

export const DmMapsIncludeTarget = new Juke.Target({
  executes: async () => {
    const folders = [
      ...Juke.glob("_maps/RandomRuins/**/*.dmm"),
      ...Juke.glob("_maps/RandomZLevels/**/*.dmm"),
      ...Juke.glob("_maps/shuttles/**/*.dmm"),
      ...Juke.glob("_maps/templates/**/*.dmm"),
    ];
    const content =
      folders
        .map((file) => file.replace("maps/", ""))
        .map((file) => `#include "${file}"`)
        .join("\n") + "\n";
    fs.writeFileSync("_maps/templates.dm", content);
  },
});

export const DmTarget = new Juke.Target({
  parameters: [DefineParameter],
  dependsOn: ({ get }) => [
    get(DefineParameter).includes("ALL_MAPS"), // && DmMapsIncludeTarget
  ],
  inputs: [
    "maps/**",
    "code/**",
    "goon/**",
    "html/**",
    "icons/**",
    "interface/**",
    `${DME_NAME}.dme`,
  ],
  outputs: [`${DME_NAME}.dmb`, `${DME_NAME}.rsc`],
  executes: async ({ get }) => {
    await DreamMaker(`${DME_NAME}.dme`, {
      defines: ["CBT", ...get(DefineParameter)],
      warningsAsErrors: get(WarningParameter).includes("error"),
    });
  },
});

export const DmTestTarget = new Juke.Target({
  parameters: [DefineParameter],
  dependsOn: ({ get }) => [
    get(DefineParameter).includes("ALL_MAPS"), // && DmMapsIncludeTarget
  ],
  executes: async ({ get }) => {
    fs.copyFileSync(`${DME_NAME}.dme`, `${DME_NAME}.test.dme`);
    await DreamMaker(`${DME_NAME}.test.dme`, {
      defines: ["CBT", "CIBUILDING", ...get(DefineParameter)],
      warningsAsErrors: get(WarningParameter).includes("error"),
    });
    Juke.rm("data/logs/ci", { recursive: true });
    await DreamDaemon(
      `${DME_NAME}.test.dmb`,
      "-close",
      "-trusted",
      "-verbose",
      "-params",
      "log-directory=ci"
    );
    Juke.rm("*.test.*");
    try {
      const cleanRun = fs.readFileSync("data/logs/ci/clean_run.lk", "utf-8");
      console.log(cleanRun);
    } catch (err) {
      Juke.logger.error("Test run was not clean, exiting");
      throw new Juke.ExitCode(1);
    }
  },
});


export const TestTarget = new Juke.Target({
  dependsOn: [DmTestTarget],
});


export const BuildTarget = new Juke.Target({
  dependsOn: [DmTarget],
});

export const ServerTarget = new Juke.Target({
  dependsOn: [BuildTarget],
  executes: async ({ get }) => {
    const port = get(PortParameter) || "1337";
    await DreamDaemon(`${DME_NAME}.dmb`, port, "-trusted");
  },
});

export const AllTarget = new Juke.Target({
  dependsOn: [TestTarget, BuildTarget],
});

export const CleanTarget = new Juke.Target({
  executes: async () => {
    Juke.rm("*.{dmb,rsc}");
    Juke.rm("*.mdme*");
    Juke.rm("*.m.*");
    Juke.rm("_maps/templates.dm");
  },
});

/**
 * Removes more junk at the expense of much slower initial builds.
 */
export const CleanAllTarget = new Juke.Target({
  dependsOn: [CleanTarget],
  executes: async () => {
    Juke.logger.info("Cleaning up data/logs");
    Juke.rm("data/logs", { recursive: true });
    Juke.logger.info("Cleaning up global yarn cache");
    await yarn("cache", "clean", "--all");
  },
});

/**
 * Prepends the defines to the .dme.
 * Does not clean them up, as this is intended for TGS which
 * clones new copies anyway.
 */
const prependDefines = (...defines) => {
  const dmeContents = fs.readFileSync(`${DME_NAME}.dme`);
  const textToWrite = defines.map((define) => `#define ${define}\n`);
  fs.writeFileSync(`${DME_NAME}.dme`, `${textToWrite}\n${dmeContents}`);
};

export const TgsTarget = new Juke.Target({
  executes: async () => {
    Juke.logger.info("Prepending TGS define");
    prependDefines("TGS");
  },
});

const TGS_MODE = process.env.CBT_BUILD_MODE === "TGS";

export default TGS_MODE ? TgsTarget : BuildTarget;
