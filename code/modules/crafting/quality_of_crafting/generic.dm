/datum/repeatable_crafting_recipe/sigdry
	name = "westleach zig"
	output = /obj/item/clothing/face/cigarette/rollie/nicotine
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/dry_westleach
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/dry_westleach = 2
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/dry_westleach

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a westleach zig"
	craftdiff = 0
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/sigsweet
	name = "swampweed zig"
	output = /obj/item/clothing/face/cigarette/rollie/cannabis
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/swampweed_dried = 2
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a swampweed zig"
	craftdiff = 0
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/canvas
	name = "canvas"
	output = /obj/item/canvas
	requirements = list(
		/obj/item/paper = 2,
	)
	tool_usage = list(
		/obj/item/needle = list("starts to weave", "start to weave")
	)
	starting_atom = /obj/item/needle
	attacked_atom = /obj/item/paper
	craft_time = 3 SECONDS
	crafting_message = "starts weaving a canvas"
	craftdiff = 0

/datum/repeatable_crafting_recipe/paintbrush
	name = "paint brush"
	output = /obj/item/paint_brush
	starting_atom = /obj/item/natural/feather
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/feather = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick

	craft_time = 3 SECONDS
	crafting_message = "starts tying a paint brush"
	craftdiff = 0
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/paint_palette
	name = "paint palette"
	output = /obj/item/paint_palette
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/wood/plank = 1,
	)
	attacked_atom = /obj/item/natural/wood/plank

	craft_time = 3 SECONDS
	crafting_message = "starts constructing a paint palette"
	craftdiff = 0
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE
