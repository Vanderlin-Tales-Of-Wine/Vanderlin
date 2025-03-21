

// ===================================================================================
/*	..................   Sewer Danger   ................... */
/obj/effect/spawner/map_spawner/sewerencounter
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/item/reagent_containers/food/snacks/smallrat = 30,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/obj/item/organ/guts = 5,
		/obj/item/coin/copper = 5,
		/obj/effect/gibspawner/generic = 5,
		/obj/effect/decal/remains/bigrat = 5,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 2,
		)

/*	..................   Cheap Room Danger   ................... */
/obj/effect/spawner/map_spawner/cheapinnroomencounter
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/item/reagent_containers/food/snacks/smallrat = 15,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/obj/item/coin/copper = 50,
		/mob/living/carbon/human/species/human/northern/bum/skilled/madman  = 10,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 10
		)



/*	..................   Beggar Danger   ................... */
/obj/effect/spawner/map_spawner/hostile_beggar_danger
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/effect/decal/cleanable/vomit = 10,
		/obj/item/clothing/face/cigarette/rollie = 10,
		/obj/item/weapon/knife/stone = 10,
		/mob/living/carbon/human/species/human/northern/bum/skilled/madman = 25	)

/*	..................   Mines Danger   ................... */
/obj/effect/spawner/map_spawner/mine_mole_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/effect/decal/remains/mole = 20,
		/obj/item/natural/rock = 10,
		/obj/item/natural/stone = 10,
		/obj/item/gem/yellow = 10,
		/obj/structure/idle_enemy/mole = 50	)

/*	..................   Crypt Danger   ................... */
/obj/effect/spawner/map_spawner/crypt_randomdanger
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/item/coin/silver = 5,
		/obj/item/natural/worms/grub_silk = 5,
		/obj/item/natural/worms = 20,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 5,
		/mob/living/simple_animal/hostile/skeleton = 50	)

/*	..................   Rat Danger   ................... */
/obj/effect/spawner/map_spawner/rat_danger
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/effect/decal/remains/bigrat = 20,
		/obj/item/reagent_containers/food/snacks/smallrat = 20,
		/obj/item/natural/worms = 10,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 40)

/*	..................   50/50 enemy spawner   ................... */
/obj/effect/spawner/map_spawner/enemy_fifty
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50


/*	..................   Skeleton Fighter Enemy   ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/skeleton_fighter
	spawned = list(
//		/obj/structure/idle_enemy/skeleton_fighter = 100
		/mob/living/carbon/human/species/skeleton/skilled/fighter = 100
		)

/*	..................   Flesheater Enemy    ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/flesheaters
	spawned = list(
//		/obj/structure/idle_enemy/lamia = 50,
//		/obj/structure/idle_enemy/headless = 50
		/mob/living/simple_animal/hostile/retaliate/lamia = 50,
		/mob/living/simple_animal/hostile/retaliate/headless = 50
		)

/*	..................   Zizombie Farmer Enemy    ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/zizombie_peasant
	spawned = list(
//		/obj/structure/idle_enemy/zizombie_farmer = 100
		/mob/living/carbon/human/species/zizombie/npc/peasant = 100
		)

/*	..................   Hairy Spider Enemy   ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/hairy_spider
	spawned = list(
//		/obj/structure/idle_enemy/hairy_spider = 100
		/mob/living/simple_animal/hostile/retaliate/spider/hairy = 100
		)

/*	..................   Savage Orc Enemy    ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/orc_warrior
	spawned = list(
//		/obj/structure/idle_enemy/savage_orc = 65,
//		/obj/structure/idle_enemy/savage_orc_looter = 35
		/mob/living/carbon/human/species/orc/skilled/savage = 65,
		/mob/living/carbon/human/species/orc/skilled/looter = 35
		)

/obj/effect/spawner/map_spawner/orc_warlord_carbon
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 100
	color = "#caa3a3"
	spawned = list(
//		/obj/structure/idle_enemy/savage_orc_chieftain = 100
		/mob/living/carbon/human/species/orc/skilled/savage_chieftain = 100
		)

/*	..................   Haunts Enemy    ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/haunt_bonepile
	spawned = list(
		/obj/structure/bonepile = 100	)

/*	..................   Bushwacker Enemy  (starving desperate peasants)  ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/bushwacker
	spawned = list(
//		/obj/structure/idle_enemy/outlaw = 100
		/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw = 50,
		/mob/living/carbon/human/species/human/northern/bum/ambush/outlaw = 50
		)

/*	..................   Volf Enemy   ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/volf
	spawned = list(
		/mob/living/simple_animal/hostile/retaliate/wolf = 100
//		/obj/structure/idle_enemy/volf= 100
		)

/*	..................   Honeyspider Enemy   ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/honey_spider
	spawned = list(
//		/obj/structure/idle_enemy/honeyspider = 100
		/mob/living/simple_animal/hostile/retaliate/spider = 100
	)

/*	..................   Cave Goblin Enemy    ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/goblin_cave
	spawned = list(
//		/obj/structure/idle_enemy/cavegoblin = 100,
		/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 100
		)

/*	..................   Cabbit Cabin Enemy    ................... */
/obj/effect/spawner/map_spawner/enemy_fifty/cabbit_cabin
	spawned = list(
		/mob/living/simple_animal/pet/cat/cabbit = 50,
		/mob/living/simple_animal/hostile/retaliate/troll/caerbannog = 25,
		/obj/item/reagent_containers/food/snacks/smallrat = 25
		)



