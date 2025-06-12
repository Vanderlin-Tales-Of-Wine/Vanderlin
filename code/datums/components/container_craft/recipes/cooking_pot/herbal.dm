/datum/container_craft/cooking/herbal_tea
	abstract_type = /datum/container_craft/cooking/herbal_tea
	category = "Herbal Remedies"
	crafting_time = 8 SECONDS
	reagent_requirements = list(
		/datum/reagent/water = 25
	)
	craft_verb = "brewing "
	required_chem_temp = 350 // Lower temp for gentle herbal brewing
	pollute_amount = 200
	wording_choice = "leaves of"
	complete_message = "The herbal brew smells soothing!"
	used_skill = /datum/skill/craft/alchemy
	quality_modifier = 0.8

// Symphitum Tea Recipe
/datum/container_craft/cooking/herbal_tea/symphitum_tea
	name = "Symphitum Tea"
	created_reagent = /datum/reagent/medicine/herbal/symphitum_tea
	water_conversion = 1
	requirements = list(
		/obj/item/alch/symphitum = 2
	)
	output_amount = 35
	finished_smell = /datum/pollutant/food/teas

// Taraxacum Extract Recipe
/datum/container_craft/cooking/herbal_tea/taraxacum_extract
	name = "Taraxacum Extract"
	created_reagent = /datum/reagent/medicine/herbal/taraxacum_extract
	water_conversion = 1
	requirements = list(
		/obj/item/alch/taraxacum = 3
	)
	output_amount = 30
	crafting_time = 12 SECONDS
	wording_choice = "roots of"
	finished_smell = /datum/pollutant/food/bitter

// Urtica Brew Recipe
/datum/container_craft/cooking/herbal_tea/urtica_brew
	name = "Urtica Brew"
	created_reagent = /datum/reagent/medicine/herbal/urtica_brew
	water_conversion = 1
	requirements = list(
		/obj/item/alch/urtica = 2
	)
	optional_requirements = list(
		/obj/item/alch/irondust = 1 // Iron dust enhances blood restoration
	)
	output_amount = 35
	max_optionals = 1
	finished_smell = /datum/pollutant/food/roasted_seeds

// Calendula Salve Recipe (uses oil instead of water)
/datum/container_craft/cooking/herbal_salve
	abstract_type = /datum/container_craft/cooking/herbal_salve
	category = "Herbal Remedies"
	crafting_time = 15 SECONDS
	reagent_requirements = list(
		/datum/reagent/consumable/ethanol/aqua_vitae = 20
	)
	craft_verb = "preparing "
	required_chem_temp = 320 // Lower temp for salves
	pollute_amount = 150
	wording_choice = "petals of"
	complete_message = "The herbal salve looks ready!"
	used_skill = /datum/skill/craft/alchemy
	quality_modifier = 0.9

/datum/container_craft/cooking/herbal_salve/calendula_salve
	name = "Calendula Salve"
	created_reagent = /datum/reagent/medicine/herbal/calendula_salve
	water_conversion = 1
	requirements = list(
		/obj/item/alch/calendula = 3
	)
	output_amount = 25
	finished_smell = /datum/pollutant/food/flower

// Hypericum Tonic Recipe
/datum/container_craft/cooking/herbal_tea/hypericum_tonic
	name = "Hypericum Tonic"
	created_reagent = /datum/reagent/medicine/herbal/hypericum_tonic
	water_conversion = 1
	requirements = list(
		/obj/item/alch/hypericum = 2
	)
	optional_requirements = list(
		/obj/item/alch/golddust = 1 // Gold dust enhances mana restoration
	)
	output_amount = 30
	max_optionals = 1
	finished_smell = /datum/pollutant/food/bitter

// Mentha Tea Recipe
/datum/container_craft/cooking/herbal_tea/mentha_tea
	name = "Mentha Tea"
	created_reagent = /datum/reagent/medicine/herbal/mentha_tea
	water_conversion = 1
	requirements = list(
		/obj/item/alch/mentha = 2
	)
	output_amount = 35
	crafting_time = 6 SECONDS
	finished_smell = /datum/pollutant/food/mint

// Herbal Buff Teas
/datum/container_craft/cooking/herbal_tea/salvia_wisdom
	name = "Salvia Wisdom Tea"
	created_reagent = /datum/reagent/buff/herbal/salvia_wisdom
	water_conversion = 1
	requirements = list(
		/obj/item/alch/salvia = 2
	)
	optional_requirements = list(
		/obj/item/alch/bonemeal = 1 // Bone meal enhances wisdom
	)
	output_amount = 30
	max_optionals = 1
	finished_smell = /datum/pollutant/food/herb

/datum/container_craft/cooking/herbal_tea/artemisia_luck
	name = "Artemisia Fortune Tea"
	created_reagent = /datum/reagent/buff/herbal/artemisia_luck
	water_conversion = 1
	requirements = list(
		/obj/item/alch/artemisia = 2
	)
	optional_requirements = list(
		/obj/item/alch/silverdust = 1 // Silver dust enhances luck
	)
	output_amount = 30
	max_optionals = 1
	finished_smell = /datum/pollutant/food/bitter

// Mild Poison Recipes
/datum/container_craft/cooking/herbal_tea/weak_atropa
	name = "Dilute Atropa Extract"
	created_reagent = /datum/reagent/poison/herbal/weak_atropa
	water_conversion = 1
	requirements = list(
		/obj/item/alch/atropa = 1
	)
	output_amount = 40 // More diluted
	crafting_time = 5 SECONDS
	finished_smell = /datum/pollutant/food/bitter
	complete_message = "The extract smells dangerous..."

/datum/container_craft/cooking/herbal_tea/matricaria_irritant
	name = "Matricaria Irritant"
	created_reagent = /datum/reagent/poison/herbal/matricaria_irritant
	water_conversion = 1
	requirements = list(
		/obj/item/alch/matricaria = 2
	)
	output_amount = 35
	finished_smell = /datum/pollutant/food/flower

/datum/container_craft/cooking/herbal_tea/rosa_water
	name = "Rosa Water"
	created_reagent = /datum/reagent/medicine/herbal/simple_rosa
	water_conversion = 1
	requirements = list(
		/obj/item/alch/rosa = 1
	)
	output_amount = 40
	crafting_time = 4 SECONDS
	finished_smell = /datum/pollutant/food/flower

/datum/container_craft/cooking/herbal_tea/euphrasia_wash
	name = "Euphrasia Eye Wash"
	created_reagent = /datum/reagent/medicine/herbal/euphrasia_eye_wash
	water_conversion = 1
	requirements = list(
		/obj/item/alch/euphrasia = 2
	)
	output_amount = 35
	finished_smell = /datum/pollutant/food/herb

// Valeriana Sleep Draught (calming/sleep aid)
/datum/container_craft/cooking/herbal_tea/valeriana_draught
	name = "Valeriana Sleep Draught"
	created_reagent = /datum/reagent/medicine/herbal/valeriana_draught
	water_conversion = 1
	requirements = list(
		/obj/item/alch/valeriana = 2,
		/obj/item/alch/mentha = 1
	)
	output_amount = 30
	crafting_time = 10 SECONDS
	finished_smell = /datum/pollutant/food/herb
	complete_message = "The draught smells deeply relaxing..."

// Benedictus Vigor Tea (stamina enhancement)
/datum/container_craft/cooking/herbal_tea/benedictus_vigor
	name = "Benedictus Vigor Tea"
	created_reagent = /datum/reagent/buff/herbal/benedictus_vigor
	water_conversion = 1
	requirements = list(
		/obj/item/alch/benedictus = 2
	)
	optional_requirements = list(
		/obj/item/alch/irondust = 1 // Iron enhances physical vigor
	)
	output_amount = 35
	max_optionals = 1
	finished_smell = /datum/pollutant/food/herb

// Paris Numbing Poultice (topical anesthetic)
/datum/container_craft/cooking/herbal_salve/paris_poultice
	name = "Paris Numbing Poultice"
	created_reagent = /datum/reagent/medicine/herbal/paris_poultice
	water_conversion = 1
	requirements = list(
		/obj/item/alch/paris = 2,
		/obj/item/alch/calendula = 1
	)
	output_amount = 20
	crafting_time = 18 SECONDS
	finished_smell = /datum/pollutant/food/bitter
	complete_message = "The poultice looks thick and medicinal."

// Complex Multi-Herb Recipes

// Herbalist's Panacea (multiple healing herbs)
/datum/container_craft/cooking/herbal_tea/herbalist_panacea
	name = "Herbalist's Panacea"
	created_reagent = /datum/reagent/medicine/herbal/herbalist_panacea
	water_conversion = 1
	requirements = list(
		/obj/item/alch/symphitum = 1,
		/obj/item/alch/calendula = 1,
		/obj/item/alch/urtica = 1
	)
	optional_requirements = list(
		/obj/item/alch/rosa = 1 // Rosa enhances the blend
	)
	output_amount = 25
	max_optionals = 1
	crafting_time = 20 SECONDS
	finished_smell = /datum/pollutant/food/herb
	complete_message = "The panacea glows with herbal potency!"

