GLOBAL_LIST_INIT(wisdoms, world.file2list("strings/rt/wisdoms.txt"))

/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	var/original_name
	desc = "A bottle with a cork."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	icon_state = "clear_bottle1"
	var/original_icon_state = null
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	volume = 70
	fill_icon_thresholds = list(0, 25, 50, 75, 100)
	dropshrink = 0.8
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	obj_flags = CAN_BE_HIT
	spillable = FALSE
	var/closed = TRUE
	reagent_flags = TRANSPARENT
	w_class = WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	experimental_onhip = TRUE
	var/can_label_bottle = TRUE	// Determines if the bottle can be labeled with paper
	var/fancy		// for bottles with custom descriptors that you don't want to change when bottle manipulated

/obj/item/reagent_containers/glass/bottle/Initialize()
	icon_state = "clear_bottle[rand(1,4)]"
	return ..()

/obj/item/reagent_containers/glass/bottle/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/paper/scroll))
		if(reagents?.total_volume)
			to_chat(user, span_notice("I cannot put a message in [src] while it is full!"))
			return
		if(closed)
			to_chat(user, span_notice("I cannot put a message in [src] while it is closed!"))
			return
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			var/obj/item/paper/scroll/P = I
			var/obj/item/bottlemessage/BM = new
			BM.icon_state = "[icon_state]_message"

			P.forceMove(BM)
			BM.contained = P
			H.put_in_active_hand(BM)
			playsound(src, 'sound/items/scroll_open.ogg', 100, FALSE)
			qdel(src)
		return
	return ..()

/obj/item/reagent_containers/glass/bottle/update_overlays()
	. = ..()
	if(closed)
		. += "[icon_state]cork"

/obj/item/reagent_containers/glass/bottle/rmb_self(mob/user)
	. = ..()
	closed = !closed
	user.changeNext_move(CLICK_CD_RAPID)
	if(closed)
		reagent_flags &= ~TRANSFERABLE
		reagents.flags = reagent_flags
		to_chat(user, span_notice("You carefully press the cork back into the mouth of [src]."))
		spillable = FALSE
		GLOB.weather_act_upon_list -= src
		if(!fancy)
			desc = "A bottle with a cork."
	else
		reagent_flags |= TRANSFERABLE
		reagents.flags = reagent_flags
		playsound(user.loc,'sound/items/uncork.ogg', 100, TRUE)
		to_chat(user, span_notice("You thumb off the cork from [src]."))
		spillable = TRUE
		GLOB.weather_act_upon_list |= src
		if(!fancy)
			desc = "An open bottle, hopefully a cork is close by."
	update_appearance(UPDATE_OVERLAYS)

/obj/item/reagent_containers/glass/bottle/toxin
	name = "toxin bottle"
	desc = ""
	list_reagents = list(/datum/reagent/toxin = 30)

/obj/item/reagent_containers/glass/bottle/plasma
	name = "purple aetherium bottle"
	desc = ""
	list_reagents = list(/datum/reagent/toxin/plasma = 30)

/obj/item/reagent_containers/glass/bottle/venom
	name = "venom bottle"
	desc = ""
	list_reagents = list(/datum/reagent/toxin/venom = 30)

/obj/item/reagent_containers/glass/bottle/fentanyl
	name = "fentanyl bottle"
	desc = ""
	list_reagents = list(/datum/reagent/toxin/fentanyl = 30)

/obj/item/reagent_containers/glass/bottle/amanitin
	name = "amanitin bottle"
	desc = ""
	list_reagents = list(/datum/reagent/toxin/amanitin = 30)

/obj/item/reagent_containers/glass/bottle/mercury
	name = "mercury bottle"
	list_reagents = list(/datum/reagent/mercury = 30)

/obj/item/reagent_containers/glass/bottle/water
	name = "water bottle"
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/glass/bottle/ethanol
	name = "ethanol bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol = 30)

/obj/item/reagent_containers/glass/bottle/sugar
	name = "sugar bottle"
	list_reagents = list(/datum/reagent/consumable/sugar = 30)

/obj/item/reagent_containers/glass/bottle/sacid
	name = "sulphuric acid bottle"
	list_reagents = list(/datum/reagent/toxin/acid = 30)