/obj/effect/spawner/map_spawner/beartrap_obvious
	icon_state = "beartrap"
	name = "beartrap"
	probby = 50
	spawned = list(/obj/item/restraints/legcuffs/beartrap/armed)


// ======================================================================
/*	..................   Either Or Spawners   ................... */
/obj/effect/spawner/map_spawner/skel_or_remains
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	probby = 50
	color = "#ffce0b"
	spawned = list(
		/mob/living/simple_animal/hostile/skeleton = 5,
		/obj/effect/decal/remains/neu/human = 50,
		/obj/effect/decal/remains/neu/humanc = 45,
		/obj/item/coin/silver = 1,
		/obj/item/clothing/ring/silver = 1,
		)

/*	..................   Catacomb Random   ................... */
/obj/effect/spawner/map_spawner/catacomb_random
	icon_state = "srat"
	icon = 'icons/roguetown/mob/monster/rat.dmi'
	probby = 50
	color = "#ffce0b"
	spawned = list(
		/obj/item/coin/silver = 5,
		/obj/item/clothing/pants/trou = 2,
		/obj/item/flashlight/flare/torch/lantern = 1,
		/obj/item/natural/worms = 20,
		/obj/item/reagent_containers/food/snacks/smallrat = 5,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 5,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 1,
		)





// ===================================================================================

/* Ide enemy structures use the new range var in the spawner to only try spawning if a mob containing a mind is inside the
range. How much processing this saves is unclear */
/*	..................   Idle Enemy Spawner   ................... */
/obj/structure/idle_enemy
	name = ""
	icon = 'icons/roguetown/mob/skeleton_male.dmi'
	icon_state = ""
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/datum/component/spawner/npc
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	spawn_text = ""
//	no_nest = TRUE

// *** CARBONS ***
/*	..................   Skeleton Fighter Spawner   ................... */
/obj/structure/idle_enemy/skeleton_fighter
/obj/structure/idle_enemy/skeleton_fighter/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/skeleton_fighter)
/datum/component/spawner/npc/skeleton_fighter
	mob_types = list(/mob/living/carbon/human/species/skeleton/skilled/fighter)
	range = 11

/*	..................   Orc Carbons Spawner   ................... */
/obj/structure/idle_enemy/savage_orc
/obj/structure/idle_enemy/savage_orc/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/savage_orc)
/datum/component/spawner/npc/savage_orc
	mob_types = list(/mob/living/carbon/human/species/orc/skilled/savage)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/obj/structure/idle_enemy/savage_orc_looter
/obj/structure/idle_enemy/savage_orc_looter/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/savage_orc_looter)
/datum/component/spawner/npc/savage_orc_looter
	mob_types = list(/mob/living/carbon/human/species/orc/skilled/looter)
	range = 11

