/datum/brewing_recipe/cider
	name = "Apple Cider"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider
	needed_reagents = list(/datum/reagent/water = 90)
	needed_crops = list(/obj/item/reagent_containers/food/snacks/produce/apple = 6)
	brewed_amount = 3
	brew_time = 8 MINUTES
	sell_value = 30

/datum/brewing_recipe/cider/pear
	name = "Pear Cider"
	reagent_to_brew = /datum/reagent/consumable/ethanol/cider/pear
	needed_crops = list(/obj/item/reagent_containers/food/snacks/produce/pear = 6)
