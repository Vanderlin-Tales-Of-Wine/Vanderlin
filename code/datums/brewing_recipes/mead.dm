/datum/brewing_recipe/spidermead
	name = "Spider Honey Mead"
	reagent_to_brew = /datum/reagent/consumable/ethanol/mead/spider
	needed_reagents = list(/datum/reagent/water = 99)
	needed_items = list(/obj/item/reagent_containers/food/snacks/spiderhoney = 4)
	brewed_amount = 3
	brew_time = 3 MINUTES
	sell_value = 75

/datum/brewing_recipe/mead
	name = "Mead"
	reagent_to_brew = /datum/reagent/consumable/ethanol/mead
	needed_reagents = list(/datum/reagent/water = 99)
	needed_items = list(/obj/item/reagent_containers/food/snacks/spiderhoney/honey = 4)
	brewed_amount = 3
	brew_time = 3 MINUTES
	sell_value = 30