/obj/item/reagent_containers/glass/bottle/welding_fuel
	name = "naphta bottle"
	list_reagents = list(/datum/reagent/fuel = 30)

// message in a bootl

/obj/item/bottlemessage
	name = "message bottle"
	desc = "Inside is a scroll, pop it open and read the ancient wisdoms."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	dropshrink = 0.8
	icon_state = "clear_bottle1"
	w_class = WEIGHT_CLASS_NORMAL
	var/obj/item/paper/contained

/obj/item/bottlemessage/ancient/Initialize()
	. = ..()
	var/obj/item/paper/scroll/pp = new(src)
	contained = pp
	pp.info = pick(GLOB.wisdoms)

/obj/item/bottlemessage/rmb_self(mob/user)
	. = ..()
	playsound(user.loc,'sound/items/uncork.ogg', 100, TRUE)
	if(!contained)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/reagent_containers/glass/bottle/btle = new
		btle.icon_state = replacetext("[icon_state]","_message","")
		btle.closed = FALSE
		H.dropItemToGround(src, silent=TRUE)
		H.put_in_active_hand(btle)
		H.put_in_hands(contained)
		contained = null
		qdel(src)

// vials
/obj/item/reagent_containers/glass/bottle/vial
	name = "vial"
	desc = "A vial with a cork."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	icon_state = "clear_vial1"
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	volume = 30
	fill_icon_thresholds = list(0, 25, 50, 75, 100)
	dropshrink = 0.8
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_MOUTH
	obj_flags = CAN_BE_HIT
	spillable = FALSE
	closed = TRUE
	reagent_flags = TRANSPARENT
	w_class = WEIGHT_CLASS_SMALL
	grid_height = 32
	drinksounds = list('sound/items/drink_bottle (1).ogg','sound/items/drink_bottle (2).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')

/obj/item/reagent_containers/glass/bottle/vial/Initialize()
	. = ..()
	icon_state = "clear_vial1"
	update_appearance(UPDATE_OVERLAYS)

/obj/item/reagent_containers/glass/bottle/vial/rmb_self(mob/user)
	closed = !closed
	user.changeNext_move(CLICK_CD_RAPID)
	if(closed)
		reagent_flags &= ~TRANSFERABLE
		reagents.flags = reagent_flags
		desc = "A vial with a cork."
		to_chat(user, span_notice("You carefully press the cork back into the mouth of [src]."))
		spillable = FALSE
	else
		reagent_flags |= TRANSFERABLE
		reagents.flags = reagent_flags
		to_chat(user, span_notice("You thumb off the cork from [src]."))
		playsound(user.loc,'sound/items/uncork.ogg', 100, TRUE)
		desc = "An open vial, easy to drink quickly."
		spillable = TRUE
	update_appearance(UPDATE_OVERLAYS)

/obj/item/reagent_containers/glass/bottle/decanter
	name = "clay decanter"
	desc = "A decanter fired from clay."
	icon = 'icons/obj/handmade/decanter.dmi'
	icon_state = "world"
	volume = 50
	amount_per_transfer_from_this = 8
	possible_transfer_amounts = list(8)
	dropshrink = 1
	can_label_bottle = FALSE
	spillable = TRUE
	fill_icon_thresholds = null

/obj/item/reagent_containers/glass/bottle/decanter/Initialize()
	. = ..()
	icon_state = "world"

/obj/item/reagent_containers/glass/bottle/decanter/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] clay decanter"

/obj/item/reagent_containers/glass/bottle/teapot
	name = "clay teapot"
	desc = "A teapot fired from clay."

	icon = 'icons/obj/handmade/teapot.dmi'
	icon_state = "world"
	volume = 99
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	dropshrink = 1
	can_label_bottle = FALSE
	spillable = TRUE

	fill_icon_thresholds = null

/obj/item/reagent_containers/glass/bottle/teapot/Initialize()
	. = ..()
	icon_state = "world"

/obj/item/reagent_containers/glass/bottle/teapot/Initialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/teapot)
	AddComponent(/datum/component/container_craft, subtypesof(/datum/container_craft/cooking/tea), TRUE)

/obj/item/reagent_containers/glass/bottle/teapot/random/Initialize()
	. = ..()
	main_material = pick(typesof(/datum/material/clay))
	set_material_information()

/obj/item/reagent_containers/glass/bottle/teapot/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] clay teapot"

