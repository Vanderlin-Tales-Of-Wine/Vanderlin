
/datum/repeatable_crafting_recipe/cooking/raw_handpie_mushroom
	name = "Raw Mushroom Handpie"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/truffles = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/truffles
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/mushroom
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_handpie_mushroom
	name = "Raw Mince Handpie"

	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/mince = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/meat/mince
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/mince
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_handpie_poison
	hides_from_books = TRUE
	name = "Raw Berry Handpie"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/poison
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_handpie_berry
	name = "Raw Berry Handpie"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/berry
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_handpie_apple
	name = "Raw Apple Handpie"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/apple = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/apple
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/apple
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_handpie_gote
	name = "Raw Gote Cheese Handpie"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cheese/gote = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/cheese/gote
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_handpie_cheddar
	name = "Raw Cheddar Cheese Handpie"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cheese_wedge = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/cheese_wedge
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_handpie_fresh
	name = "Raw Fresh Cheese Handpie"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cheese = 1,
		/obj/item/reagent_containers/food/snacks/piedough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/piedough
	starting_atom = /obj/item/reagent_containers/food/snacks/cheese
	output = /obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese
	uses_attacked_atom = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Making a handpie..."
	extra_chance = 100
