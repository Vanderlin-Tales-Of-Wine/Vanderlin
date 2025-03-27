/datum/repeatable_crafting_recipe/bomb
	abstract_type = /datum/repeatable_crafting_recipe/bomb
	skillcraft = /datum/skill/craft/bombs
	craftdiff = 2

/datum/repeatable_crafting_recipe/bomb
	name = "bottle bomb"

	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
		/obj/item/reagent_containers/glass/bottle = 1,
	)

	starting_atom = /obj/item/natural/cloth
	attacked_atom = /obj/item/reagent_containers/glass/bottle
	output = /obj/item/bomb/homemade
	craft_time = 1 SECONDS
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE
