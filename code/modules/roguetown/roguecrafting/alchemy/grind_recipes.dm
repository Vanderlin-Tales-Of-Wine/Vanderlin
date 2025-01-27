/datum/alch_grind_recipe
	var/picky = TRUE // if TRUE: the item path MUST MATCH, and cannot be a subtype.
	var/valid_input = null //the typepath that, when ground, makes an output
	var/list/valid_outputs = list() //List of [Itempath = amnt?1] to be created always
	var/list/bonus_chance_outputs = list() //List of [Itempath = chance/100] to create sometimes.

/datum/alch_grind_recipe/sinew
	valid_input = /obj/item/alch/sinew
	valid_outputs = list(/obj/item/alch/viscera = 1)
	bonus_chance_outputs = list(/obj/item/alch/viscera = 75)

//Runes -> dust
/datum/alch_grind_recipe/fire_rune
	valid_input = /obj/item/rune/spell/fire_rune
	valid_outputs = list(/obj/item/alch/firedust = 2)
	bonus_chance_outputs = list(/obj/item/alch/firedust = 33)

/datum/alch_grind_recipe/water_rune
	valid_input = /obj/item/rune/spell/water_rune
	valid_outputs = list(/obj/item/alch/waterdust = 2)
	bonus_chance_outputs = list(/obj/item/alch/waterdust = 33)

/datum/alch_grind_recipe/air_rune
	valid_input = /obj/item/rune/spell/air_rune
	valid_outputs = list(/obj/item/alch/airdust = 2)
	bonus_chance_outputs = list(/obj/item/alch/airdust = 33)

/datum/alch_grind_recipe/earth_rune
	valid_input = /obj/item/rune/spell/earth_rune
	valid_outputs = list(/obj/item/alch/earthdust = 2)
	bonus_chance_outputs = list(/obj/item/alch/earthdust = 33)

/datum/alch_grind_recipe/blank_rune
	valid_input = /obj/item/rune/spell/blank_rune
	valid_outputs = list(/obj/item/alch/runedust = 2)
	bonus_chance_outputs = list(/obj/item/alch/runedust = 33)

//Objects -> dusts
/datum/alch_grind_recipe/crow
	valid_input = /obj/item/reagent_containers/food/snacks/crow
	valid_outputs = list(/obj/item/alch/airdust = 1)
	bonus_chance_outputs = list(/obj/item/alch/airdust = 33)

/datum/alch_grind_recipe/bone
	valid_input = /obj/item/alch/bone
	valid_outputs = list( /obj/item/alch/bonemeal = 2)
	bonus_chance_outputs = list(/obj/item/alch/bonemeal = 50)

/datum/alch_grind_recipe/horn
	valid_input = /obj/item/alch/horn
	valid_outputs = list(/obj/item/alch/earthdust = 1,/obj/item/alch/bonemeal = 2)
	bonus_chance_outputs = list(/obj/item/alch/earthdust = 66)

/datum/alch_grind_recipe/fish
	picky = FALSE
	valid_input = /obj/item/reagent_containers/food/snacks/fish
	valid_outputs = list(/obj/item/alch/waterdust = 1)
	bonus_chance_outputs = list(/obj/item/alch/bonemeal = 50)

/datum/alch_grind_recipe/swampweed
	valid_input = /obj/item/reagent_containers/food/snacks/produce/swampweed
	valid_outputs = list(/obj/item/alch/swampdust = 1)
	bonus_chance_outputs = list(/obj/item/alch/earthdust = 33)

/datum/alch_grind_recipe/swampweed_dried
	valid_input = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried
	valid_outputs = list(/obj/item/alch/swampdust = 1)
	bonus_chance_outputs = list(/obj/item/alch/earthdust = 50,/obj/item/alch/swampdust = 50)

/datum/alch_grind_recipe/westleach
	valid_input = /obj/item/reagent_containers/food/snacks/produce/westleach
	valid_outputs = list(/obj/item/alch/tobaccodust = 1)
	bonus_chance_outputs = list(/obj/item/alch/airdust = 33)

/datum/alch_grind_recipe/dry_westleach
	valid_input = /obj/item/reagent_containers/food/snacks/produce/dry_westleach
	valid_outputs = list(/obj/item/alch/tobaccodust = 1)
	bonus_chance_outputs = list(/obj/item/alch/airdust = 50,/obj/item/alch/tobaccodust = 50)

/datum/alch_grind_recipe/fyritius
	valid_input = /obj/item/reagent_containers/food/snacks/produce/fyritius
	valid_outputs = list(/obj/item/alch/firedust = 1)

/datum/alch_grind_recipe/poppy
	valid_input = /obj/item/reagent_containers/food/snacks/produce/poppy
	valid_outputs = list(/obj/item/reagent_containers/powder/ozium = 1)
	bonus_chance_outputs = list(/obj/item/alch/airdust =33,/obj/item/alch/earthdust = 33)

