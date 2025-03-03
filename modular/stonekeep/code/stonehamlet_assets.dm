/*	*	*	*	*	*
*					*
*	Stone Hamlet	*
*					*
*	*	*	*	*	*/


// ============================		LANDMARKS	================================

/*	..................   Dwarf Outpost   ................... */
/obj/effect/landmark/map_load_mark/dwarf_outpost
	name = "Dwarf Outpost"
	templates = list( "dwarfoutpost_1","dwarfoutpost_2" )

/datum/map_template/dwarf_outpost_i
	name = "Dwarf Outpost Orc"
	id = "dwarfoutpost_1"
	mappath = "_maps/map_files/stonehamlet/templates/dwarfoutpost_1.dmm"

/datum/map_template/dwarf_outpost_ii
	name = "Dwarf Outpost Beastmen"
	id = "dwarfoutpost_2"
	mappath = "_maps/map_files/stonehamlet/templates/dwarfoutpost_2.dmm"


/*	..................   Roadblock   ................... */
/obj/effect/landmark/map_load_mark/hamlet_roadblock
	name = "Roadblock"
	templates = list( "roadblock_1","roadblock_2" )

/datum/map_template/roadblock_i
	name = "Roadblock"
	id = "roadblock_1"
	mappath = "_maps/map_files/stonehamlet/templates/roadblock_1.dmm"
/datum/map_template/roadblock_ii
	name = "No roadblock"
	id = "roadblock_2"
	mappath = "_maps/map_files/stonehamlet/templates/roadblock_2.dmm"

/*	..................   Outlaw camp   ................... */
/obj/effect/landmark/map_load_mark/hamlet_outlaws
	name = "Outlaw camp"
	templates = list( "outlawcamp_1","outlawcamp_2" )

/datum/map_template/outlawcamp_i
	name = "Outlaw camp"
	id = "outlawcamp_1"
	mappath = "_maps/map_files/stonehamlet/templates/outlawcamp_1.dmm"

/datum/map_template/outlawcamp_ii
	name = "Empty outlaw camp"
	id = "outlawcamp_2"
	mappath = "_maps/map_files/stonehamlet/templates/outlawcamp_2.dmm"


/*	..................   Salt Mine   ................... */
/obj/effect/landmark/map_load_mark/salt_mine
	name = "Salt Mine Special"
	templates = list( "saltmine_1","saltmine_2","saltmine_3"  )

/datum/map_template/salt_mine_i
	name = "Salt Mine Corpse"
	id = "saltmine_1"
	mappath = "_maps/map_files/stonehamlet/templates/saltmine_1.dmm"
/datum/map_template/salt_mine_ii
	name = "Salt Mine Gem"
	id = "saltmine_2"
	mappath = "_maps/map_files/stonehamlet/templates/saltmine_2.dmm"
/datum/map_template/salt_mine_iii
	name = "Salt Mine Cult"
	id = "saltmine_2"
	mappath = "_maps/map_files/stonehamlet/templates/saltmine_3.dmm"

/*	..................   Bandit Hamlet Traveltile Landmark   ................... */
/obj/effect/landmark/map_load_mark/bandit_travel
	name = "Bandit_travel"
	templates = list( "bandit_a","bandit_b","bandit_c","bandit_d"  )

/datum/map_template/banditspawna
	name = "Bandit Travel A"
	id = "bandit_a"
	mappath = "_maps/map_files/stonehamlet/templates/bspawn_a.dmm"

/datum/map_template/bandittravelb
	name = "Bandit Travel B"
	id = "bandit_b"
	mappath = "_maps/map_files/candlelight/templates/bspawn_b.dmm"

/datum/map_template/bandittravelc
	name = "Bandit Travel C"
	id = "bandit_c"
	mappath = "_maps/map_files/candlelight/templates/bspawn_c.dmm"

/datum/map_template/bandittraveld
	name = "Bandit Travel D"
	id = "bandit_d"
	mappath = "_maps/map_files/candlelight/templates/bspawn_d.dmm"



