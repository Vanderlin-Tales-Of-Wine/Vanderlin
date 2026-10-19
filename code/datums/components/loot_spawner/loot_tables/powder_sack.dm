/datum/loot_table/powder_sack
	name = "powder sack"
	cascading = TRUE
	loot_table = list(
		/datum/loot_table/powder_sack/spice_and_dust = 25,
		/datum/loot_table/powder_sack/ozium = 15,
		/datum/loot_table/powder_sack/basic = 100
	)

	base_min = 1
	base_max = 2

	scaling_factor = 0.2

/datum/loot_table/powder_sack/basic
	loot_table = list(
		/obj/item/reagent_containers/powder/flour = 25,
		/obj/item/reagent_containers/powder/salt = 10,
		/obj/item/reagent_containers/food/snacks/sugar = 10,
		/obj/item/reagent_containers/powder/manabloom = 2
	)

/// Level 4 in stealing OR alchemy
/datum/loot_table/powder_sack/ozium
	req_keys = list(/datum/attribute/skill/misc/stealing, /datum/attribute/skill/craft/alchemy)
	min_level = 4
	loot_table = list(
		/obj/item/reagent_containers/powder/ozium = 1
	)

/// Level 5 in stealing OR alchemy
/datum/loot_table/powder_sack/spice_and_dust
	req_keys = list(/datum/attribute/skill/misc/stealing, /datum/attribute/skill/craft/alchemy)
	min_level = 5
	loot_table = list(
		/obj/item/reagent_containers/powder/spice = 10,
		/obj/item/reagent_containers/powder/moondust = 10
	)
