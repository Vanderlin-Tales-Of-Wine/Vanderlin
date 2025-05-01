/datum/repeatable_crafting_recipe/dryleaf
	name = "dry swampweed"
	output = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed
	requirements = list(/obj/item/reagent_containers/food/snacks/produce/swampweed = 1)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 2 SECONDS
	crafting_message = "starts drying some swampweed"

/datum/repeatable_crafting_recipe/westleach
	name = "dry westleach leaf"
	output = /obj/item/reagent_containers/food/snacks/produce/dry_westleach
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/westleach
	requirements = list(/obj/item/reagent_containers/food/snacks/produce/westleach = 1)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 2 SECONDS
	crafting_message = "starts drying some westleach leaves"

/datum/repeatable_crafting_recipe/salami
	name = "salumoi"
	output = /obj/item/reagent_containers/food/snacks/meat/salami
	starting_atom = /obj/item/reagent_containers/food/snacks/meat/sausage
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/sausage = 1,
		/obj/item/reagent_containers/powder/salt = 1
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some sausage"
	craftdiff = 0

/datum/repeatable_crafting_recipe/coppiette
	name = "coppiette"
	output = /obj/item/reagent_containers/food/snacks/cooked/coppiette
	starting_atom = /obj/item/reagent_containers/food/snacks/meat/steak
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/steak = 1,
		/obj/item/reagent_containers/powder/salt = 1
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some meat"
	craftdiff = 0

/datum/repeatable_crafting_recipe/salo
	name = "salo"
	output = /obj/item/reagent_containers/food/snacks/fat/salo
	starting_atom = /obj/item/reagent_containers/food/snacks/fat
	requirements = list(
		/obj/item/reagent_containers/food/snacks/fat = 2,
		/obj/item/reagent_containers/powder/salt = 1
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some fat"
	craftdiff = 0

/datum/repeatable_crafting_recipe/saltfish
	name = "saltfish"
	output = /obj/item/reagent_containers/food/snacks/saltfish
	starting_atom = /obj/item/reagent_containers/food/snacks/fish
	requirements = list(
		/obj/item/reagent_containers/food/snacks/fish = 1,
		/obj/item/reagent_containers/powder/salt = 1
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some fish"
	craftdiff = 0
	subtypes_allowed = TRUE
	pass_types_in_end = list(
		/obj/item/reagent_containers/food/snacks/fish,
	)

/datum/repeatable_crafting_recipe/raisins
	name = "raisins"
	output = /obj/item/reagent_containers/food/snacks/raisins
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/jacksberry
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/jacksberry = 1,
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some jacksberries"
	craftdiff = 0
	pass_types_in_end = list(
		/obj/item/reagent_containers/food/snacks/produce/jacksberry, //old craft blacklisted poison berries, cowards
	)

/datum/repeatable_crafting_recipe/raisins_poison
	name = "raisins"
	output = /obj/item/reagent_containers/food/snacks/raisins/poison
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/jacksberry/poison
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1,
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some jacksberries"
	craftdiff = 0
	pass_types_in_end = list(
		/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison,
	)

/datum/repeatable_crafting_recipe/driedstrawberry
	name = "dried strawberries"
	output = /obj/item/reagent_containers/food/snacks/strawberry_dried
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/strawberry
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/strawberry = 1,
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some strawberries"
	craftdiff = 0

/datum/repeatable_crafting_recipe/driedtangerine
	name = "dried tangerine"
	output = /obj/item/reagent_containers/food/snacks/tangerine_dried
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/tangerine
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/tangerine = 1,
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying some tangerine"
	craftdiff = 0

/datum/repeatable_crafting_recipe/driedplum
	name = "dried plum"
	output = /obj/item/reagent_containers/food/snacks/plum_dried
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/plum
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/plum = 1,
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying a plum"
	craftdiff = 0

/datum/repeatable_crafting_recipe/driedapple
	name = "dried apple"
	output = /obj/item/reagent_containers/food/snacks/apple_dried
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/apple
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/apple = 1,
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying an apple"
	craftdiff = 0

/datum/repeatable_crafting_recipe/driedpear
	name = "dried pear"
	output = /obj/item/reagent_containers/food/snacks/pear_dried
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/pear
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/pear = 1,
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts drying a pear"
	craftdiff = 0

/datum/repeatable_crafting_recipe/parchment
	name = "parchment"
	output = /obj/item/paper
	output_amount = 6
	starting_atom = /obj/item/weapon/knife
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to prepare the hide", "start to prepare the hide", 'sound/combat/hits/bladed/genstab (1).ogg'),
	)
	requirements = list(
		/obj/item/natural/hide = 1,
	)
	reagent_requirements = list(
		/datum/reagent/water = 33
	)
	attacked_atom = /obj/machinery/tanningrack

	craft_time = 1.5 SECONDS
	crafting_message = "starts making some parchment"
	craftdiff = 0