// ===================================================================================

/*	..................   Random crap for moats  ................... */
/obj/effect/spawner/map_spawner/moat_debris
	icon_state = "clodpile"
	icon = 'icons/roguetown/items/natural.dmi'
	probby = 50
	color = "#ff82ec"
	spawned = list(
		/obj/item/natural/dirtclod = 10,
		/obj/structure/fluff/clodpile = 5,
		/obj/item/reagent_containers/food/snacks/smallrat = 3,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 2,
		/obj/item/natural/worms/leech = 2,
		/obj/item/reagent_containers/food/snacks/rotten/meat = 1,
		/obj/structure/idle_enemy/bigrat = 1,
		/obj/structure/kneestingers = 1)

/*	..................   Metal bars (weakened or normal?)  ................... */
/obj/effect/spawner/map_spawner/metal_bars
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "bars"
	probby = 100
	color = "#ff00d9"
	spawned = list(
		/obj/structure/bars/weakened = 30,
		/obj/structure/bars = 70,
		)

/obj/structure/bars/weakened
	desc = "Iron bars made to keep things in or out. These one looks pretty rusty."
	max_integrity = INTEGRITY_POOR
	color = "#edc9c9"


/*	..................   Plague District Thing  ................... */
/obj/effect/spawner/map_spawner/plaguedist_thing
	icon = 'icons/mob/mob.dmi'
	icon_state = "mist"
	probby = 50
	color = "#ff0d00"
	spawned = list(
		/datum/component/spawner/zizombie_farmer = 30,
		/obj/item/natural/worms = 10,
		/obj/item/reagent_containers/food/snacks/rotten/mince = 5,
		/obj/effect/decal/remains/bigrat = 5,
		/obj/item/reagent_containers/food/snacks/smallrat = 20,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/obj/structure/idle_enemy/bigrat = 5)

// ===================================================================================
/*	..................   Dwarf Outpost Spawner  ................... */
/obj/effect/spawner/map_spawner/outpost_dwarf_weapon
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "paxe"
	probby = 50
	color = "#ffde3a"
	spawned = list(
		/obj/item/weapon/pick/paxe = 30,
		/obj/item/weapon/axe/steel = 60,
		/obj/item/weapon/pick/steel = 10
		)

/obj/effect/spawner/map_spawner/outpost_dwarf_armor
	icon = 'icons/roguetown/clothing/head.dmi'
	icon_state = "ironpot"
	probby = 50
	color = "#ffde3a"
	spawned = list(
		/obj/item/clothing/head/helmet/ironpot = 25,
		/obj/item/clothing/head/helmet/leather/minershelm = 40,
		/obj/item/clothing/neck/chaincoif = 10,
		/obj/item/clothing/armor/chainmail = 10,
		/obj/item/clothing/armor/gambeson = 5,
		/obj/item/clothing/armor/leather/vest/butler = 10
		)

/obj/effect/spawner/map_spawner/outpost_personal_item
	icon = 'icons/roguetown/weapons/tools.dmi'
	icon_state = "hammer_s"
	probby = 50
	color = "#ffde3a"
	spawned = list(
		/obj/item/weapon/hammer/steel = 30,
		/obj/item/reagent_containers/glass/bottle/beer/voddena = 60,
		/obj/item/clothing/head/hatfur = 10,
		/obj/item/storage/belt/leather = 10,
		)

/obj/effect/spawner/map_spawner/outpost_dwarf_key
//	icon_state = "brown"
	icon = 'icons/roguetown/items/keys.dmi'
	probby = 50
	color = "#3aff4e"
	spawned = list(
		/obj/item/key/dwarf_outpost = 100
		)

/obj/item/key/dwarf_outpost
	name = "steel key"
	desc = "Dwarven craftsmanship."
	lockid = "outpost"


/*	..................   Dwarf Underdweller Corpse   ................... */
/obj/effect/mob_spawn/human/corpse/damaged/underdweller
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	color = "#aa9b00"
	mob_type = /mob/living/carbon/human/species/dwarf/mountain
	mob_name = "Dwarf Underdweller"
	name = "Dwarf Underdweller"
	hairstyle = "Miner"
	facial_hairstyle = "Pick"
	outfit = /datum/outfit/deadunderdweller

/datum/outfit/deadunderdweller
	armor = /obj/item/clothing/armor/cuirass/iron
	shirt = /obj/item/clothing/shirt/undershirt/sailor/red
	pants = /obj/item/clothing/under/trou/leather
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	backl = /obj/item/storage/backpack/backpack
	head = /obj/item/clothing/head/helmet/leather/minershelm


// ==============================================================
/*	..................   Various mapping aides   ................... */
/obj/item/clothing/armor/chainmail/hauberk/broken
	desc = "A long shirt of maille, this one is made for a short man it seems."
/obj/item/clothing/armor/chainmail/hauberk/broken/Initialize()
	. = ..()
	obj_break()

/obj/item/clothing/armor/chainmail/battered
	desc = "A good quality haubergon, but weakened by many blows."
	max_integrity = INTEGRITY_STANDARD
/*
/obj/structure/roguethrone/statues
	icon = 'modular/Mapping/icons/96x96.dmi
*/

/area/rogue/outdoors/rtfield/plague_district
	ambush_mobs = list(/mob/living/carbon/human/species/human/northern/bum/skilled/madman = 20, /mob/living/carbon/human/species/zizombie/npc/peasant = 30)
	first_time_text = "PLAGUE DISTRICT"
	color = "#d4da75"
	name = "plague district"
	ambush_types = list(
				/turf/open/floor/cobblerock)
	droning_sound = 'sound/ambience/creepywind.ogg'


/area/rogue/outdoors/rtfield/outlaw
	ambush_mobs = list(/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw = 50)
	name = "outlaw hideout"
	color = "#e9baa3"
	first_time_text = null

/area/rogue/outdoors/rtfield/boggish	// obsolete
	ambush_mobs = list(/mob/living/carbon/human/species/goblin/skilled/ambush/sea = 50)
	name = "bog approaches"
	color = "#7db36e"
	first_time_text = null

/area/rogue/outdoors/rtfield/woodish
	ambush_mobs = list(/mob/living/simple_animal/hostile/retaliate/wolf = 50)
	name = "woods approaches"
	color = "#7db36e"
	first_time_text = null

/area/rogue/outdoors/rtfield/spooky		// haunts ambush and dug down hidden treasure
	ambush_mobs = list(/mob/living/simple_animal/hostile/haunt = 50)
	name = "spooky place"
	color = "#9294d3"
	first_time_text = null

/area/rogue/outdoors/rtfield/hamlet
	name = "hamlet surroundings"
	ambush_times = list("night","dusk")
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/wolf = 60,
				/mob/living/carbon/human/species/goblin/skilled/ambush = 5,
				/mob/living/simple_animal/pet/cat/cabbit = 10)
	first_time_text = "STONEHILL VALLEY"

/area/rogue/under/cave/hollow
	name = "hollow mountain"
	first_time_text = "Hollow Mountain"

/obj/item/key/spooky_village
	icon_state = "rustkey"
	lockid = "spooky_village"


/obj/structure/flora/tree/neu
	name = "BUGREPORT MORONGOLOID HAS USED TEMPLATE TREE"
	desc = "Once leafed, growing, now just a home for termites."
	icon = 'modular/stonekeep/icons/pigflora64.dmi'
	icon_state = "acacia_dead"
	stump_type = /obj/structure/table/wood/treestump/burnt
	pixel_x = -16
	max_integrity = 180

/obj/structure/flora/tree/neu/acacia
	name = "dead tree"
	icon_state = "acacia_dead"
/obj/structure/flora/tree/neu/acacia/Initialize()
	. = ..()
	icon_state = "acacia_dead"
	dir = pick(GLOB.cardinals)

