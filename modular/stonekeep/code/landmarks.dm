
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

/*	..................   Bandit Traveltile Landmark   ................... */
/obj/effect/landmark/map_load_mark/bandit_travel
	name = "Bandit_travel"
	templates = list( "bandit_i","bandit_ii","bandit_iii"  )

/datum/map_template/banditspawna
	name = "Bandit Travel A"
	id = "bandit_i"
	mappath = "_maps/map_files/stonehamlet/templates/bandit_spawn_1.dmm"

/datum/map_template/bandittravelb
	name = "Bandit Travel B"
	id = "bandit_ii"
	mappath = "_maps/map_files/candlelight/templates/bandit_spawn_2.dmm"

/datum/map_template/bandittravelc
	name = "Bandit Travel C"
	id = "bandit_iii"
	mappath = "_maps/map_files/candlelight/templates/bandit_spawn_3.dmm"


/*	..................   Sump Grotto Landmark   ................... */
/obj/effect/landmark/map_load_mark/sumpgrotto_minidungeon
	name = "Sump Grotto"
	templates = list( "sump_goblins" )

/datum/map_template/sumpgrotto_i
	name = "Sump Grotto Goblins"
	id = "sump_goblins"
	mappath = "_maps/map_files/stonehamlet/templates/sumpgrotto_1.dmm"




// ===================================================================================
/*	..................   Dwarf Outpost Landmark sub-spawners  ................... */
/obj/effect/spawner/map_spawner/outpost/dwarf_weapon
	icon = 'icons/roguetown/weapons/32.dmi'
	icon_state = "paxe"
	probby = 50
	color = "#fee046"
	spawned = list(
		/obj/item/weapon/pick/paxe = 30,
		/obj/item/weapon/axe/steel = 60,
		/obj/item/weapon/pick/steel = 10
		)

/obj/effect/spawner/map_spawner/outpost/dwarf_armor
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

/obj/effect/spawner/map_spawner/outpost/personal_item
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

/obj/effect/spawner/map_spawner/outpost/dwarf_key
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
	icon_state = "mazekey"

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
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	backl = /obj/item/storage/backpack/backpack
	head = /obj/item/clothing/head/helmet/leather/minershelm


/obj/item/clothing/armor/chainmail/hauberk/broken
	desc = "A long shirt of maille, this one is made for a short man it seems."
/obj/item/clothing/armor/chainmail/hauberk/broken/Initialize()
	. = ..()
	obj_break()

/obj/item/clothing/armor/chainmail/battered
	desc = "A good quality haubergon, but weakened by many blows."
	max_integrity = INTEGRITY_STANDARD



// =============================================================
// ================		SPAWNPOINTS		========================
/obj/effect/landmark/start/sk_gravekeeper
	name = "Gravekeeper"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_mason
	name = "Mason"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_woodsman
	name = "Woodsman"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_elder
	name = "Village Elder"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_blacksmith
	name = "Blacksmith"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_manatarms
	name = "Man-at-arms"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_stevedore
	name = "Stevedore"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_courtwiz
	name = "Court Wizard"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_sheriff
	name = "Sheriff"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_weaver
	name = "Weaver"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_pilgrim
	name = "Pilgrim"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_nitemaster
	name = "Nitemaster"
	icon_state = "arrow"

/obj/effect/landmark/start/sk_guildmaster
	name = "Guild Master"
	icon_state = "arrow"


/obj/effect/landmark/start/sk_mig_bogroad
	name = "Migration Bog Road"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
/obj/effect/landmark/start/sk_mig_bogroad/Initialize()
	. = ..()
	GLOB.bogroad_starts += loc

/obj/effect/landmark/start/sk_mig_forestroad
	name = "Migration Forest Road"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
/obj/effect/landmark/start/sk_mig_forestroad/Initialize()
	. = ..()
	GLOB.forestroad_starts += loc

/obj/effect/landmark/start/sk_mig_mountainroad
	name = "Migration Mountain Road"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
/obj/effect/landmark/start/sk_mig_mountainroad/Initialize()
	. = ..()
	GLOB.mountainroad_starts += loc


/obj/effect/landmark/start/sk_mig_bogevil
	name = "Migration Bog Evil"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
/obj/effect/landmark/start/sk_mig_bogevil/Initialize()
	. = ..()
	GLOB.bogevil_starts += loc

/obj/effect/landmark/start/sk_mig_forestevil
	name = "Migration Forest Evil"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
/obj/effect/landmark/start/sk_mig_forestevil/Initialize()
	. = ..()
	GLOB.forestevil_starts += loc

/obj/effect/landmark/start/sk_mig_mountainevil
	name = "Migration Mountain Evil"
	icon_state = "arrow"
	delete_after_roundstart = FALSE
/obj/effect/landmark/start/sk_mig_mountainevil/Initialize()
	. = ..()
	GLOB.mountainevil_starts += loc
