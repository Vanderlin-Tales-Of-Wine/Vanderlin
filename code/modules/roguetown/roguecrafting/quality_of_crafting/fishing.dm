/datum/repeatable_crafting_recipe/fishing
	abstract_type = /datum/repeatable_crafting_recipe/fishing

/datum/repeatable_crafting_recipe/fishing/bait
	name = "red bait"
	output = /obj/item/fishing/bait/meat
	output_amount = 6
	starting_atom = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	requirements = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 2,
	)
	attacking_atom = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish

	craft_time = 2 SECONDS
	crafting_message = "starts rolling some bait"
	craftdiff = 0
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/bait/dough
	name = "doughy bait"
	output = /obj/item/fishing/bait/dough
	starting_atom = /obj/item/reagent_containers/powder/flour
	requirements = list(
		/obj/item/reagent_containers/powder/flour = 2,
	)
	attacking_atom = /obj/item/reagent_containers/powder/flour

/datum/repeatable_crafting_recipe/fishing/bait/gray
	name = "gray bait"
	output = /obj/item/fishing/bait/gray
	output_amount = 5
	starting_atom = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	requirements = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 1,
		/obj/item/reagent_containers/powder/flour = 1,
	)
	attacking_atom = /obj/item/reagent_containers/powder/flour

/datum/repeatable_crafting_recipe/fishing/bait/speckled
	name = "speckled bait"
	output = /obj/item/fishing/bait/speckled
	output_amount = 3
	starting_atom = /obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish
	requirements = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 1,
		/obj/item/reagent_containers/food/snacks/produce/jacksberry = 1,
		/obj/item/reagent_containers/powder/flour = 1,
	)
	attacking_atom = /obj/item/reagent_containers/food/snacks/produce/jacksberry

/obj/item/grown/log/tree/stick

/datum/repeatable_crafting_recipe/fishing/reel
	name = "twine fishing line"
	output = /obj/item/fishing/reel/twine
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/natural/fibers = 2,
	)
	attacking_atom = /obj/item/natural/fibers
	uses_attacking_atom = FALSE
	crafting_message = "starts weaving a reel"

/datum/repeatable_crafting_recipe/fishing/reel/silk
	name = "silk fishing line"
	requirements = list(
		/obj/item/natural/silk = 1,
	)
	attacking_atom = /obj/item/natural/silk
	output = /obj/item/fishing/reel/silk

/datum/repeatable_crafting_recipe/fishing/reel/leather
	name = "leather fishing line"
	requirements = list(
		/obj/item/natural/hide = 1,
	)
	attacking_atom = /obj/item/natural/hide
	output = /obj/item/fishing/reel/leather

/datum/repeatable_crafting_recipe/fishing/bobber
	name = "wooden bobber"
	output = /obj/item/fishing/line/bobber
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	attacking_atom = /obj/item/natural/fibers
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/bobber/stone
	name = "stone sinker"
	output = /obj/item/fishing/line/sinker
	starting_atom = /obj/item/natural/stone
	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/natural/stone = 1,
	)
	attacking_atom = /obj/item/natural/fibers
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/hook
	name = "wooden fishing hook"
	output = /obj/item/fishing/hook/wooden
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
	)
	attacking_atom = /obj/item/grown/log/tree/stick
	uses_attacking_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/hook/thorn
	name = "thorn fishing hook"
	output = /obj/item/fishing/hook/thorn
	starting_atom = /obj/item/natural/thorn
	requirements = list(
		/obj/item/natural/thorn = 2,
	)
	attacking_atom = /obj/item/natural/thorn
