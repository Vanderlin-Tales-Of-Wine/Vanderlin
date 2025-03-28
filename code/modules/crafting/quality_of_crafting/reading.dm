/datum/repeatable_crafting_recipe/reading
	abstract_type = /datum/repeatable_crafting_recipe/reading
	skillcraft = /datum/skill/misc/reading

	tool_usage = list(
		/obj/item/natural/feather = list("starts to write", "start writing", 'sound/items/wood_sharpen.ogg'),
	)
	requirements = list(
		/obj/item/paper = 1,
	)

	attacked_atom = /obj/item/natural/feather
	starting_atom = /obj/item/paper
	craftdiff = 0

/datum/repeatable_crafting_recipe/reading/confessional
	name = "confession"
	output = /obj/item/paper/confession
	requires_learning = TRUE

/datum/repeatable_crafting_recipe/reading/guide
	name = "novice's guide to literature"
	requirements = list(
		/obj/item/paper/scroll = 3,
	)
	starting_atom = /obj/item/paper/scroll
	craftdiff = 2
	output = /obj/item/textbook

/datum/repeatable_crafting_recipe/reading/guide/apprentice
	name = "apprentice's guide to literature"
	output = /obj/item/textbook/apprentice
	craftdiff = 3

/datum/repeatable_crafting_recipe/reading/guide/journeyman
	name = "journeyman's guide to literature"
	output = /obj/item/textbook/journeyman
	craftdiff = 4

/datum/repeatable_crafting_recipe/reading/guide/expert
	name = "expert's guide to literature"
	output = /obj/item/textbook/expert
	craftdiff = 5

/datum/repeatable_crafting_recipe/reading/guide/master
	name = "master's guide to literature"
	output = /obj/item/textbook/master
	craftdiff = 6
