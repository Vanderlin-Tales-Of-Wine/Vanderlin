/datum/brewing_recipe/cider
	name = "Apple Cider"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider
	needed_reagents = list(/datum/reagent/water = 90)
	needed_crops = list(/obj/item/reagent_containers/food/snacks/produce/fruit/apple = 6)
	brewed_amount = 3
	brew_time = 8 MINUTES
	sell_value = 30

/datum/brewing_recipe/cider/pear
	name = "Pear Cider"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider/pear
	needed_crops = list(/obj/item/reagent_containers/food/snacks/produce/fruit/pear = 6)

/datum/brewing_recipe/strawberry_cider
	name = "Strawberry Cider"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider/strawberry
	pre_reqs = /datum/reagent/consumable/ethanol/cider
	needed_items = list(/obj/item/reagent_containers/food/snacks/produce/fruit/strawberry = 3)
	brewed_amount = 3
	brew_time = 5 MINUTES
	sell_value = 40
