/obj/effect/landmark/mapGenerator/rosewood/field
	mapGeneratorType = /datum/mapGenerator/rosewoodfields
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/rosewoodfields
	modules = list(/datum/mapGeneratorModule/ambushing,
				/datum/mapGeneratorModule/rosewooddirt,
				/datum/mapGeneratorModule/rosewooddirt/grass,
				/datum/mapGeneratorModule/rosewooddirt/road,
				/datum/mapGeneratorModule/rosewoodgrass,
				/datum/mapGeneratorModule/rosewoodgrass/grass,
				/datum/mapGeneratorModule/rosewoodsnow,
				/datum/mapGeneratorModule/rosewoodsnow/grass)

/datum/mapGeneratorModule/rosewooddirt
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	clusterMax = 4
	clusterMin = 1
	allowed_turfs = list(/turf/open/floor/dirt)
	excluded_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/grass/bush/tundra = 3,
							/obj/structure/flora/grass/bush_meagre/tundra = 12,
							/obj/structure/flora/grass/bush/wall/tall/tundra = 0.25,
							/obj/structure/flora/grass/herb/random = 1,
							/obj/structure/flora/grass/maneater = 1,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							/obj/item/natural/stone = 8,
							/obj/item/natural/rock = 7,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/closet/dirthole/closed/loot=0.75,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage=0.5)
	spawnableTurfs = list(/turf/open/floor/dirt/road=5)
	allowed_areas = list(/area/rogue/outdoors/rtfield)

/datum/mapGeneratorModule/rosewooddirt/grass
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/dirt)
	excluded_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/grass = 15)
	allowed_areas = list(/area/rogue/outdoors/rtfield,
							/area/rogue/outdoors/rtfield/safe,
							/area/rogue/outdoors/town)

/datum/mapGeneratorModule/rosewooddirt/road
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/dirt/road)
	excluded_turfs = list()
	spawnableAtoms = list(/obj/structure/flora/grass = 5,
							/obj/item/natural/stone = 8,
							/obj/item/natural/rock = 1,
							/obj/item/grown/log/tree/stick = 3)
	allowed_areas = list(/area/rogue/outdoors/rtfield,
							/area/rogue/outdoors/rtfield/safe,
							/area/rogue/outdoors/town)

/datum/mapGeneratorModule/rosewoodgrass
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	clusterMax = 4
	clusterMin = 1
	allowed_turfs = list(/turf/open/floor/grass/cold)
	excluded_turfs = list()
	spawnableAtoms = list(/obj/structure/flora/grass/bush/tundra = 3,
							/obj/structure/flora/grass/bush_meagre/tundra = 12,
							/obj/structure/flora/grass/bush/wall/tall/tundra = 0.25,
							/obj/structure/flora/grass/herb/random = 1,
							/obj/structure/flora/grass/maneater = 1,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							/obj/item/natural/stone = 3,
							/obj/item/natural/rock = 1,
							/obj/item/grown/log/tree/stick = 8)
	spawnableTurfs = list(/turf/open/floor/snowpatchy)
	allowed_areas = list(/area/rogue/outdoors/rtfield,
							/area/rogue/outdoors/rtfield/safe)

/datum/mapGeneratorModule/rosewoodgrass/grass
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/grass/cold)
	excluded_turfs = list()
	spawnableAtoms = list(/obj/structure/flora/grass = 50)
	spawnableTurfs = list()
	allowed_areas = list(/area/rogue/outdoors/rtfield,
							/area/rogue/outdoors/rtfield/safe,
							/area/rogue/outdoors/town)

/datum/mapGeneratorModule/rosewoodsnow
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	clusterMax = 5
	clusterMin = 1
	allowed_turfs = list(/turf/open/floor/snow,
						/turf/open/floor/snow/rough)
	excluded_turfs = list(/turf/open/floor/snow/patchy)
	spawnableAtoms = list(/obj/structure/flora/grass/bush/tundra = 3,
							/obj/structure/flora/grass/bush_meagre/tundra = 12,
							/obj/structure/flora/grass/bush/wall/tall/tundra = 0.25,
							/obj/structure/flora/grass/herb/random = 1,
							/obj/structure/flora/grass/maneater = 1,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							/obj/item/natural/rock = 2,
							/obj/item/grown/log/tree/stick = 6)
	spawnableTurfs = list(/turf/open/floor/snow/rough = 10,
							/turf/open/floor/snow/patchy = 5)
	allowed_areas = list(/area/rogue/outdoors/rtfield,
							/area/rogue/outdoors/rtfield/safe)

/datum/mapGeneratorModule/rosewoodsnow/grass
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/snow/patchy)
	excluded_turfs = list()
	spawnableAtoms = list(/obj/structure/flora/grass = 20)
	spawnableTurfs = list()
	allowed_areas = list(/area/rogue/outdoors/rtfield,
							/area/rogue/outdoors/rtfield/safe,
							/area/rogue/outdoors/town)
