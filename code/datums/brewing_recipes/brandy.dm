/datum/brewing_recipe/brandy
	name = "Apple Brandy"
	reagent_to_brew = /datum/reagent/consumable/ethanol/brandy
	pre_reqs = /datum/reagent/consumable/ethanol/cider
	brewed_amount = 3
	brew_time = 8 MINUTES
	sell_value = 60
	heat_required = 360

/datum/brewing_recipe/brandy/pear
	name = "Pear Brandy"
	pre_reqs = /datum/reagent/consumable/ethanol/cider/pear
	reagent_to_brew = /datum/reagent/consumable/ethanol/brandy/pear
