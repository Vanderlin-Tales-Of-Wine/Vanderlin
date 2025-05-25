/datum/repeatable_crafting_recipe/cooking/frybird_tato
	name = "Frybird and Tatos"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/frybird = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/frybird
	starting_atom =/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked
	output = /obj/item/reagent_containers/food/snacks/cooked/frybird_tatos
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/frybird_tato
	hides_from_books = TRUE
	name = "Frybird and Tatos"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/frybird = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked
	starting_atom = /obj/item/reagent_containers/food/snacks/cooked/frybird
	output = /obj/item/reagent_containers/food/snacks/cooked/frybird_tatos
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/frybird_tato
	name = "Frybird and Fried Tatos"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/frybird = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/fried = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/frybird
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/vegetable/potato/fried
	output = /obj/item/reagent_containers/food/snacks/cooked/frybird_tatos
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100


/datum/repeatable_crafting_recipe/cooking/frysteak_tato
	name = "Frysteak and Tatos"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/frysteak = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/frysteak
	starting_atom =/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked
	output = /obj/item/reagent_containers/food/snacks/cooked/frysteak_tatos
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding potato..."

/datum/repeatable_crafting_recipe/cooking/frysteak_tato
	name = "Frysteak and Onions"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/frysteak = 1,
		/obj/item/reagent_containers/food/snacks/onion_fried = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/frysteak
	starting_atom =/obj/item/reagent_containers/food/snacks/onion_fried
	output = /obj/item/reagent_containers/food/snacks/cooked/frysteak_onion
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding onions..."

/datum/repeatable_crafting_recipe/cooking/wiener_cabbage
	name = "Wiener on Cabbage"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/cabbage = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	starting_atom =/obj/item/reagent_containers/food/snacks/produce/vegetable/cabbage
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_cabbage
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding cabbage..."

/datum/repeatable_crafting_recipe/cooking/wiener_cabbage
	hides_from_books = TRUE
	name = "Wiener on Cabbage"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/cabbage = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/vegetable/cabbage
	starting_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_cabbage
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding cabbage..."

/datum/repeatable_crafting_recipe/cooking/wiener_potato
	name = "Wiener on Tato"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	starting_atom =/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_potato
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding potato..."

/datum/repeatable_crafting_recipe/cooking/wiener_potato
	name = "Wiener on Fried Tato"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/fried = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	starting_atom =/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/fried
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_potato
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding potato..."

/datum/repeatable_crafting_recipe/cooking/wiener_potato
	hides_from_books = TRUE
	name = "Wiener on Tato"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/vegetable/potato/baked
	starting_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_potato
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding potato..."

/datum/repeatable_crafting_recipe/cooking/wiener_potato
	name = "Wiener on Onions"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/reagent_containers/food/snacks/onion_fried = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	starting_atom =/obj/item/reagent_containers/food/snacks/onion_fried
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_onion
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding Onions..."

/datum/repeatable_crafting_recipe/cooking/wiener_potato
	hides_from_books = TRUE
	name = "Wiener on Onions"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/reagent_containers/food/snacks/onion_fried = 1,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	attacked_atom = /obj/item/reagent_containers/food/snacks/onion_fried
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_onion
	uses_attacked_atom = TRUE
	craft_time = 2 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Adding Onions..."
