// ===================================================================================
/*	..................  StoneHamlet Fields Mapgen  ................... */
/obj/effect/landmark/mapGenerator/stonefields
	mapGeneratorType = /datum/mapGenerator/stonefields
	endTurfX = 250
	endTurfY = 250
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/stonefields
	modules = list(/datum/mapGeneratorModule/ambushing/stonefields,/datum/mapGeneratorModule/stonefields, /datum/mapGeneratorModule/stonefieldsdirt)

/datum/mapGeneratorModule/stonefields
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/tree/neu/bush = 1,
							/obj/structure/flora/grass/bush_meagre = 2,
							/obj/structure/flora/grass/herb/random = 2,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/structure/flora/grass = 10,
							/obj/structure/table/wood/treestump = 1,
							/obj/item/natural/rock = 1,
							/obj/item/natural/stone = 4,
							/obj/item/grown/log/tree/stick = 2,
							)
	spawnableTurfs = list(/turf/open/floor/dirt = 2)
	allowed_areas = list(/area/rogue/outdoors/rtfield/hamlet)
	excluded_turfs = list(/turf/open/floor/dirt/road)

/datum/mapGeneratorModule/stonefieldsdirt
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/rock/pebbles/bogmix = 3,
						/obj/structure/flora/rock/pebbles/brown = 1)
	spawnableTurfs = list(/turf/open/floor/grass = 2)
	allowed_turfs = list(/turf/open/floor/dirt)
	allowed_areas = list(/area/rogue/outdoors/rtfield/hamlet)

/datum/mapGeneratorModule/ambushing/stonefields
	spawnableAtoms = list(/obj/effect/landmark/ambush=100)
	allowed_turfs = list(/turf/open/floor/dirt)
	allowed_areas = list(/area/rogue/outdoors/rtfield/hamlet)
	excluded_turfs = list(/turf/open/floor/dirt/road)

// ===================================================================================
/*	..................  StoneHamlet Bog Mapgen  ................... */
/obj/effect/landmark/mapGenerator/stonebog
	mapGeneratorType = /datum/mapGenerator/stonebog
	endTurfX = 250
	endTurfY = 250
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/stonebog
	modules = list(/datum/mapGeneratorModule/ambushing/stonebog,/datum/mapGeneratorModule/stonebog, /datum/mapGeneratorModule/stonebogwater, /datum/mapGeneratorModule/stonebogwaterdeep, /datum/mapGeneratorModule/stonebogdirt)

/datum/mapGeneratorModule/stonebog
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 7,
							/obj/structure/flora/grass/bush_meagre/bog = 4,
							/obj/structure/flora/grass/maneater = 1,
							/obj/structure/flora/grass/herb/random = 20,
							/obj/structure/flora/grass = 23,
							/obj/structure/chair/bench/ancientlog = 10,
							/obj/item/natural/rock = 10,
							/obj/item/natural/stone = 15,
							/obj/structure/flora/grass/swampweed = 10,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/grass/maneater/real = 2,
							/obj/structure/innocent_bush = 1,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							)
	spawnableTurfs = list(/turf/open/water/swamp = 2)
	allowed_areas = list(/area/rogue/outdoors/bog)

/datum/mapGeneratorModule/stonebogwater
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/grass/water = 5,
						/obj/structure/flora/grass/water/reeds = 20,
						/obj/structure/flora/rogueflower/reedbush = 5,
						/obj/structure/kneestingers = 30)
	allowed_turfs = list(/turf/open/water/swamp)
	allowed_areas = list(/area/rogue/outdoors/bog)

/datum/mapGeneratorModule/stonebogwaterdeep
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/rogueflower/reedbush = 5)
	allowed_turfs = list(/turf/open/water/swamp/deep)
	allowed_areas = list(/area/rogue/outdoors/bog)

/datum/mapGeneratorModule/stonebogdirt
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/rock/pebbles/bogmix = 3,
						/obj/structure/flora/rock/pebbles/brown = 1)
	allowed_turfs = list(/turf/open/floor/dirt)
	allowed_areas = list(/area/rogue/outdoors/bog)

