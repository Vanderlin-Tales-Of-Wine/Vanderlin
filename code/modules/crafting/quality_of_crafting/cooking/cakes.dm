
/datum/repeatable_crafting_recipe/cooking/chescake_poison
	hides_from_books = TRUE
	category = "Cakes"
	name = "Cheesecake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison
	output = /obj/item/reagent_containers/food/snacks/chescake_poison
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "add some juicy fruit filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/chescake_poison_raisan
	hides_from_books = TRUE
	category = "Cakes"
	name = "Berry Cheesecake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/raisins/poison = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/raisins/poison
	output = /obj/item/reagent_containers/food/snacks/chescake_poison
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "add some juicy fruit filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/chescake
	category = "Cakes"
	name = "Raisin Cheesecake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry
	output = /obj/item/reagent_containers/food/snacks/chescake
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "add some juicy fruit filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/chescake_raisan
	category = "Cakes"
	name = "Cheesecake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/raisins = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/raisins
	output = /obj/item/reagent_containers/food/snacks/chescake_poison
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "add some juicy fruit filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/cake_base
	category = "Cakes"
	name = "Cake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/egg = 1,
		/obj/item/reagent_containers/food/snacks/butterdough = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/butterdough
	starting_atom = /obj/item/reagent_containers/food/snacks/egg
	output = /obj/item/reagent_containers/food/snacks/cake
	uses_attacked_atom = TRUE
	required_table = TRUE
	craft_time = 6 SECONDS
	crafting_sound = 'sound/foley/dropsound/food_drop.ogg'
	crafting_message = "work egg into the dough, shaping it into a cake"
	minimum_skill_level = 2
	extra_chance = 100


/datum/repeatable_crafting_recipe/cooking/cake_pear
	category = "Cakes"
	name = "Zaladin Cake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/pear = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/pear
	output = /obj/item/reagent_containers/food/snacks/zybcake
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "add mouth-watering pear filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/cake_plum
	category = "Cakes"
	name = "Crimson Pine Cake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/plum = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/plum
	output = /obj/item/reagent_containers/food/snacks/crimsoncake
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "add some fine plum filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/cake_tangerine
	category = "Cakes"
	name = "Scarletharp Cake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/tangerine = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/tangerine
	output = /obj/item/reagent_containers/food/snacks/tangerinecake
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "add some tangy tangerine filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/cake_strawberry
	category = "Cakes"
	name = "Strawberry Cake Base"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/strawberry = 1,
		/obj/item/reagent_containers/food/snacks/cake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/cake
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/strawberry
	output = /obj/item/reagent_containers/food/snacks/strawbycake
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "add some tangy tangerine filling"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_cheesecake
	category = "Cakes"
	name = "Unbaked Cheesecake"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cheese = 1,
		/obj/item/reagent_containers/food/snacks/chescake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/chescake
	starting_atom = /obj/item/reagent_containers/food/snacks/cheese
	output = /obj/item/reagent_containers/food/snacks/chescake_ready
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "spread fresh cheese on the cake"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_cheesecake_poison
	hides_from_books = TRUE
	category = "Cakes"
	name = "Unbaked Cheesecake"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/cheese = 1,
		/obj/item/reagent_containers/food/snacks/chescake_poison = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/chescake_poison
	starting_atom = /obj/item/reagent_containers/food/snacks/cheese
	output = /obj/item/reagent_containers/food/snacks/chescake_poison_ready
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "spread fresh cheese on the cake"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_zybcake
	category = "Cakes"
	name = "Unbaked Zaladin Cake"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/spiderhoney = 1,
		/obj/item/reagent_containers/food/snacks/zybcake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/zybcake
	starting_atom = /obj/item/reagent_containers/food/snacks/spiderhoney
	output = /obj/item/reagent_containers/food/snacks/zybcake_ready
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "spread spider-honey on the cake"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_strawberrycake
	category = "Cakes"
	name = "Unbaked Strawberry Cake"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/sugar = 1,
		/obj/item/reagent_containers/food/snacks/strawbycake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/strawbycake
	starting_atom = /obj/item/reagent_containers/food/snacks/sugar
	output = /obj/item/reagent_containers/food/snacks/strawbycake_ready
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "spread sugar frosting on the cake"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_crimsoncake
	category = "Cakes"
	name = "Unbaked Crimson Cake"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/chocolate = 1,
		/obj/item/reagent_containers/food/snacks/crimsoncake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/crimsoncake
	starting_atom = /obj/item/reagent_containers/food/snacks/chocolate
	output = /obj/item/reagent_containers/food/snacks/crimsoncake_ready
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "add chocolate to the dough"
	extra_chance = 100

/datum/repeatable_crafting_recipe/cooking/unbaked_tangerinecake
	category = "Cakes"
	name = "Unbaked Scarletharp Cake"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/sugar = 1,
		/obj/item/reagent_containers/food/snacks/tangerinecake = 1,
	)
	required_table = TRUE
	attacked_atom = /obj/item/reagent_containers/food/snacks/tangerinecake
	starting_atom = /obj/item/reagent_containers/food/snacks/sugar
	output = /obj/item/reagent_containers/food/snacks/tangerinecake_ready
	uses_attacked_atom = TRUE
	craft_time = 9 SECONDS
	crafting_sound = 'sound/foley/dropsound/gen_drop.ogg'
	crafting_message = "spread sugar frosting on the cake"
	extra_chance = 100
