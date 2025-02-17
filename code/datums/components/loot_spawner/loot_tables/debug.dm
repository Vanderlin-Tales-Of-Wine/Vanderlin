/obj/structure/closet/crate/chest/gold/debug
	name = "loot table testing chest"

/obj/structure/closet/crate/chest/gold/debug/Initialize()
	. = ..()
	AddComponent(/datum/component/loot_spawner, /datum/loot_table/debug, 100, 100)

/datum/loot_table/debug
	loot_table = list(
		STATKEY_LCK = list(
			/obj/item/roguecoin/gold = 5,
			/obj/item/roguecoin/silver = 10,
			200,
			/obj/item/roguecoin/copper = 25,
		),
		/datum/skill/misc/stealing = list(
			/obj/item/roguegem/green = 5,
			/obj/item/roguegem/blue = 10,
			/obj/item/lockpick = 25,
		),
		list(
			/obj/item/reagent_containers/food/snacks/biscuit = 25,
			/obj/item/reagent_containers/food/snacks/breadslice/toast = 10,
		)
	)

	base_min = 10
	base_max = 15

	scaling_factor = 1