/obj/structure/idle_enemy/savage_orc_chieftain
/obj/structure/idle_enemy/savage_orc_chieftain/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/savage_orc_chieftain)
/datum/component/spawner/npc/savage_orc_chieftain
	mob_types = list(/mob/living/carbon/human/species/orc/skilled/savage_chieftain)
	range = 11


/*	..................   Hostile Bum Spawner   ................... */
/obj/structure/idle_enemy/hostile_bum
/obj/structure/idle_enemy/hostile_bum/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/hostile_bum)
/datum/component/spawner/npc/hostile_bum
	mob_types = list(/mob/living/carbon/human/species/human/northern/bum/skilled/madman)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""



/*	..................   Weak Skelly Spawner   ................... */
/obj/structure/idle_enemy/weak_skelly
/obj/structure/idle_enemy/weak_skelly/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/weak_skelly)
/datum/component/spawner/npc/weak_skelly
	mob_types = list(/mob/living/carbon/human/species/skeleton/skilled/unarmed)
	range = 11
	spawn_text = ""

/*	..................   Zizombie Farmer Spawner   ................... */
/obj/structure/idle_enemy/zizombie_farmer
/obj/structure/idle_enemy/zizombie_farmer/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/zizombie_farmer)
/datum/component/spawner/npc/zizombie_farmer
	mob_types = list(/mob/living/carbon/human/species/zizombie/npc/peasant)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 6
	spawn_text = ""


/*	..................   Outlaw Spawner   ................... */
/obj/structure/idle_enemy/outlaw
/obj/structure/idle_enemy/outlaw/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/outlaw)
/datum/component/spawner/npc/outlaw
	mob_types = list(/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw )
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""


// *** SIMPLE ANIMALS ***
/*	..................   Big Rat Spawner   ................... */
/obj/structure/idle_enemy/bigrat
/obj/structure/idle_enemy/bigrat/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/bigrat)
/datum/component/spawner/bigrat
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/bigrat)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Lesser Mole Spawner   ................... */
/obj/structure/idle_enemy/mole
/obj/structure/idle_enemy/mole/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/mole)
/datum/component/spawner/mole
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/mole)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Lamia Spawner   ................... */
/obj/structure/idle_enemy/lamia
/obj/structure/idle_enemy/lamia/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/lamia)
/datum/component/spawner/lamia
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/lamia)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 10
	spawn_text = ""

/*	..................   Headless Spawner   ................... */
/obj/structure/idle_enemy/headless
/obj/structure/idle_enemy/headless/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/headless)
/datum/component/spawner/headless
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/headless)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 10
	spawn_text = ""


/*	..................   Hairy Spider Spawner   ................... */
/obj/structure/idle_enemy/hairy_spider
/obj/structure/idle_enemy/hairy_spider/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/hairy_spider)
/datum/component/spawner/hairy_spider
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/spider/hairy)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Volf Spawner   ................... */
/obj/structure/idle_enemy/volf
/obj/structure/idle_enemy/volf/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/volf)
/datum/component/spawner/volf
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/wolf )
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Cave Goblin Spawner   ................... */
/obj/structure/idle_enemy/cavegoblin
/obj/structure/idle_enemy/cavegoblin/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/cavegoblin)
	icon_state = ""
/datum/component/spawner/npc/cavegoblin
	mob_types = list(/mob/living/carbon/human/species/goblin/skilled/ambush/cave )
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""


/*	..................   Cabbit Boss Spawner   ................... */
/obj/structure/idle_enemy/cabbit_boss
/obj/structure/idle_enemy/cabbit_boss/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/cabbit_boss)
/datum/component/spawner/cabbit_boss
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/troll/caerbannog)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Honeyspider Spawner   ................... */
/obj/structure/idle_enemy/honeyspider
/obj/structure/idle_enemy/honeyspider/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/honeyspider)
/datum/component/spawner/honeyspider
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/spider)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/obj/effect/spawner/map_spawner/tallgrass
	color = "#ec98df"
