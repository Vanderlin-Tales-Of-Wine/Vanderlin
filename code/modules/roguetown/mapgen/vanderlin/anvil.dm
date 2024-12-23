//genstuff
/obj/effect/landmark/mapGenerator/rogue/anvil
	mapGeneratorType = /datum/mapGenerator/anvil
	endTurfX = 255
	endTurfY = 255
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/anvil
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/abovemountain,/datum/mapGeneratorModule/undermountain,/datum/mapGeneratorModule/grove)


/datum/mapGeneratorModule/abovemountain
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	include_subtypes = FALSE
	allowed_turfs = list(/turf/open/floor/rogue/snow,/turf/open/floor/rogue/grass/cold,/turf/open/floor/rogue/snow/patchy)
	spawnableAtoms = list(/obj/structure/flora/roguegrass/bush_meagre = 25,
						/obj/structure/flora/roguegrass = 25,
						/obj/structure/flora/roguegrass/herb/random = 2,
						/obj/item/natural/stone = 10,
						/obj/item/natural/rock = 5,
						/obj/item/grown/log/tree/stick = 10,
						/obj/structure/flora/roguegrass/pyroclasticflowers = 20)
	allowed_areas = list(/area/rogue/outdoors/mountains/anvil/snowyforest)

/datum/mapGeneratorModule/undermountain
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt,/turf/open/floor/rogue/cobblerock, /turf/open/floor/rogue/naturalstone)
	spawnableAtoms = list(/obj/item/natural/stone = 15,
						/obj/item/natural/rock = 10,
						/obj/item/natural/rock/random_ore = 5,
						/obj/structure/flora/rogueshroom = 5,
						/obj/item/restraints/legcuffs/beartrap/armed = 2)
	allowed_areas = list(/area/rogue/under/mountains/anvil/lower)

/datum/mapGeneratorModule/grove
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt,/turf/open/floor/rogue/dirt/road, /turf/open/floor/rogue/grass)
	spawnableAtoms = list(/obj/item/natural/stone = 3,
						/obj/structure/flora/roguegrass = 25,
						/obj/structure/flora/roguegrass/herb/random = 2,
						/obj/structure/flora/roguegrass/bush = 4,
						/obj/item/grown/log/tree/stick = 10)
	allowed_areas = list(/area/rogue/outdoors/mountains/anvil/grove)