/datum/mapGeneratorModule/ambushing/stonebog
	spawnableAtoms = list(/obj/effect/landmark/ambush=100)
	allowed_areas = list(/area/rogue/outdoors/bog)
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/water/swamp)

// ===================================================================================
/*	..................  StoneHamlet Forest Mapgen  ................... */
/obj/effect/landmark/mapGenerator/stoneforest
	mapGeneratorType = /datum/mapGenerator/stoneforest
	endTurfX = 250
	endTurfY = 250
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/stoneforest
	modules = list(/datum/mapGeneratorModule/ambushing/stoneforest,/datum/mapGeneratorModule/stoneforest_undertree,/datum/mapGeneratorModule/stoneforestgrassturf,/datum/mapGeneratorModule/stoneforest,/datum/mapGeneratorModule/stoneforestgrassyel ,/datum/mapGeneratorModule/stoneforestroad,/datum/mapGeneratorModule/stoneforestgrass,/datum/mapGeneratorModule/stoneforestwaterturf)

/datum/mapGeneratorModule/stoneforest
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt)
	excluded_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 5,
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass/thorn_bush = 2,
							/obj/structure/flora/grass = 80,
							/obj/item/natural/stone = 5,
							/obj/item/natural/rock = 6,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/chair/bench/ancientlog = 2,
							/obj/structure/table/wood/treestump = 2,
							/obj/structure/closet/dirthole/closed/loot=3,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage=0.1)
	spawnableTurfs = list(/turf/open/floor/dirt/road=10)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/stoneforestroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 3,/obj/item/grown/log/tree/stick = 2)

/datum/mapGeneratorModule/stoneforestgrassturf
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/dirt)
	excluded_turfs = list(/turf/open/floor/dirt/road)
	spawnableTurfs = list(/turf/open/floor/grass = 10)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/stoneforest_undertree
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass/mixyel/under_tree)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/innocent_web = 10,
							/obj/structure/flora/rogueflower/random = 2,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/rogueflower/fallenleaves = 20)

/datum/mapGeneratorModule/stoneforestgrass
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass)
	excluded_turfs = list(/turf/open/floor/grass/mixyel)
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 4,
							/obj/structure/flora/grass = 65,
							/obj/structure/flora/grass/herb/random = 1,
							/obj/structure/flora/rogueflower/random = 2,
							/obj/item/natural/stone = 3,
							/obj/item/natural/rock = 1,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 3)

/datum/mapGeneratorModule/stoneforestgrassyel
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass/mixyel)
	excluded_turfs = list(/turf/open/floor/grass/mixyel/under_tree)
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 3,
							/obj/structure/flora/grass = 60,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/item/natural/stone = 4,
							/obj/item/natural/rock = 2,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 3)

/datum/mapGeneratorModule/stoneforestwaterturf
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/water/cleanshallow)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/grass/water = 20)

/datum/mapGeneratorModule/ambushing/stoneforest
	spawnableAtoms = list(/obj/effect/landmark/ambush=100)
	allowed_areas = list(/area/rogue/outdoors/woods)
	allowed_turfs = list(/turf/open/floor/grass)

// ===================================================================================
/*	..................  Hollow Mountain Mapgen  ................... */
/obj/effect/landmark/mapGenerator/hollow_mountain
	mapGeneratorType = /datum/mapGenerator/hollow_mountain
	endTurfX = 250
	endTurfY = 250
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/hollow_mountain
	modules = list(/datum/mapGeneratorModule/ambushing/hollow,/datum/mapGeneratorModule/hollow_naturalstone,/datum/mapGeneratorModule/hollow_muddie )

