/datum/repeatable_crafting_recipe/survival
	abstract_type = /datum/repeatable_crafting_recipe/survival

/datum/repeatable_crafting_recipe/survival/cloth
	name = "cloth"
	requirements = list(
		/obj/item/natural/fibers = 2
	)
	tool_usage = list(
		/obj/item/needle = list("starts to sew", "start to sew")
	)

	starting_atom = /obj/item/needle
	attacked_atom = /obj/item/natural/fibers
	skillcraft = /datum/skill/misc/sewing
	output = /obj/item/natural/cloth
	craftdiff = 0

/datum/repeatable_crafting_recipe/survival/thorn_needle
	name = "thorn needle"
	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/natural/thorn = 1,
	)

	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/natural/thorn
	output = /obj/item/needle/thorn
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/dart
	name = "dart"
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/thorn = 1,
	)

	starting_atom = /obj/item/natural/thorn
	attacked_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/ammo_casing/caseless/dart
	craftdiff = 0
	uses_attacked_atom = TRUE
	output_amount = 2

/datum/repeatable_crafting_recipe/survival/rope
	name = "rope"
	requirements = list(
		/obj/item/natural/fibers = 3
	)

	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/natural/fibers
	output = /obj/item/rope
	craftdiff = 0
	crafting_message = "starts to braid some fibers"
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/torch
	name = "torch"
	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/flashlight/flare/torch
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_axe
	name = "stone axe"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/grown/log/tree/small = 1,
	)

	attacked_atom = /obj/item/natural/stone
	starting_atom = /obj/item/grown/log/tree/small
	output = /obj/item/weapon/axe/stone
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_knife
	name = "stone knife"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	attacked_atom = /obj/item/natural/stone
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/knife/stone
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_hoe
	name = "stone hoe"
	requirements = list(
		/obj/item/natural/stone = 2,
		/obj/item/natural/fibers = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	attacked_atom = /obj/item/natural/stone
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/hoe/stone
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_tongs
	name = "stone tongs"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/grown/log/tree/stick = 2,
	)

	attacked_atom = /obj/item/natural/stone
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/tongs/stone
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_pick
	name = "stone pick"
	requirements = list(
		/obj/item/natural/stone = 2,
		/obj/item/grown/log/tree/stick = 1,
	)

	attacked_atom = /obj/item/natural/stone
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/pick/stone
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_spear
	name = "stone spear"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/weapon/polearm/woodstaff = 1,
	)

	starting_atom = /obj/item/weapon/polearm/woodstaff
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/weapon/polearm/spear/stone
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_pot
	name = "stone pot"
	requirements = list(
		/obj/item/natural/stone = 2,
	)

	starting_atom = /obj/item/natural/stone
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/reagent_containers/glass/bucket/pot
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_mortar
	name = "stone mortar"
	requirements = list(
		/obj/item/natural/stone = 1,
	)

	starting_atom = /obj/item/weapon/knife
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/reagent_containers/glass/mortar
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/survival/alchemy_mortar
	name = "alchemical mortar"
	requirements = list(
		/obj/item/natural/stone = 2,
	)

	starting_atom = /obj/item/weapon/knife
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/mortar
	craftdiff = 0
	skillcraft = /datum/skill/craft/masonry
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/survival/pestle
	name = "pestle"
	requirements = list(
		/obj/item/natural/stone = 1,
	)

	starting_atom = /obj/item/weapon/knife
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/pestle
	craftdiff = 0
	skillcraft = /datum/skill/craft/masonry
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/survival/bag
	name = "sack"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	tool_usage = list(
		/obj/item/needle = list("starts to sew", "start to sew")
	)
	starting_atom = /obj/item/needle
	attacked_atom = /obj/item/natural/cloth
	output = /obj/item/storage/sack
	craftdiff = 0
	skillcraft = /datum/skill/misc/sewing
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/survival/mantrap
	name = "mantrap"
	requirements = list(
		/obj/item/grown/log/tree/stake = 1,
		/obj/item/rope = 1,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stake
	starting_atom  = /obj/item/rope
	output = /obj/item/restraints/legcuffs/beartrap
	craftdiff = 1

/datum/repeatable_crafting_recipe/survival/imp_saw
	name = "improvised saw"
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/stone = 1,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/saw/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/survival/imp_clamp
	name = "improvised clamp"
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/hemostat/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/survival/imp_retractor
	name = "improvised retractor"
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/retractor/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/survival/recurve_bow
	name = "recurve bow"
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 4,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 1

/datum/repeatable_crafting_recipe/survival/long_bow
	name = "long bow"
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 8,
		/obj/item/reagent_containers/food/snacks/fat = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3

/datum/repeatable_crafting_recipe/survival/quarterstaff
	name = "wooden quarterstaff"
	requirements = list(
		/obj/item/grown/log/tree= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittle", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/survival/steel_quarterstaff
	name = "steel quarterstaff"
	requirements = list(
		/obj/item/weapon/polearm/woodstaff/quarterstaff = 1,
		/obj/item/ingot/steel = 1,
	)
	attacked_atom = /obj/item/weapon/polearm/woodstaff/quarterstaff
	starting_atom  = /obj/item/ingot/steel
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff/steel
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3

/datum/repeatable_crafting_recipe/survival/iron_quarterstaff
	name = "iron quarterstaff"
	requirements = list(
		/obj/item/weapon/polearm/woodstaff/quarterstaff = 1,
		/obj/item/ingot/iron = 1,
	)
	attacked_atom = /obj/item/weapon/polearm/woodstaff/quarterstaff
	starting_atom  = /obj/item/ingot/iron
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff/iron
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/repeatable_crafting_recipe/survival/woodflail
	name = "wooden flail"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/rope/chain = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/weapon/flail/towner
	output_amount = 2
	craftdiff = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/survival/woodthresher
	name = "wooden thresher"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/rope = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/weapon/thresher
	craftdiff = 1
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/survival/earnecklace
	name = "ear necklace"
	requirements = list(
		/obj/item/organ/ears= 4,
		/obj/item/rope = 1,
	)
	attacked_atom = /obj/item/rope
	starting_atom= /obj/item/organ/ears
	output = /obj/item/clothing/neck/menears
	craftdiff = 0

/datum/repeatable_crafting_recipe/survival/earnecklace/elf
	name = "elf ear necklace"
	output = /obj/item/clothing/neck/elfears

/datum/repeatable_crafting_recipe/survival/wickercloak
	name = "wicker cloak"
	requirements = list(
		/obj/item/natural/dirtclod= 1,
		/obj/item/grown/log/tree/stick= 5,
		/obj/item/natural/fibers = 3,
	)
	attacked_atom = /obj/item/natural/fibers
	starting_atom= /obj/item/natural/dirtclod
	output = /obj/item/clothing/cloak/wickercloak
	craftdiff = 0

/datum/repeatable_crafting_recipe/survival/bog_cowl
	name = "bog cowl"
	requirements = list(
		/obj/item/natural/dirtclod= 1,
		/obj/item/grown/log/tree/stick= 3,
		/obj/item/natural/fibers = 2,
	)
	attacked_atom = /obj/item/natural/fibers
	starting_atom= /obj/item/natural/dirtclod
	output = /obj/item/clothing/neck/bogcowl
	craftdiff = 0

/datum/repeatable_crafting_recipe/survival/skull_mask
	name = "skull mask"
	requirements = list(
		/obj/item/alch/bone= 3,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/natural/fibers
	starting_atom= /obj/item/alch/bone
	output = /obj/item/clothing/face/skullmask
	craftdiff = 0

/datum/repeatable_crafting_recipe/survival/antlerhood
	name = "antler hood"
	requirements = list(
		/obj/item/alch/bone= 2,
		/obj/item/natural/hide = 1,
	)
	attacked_atom = /obj/item/natural/hide
	starting_atom= /obj/item/alch/bone
	output = /obj/item/clothing/head/antlerhood
	craftdiff = 0

/datum/repeatable_crafting_recipe/survival/bone_spear
	name = "bone spear"
	requirements = list(
		/obj/item/weapon/polearm/woodstaff = 1,
		/obj/item/alch/bone= 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/weapon/polearm/woodstaff
	starting_atom= /obj/item/natural/fibers
	output = /obj/item/weapon/polearm/spear/bonespear
	craftdiff = 3

/datum/repeatable_crafting_recipe/survival/bone_axe
	name = "bone axe"
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/alch/bone= 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/natural/fibers
	output = /obj/item/weapon/axe/boneaxe
	craftdiff = 2
