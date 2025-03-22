// ===================================================================================
/*	..................  StoneHamlet Fields Mapgen   (including Plague District & Outlaw Encampment) ................... */
/obj/effect/landmark/mapGenerator/stonefields
	mapGeneratorType = /datum/mapGenerator/stonefields
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/stonefields
	modules = list(/datum/mapGeneratorModule/ambushing/stonehamlet,/datum/mapGeneratorModule/stonefields, /datum/mapGeneratorModule/stonefieldsdirt, /datum/mapGeneratorModule/plaguedistrict,/datum/mapGeneratorModule/outlawcamp)

/datum/mapGeneratorModule/stonefields
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/tree/neu/bush = 1,
							/obj/structure/flora/grass/bush_meagre = 1,
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

/datum/mapGeneratorModule/plaguedistrict
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)
	spawnableAtoms = list(	/obj/structure/flora/grass = 14,
							/obj/structure/flora/grass/thorn_bush = 3,
							/obj/item/natural/stone = 1,
							/obj/structure/fluff/clodpile = 1,
							/obj/structure/flora/tree/neu/bush = 2,
							/obj/structure/flora/grass/bush_meagre = 1,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/structure/closet/dirthole = 1,
							/obj/item/grown/log/tree/stick = 1,
							/obj/item/reagent_containers/food/snacks/smallrat = 0.2,
							/obj/item/reagent_containers/food/snacks/rotten/meat = 0.1,
							/obj/structure/closet/dirthole/grave = 0.1,
							/obj/structure/closet/dirthole/closed = 0.1,
							/obj/structure/closet/dirthole/closed/loot = 0.1,
							)
	spawnableTurfs = list(/turf/open/floor/dirt/muddie = 1, /turf/open/floor/grass = 10)
	allowed_areas = list(/area/rogue/outdoors/rtfield/plague_district)

/datum/mapGeneratorModule/outlawcamp
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)
	spawnableAtoms = list(	/obj/structure/flora/grass = 14,
							/obj/structure/flora/grass/thorn_bush = 6,
							/obj/item/natural/stone = 1,
							/obj/structure/flora/tree/neu/bush = 2,
							/obj/structure/flora/grass/bush_meagre = 1,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/tree = 1,
							/obj/structure/flora/rock/pebbles/bogmix = 2,
							/obj/structure/chair/bench/ancientlog = 1,
							/obj/item/restraints/legcuffs/beartrap/armed = 0.1
							)
	spawnableTurfs = list(/turf/open/floor/dirt/muddie = 1, /turf/open/floor/grass = 10)
	allowed_areas = list(/area/rogue/outdoors/rtfield/outlaw)

/datum/mapGeneratorModule/ambushing/stonehamlet
	spawnableAtoms = list(/obj/effect/landmark/ambush=10)
	allowed_turfs = list(/turf/open/floor/dirt)
	allowed_areas = list(/area/rogue/outdoors/rtfield/hamlet,/area/rogue/outdoors/rtfield/plague_district, /area/rogue/outdoors/rtfield/outlaw)
	excluded_turfs = list(/turf/open/floor/dirt/road)

// ===================================================================================
/*	..................  StoneHamlet Wetlands Mapgen  ................... */
/obj/effect/landmark/mapGenerator/wetlands
	mapGeneratorType = /datum/mapGenerator/wetlands
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/wetlands
	modules = list(/datum/mapGeneratorModule/ambushing/wetlands,/datum/mapGeneratorModule/wetlands, /datum/mapGeneratorModule/wetwater, /datum/mapGeneratorModule/wetwaterdeep, /datum/mapGeneratorModule/wetgrass,/datum/mapGeneratorModule/wetdirt,/datum/mapGeneratorModule/wetlandsred)

/datum/mapGeneratorModule/wetlands
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass)
	spawnableAtoms = list(
							/obj/structure/flora/grass/herb/random = 0.5,
							/obj/item/natural/stone = 1,
							/obj/structure/flora/grass/swampweed = 0.2,
							/obj/structure/flora/rock/pebbles/bogmix = 4,
							)
	spawnableTurfs = list(/turf/open/floor/dirt/muddie = 2)
	allowed_areas = list(/area/rogue/outdoors/bog/wetlands)
	excluded_turfs = list(/turf/open/floor/dirt/road)

/datum/mapGeneratorModule/wetwater
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/grass/water = 4,
						/obj/structure/flora/grass/water/reeds = 2,
						/obj/structure/flora/rogueflower/reedbush = 2,
						/obj/structure/kneestingers = 2)
	allowed_turfs = list(/turf/open/water/swamp)
	allowed_areas = list(/area/rogue/outdoors/bog/wetlands, /area/rogue/outdoors/bog/wetlands/gator)

