/datum/repeatable_crafting_recipe/sigdry
	name = "westleach zig"
	output = /obj/item/clothing/mask/cigarette/rollie/nicotine
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/dry_westleach
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/dry_westleach = 1,
		/obj/item/paper = 1
	)
	attacking_atom = /obj/item/paper

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a westleach zig"
	craftdiff = 0
	uses_attacking_atom = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/sigsweet
	name = "swampweed zig"
	output = /obj/item/clothing/mask/cigarette/rollie/cannabis
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/swampweed_dried = 1,
		/obj/item/paper = 1
	)
	attacking_atom = /obj/item/paper

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a swampweed zig"
	craftdiff = 0
	uses_attacking_atom = TRUE
	subtypes_allowed = TRUE