// Witch's Bane (anti-poison blend)
/datum/container_craft/cooking/herbal_tea/witches_bane
	name = "Witch's Bane"
	created_reagent = /datum/reagent/medicine/herbal/witches_bane
	water_conversion = 1
	requirements = list(
		/obj/item/alch/rosa = 2,
		/obj/item/alch/hypericum = 1
	)
	optional_requirements = list(
		/obj/item/alch/silverdust = 1 // Silver purifies
	)
	output_amount = 30
	max_optionals = 1
	crafting_time = 15 SECONDS
	finished_smell = /datum/pollutant/food/flower

// Scholar's Focus (mental enhancement)
/datum/container_craft/cooking/herbal_tea/scholar_focus
	name = "Scholar's Focus Tea"
	created_reagent = /datum/reagent/buff/herbal/scholar_focus
	water_conversion = 1
	requirements = list(
		/obj/item/alch/mentha = 1,
		/obj/item/alch/euphrasia = 1,
		/obj/item/alch/salvia = 1
	)
	output_amount = 25
	crafting_time = 12 SECONDS
	finished_smell = /datum/pollutant/food/mint
	complete_message = "The tea shimmers with intellectual clarity!"


// Moonwater Elixir (magical enhancement)
/datum/container_craft/cooking/herbal_tea/moonwater_elixir
	name = "Moonwater Elixir"
	created_reagent = /datum/reagent/buff/herbal/moonwater_elixir
	water_conversion = 1
	requirements = list(
		/obj/item/alch/artemisia = 1,
		/obj/item/alch/hypericum = 1
	)
	optional_requirements = list(
		/obj/item/alch/silverdust = 1,
		/obj/item/alch/waterdust = 1
	)
	output_amount = 25
	max_optionals = 2
	crafting_time = 30 SECONDS // Long brewing time
	required_chem_temp = 320
	finished_smell = /datum/pollutant/food/herb
	complete_message = "The elixir glows faintly with moonlight!"

// Battle Stim (combat enhancement)
/datum/container_craft/cooking/herbal_tea/battle_stim
	name = "Warrior's Battle Broth"
	created_reagent = /datum/reagent/buff/herbal/battle_stim
	water_conversion = 1
	requirements = list(
		/obj/item/alch/benedictus = 1,
		/obj/item/alch/valeriana = 1, // Calms nerves
		/obj/item/alch/urtica = 1    // Energizes
	)
	optional_requirements = list(
		/obj/item/alch/irondust = 1  // Strengthens resolve
	)
	output_amount = 30
	max_optionals = 1
	crafting_time = 16 SECONDS
	finished_smell = /datum/pollutant/food/herb

// Experimental Tinctures

// Alchemist's Insight (reveals herb properties)
/datum/container_craft/cooking/herbal_tea/alchemist_insight
	name = "Alchemist's Insight"
	created_reagent = /datum/reagent/buff/herbal/alchemist_insight
	water_conversion = 1
	requirements = list(
		/obj/item/alch/salvia = 1,
		/obj/item/alch/mentha = 1
	)
	optional_requirements = list(
		/obj/item/alch/golddust = 1 // Gold enhances perception
	)
	output_amount = 25
	max_optionals = 1
	crafting_time = 14 SECONDS
	finished_smell = /datum/pollutant/food/herb
	complete_message = "The insight brew swirls with hidden knowledge!"

// Purification Draught (removes negative effects)
/datum/container_craft/cooking/herbal_tea/purification_draught
	name = "Purification Draught"
	created_reagent = /datum/reagent/medicine/herbal/purification_draught
	water_conversion = 1
	requirements = list(
		/obj/item/alch/rosa = 1,
		/obj/item/alch/calendula = 1,
		/obj/item/alch/hypericum = 1
	)
	optional_requirements = list(
		/obj/item/alch/silverdust = 1,
		/obj/item/alch/waterdust = 1
	)
	output_amount = 20
	max_optionals = 2
	crafting_time = 25 SECONDS
	finished_smell = /datum/pollutant/food/flower
	complete_message = "The draught radiates purity and cleansing!"
