/datum/repeatable_crafting_recipe/fishing
	abstract_type = /datum/repeatable_crafting_recipe/fishing

/datum/repeatable_crafting_recipe/fishing/bait
	name = "red bait"
	output = /obj/item/fishing/bait/meat
	output_amount = 6
	starting_atom = /obj/item/reagent_containers/food/snacks/meat/mince/fish
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 2,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/meat/mince/fish

	craft_time = 2 SECONDS
	crafting_message = "starts rolling some bait"
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/bait/dough
	name = "doughy bait"
	output = /obj/item/fishing/bait/dough
	starting_atom = /obj/item/reagent_containers/food/snacks/dough_slice
	requirements = list(
		/obj/item/reagent_containers/powder/flour = 2,
	)
	attacked_atom = /obj/item/reagent_containers/powder/flour

/datum/repeatable_crafting_recipe/fishing/bait/gray
	name = "gray bait"
	output = /obj/item/fishing/bait/gray
	output_amount = 5
	starting_atom = /obj/item/reagent_containers/food/snacks/meat/mince/fish
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 1,
		/obj/item/reagent_containers/powder/flour = 1,
	)
	attacked_atom = /obj/item/reagent_containers/powder/flour

/datum/repeatable_crafting_recipe/fishing/bait/speckled
	name = "speckled bait"
	output = /obj/item/fishing/bait/speckled
	output_amount = 3
	starting_atom = /obj/item/reagent_containers/food/snacks/meat/mince/fish
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 1,
		/obj/item/reagent_containers/food/snacks/produce/jacksberry = 1,
		/obj/item/reagent_containers/powder/flour = 1,
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/jacksberry

/obj/item/grown/log/tree/stick

/datum/repeatable_crafting_recipe/fishing/reel
	name = "twine fishing line"
	output = /obj/item/fishing/reel/twine
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/natural/fibers = 2,
	)
	attacked_atom = /obj/item/natural/fibers
	uses_attacked_atom = FALSE
	crafting_message = "starts weaving a reel"

/datum/repeatable_crafting_recipe/fishing/reel/silk
	name = "silk fishing line"
	requirements = list(
		/obj/item/natural/silk = 1,
	)
	attacked_atom = /obj/item/natural/silk
	output = /obj/item/fishing/reel/silk

/datum/repeatable_crafting_recipe/fishing/reel/leather
	name = "leather fishing line"
	requirements = list(
		/obj/item/natural/hide = 1,
	)
	attacked_atom = /obj/item/natural/hide
	output = /obj/item/fishing/reel/leather

/datum/repeatable_crafting_recipe/fishing/bobber
	name = "wooden bobber"
	output = /obj/item/fishing/line/bobber
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	attacked_atom = /obj/item/natural/fibers
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/bobber/stone
	name = "stone sinker"
	output = /obj/item/fishing/line/sinker
	starting_atom = /obj/item/natural/stone
	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/natural/stone = 1,
	)
	attacked_atom = /obj/item/natural/fibers
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/hook
	name = "wooden fishing hook"
	output = /obj/item/fishing/hook/wooden
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/hook/thorn
	name = "thorn fishing hook"
	output = /obj/item/fishing/hook/thorn
	starting_atom = /obj/item/natural/thorn
	requirements = list(
		/obj/item/natural/thorn = 2,
	)
	attacked_atom = /obj/item/natural/thorn

/datum/repeatable_crafting_recipe/fishing/normalbait
	name = "bait"
	output = /obj/item/bait
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/wheat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/wheat
	attacked_atom = /obj/item/natural/cloth
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/sweetbait
	name = "sweet bait - Apple"
	output = /obj/item/bait/sweet
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/apple = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/apple
	attacked_atom = /obj/item/natural/cloth
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/berrybait
	name = "sweet bait - Berry"
	output = /obj/item/bait/sweet
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/jacksberry = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/jacksberry
	attacked_atom = /obj/item/natural/cloth
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/fishing/bloodbait
	name = "Blood Bait"
	output = /obj/item/bait/bloody
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/meat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/meat
	attacked_atom = /obj/item/natural/cloth
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/fishing/fishingrod
	name = "Fishing Rod"
	output = /obj/item/fishingrod/crafted
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2,
	)
	starting_atom = /obj/item/grown/log/tree/small
	attacked_atom = /obj/item/natural/fibers
	uses_attacked_atom = TRUE

/obj/item/fishingrod/crafted
	sellprice = 8
