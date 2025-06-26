
/datum/container_craft/cooking/herbal_oil
	abstract_type = /datum/container_craft/cooking/herbal_oil
	category = "Herbal Oils"
	crafting_time = 25 SECONDS
	reagent_requirements = list(
		/datum/reagent/consumable/ethanol/ale = 30
	)
	craft_verb = "infusing "
	required_chem_temp = 300 // Low heat for oil infusion
	pollute_amount = 100
	wording_choice = "essence of"
	complete_message = "The oil glistens with herbal essence!"
	used_skill = /datum/skill/craft/alchemy
	quality_modifier = 1.0

// Rosa Oil (perfume/cosmetic)
/datum/container_craft/cooking/herbal_oil/rosa_oil
	name = "Rosa Perfume Oil"
	created_reagent = /datum/reagent/consumable/herbal/rosa_oil
	water_conversion = 1
	requirements = list(
		/obj/item/alch/rosa = 3
	)
	output_amount = 20
	finished_smell = /datum/pollutant/food/flower

// Mentha Cooling Oil (muscle relief)
/datum/container_craft/cooking/herbal_oil/mentha_oil
	name = "Mentha Cooling Oil"
	created_reagent = /datum/reagent/medicine/herbal/mentha_oil
	water_conversion = 1
	requirements = list(
		/obj/item/alch/mentha = 2,
		/obj/item/alch/euphrasia = 1
	)
	output_amount = 25
	finished_smell = /datum/pollutant/food/mint