/obj/structure/flora/tree/neu/pine
	name = "pine tree"
	desc = "A smell of amber and pine needles linger."
	icon_state = "pine"
/obj/structure/flora/tree/neu/pine/Initialize()
	. = ..()
	icon_state = "pine"

/obj/structure/flora/tree/neu/pine_dead
	name = "dead tree"
	desc = "A faint smell of amber and pine needles linger."
	icon_state = "pine_dead"
/obj/structure/flora/tree/neu/pine_dead/Initialize()
	. = ..()
	icon_state = "pine_dead"

/obj/structure/flora/tree/neu/bush
	name = "bush"
	desc = ""
	icon_state = "deadbush_1"
	stump_type = /obj/item/grown/log/tree/stick
	max_integrity = 80
	destroy_sound = 'sound/misc/woodhit.ogg'
	static_debris = list(/obj/item/grown/log/tree/stick = 1)
	pixel_x = -16
	alpha = 255
/obj/structure/flora/tree/neu/bush/Initialize()
	. = ..()
	icon_state = "deadbush_[rand(1,3)]"

/obj/effect/decal/bogfluff
	name = ""
	desc = ""
	icon = 'modular/stonekeep/icons/pigflora64.dmi'
	icon_state = "1"
	mouse_opacity = 0
/obj/effect/decal/bogfluff/Initialize()
	. = ..()
	icon_state = "[rand(1,22)]"

/obj/effect/decal/pebbles
	name = ""
	desc = ""
	icon = 'modular/stonekeep/icons/pebbles.dmi'
	icon_state = "1"
	mouse_opacity = 0

/obj/effect/decal/pebbles/dark
	icon_state = "d1"

/obj/effect/decal/pebbles/brown
	icon_state = "b1"

/obj/structure/punji_sticks
	icon = 'modular/stonekeep/icons/pebbles.dmi'




// ===================================================================================
/*	..................  Bog Tree Spawner  ................... */
/obj/effect/spawner/map_spawner/bogtree
	icon = 'modular/stonekeep/icons/pigflora64.dmi'
	icon_state = "acacia_dead"
	probby = 80
	color = "#3aff47"
	pixel_x = -16
	spawned = list(
		/obj/structure/flora/tree/burnt = 65,
		/obj/structure/flora/tree/neu/acacia = 30,
		/obj/structure/table/wood/treestump/burnt = 5
		)

/*	..................  Bog Dirt decoration Spawner  ................... */
/obj/effect/spawner/map_spawner/bogdirt
	icon = 'modular/stonekeep/icons/pigflora64.dmi'
	icon_state = "1"
	probby = 50
	color = "#3aff47"
	spawned = list(
		/obj/effect/decal/bogfluff = 10,
		/obj/effect/decal/pebbles/brown = 5
		)

/*	..................  Normal Tree Spawner (mapping visual)  ................... */
/obj/effect/spawner/map_spawner/tree
	icon = 'icons/roguetown/misc/foliagetall.dmi'
	icon_state = "t2"
	alpha = 200
	color = "#88f78f"
	pixel_x = -16
	spawned = list(/obj/structure/flora/tree =95,
			 /obj/structure/flora/grass/bush_meagre = 5,
			 /obj/structure/table/wood/treestump = 1)

/*	..................  Outlaw Tree Spawner  ................... */
/obj/effect/spawner/map_spawner/outlawtree
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = "thornbush1"
	alpha = 200
	color = "#88f78f"
	probby = 40
	spawned = list(/obj/structure/flora/tree =50,
			 /obj/structure/flora/grass/bush_meagre = 5,
			 /obj/structure/table/wood/treestump = 5,
			 /obj/structure/flora/grass/thorn_bush = 10)

/*	..................  Ruined Farm Spawner  ................... */
/obj/effect/spawner/map_spawner/ruinedfarmgrowth
	icon = 'modular/stonekeep/icons/pigflora64.dmi'
	icon_state = "deadbush_1"
	alpha = 200
	color = "#35da40"
	probby = 40
	pixel_x = -16
	spawned = list(/obj/structure/flora/tree/neu/bush =30,
			 /obj/structure/flora/grass/bush_meagre = 20,
			 /obj/structure/flora/grass/thorn_bush = 10,
			 /obj/structure/flora/tree = 5)


