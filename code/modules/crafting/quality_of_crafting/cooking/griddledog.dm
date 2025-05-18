/datum/repeatable_crafting_recipe/cooking/wiener_stick
	name = "Skewered Wiener"
	subtypes_allowed = TRUE
	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/reagent_containers/food/snacks/cooked/sausage_sticked
	uses_attacked_atom = TRUE
	craft_time = 3 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	extra_chance = 100
	crafting_message = "Skewering the sausage..."

/datum/repeatable_crafting_recipe/cooking/raw_griddle_dog
	name = "Raw Griddledog"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage_sticked = 1,
		/obj/item/reagent_containers/food/snacks/butterdough_slice = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/butterdough_slice
	starting_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage_sticked
	output = /obj/item/reagent_containers/food/snacks/foodbase/griddledog_raw
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/kneading_alt.ogg'
	sound_volume = 90
	crafting_message = "Covering sausage with dough..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/raw_griddledog
	hides_from_books = TRUE
	name = "Raw Griddledog"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cooked/sausage_sticked = 1,
		/obj/item/reagent_containers/food/snacks/butterdough_slice = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cooked/sausage_sticked
	starting_atom = /obj/item/reagent_containers/food/snacks/butterdough_slice
	output = /obj/item/reagent_containers/food/snacks/foodbase/griddledog_raw
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 5 SECONDS
	crafting_sound = 'sound/foley/kneading_alt.ogg'
	extra_chance = 100
	crafting_message = "Covering sausage with dough..."
