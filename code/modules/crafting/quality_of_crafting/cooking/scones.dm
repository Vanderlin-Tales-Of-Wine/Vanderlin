
/datum/repeatable_crafting_recipe/cooking/unbaked_scones
	name = "Unbaked Scones"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/sugar = 1,
		/obj/item/reagent_containers/food/snacks/butterdough_slice = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/butterdough_slice
	starting_atom = /obj/item/reagent_containers/food/snacks/sugar
	output = /obj/item/reagent_containers/food/snacks/foodbase/scone_raw
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	minimum_skill_level = 2
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Adding sugar to the dough..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/biscuit_poison
	hides_from_books = TRUE
	name = "Unbaked Raisan Biscuit"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/raisins/poison = 1,
		/obj/item/reagent_containers/food/snacks/butterdough_slice = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/butterdough_slice
	starting_atom = /obj/item/reagent_containers/food/snacks/raisins/poison
	output = /obj/item/reagent_containers/food/snacks/foodbase/biscuitpoison_raw
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "Adding raisins to the dough..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_scone_tangerine
	name = "Unbaked Tangerine Scone"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/tangerine = 1,
		/obj/item/reagent_containers/food/snacks/foodbase/scone_raw = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/foodbase/scone_raw
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/tangerine
	output = /obj/item/reagent_containers/food/snacks/foodbase/scone_raw_tangerine
	uses_attacked_atom = TRUE
	craft_time = 5 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "Adding tangerine to the scone..."
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_scone_plum
	name = "Unbaked Plum Scone"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/plum = 1,
		/obj/item/reagent_containers/food/snacks/foodbase/scone_raw = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/foodbase/scone_raw
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/plum
	output = /obj/item/reagent_containers/food/snacks/foodbase/scone_raw_plum
	uses_attacked_atom = TRUE
	craft_time = 5 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "Adding plum to the scone..."
	extra_chance = 100