/*	..................  Mountain Tree Spawner  ................... */
/obj/effect/spawner/map_spawner/mountaintree
	icon = 'modular/stonekeep/icons/pigflora64.dmi'
	icon_state = "pine"
	alpha = 200
	color = "#88f78f"
	probby = 50
	pixel_x = -16
	spawned = list(/obj/structure/flora/tree/neu/pine =40,
			 /obj/structure/flora/tree/neu/pine_dead = 5,
			 /obj/effect/decal/pebbles/dark = 10,
			 /obj/structure/roguerock = 5)

/*	..................  Rocky Spawner  ................... */
/obj/effect/spawner/map_spawner/rockies
	icon_state = "rock1"
	icon = 'icons/roguetown/misc/foliage.dmi'
	alpha = 200
	color = "#88f78f"
	probby = 50
	spawned = list(/obj/structure/roguerock = 10,
			 /obj/item/natural/rock = 10,
			 /obj/effect/decal/pebbles/dark = 20,
			 /obj/item/natural/stone = 10,
			 /obj/effect/decal/bogfluff = 10)

/*	..................  Grave Spawner  ................... */
/obj/effect/spawner/map_spawner/graverandom
	icon_state = "gravecovered"
	icon = 'icons/turf/roguefloor.dmi'
	alpha = 200
	color = "#88f78f"
	probby = 50
	spawned = list(/obj/structure/closet/dirthole/grave = 10,
			/obj/structure/closet/dirthole/closed = 10,
			/obj/structure/closet/dirthole/closed/loot = 2,
			/obj/structure/closet/dirthole = 10)




// ===================================================================================
/*	..................  StoneHamlet Bog Mapgen  ................... */
/obj/effect/landmark/mapGenerator/stonebog
	mapGeneratorType = /datum/mapGenerator/stonebog
	endTurfX = 255
	endTurfY = 120
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/stonebog
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/stonebog, /datum/mapGeneratorModule/stonebogwater, /datum/mapGeneratorModule/stonebogwaterdeep, /datum/mapGeneratorModule/stonebogdirt)

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
							/obj/item/natural/rock = 20,
							/obj/item/natural/stone = 20,
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
	spawnableAtoms = list(/obj/effect/decal/bogfluff = 3,
						/obj/effect/decal/pebbles/brown = 1)
	allowed_turfs = list(/turf/open/floor/dirt)
	allowed_areas = list(/area/rogue/outdoors/bog)


// ===================================================================================
/*	..................  StoneHamlet Forest Mapgen  ................... */
/obj/effect/landmark/mapGenerator/stoneforest
	mapGeneratorType = /datum/mapGenerator/stoneforest
	endTurfX = 150
	endTurfY = 255
	startTurfX = 1
	startTurfY = 60

/datum/mapGenerator/stoneforest
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/stoneforest_undertree,/datum/mapGeneratorModule/stoneforestgrassturf,/datum/mapGeneratorModule/stoneforest,/datum/mapGeneratorModule/stoneforestroad,/datum/mapGeneratorModule/stoneforestgrass,/datum/mapGeneratorModule/stoneforestwaterturf)

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
							/obj/structure/closet/dirthole/closed/loot=6,
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
							/obj/structure/flora/rogueflower/random = 6,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/rogueflower/fallenleaves = 30)

/datum/mapGeneratorModule/stoneforestgrass
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/tree = 1,
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass = 80,
							/obj/structure/flora/grass/herb/random = 7,
							/obj/structure/flora/rogueflower/random = 6,
							/obj/item/natural/stone = 6,
							/obj/item/natural/rock = 3,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 5)

/datum/mapGeneratorModule/stoneforestwaterturf
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/water/cleanshallow)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/grass/water = 20)