/datum/alch_grind_recipe/seeds
	picky = FALSE
	valid_input = /obj/item/neuFarm/seed
	valid_outputs = list(/obj/item/alch/seeddust = 1)
	bonus_chance_outputs = list(/obj/item/alch/airdust =25,/obj/item/alch/earthdust = 25)

/datum/alch_grind_recipe/seedsherb
	picky = FALSE
	valid_input = /obj/item/herbseed
	valid_outputs = list(/obj/item/alch/seeddust = 1)
	bonus_chance_outputs = list(/obj/item/alch/airdust =25,/obj/item/alch/earthdust = 25)

/datum/alch_grind_recipe/ozium
	valid_input = /obj/item/reagent_containers/powder/ozium
	valid_outputs = list(/obj/item/alch/ozium = 1)
	bonus_chance_outputs = list(/obj/item/alch/airdust =25,/obj/item/alch/ozium = 25)

//Ores -> dust
/datum/alch_grind_recipe/gold_ore
	valid_input = /obj/item/rogueore/gold
	valid_outputs = list(/obj/item/alch/golddust = 1)
	bonus_chance_outputs = list(/obj/item/alch/golddust = 33)

/datum/alch_grind_recipe/silver_ore
	valid_input = /obj/item/rogueore/silver
	valid_outputs = list(/obj/item/alch/silverdust = 1)
	bonus_chance_outputs = list(/obj/item/alch/silverdust = 33)

/datum/alch_grind_recipe/iron_ore
	valid_input = /obj/item/rogueore/iron
	valid_outputs = list(/obj/item/alch/irondust = 1)
	bonus_chance_outputs = list(/obj/item/alch/irondust = 33)

/datum/alch_grind_recipe/coal_ore
	valid_input = /obj/item/rogueore/coal
	valid_outputs = list(/obj/item/alch/coaldust = 1)
	bonus_chance_outputs = list(/obj/item/alch/coaldust = 33)

/datum/alch_grind_recipe/gold_bar
	valid_input = /obj/item/ingot/gold
	valid_outputs = list(/obj/item/alch/golddust = 1)
	bonus_chance_outputs = list(/obj/item/alch/golddust = 33)

/datum/alch_grind_recipe/silver_bar
	valid_input = /obj/item/ingot/silver
	valid_outputs = list(/obj/item/alch/silverdust = 1)
	bonus_chance_outputs = list(/obj/item/alch/silverdust = 33)

/datum/alch_grind_recipe/iron_bar
	valid_input = /obj/item/ingot/iron
	valid_outputs = list(/obj/item/alch/irondust = 1)
	bonus_chance_outputs = list(/obj/item/alch/irondust = 33)

//Herb -> Herbseed
/datum/alch_grind_recipe/atropa_seed
	valid_input = /obj/item/alch/atropa
	valid_outputs = list(/obj/item/herbseed/atropa = 1)

/datum/alch_grind_recipe/matricaria_seed
	valid_input = /obj/item/alch/matricaria
	valid_outputs = list(/obj/item/herbseed/matricaria = 1)

/datum/alch_grind_recipe/symphitum_seed
	valid_input = /obj/item/alch/symphitum
	valid_outputs = list(/obj/item/herbseed/symphitum = 1)

/datum/alch_grind_recipe/taraxacum_seed
	valid_input = /obj/item/alch/taraxacum
	valid_outputs = list(/obj/item/herbseed/taraxacum = 1)

/datum/alch_grind_recipe/euphrasia_seed
	valid_input = /obj/item/alch/euphrasia
	valid_outputs = list(/obj/item/herbseed/euphrasia = 1)

/datum/alch_grind_recipe/paris_seed
	valid_input = /obj/item/alch/paris
	valid_outputs = list(/obj/item/herbseed/paris = 1)

/datum/alch_grind_recipe/calendula_seed
	valid_input = /obj/item/alch/calendula
	valid_outputs = list(/obj/item/herbseed/calendula = 1)

/datum/alch_grind_recipe/mentha_seed
	valid_input = /obj/item/alch/mentha
	valid_outputs = list(/obj/item/herbseed/mentha = 1)

/datum/alch_grind_recipe/urtica_seed
	valid_input = /obj/item/alch/urtica
	valid_outputs = list(/obj/item/herbseed/urtica = 1)

/datum/alch_grind_recipe/salvia_seed
	valid_input = /obj/item/alch/salvia
	valid_outputs = list(/obj/item/herbseed/salvia = 1)

/datum/alch_grind_recipe/hypericum_seed
	valid_input = /obj/item/alch/hypericum
	valid_outputs = list(/obj/item/herbseed/hypericum = 1)

/datum/alch_grind_recipe/benedictus_seed
	valid_input = /obj/item/alch/benedictus
	valid_outputs = list(/obj/item/herbseed/benedictus = 1)

/datum/alch_grind_recipe/valeriana_seed
	valid_input = /obj/item/alch/valeriana
	valid_outputs = list(/obj/item/herbseed/valeriana = 1)

/datum/alch_grind_recipe/artemisia_seed
	valid_input = /obj/item/alch/artemisia
	valid_outputs = list(/obj/item/herbseed/artemisia = 1)

