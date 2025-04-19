/datum/component/storage/concrete/grid
	grid = TRUE

/datum/component/storage/concrete/grid/satchel
	screen_max_rows = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/grid/backpack
	screen_max_rows = 7
	screen_max_columns = 4
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = TRUE

/datum/component/storage/concrete/grid/surgery_bag
	screen_max_rows = 5
	screen_max_columns = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/grid/belt
	screen_max_rows = 3
	screen_max_columns = 2
	max_w_class = WEIGHT_CLASS_SMALL

/datum/component/storage/concrete/grid/coin_pouch
	screen_max_rows = 4
	screen_max_columns = 1
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = FALSE

/datum/component/storage/concrete/grid/keyring
	screen_max_rows = 4
	screen_max_columns = 5
	max_w_class = WEIGHT_CLASS_SMALL
	allow_dump_out = TRUE
	click_gather = TRUE
	attack_hand_interact = FALSE
	collection_mode = COLLECT_ONE
	insert_verb = "slide"
	insert_preposition = "on"
	rustle_sound = 'sound/items/gems (1).ogg'

/datum/component/storage/concrete/grid/keyring/New(datum/P, ...)
	. = ..()
	set_holdable(typecacheof(list(/obj/item/key)))

/datum/component/storage/concrete/grid/belt/knife_belt
	screen_max_rows = 4
	screen_max_columns = 4

/datum/component/storage/concrete/grid/belt/knife_belt/New(datum/P, ...)
	. = ..()
	set_holdable(typecacheof(list(/obj/item/weapon/knife/throwingknife)))


/datum/component/storage/concrete/grid/belt/cloth
	screen_max_columns = 1

/datum/component/storage/concrete/grid/belt/assassin
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/grid/cloak
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 2
	screen_max_columns = 2

/datum/component/storage/concrete/grid/cloak/lord
	max_w_class = WEIGHT_CLASS_BULKY

/datum/component/storage/concrete/grid/mailmaster
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 10
	screen_max_columns = 10

/datum/component/storage/concrete/grid/bin
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 8
	screen_max_columns = 4

/datum/component/storage/concrete/grid/bin/New(datum/P, ...)
	. = ..()
	cant_hold = typecacheof(list(/obj/item/weapon))

/datum/component/storage/concrete/grid/sack
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 5
	screen_max_columns = 4
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	allow_dump_out = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/grid/sack/meat/New(datum/P, ...)
	. = ..()
	set_holdable(list(
		/obj/item/reagent_containers/food/snacks/meat,
		/obj/item/reagent_containers/food/snacks/fat,
		/obj/item/natural/fur,
		/obj/item/natural/hide,
		/obj/item/alch/sinew,
		/obj/item/alch/viscera,
		/obj/item/alch/bone
		))

/datum/component/storage/concrete/grid/egg_basket
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 5
	screen_max_columns = 2
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = FALSE
	allow_quick_empty = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/grid/egg_basket/New(datum/P, ...)
	. = ..()
	set_holdable(
		typecacheof(list(/obj/item/reagent_containers/food/snacks/egg)
	))

/datum/component/storage/concrete/grid/magebag
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 8
	screen_max_columns = 5

/datum/component/storage/concrete/grid/magebag/New(datum/P, ...)
	. = ..()
	set_holdable(list(
		/obj/item/natural/infernalash,
		/obj/item/natural/hellhoundfang,
		/obj/item/natural/moltencore,
		/obj/item/natural/abyssalflame,
		/obj/item/natural/fairydust,
		/obj/item/natural/iridescentscale,
		/obj/item/natural/heartwoodcore,
		/obj/item/natural/sylvanessence,
		/obj/item/natural/elementalmote,
		/obj/item/natural/elementalshard,
		/obj/item/natural/elementalfragment,
		/obj/item/natural/elementalrelic,
		/obj/item/natural/obsidian,
		/obj/item/natural/leyline,
		/obj/item/reagent_containers/food/snacks/produce/manabloom,
		/obj/item/mana_battery/mana_crystal,
		/obj/item/ash,
		))

/datum/component/storage/concrete/grid/headhook
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 6
	screen_max_columns = 4
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	allow_dump_out = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/grid/headhook/New(datum/P, ...)
	. = ..()
	set_holdable(
		typecacheof(list(/obj/item/natural/head/volf,
		/obj/item/natural/head/saiga,
		/obj/item/natural/head/rous,
		/obj/item/natural/head/spider,
		/obj/item/natural/head/bug,
		/obj/item/bodypart/head/goblin,
		/obj/item/bodypart/head/rousman,
		/obj/item/bodypart/head,
		/obj/item/bodypart/head/orc,
		/obj/item/bodypart/head/zizombie)
	))

/datum/component/storage/concrete/grid/headhook/bronze
	max_w_class = WEIGHT_CLASS_NORMAL
	screen_max_rows = 8
	screen_max_columns = 6
	click_gather = TRUE
	collection_mode = COLLECT_EVERYTHING
	dump_time = 0
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	allow_dump_out = TRUE
	insert_preposition = "in"

/datum/component/storage/concrete/grid/headhook/bronze/New(datum/P, ...)
	. = ..()
	set_holdable(
		typecacheof(list(/obj/item/natural/head/volf,
		/obj/item/natural/head/saiga,
		/obj/item/natural/head/rous,
		/obj/item/natural/head/spider,
		/obj/item/natural/head/bug,
		/obj/item/bodypart/head/goblin,
		/obj/item/bodypart/head/rousman,
		/obj/item/bodypart/head,
		/obj/item/bodypart/head/orc,
		/obj/item/bodypart/head/zizombie)
	))

/datum/component/storage/concrete/grid/crucible
	screen_max_rows = 5
	screen_max_columns = 3
	max_w_class = WEIGHT_CLASS_HUGE
	not_while_equipped = TRUE

/datum/component/storage/concrete/grid/crucible/can_be_inserted(obj/item/storing, stop_messages, mob/user, worn_check, params, storage_click)
	if(!storing.melting_material)
		return FALSE
	. = ..()

/datum/component/storage/concrete/grid/anvil_bin
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_rows = 8
	screen_max_columns = 4

/datum/component/storage/concrete/grid/anvil_bin/show_to(mob/M)
	var/obj/structure/material_bin/source = src.parent
	if(!source.opened)
		return FALSE
	. = ..()

/datum/component/storage/concrete/grid/anvil_bin/can_be_inserted(obj/item/storing, stop_messages, mob/user, worn_check, params, storage_click)
	var/obj/structure/material_bin/source = src.parent
	if(!source.opened)
		return FALSE
	. = ..()

/datum/component/storage/concrete/grid/kobold_storage
	max_w_class = WEIGHT_CLASS_HUGE
	screen_max_columns = 2
	screen_max_rows = 3

/datum/component/storage/concrete/grid/kobold_storage/New(datum/P, ...)
	. = ..()
	set_holdable(list(
		/obj/item/clothing/head/mob_holder,
		))

/datum/component/storage/concrete/grid/zigbox
	max_w_class = WEIGHT_CLASS_TINY
	screen_max_rows = 2
	screen_max_columns = 3
	max_items = 6
