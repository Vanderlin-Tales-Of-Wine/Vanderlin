/datum/brewing_recipe/jack_wine
	name = "Jacksberry Wine"
	reagent_to_brew = /datum/reagent/consumable/ethanol/jackberrywine
	needed_reagents = list(/datum/reagent/water = 198)
	needed_crops = list(/obj/item/reagent_containers/food/snacks/produce/jacksberry = 5)
	brewed_amount = 4
	brew_time = 5 MINUTES
	sell_value = 50

	ages = TRUE
	age_times = list(
		/datum/reagent/consumable/ethanol/jackberrywine/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/jackberrywine/delectable = 20 MINUTES
	)

/datum/brewing_recipe/plum_wine
	name = "Umeshu"
	reagent_to_brew = /datum/reagent/consumable/ethanol/plum_wine
	needed_reagents = list(/datum/reagent/water = 90)
	needed_items = list(/obj/item/reagent_containers/food/snacks/produce/plum = 3, /obj/item/reagent_containers/food/snacks/sugar = 1)
	brewed_amount = 3
	brew_time = 6 MINUTES
	sell_value = 35
	age_times = list(
		/datum/reagent/consumable/ethanol/plum_wine/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/plum_wine/delectable = 20 MINUTES
	)

/datum/brewing_recipe/tangerine_wine
	name = "Tangerine Wine"
	reagent_to_brew = /datum/reagent/consumable/ethanol/tangerine
	needed_reagents = list(/datum/reagent/water = 90)
	needed_items = list(/obj/item/reagent_containers/food/snacks/produce/tangerine = 3, /obj/item/reagent_containers/food/snacks/sugar = 1)
	brewed_amount = 3
	brew_time = 6 MINUTES
	sell_value = 35
	age_times = list(
		/datum/reagent/consumable/ethanol/tangerine/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/tangerine/delectable = 20 MINUTES
	)

/datum/brewing_recipe/raspberry_wine
	name = "Raspberry Wine"
	reagent_to_brew = /datum/reagent/consumable/ethanol/raspberry
	needed_reagents = list(/datum/reagent/water = 90)
	needed_items = list(/obj/item/reagent_containers/food/snacks/produce/raspberry = 3, /obj/item/reagent_containers/food/snacks/sugar = 1)
	brewed_amount = 3
	brew_time = 6 MINUTES
	sell_value = 35
	age_times = list(
		/datum/reagent/consumable/ethanol/raspberry/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/raspberry/delectable = 20 MINUTES
	)

/datum/brewing_recipe/blackberry_wine
	name = "Blackberry Wine"
	reagent_to_brew = /datum/reagent/consumable/ethanol/blackberry
	needed_reagents = list(/datum/reagent/water = 90)
	needed_items = list(/obj/item/reagent_containers/food/snacks/produce/blackberry = 3, /obj/item/reagent_containers/food/snacks/sugar = 1)
	brewed_amount = 3
	brew_time = 6 MINUTES
	sell_value = 35
	age_times = list(
		/datum/reagent/consumable/ethanol/blackberry/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/blackberry/delectable = 20 MINUTES
	)


/datum/brewing_recipe/tiefling_wine
	name = "Tiefling Blood Wine"
	reagent_to_brew = /datum/reagent/consumable/ethanol/tiefling
	needed_reagents = list(/datum/reagent/water = 90, /datum/reagent/blood/tiefling = 60)
	needed_items = list(/obj/item/reagent_containers/food/snacks/sugar = 1)
	brewed_amount = 3
	brew_time = 6 MINUTES
	sell_value = 90
	age_times = list(
		/datum/reagent/consumable/ethanol/tiefling/aged = 10 MINUTES,
		/datum/reagent/consumable/ethanol/tiefling/delectable = 20 MINUTES
	)
