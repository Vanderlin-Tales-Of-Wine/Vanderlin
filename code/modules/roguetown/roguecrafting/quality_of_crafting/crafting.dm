/datum/repeatable_crafting_recipe/crafting
	abstract_type = /datum/repeatable_crafting_recipe/crafting
	skillcraft = /datum/skill/craft/crafting

/datum/repeatable_crafting_recipe/crafting/sspear
	name = "stone spear"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/rogueweapon/polearm/woodstaff = 1,
	)

	starting_atom = /obj/item/rogueweapon/polearm/woodstaff
	attacking_atom = /obj/item/natural/stone
	output = /obj/item/rogueweapon/polearm/spear/stone
	craftdiff = 0
	uses_attacking_atom = TRUE

// /datum/repeatable_crafting_recipe/crafting/wstaff
// 	name = "wooden staff"
// 	requirements = list(
// 		/obj/item/natural/wood/plank = 2,
// 	)

// 	starting_atom =/obj/item/natural/wood/plank
// 	attacking_atom = /obj/item/natural/wood/plank
// 	output = /obj/item/rogueweapon/polearm/woodstaff
// 	craftdiff = 0
// 	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/bow
	name = "wooden bow"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/natural/fibers = 1,
	)

	starting_atom = /obj/item/natural/fibers
	attacking_atom = /obj/item/natural/wood/plank
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/wsword
	name = "wooden sword"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	starting_atom = /obj/item/grown/log/tree/stick
	attacking_atom = /obj/item/natural/wood/plank
	output = /obj/item/rogueweapon/mace/woodclub/train_sword
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/wshield
	name = "wooden shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
	)

	starting_atom = /obj/item/natural/wood/plank
	attacking_atom = /obj/item/natural/wood/plank
	output = /obj/item/rogueweapon/shield/wood/crafted
	uses_attacking_atom = TRUE

/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/repeatable_crafting_recipe/crafting/heatershield
	name = "heater shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/hide = 1,
	)

	starting_atom = /obj/item/natural/wood/plank
	attacking_atom = /obj/item/natural/wood/plank
	output = /obj/item/rogueweapon/shield/heater/crafted
	craftdiff = 2
	uses_attacking_atom = TRUE

/obj/item/rogueweapon/shield/heater/crafted
	sellprice = 6
