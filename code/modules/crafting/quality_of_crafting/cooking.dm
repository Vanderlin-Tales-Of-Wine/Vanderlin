/datum/repeatable_crafting_recipe/cooking
	abstract_type = /datum/repeatable_crafting_recipe/cooking
	skillcraft = /datum/skill/craft/cooking


/datum/repeatable_crafting_recipe/cooking/soap
	name = "soap"
	tool_usage = list(
		/obj/item/pestle = list("starts to grind materials in the mortar", "start to grind materials in the mortar", 'sound/foley/mortarpestle.ogg'),
	)

	reagent_requirements = list(
		/datum/reagent/water = 10,
	)
	requirements = list(
		/obj/item/ash = 1,
		/obj/item/reagent_containers/food/snacks/fat = 1,
	)
	output = /obj/item/soap
	starting_atom = /obj/item/pestle
	attacked_atom = /obj/item/reagent_containers/glass/mortar
	tool_use_time = 4 SECONDS
	craft_time = 6 SECONDS

/datum/repeatable_crafting_recipe/cooking/soap/bath
	name = "herbal soap "
	tool_usage = list(
		/obj/item/pestle = list("starts to grind materials in the mortar", "start to grind materials in the mortar", 'sound/foley/mortarpestle.ogg'),
	)

	requirements = list(
		/obj/item/ash = 1,
		/obj/item/reagent_containers/food/snacks/fat = 1,
		/obj/item/alch/mentha = 1,
	)
	output = /obj/item/soap/bath
