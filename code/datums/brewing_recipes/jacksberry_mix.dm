/datum/brewing_recipe/jack_wine
	name = "Jacksberry Wine"
	reagent_to_brew = /datum/reagent/consumable/ethanol/beer/jackberrywine
	needed_reagents = list(/datum/reagent/water = 200)
	needed_crops = list(/obj/item/reagent_containers/food/snacks/produce/jacksberry = 5)
	brewed_amount = 4
	brew_time = 5 MINUTES
	sell_value = 50

	ages = TRUE
	age_times = list(
		/datum/reagent/consumable/ethanol/beer/jackberrywine/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/beer/jackberrywine/delectable = 20 MINUTES
	)
