/datum/container_craft/cooking/tea
	category = "Teas"
	abstract_type = /datum/container_craft/cooking/tea
	pollute_amount = 100
	finished_smell = /datum/pollutant/food/teas
	max_optionals = 2
	optional_reagent_requirements = list(/datum/reagent/consumable/milk = 6)
	optional_requirements = list(/obj/item/reagent_containers/food/snacks/sugar = 1)


/datum/container_craft/cooking/tea/after_craft(atom/created_output, obj/item/crafter, mob/initiator, list/found_optional_requirements, list/found_optional_wildcards, list/found_optional_reagents, list/removing_items)
	var/datum/reagent/found_product = crafter.reagents.get_reagent(created_reagent)

	if(!length(found_optional_requirements) && !length(found_optional_reagents))
		return

	var/extra_string = " with "

	var/first_ingredient
	if(length(found_optional_requirements))
		extra_string += "sugar"
		first_ingredient = FALSE

	if(length(found_optional_reagents))
		if(!first_ingredient)
			extra_string += " and "
		extra_string += "milk"

	found_product.name += extra_string


/datum/container_craft/cooking/tea/taraxamint
	name = "Taraxacum-Mentha tea"
	crafting_time = 60 SECONDS
	water_conversion = 0.6
	created_reagent = /datum/reagent/consumable/tea/taraxamint
	requirements = list(
		/obj/item/alch/taraxacum = 1,
		/obj/item/alch/mentha = 1
	)

/datum/container_craft/cooking/tea/utricasalvia
	name = "Urtica-Salvia tea"
	crafting_time = 60 SECONDS
	water_conversion = 0.6
	created_reagent = /datum/reagent/consumable/tea/utricasalvia
	requirements = list(/obj/item/alch/urtica = 1, /obj/item/alch/salvia = 1)

/datum/container_craft/cooking/tea/badidea
	name = "westleach tar tea"
	crafting_time = 40 SECONDS
	water_conversion = 0.2
	created_reagent = /datum/reagent/consumable/tea/badidea
	requirements = list(/obj/item/reagent_containers/food/snacks/produce/dry_westleach = 3)
	finished_smell = /datum/pollutant/food/fried_rat

/datum/container_craft/cooking/tea/fourtwenty
	name = "swampweed brew"
	crafting_time = 40 SECONDS
	water_conversion = 0.6
	created_reagent = /datum/reagent/consumable/tea/fourtwenty
	requirements = list(/obj/item/reagent_containers/food/snacks/produce/swampweed_dried = 2)
	finished_smell = /datum/pollutant/food/druqks

/datum/container_craft/cooking/tea/manabloom
	name = "Manabloom tea"
	crafting_time = 40 SECONDS
	water_conversion = 0.6
	created_reagent = /datum/reagent/consumable/tea/manabloom
	requirements = list(/obj/item/reagent_containers/food/snacks/produce/manabloom = 2)
	finished_smell = /datum/pollutant/food/druqks

/datum/container_craft/cooking/tea/compot
	name = "Compot"
	crafting_time = 90 SECONDS
	water_conversion = 0.3
	created_reagent = /datum/reagent/consumable/tea/compot
	requirements = list(/obj/item/reagent_containers/food/snacks/raisins = 2)
	finished_smell = /datum/pollutant/food/druqks

