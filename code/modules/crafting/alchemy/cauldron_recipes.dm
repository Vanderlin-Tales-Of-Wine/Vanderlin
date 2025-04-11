/datum/alch_cauldron_recipe
	var/recipe_name = "" //The name of the recipe, kinda there just in case.
	var/smells_like = "nothing" //cauldron emits this smell when done, and alchemists can sniff ingredients to find what they do
	var/list/output_reagents = list() //list of paths of new reagents to create in the cauldron. Remember, 1 oz is 3 units! [reagent = amnt]
	var/list/output_items = list() //List of paths for new items that should be created, [path = chance to be created]

/datum/alch_cauldron_recipe/disease_cure
	recipe_name = "Disease Cure"
	smells_like = "purity"
	output_reagents = list(/datum/reagent/medicine/diseasecure = 81)

/datum/alch_cauldron_recipe/antidote
	recipe_name = "Antidote"
	smells_like = "wet moss"
	output_reagents = list(/datum/reagent/medicine/antidote = 81)

/datum/alch_cauldron_recipe/berrypoison
	recipe_name = "Poison"
	smells_like = "death"
	output_reagents = list(/datum/reagent/berrypoison = 81)

/datum/alch_cauldron_recipe/doompoison
	recipe_name = "Strong Poison"
	smells_like = "doom"
	output_reagents = list(/datum/reagent/berrypoison = 81,/datum/reagent/additive = 81)

/datum/alch_cauldron_recipe/stam_poison
	recipe_name = "Stamina Poison"
	smells_like = "a slow breeze"
	output_reagents = list(/datum/reagent/stampoison = 81)

/datum/alch_cauldron_recipe/big_stam_poison
	recipe_name = "Strong Stamina Poison"
	smells_like = "stagnant air"
	output_reagents = list(/datum/reagent/stampoison = 81,/datum/reagent/additive = 81)

/datum/alch_cauldron_recipe/gender_potion
	recipe_name = "Gender Potion"
	smells_like = "living beings"
	output_reagents = list(/datum/reagent/medicine/gender_potion = 9)

//Healing potions
/datum/alch_cauldron_recipe/health_potion
	recipe_name = "Elixir of Health"
	smells_like = "sweet berries"
	output_reagents = list(/datum/reagent/medicine/healthpot = 81)

/datum/alch_cauldron_recipe/big_health_potion
	recipe_name = "Strong Elixir of Health"
	smells_like = "berry pie"
	output_reagents = list(/datum/reagent/medicine/healthpot = 81,/datum/reagent/additive = 81)

/datum/alch_cauldron_recipe/rosewater_potion
	recipe_name = "Rose Water"
	smells_like = "roses"
	output_reagents = list(/datum/reagent/medicine/rosewater = 81)

/datum/alch_cauldron_recipe/mana_potion
	recipe_name = "Arcane Elixir"
	smells_like = "power"
	output_reagents = list(/datum/reagent/medicine/manapot = 81)

/datum/alch_cauldron_recipe/big_mana_potion
	recipe_name = "Powerful Arcane Elixir"
	smells_like = "fear"
	output_reagents = list(/datum/reagent/medicine/manapot = 81,/datum/reagent/additive = 81)

/datum/alch_cauldron_recipe/stamina_potion
	recipe_name = "Stamina Elixir"
	smells_like = "fresh air"
	output_reagents = list(/datum/reagent/medicine/stampot = 81)

/datum/alch_cauldron_recipe/big_stamina_potion
	recipe_name = "Powerful Stamina Elixir"
	smells_like = "clean winds"
	output_reagents = list(/datum/reagent/medicine/stampot = 81,/datum/reagent/additive = 81)

//S.P.E.C.I.A.L. potions
/datum/alch_cauldron_recipe/str_potion
	recipe_name = "Potion of Mountain Muscles"
	smells_like = "petrichor"
	output_reagents = list(/datum/reagent/buff/strength = 27)

/datum/alch_cauldron_recipe/per_potion
	recipe_name = "Potion of Keen Eye"
	smells_like = "fire"
	output_reagents = list(/datum/reagent/buff/perception = 27)

/datum/alch_cauldron_recipe/end_potion
	recipe_name = "Potion of Enduring Fortitude"
	smells_like = "mountain air"
	output_reagents = list(/datum/reagent/buff/endurance = 27)

/datum/alch_cauldron_recipe/con_potion
	recipe_name = "Potion of Stone Flesh"
	smells_like = "earth"
	output_reagents = list(/datum/reagent/buff/constitution = 27)

/datum/alch_cauldron_recipe/int_potion
	recipe_name = "Potion of Keen Mind"
	smells_like = "water"
	output_reagents = list(/datum/reagent/buff/intelligence = 27)

/datum/alch_cauldron_recipe/spd_potion
	recipe_name = "Potion of Fleet Foot"
	smells_like = "clean air"
	output_reagents = list(/datum/reagent/buff/speed = 27)

/datum/alch_cauldron_recipe/lck_potion
	recipe_name = "Potion of Seven Clovers"
	smells_like = "calming"
	output_reagents = list(/datum/reagent/buff/fortune = 27)
