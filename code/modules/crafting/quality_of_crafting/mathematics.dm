/datum/repeatable_crafting_recipe/mathematics
	abstract_type = /datum/repeatable_crafting_recipe/mathematics
	skillcraft = /datum/skill/labor/mathematics

	tool_usage = list(
		/obj/item/natural/feather = list("starts to write", "start writing", 'sound/items/wood_sharpen.ogg'),
	)
	requirements = list(
		/obj/item/paper/scroll = 3,
	)

	attacked_atom = /obj/item/natural/feather
	starting_atom = /obj/item/paper

/datum/repeatable_crafting_recipe/mathematics/guide
	name = "novice's guide to mathematics"
	starting_atom = /obj/item/paper/scroll
	craftdiff = 2
	output = /obj/item/textbook/mathematics

/datum/repeatable_crafting_recipe/mathematics/guide/apprentice
	name = "apprentice's guide to mathematics"
	output = /obj/item/textbook/apprentice/mathematics
	craftdiff = 3

/datum/repeatable_crafting_recipe/mathematics/guide/journeyman
	name = "journeyman's guide to mathematics"
	output = /obj/item/textbook/journeyman/mathematics
	craftdiff = 4

/datum/repeatable_crafting_recipe/mathematics/guide/expert
	name = "expert's guide to mathematics"
	output = /obj/item/textbook/expert/mathematics
	craftdiff = 5

/datum/repeatable_crafting_recipe/mathematics/guide/master
	name = "master's guide to mathematics"
	output = /obj/item/textbook/master/mathematics
	craftdiff = 6