/datum/mapGeneratorModule/wetwaterdeep
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/grass/water = 8, /obj/structure/flora/rogueflower/reedbush = 3)
	allowed_turfs = list(/turf/open/floor/dirt/muddie)
	allowed_areas = list(/area/rogue/outdoors/bog/wetlands, /area/rogue/outdoors/bog/wetlands/gator)

/datum/mapGeneratorModule/wetlandsred
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/grass/bush_meagre/bog = 3,
						/obj/structure/innocent_bush = 1)
	allowed_turfs = list(/turf/open/floor/grass/red)
	allowed_areas = list(/area/rogue/outdoors/bog/wetlands)

/datum/mapGeneratorModule/wetgrass
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 2,
							/obj/structure/flora/grass/maneater = 1,
							/obj/structure/flora/grass/herb/random = 4,
							/obj/structure/flora/grass = 2,
							/obj/structure/flora/grass/swampweed = 1,
							/obj/item/grown/log/tree/stick = 1,
							/obj/structure/flora/grass/maneater/real = 1,
							)
	allowed_turfs = list(/turf/open/floor/grass)
	spawnableTurfs = list(/turf/open/floor/dirt = 2)
	allowed_areas = list(/area/rogue/outdoors/bog/wetlands)


/datum/mapGeneratorModule/wetdirt
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/rock/pebbles/bogmix = 6,
						/obj/structure/flora/rock/pebbles/brown = 1,
						/obj/item/reagent_containers/food/snacks/fogdart = 2)
	allowed_turfs = list(/turf/open/floor/dirt)
	allowed_areas = list(/area/rogue/outdoors/bog/wetlands)
	excluded_turfs = list(/turf/open/floor/dirt/road)

/datum/mapGeneratorModule/ambushing/wetlands
	spawnableAtoms = list(/obj/effect/landmark/ambush=8)
	allowed_areas = list(/area/rogue/outdoors/bog/wetlands)
	allowed_turfs = list(/turf/open/floor/dirt, /turf/open/floor/grass, /turf/open/water/swamp)

// ===================================================================================
/*	..................  StoneHamlet Murderwoods Mapgen  ................... */
/obj/effect/landmark/mapGenerator/murderwoods
	mapGeneratorType = /datum/mapGenerator/murderwoods
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/murderwoods
	modules = list(/datum/mapGeneratorModule/ambushing/murderwoods,/datum/mapGeneratorModule/murderwoods_undertree,/datum/mapGeneratorModule/murderwoods,/datum/mapGeneratorModule/murderwoodsgrassyel ,/datum/mapGeneratorModule/murderwoodsroad,/datum/mapGeneratorModule/murderwoodsgrass,/datum/mapGeneratorModule/murderwoodswaterturf)

/datum/mapGeneratorModule/murderwoods
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt)
	excluded_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 5,
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass/thorn_bush = 1,
							/obj/structure/flora/grass = 80,
							/obj/item/natural/stone = 5,
							/obj/item/natural/rock = 6,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/chair/bench/ancientlog = 2,
							/obj/structure/table/wood/treestump = 2,
							/obj/structure/closet/dirthole/closed/loot=3)
	spawnableTurfs = list(/turf/open/floor/dirt/road=10)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/murderwoodsroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 1,/obj/item/grown/log/tree/stick = 0.1)

/datum/mapGeneratorModule/murderwoods_undertree
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass/mixyel/under_tree)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/innocent_web = 10,
							/obj/structure/flora/rogueflower/random = 2,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/rogueflower/fallenleaves = 20)

/datum/mapGeneratorModule/murderwoodsgrass
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass)
	excluded_turfs = list(/turf/open/floor/grass/mixyel)
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 4,
							/obj/structure/flora/grass = 30,
							/obj/structure/flora/grass/herb/random = 0.5,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/item/natural/stone = 3,
							/obj/item/natural/rock = 1,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 2)

/datum/mapGeneratorModule/murderwoodsgrassyel
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass/mixyel)
	excluded_turfs = list(/turf/open/floor/grass/mixyel/under_tree)
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 3,
							/obj/structure/flora/grass = 20,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/item/natural/stone = 2,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 1)

/datum/mapGeneratorModule/murderwoodswaterturf
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/water/cleanshallow)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/grass/water = 20)

