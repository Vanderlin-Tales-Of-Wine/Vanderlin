/datum/repeatable_crafting_recipe/survival
	abstract_type = /datum/repeatable_crafting_recipe/survival

/datum/repeatable_crafting_recipe/cloth
	name = "cloth"
	requirements = list(
		/obj/item/natural/fibers = 2
	)
	tool_usage = list(
		/obj/item/needle = list("starts to sew", "start to sew")
	)

	starting_atom = /obj/item/needle
	attacking_atom = /obj/item/natural/fibers
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
	attacking_atom = /obj/item/natural/thorn
	output = /obj/item/needle/thorn
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/dart
	name = "dart"
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/thorn = 1,
	)

	starting_atom = /obj/item/natural/thorn
	attacking_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/ammo_casing/caseless/rogue/dart
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/rope
	name = "rope"
	requirements = list(
		/obj/item/natural/fibers = 3
	)

	starting_atom = /obj/item/natural/fibers
	attacking_atom = /obj/item/natural/fibers
	output = /obj/item/rope
	craftdiff = 0
	crafting_message = "starts to braid some fibers"
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/torch
	name = "torch"
	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	starting_atom = /obj/item/natural/fibers
	attacking_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/flashlight/flare/torch
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_axe
	name = "stone axe"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/grown/log/tree/small = 1,
	)

	starting_atom = /obj/item/natural/stone
	attacking_atom = /obj/item/grown/log/tree/small
	output = /obj/item/rogueweapon/axe/stone
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_knife
	name = "stone knife"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	starting_atom = /obj/item/natural/stone
	attacking_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/rogueweapon/knife/stone
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_spear
	name = "stone spear"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/rogueweapon/polearm/woodstaff = 1,
	)

	starting_atom = /obj/item/natural/stone
	attacking_atom = /obj/item/rogueweapon/polearm/woodstaff
	output = /obj/item/rogueweapon/polearm/spear/stone
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_pot
	name = "stone pot"
	requirements = list(
		/obj/item/natural/stone = 2,
	)

	starting_atom = /obj/item/natural/stone
	attacking_atom = /obj/item/natural/stone
	output = /obj/item/reagent_containers/glass/bucket/pot
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/survival/stone_mortar
	name = "stone mortar"
	requirements = list(
		/obj/item/natural/stone = 1,
	)

	starting_atom = /obj/item/rogueweapon/knife
	attacking_atom = /obj/item/natural/stone
	output = /obj/item/reagent_containers/glass/mortar
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/survival/alchemy_mortar
	name = "alchemical mortar"
	requirements = list(
		/obj/item/natural/stone = 3,
	)

	starting_atom = /obj/item/rogueweapon/knife
	attacking_atom = /obj/item/natural/stone
	output = /obj/item/mortar
	craftdiff = 0
	skillcraft = /datum/skill/craft/masonry
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/survival/pestle
	name = "pestle"
	requirements = list(
		/obj/item/natural/stone = 2,
	)

	starting_atom = /obj/item/rogueweapon/knife
	attacking_atom = /obj/item/natural/stone
	output = /obj/item/pestle
	craftdiff = 0
	skillcraft = /datum/skill/craft/masonry
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/survival/bag
	name = "bag"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	tool_usage = list(
		/obj/item/needle = list("starts to sew", "start to sew")
	)
	starting_atom = /obj/item/needle
	attacking_atom = /obj/item/natural/cloth
	output = /obj/item/storage/roguebag/crafted
	craftdiff = 0
	skillcraft = /datum/skill/misc/sewing
	subtypes_allowed = TRUE
