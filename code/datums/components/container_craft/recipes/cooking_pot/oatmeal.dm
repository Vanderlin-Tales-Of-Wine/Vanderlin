/datum/container_craft/cooking/oatmeal
	name = "Oatmeal"
	max_optionals = 2
	created_reagent = /datum/reagent/consumable/soup/oatmeal
	requirements = list(/obj/item/reagent_containers/food/snacks/produce/grain/oat = 1)
	optional_wildcard_requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit = 2,
		/obj/item/reagent_containers/food/snacks/produce/vegetable = 2
	)
	wording_choice = "mashed"