/datum/mapGeneratorModule/ambushing/murderwoods
	spawnableAtoms = list(/obj/effect/landmark/ambush=8)
	allowed_areas = list(/area/rogue/outdoors/woods)
	allowed_turfs = list(/turf/open/floor/grass)

// ===================================================================================
/*	..................  Sump Grotto Mapgen  ................... */
/obj/effect/landmark/mapGenerator/sump_grotto
	mapGeneratorType = /datum/mapGenerator/sump_grotto
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/sump_grotto
	modules = list(/datum/mapGeneratorModule/ambushing/sump_grotto,/datum/mapGeneratorModule/sump_grotto,/datum/mapGeneratorModule/sump_grotto_muddie )

/datum/mapGeneratorModule/sump_grotto
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/naturalstone)
	spawnableAtoms = list(	/obj/item/natural/rock = 8,
							/obj/item/natural/rock/random = 2,
							/obj/item/natural/stone = 10,
							/obj/structure/flora/rock/pebbles/bogmix = 2,
							/obj/structure/flora/rock/pebbles = 2
							)
	spawnableTurfs = list(/turf/open/floor/dirt/muddie = 2, /turf/open/floor/naturalstone/rough = 3)
	allowed_areas = list(/area/rogue/under/cave/sumpgrotto)

/datum/mapGeneratorModule/sump_grotto_muddie
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt/muddie)
	spawnableAtoms = list(/obj/structure/flora/grass/water = 12,
						/obj/structure/kneestingers = 1,
						/obj/structure/flora/grass/maneater = 1,
						/obj/structure/flora/grass/maneater/real = 1
						)
	spawnableTurfs = list(/turf/open/water/swamp = 2)
	allowed_areas = list(/area/rogue/under/cave/sumpgrotto)

/datum/mapGeneratorModule/ambushing/sump_grotto
	allowed_areas = list(/area/rogue/under/cave/sumpgrotto)
	allowed_turfs = list(/turf/open/floor/dirt/muddie, /turf/open/floor/naturalstone/rough)






/*	.................. StoneHamlet Bitter Peaks Mapgen  ................... */
/obj/effect/landmark/mapGenerator/bitterpeaks
	mapGeneratorType = /datum/mapGenerator/bitterpeaks
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/bitterpeaks
	modules = list(/datum/mapGeneratorModule/ambushing/bitterpeaks,/datum/mapGeneratorModule/snowpatchy,/datum/mapGeneratorModule/snowfull,/datum/mapGeneratorModule/snowgrass, /datum/mapGeneratorModule/lavacave)

/datum/mapGeneratorModule/snowpatchy
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/snow/patchy)
	spawnableAtoms = list(
							/obj/structure/flora/grass/bush_meagre = 1,
							/obj/structure/flora/grass/thorn_bush = 1,
							/obj/structure/flora/grass/herb/salvia = 1,
							/obj/item/natural/stone = 4,
							/obj/item/natural/rock = 3,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							)
	spawnableTurfs = list(/turf/open/floor/snow = 2)
	allowed_areas = list(/area/rogue/outdoors/mountains/decap)

/datum/mapGeneratorModule/snowfull
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/snow)
	spawnableAtoms = list(
							/obj/item/natural/rock = 2,
							 /obj/structure/flora/rock/pebbles/gray = 2,
							)
	allowed_areas = list(/area/rogue/outdoors/mountains/decap)
	excluded_turfs = list(/turf/open/floor/snow/patchy)

/datum/mapGeneratorModule/snowgrass
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/grass/cold)
	spawnableAtoms = list(
							/obj/structure/flora/grass/bush_meagre = 3,
							/obj/structure/flora/grass/herb/salvia = 1,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							)
	allowed_areas = list(/area/rogue/outdoors/mountains/decap)

/datum/mapGeneratorModule/lavacave
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/naturalstone)
	spawnableAtoms = list(
							/obj/structure/flora/grass/bush_meagre = 3,
							/obj/structure/flora/grass/herb/salvia = 1,
							/obj/structure/flora/rogueflower/random = 1,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							)
	allowed_areas = list(/area/rogue/under/cavelava)
	spawnableTurfs = list(/turf/open/floor/naturalstone/rough = 2)

/datum/mapGeneratorModule/ambushing/bitterpeaks
	spawnableAtoms = list(/obj/effect/landmark/ambush=10)
	allowed_areas = list(/area/rogue/outdoors/mountains/decap, /area/rogue/under/cavelava)
	allowed_turfs = list(/turf/open/floor/snow, /turf/open/floor/naturalstone/rough)