/datum/mapGeneratorModule/hollow_naturalstone
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/naturalstone)
	spawnableAtoms = list(	/obj/item/natural/rock = 8,
							/obj/item/natural/rock/random = 2,
							/obj/item/natural/stone = 10,
							/obj/structure/flora/rock/pebbles/bogmix = 2,
							/obj/structure/flora/rock/pebbles = 2
							)
	spawnableTurfs = list(/turf/open/floor/dirt/muddie = 2, /turf/open/floor/naturalstone/rough = 3)
	allowed_areas = list(/area/rogue/under/cave/hollow)

/datum/mapGeneratorModule/hollow_muddie
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt/muddie)
	spawnableAtoms = list(/obj/structure/flora/grass/water = 12,
						/obj/structure/kneestingers = 1,
						/obj/structure/flora/grass/maneater = 1,
						/obj/structure/flora/grass/maneater/real = 1
						)
	spawnableTurfs = list(/turf/open/water/swamp = 2)
	allowed_areas = list(/area/rogue/under/cave/hollow)

/datum/mapGeneratorModule/ambushing/hollow
	allowed_areas = list(/area/rogue/under/cave/hollow)
	allowed_turfs = list(/turf/open/floor/dirt/muddie, /turf/open/floor/naturalstone/rough)


// ===================================================================================
/*	..................  Bushwackers Mapgen  ................... */
/obj/effect/landmark/mapGenerator/bushwackers
	mapGeneratorType = /datum/mapGenerator/bushwhackers
	endTurfX = 250
	endTurfY = 250
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/bushwhackers
	modules = list(/datum/mapGeneratorModule/ambushing/bushwhackers,/datum/mapGeneratorModule/bushwhackers)

/datum/mapGeneratorModule/bushwhackers
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)
	spawnableAtoms = list(	/obj/structure/flora/grass/thorn_bush = 20,
							/obj/item/natural/stone = 2,
							/obj/structure/flora/rock/pebbles/bogmix = 2,
							/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 3,
							/obj/structure/flora/grass = 20,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 1
							)
	spawnableTurfs = list(/turf/open/floor/dirt/muddie = 2, /turf/open/floor/dirt = 3)
	allowed_areas = list(/area/rogue/outdoors/rtfield/outlaw)

/datum/mapGeneratorModule/ambushing/bushwhackers
	spawnableAtoms = list(/obj/effect/landmark/ambush=100)
	allowed_areas = list(/area/rogue/outdoors/rtfield/outlaw)
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)


/*	..................  Mount Decapitation Mapgen  ................... */
/obj/effect/landmark/mapGenerator/stonemountain
	mapGeneratorType = /datum/mapGenerator/stonemountain
	endTurfX = 250
	endTurfY = 250
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/stonemountain
	modules = list(/datum/mapGeneratorModule/ambushing/stonemountain,/datum/mapGeneratorModule/snowpatchy,/datum/mapGeneratorModule/snowfull)

/datum/mapGeneratorModule/snowpatchy
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/snow/patchy)
	spawnableAtoms = list(
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass/thorn_bush = 2,
							/obj/structure/flora/grass/herb/salvia = 10,
							/obj/item/natural/stone = 4,
							/obj/item/natural/rock = 3,
							/obj/structure/flora/grass/pyroclasticflowers = 10,
							)
	spawnableTurfs = list(/turf/open/floor/snow = 2)
	allowed_areas = list(/area/rogue/outdoors/mountains/decap)

/datum/mapGeneratorModule/snowfull
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/snow)
	spawnableAtoms = list(
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass/thorn_bush = 2,
							/obj/structure/flora/grass/herb/salvia = 10,
							/obj/item/natural/rock = 3,
							/obj/structure/flora/grass/pyroclasticflowers = 10,
							)
	spawnableTurfs = list(/turf/open/floor/snow = 2)
	allowed_areas = list(/area/rogue/outdoors/mountains/decap)
	excluded_turfs = list(/turf/open/floor/snow/patchy)


/datum/mapGeneratorModule/ambushing/stonemountain
	spawnableAtoms = list(/obj/effect/landmark/ambush=100)
	allowed_areas = list(/area/rogue/outdoors/mountains/decap)
	allowed_turfs = list(/turf/open/floor/snow)
