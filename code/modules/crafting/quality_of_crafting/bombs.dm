/datum/repeatable_crafting_recipe/bomb
	abstract_type = /datum/repeatable_crafting_recipe/bomb
	skillcraft = /datum/skill/craft/bombs
	craftdiff = 2

/datum/repeatable_crafting_recipe/bomb/homemade
	name = "homemade bottle bomb"

	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
		/obj/item/reagent_containers/glass/bottle = 1,
	)
	reagent_requirements = list(
		/datum/reagent/consumable/ethanol = 10
	)

	starting_atom = /obj/item/natural/cloth
	attacked_atom = /obj/item/reagent_containers/glass/bottle
	output = /obj/item/bomb/homemade
	craft_time = 1 SECONDS
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE
	reagent_subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/bomb/smokebomb
	name = "smoke bomb"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/ash = 2,
	)

	starting_atom = /obj/item/reagent_containers/glass/bottle
	attacked_atom = /obj/item/ash
	output = /obj/item/smokebomb
	craft_time = 1 SECONDS
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE
