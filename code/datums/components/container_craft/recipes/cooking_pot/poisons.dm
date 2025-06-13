// Atropa Concentrate (deadly poison)
/datum/container_craft/cooking/herbal_tea/atropa_concentrate
	name = "Atropa Death Draught"
	created_reagent = /datum/reagent/poison/herbal/atropa_concentrate
	water_conversion = 1
	requirements = list(
		/obj/item/alch/atropa = 3,
		/obj/item/alch/matricaria = 1
	)
	output_amount = 20 // Small amount of concentrated poison
	crafting_time = 15 SECONDS
	finished_smell = /datum/pollutant/food/bitter
	complete_message = "The draught reeks of death and malice..."

// Swamp Miasma (area poison)
/datum/container_craft/cooking/herbal_tea/swamp_miasma
	name = "Swamp Miasma"
	created_reagent = /datum/reagent/poison/herbal/swamp_miasma
	water_conversion = 1
	requirements = list(
		/obj/item/alch/swampdust = 2,
		/obj/item/alch/paris = 1
	)
	output_amount = 30
	crafting_time = 8 SECONDS
	finished_smell = /datum/pollutant/food/bitter
	complete_message = "Noxious vapors rise from the mixture..."
