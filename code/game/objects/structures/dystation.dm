/*	.................   Luxury dye bin   ................... */
/obj/machinery/dye_bin
	name = "luxury dye bin"
	desc = "Precious extracts, oils, powders, will transform your plain clothes to displays of wealth and extravagance!"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dye_bin_luxury"
	density = TRUE
	anchored = FALSE
	max_integrity = 80
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	var/atom/movable/inserted
	var/activecolor = "#FFFFFF"
	/// Allow holder'd mobs
	var/allow_mobs = TRUE
	var/static/list/selectable_colors = list(
		"Bleach" ="#ffffff",
		"Ash Grey" ="#676262",
		"Chalk White" ="#c7c0b5",
		"Linen" ="#a1a17a",
		"Blood Red" ="#763434",
		"Plum Purple" ="#4b3c54",
		"Dark Ink" ="#392f2f",
		"Forest Green" ="#45553f",
		"Sky Blue" ="#40445f",
		"Mustard Yellow" ="#646149",

		"Royal Black" ="#2f352f",
		"Royal Red" ="#813434",
		"Royal Majenta" ="#822b52",
		"Bark Brown"="#685542",
		"Bog Green" ="#4f693b",
		"Mage Green" ="#60794a",
		"Royal Teal" ="#3b817a",
		"Pear Yellow" ="#a19f52",
		"Mage Yellow" ="#a79730",
		"Fyritius Orange" ="#9b7540",
		"Mage Orange" ="#935329",
		"Royal Purple" ="#865c9c",
		"Mage Blue" ="#454fa6",

		"Salmon" ="#70545e",
		"Russet" ="#583f2c",
		"Yellow Ochre" ="#685e3b",
		"Red Ochre" = "#573936",
		"Maroon" ="#533727",
		"Swampweed" ="#00713d",
		"Ocean" ="#45749d"
		)

/obj/machinery/dye_bin/Destroy()
	inserted?.forceMove(drop_location())
	return ..()

/obj/machinery/dye_bin/Destroy()
	layer = 2.8
	icon_state = "washbin_destroy"
	density = FALSE
	GLOB.machines.Remove(src)
	if(!speed_process)
		STOP_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSfastprocess, src)
	return ..()

/obj/machinery/dye_bin/proc/apply_dye(mob/living/carbon/human/user, obj/item/clothing/item_to_dye, color)
	if (!item_to_dye || !color)
		return
	if (item_to_dye.detail_tag)
		item_to_dye.detail_color = color
		item_to_dye.update_icon()
	else
		item_to_dye.add_atom_colour(color, FIXED_COLOUR_PRIORITY)

/obj/machinery/dye_bin/attackby(obj/item/I, mob/living/user)
	if(allow_mobs && istype(I, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/H = I
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		if(!QDELETED(H))
			H.release()

	if(I.sewrepair)
		if(user.mind.get_skill_level(/datum/skill/misc/sewing) <= 2) // We're not letting people with 0 knowledge in sewing do dying, so they don't step on the toes of the seamstress
			to_chat(user, "<span class='warning'>I do not know enough about this craft...</span>")
			return
		if(inserted)
			to_chat(user, "<span class='warning'>There is already something inside the dye bin!</span>")
			return
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		user.visible_message("<span class='notice'>[user] inserts [I] into [src].</span>")

		inserted = I
		icon_state = "dye_bin_full"
		return
	else
		if(I.force < 8)
			to_chat(user, "<span class='warning'>I don't think this item can be dyed this way.</span>")
		return ..()

/obj/machinery/dye_bin/attack_hand(mob/living/user)
	ui_interact(user)

/obj/machinery/dye_bin/AllowDrop()
	return FALSE

/obj/machinery/dye_bin/ui_interact(mob/user)
	if( user.used_intent.type == /datum/intent/grab )
		return
	if( user.used_intent.type == /datum/intent/unarmed/shove )
		return ..()
	if(!is_operational())
		return ..()
	user.set_machine(src)
	var/list/dat = list("<TITLE>Dye Station Control Panel</TITLE><BR>")
	if(!inserted)
		dat += "No item inserted."
	else
		dat += "Item inserted: [inserted]<HR>"
		dat += "<A href='byond://?src=\ref[src];select=1'>Select new color.</A><BR>"
		dat += "Color: <font color='[activecolor]'>&#9899;</font>"
		dat += "<A href='byond://?src=\ref[src];paint=1'>Apply new dye.</A><BR><BR>"
		dat += "<A href='byond://?src=\ref[src];clear=1'>Bleach out the color.</A><BR><BR>"
		dat += "<A href='byond://?src=\ref[src];eject=1'>Remove item.</A><BR><BR>"

	var/datum/browser/menu = new(user, "colormate","Dye Station", 400, 400, src)
	menu.set_content(dat.Join(""))
	menu.open()

/obj/machinery/dye_bin/Topic(href, href_list)
	if(!(. = ..()))
		return

	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=colormate")
		return

	if(href_list["select"])
		var/choice = input(usr,"Choose your dye:","Dyes",null) as null|anything in selectable_colors
		if(!choice)
			return
		activecolor = selectable_colors[choice]
		updateUsrDialog()

	if(href_list["paint"])
		if(!inserted)
			return
		apply_dye(usr, inserted, activecolor)
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		updateUsrDialog()

	if(href_list["clear"])
		if(!inserted)
			return
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		updateUsrDialog()

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(get_turf(usr))
		inserted = null
		playsound(src, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)
		updateUsrDialog()
		icon_state = "dye_bin_luxury"
		update_icon()

/obj/machinery/dye_bin/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(prob(L.STASTR * 8))
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks over [src], ruining the contents!</span>", \
				"<span class='warning'>I kick over [src], ruining the contents!</span>")
			new /obj/effect/decal/cleanable/dyes(get_turf(src))
			var/obj/item/roguebin/I = new /obj/item/roguebin (loc)
			I.kover = TRUE
			I.update_icon()
			qdel(src)

		else
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")

/*	.................   Cheap dye bin   ................... */
/obj/machinery/simple_dye_bin
	name = "cheap dye bin"
	desc = "A barrel with a selection of cheap things that will stain your clothes in muted colors. Ash, clods of dirt, jacksberries and swampweed provides all the colors any peasant could want!"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dye_bin"
	density = TRUE
	anchored = FALSE
	max_integrity = 80
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	var/atom/movable/inserted
	var/activecolor = "#FFFFFF"
	/// Allow holder'd mobs
	var/allow_mobs = TRUE
	var/static/list/selectable_colors = list(
		"Bleach" ="#ffffff",
		"Ash Grey" ="#676262",
		"Chalk White" ="#c7c0b5",
		"Linen" ="#a1a17a",
		"Soot Black" ="#414145",
		"Royal Black" ="#2f352f",
		"Winestain Red" ="#673c3c",
		"Royal Red" ="#8f3636",
		"Royal Majenta" ="#822b52",
		"Peasant Brown" ="#634f44",
		"Chestnut" ="#604631",
		"Bark Brown"="#685542",
		"Mud Brown" ="#6f5f4d",
		"Old Leather" ="#473f39",
		"Spring Green" ="#41493a",
		"Bog Green" ="#4f693b",
		"Royal Teal" ="#3b817a",
		"Berry Blue" ="#39404d",
		"Pear Yellow" ="#a19f52",
		"Fyritius Orange" ="#9b7540",
		"Royal Purple" ="#865c9c"
		)

/obj/machinery/simple_dye_bin/Destroy()
	inserted?.forceMove(drop_location())
	return ..()

/obj/machinery/simple_dye_bin/Destroy()
	layer = 2.8
	icon_state = "washbin_destroy"
	density = FALSE
	GLOB.machines.Remove(src)
	if(!speed_process)
		STOP_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSfastprocess, src)
	dropContents()
	return ..()

/obj/machinery/simple_dye_bin/proc/apply_dye(mob/living/carbon/human/user, obj/item/clothing/item_to_dye, color)
	if (!item_to_dye || !color)
		return
	if (item_to_dye.detail_tag)
		item_to_dye.detail_color = color
		item_to_dye.update_icon()
	else
		item_to_dye.add_atom_colour(color, FIXED_COLOUR_PRIORITY)

/obj/machinery/simple_dye_bin/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/luxury_dyes))
		playsound(src, "bubbles", 50, 1)
		user.visible_message("<span class='info'>[user] adds luxury dye to [src].</span>")
		if(do_after(user, 3 SECONDS))
			new /obj/machinery/dye_bin(get_turf(src.loc))
			qdel(I)
			qdel(src)
			return
	if(allow_mobs && istype(I, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/H = I
		if(inserted)
			user.visible_message("<span class='notice'>[src] is already full.</span>")
			return
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		if(!QDELETED(H))
			H.release()

	if(I.sewrepair)
		if(user.mind.get_skill_level(/datum/skill/misc/sewing) <= 2) // We're not letting people with 0 knowledge in sewing do dying, so they don't step on the toes of the seamstress
			to_chat(user, "<span class='warning'>I do not know enough about this craft...</span>")
			return
		if(inserted)
			to_chat(user, "<span class='warning'>There is already something inside the dye bin!</span>")
			return
		if(!user.transferItemToLoc(I, src))
			to_chat(user, "<span class='warning'>[I] is stuck to your hand!</span>")
			return
		user.visible_message("<span class='notice'>[user] inserts [I] into [src]'s receptable.</span>")
		inserted = I
		icon_state = "dye_bin_full"
	else
		if(I.force < 8)
			to_chat(user, "<span class='warning'>I don't think this item can be dyed this way.</span>")
		return ..()

/obj/machinery/simple_dye_bin/AllowDrop()
	return FALSE

/obj/machinery/simple_dye_bin/attack_hand(mob/living/user)
	ui_interact(user)

/obj/machinery/simple_dye_bin/ui_interact(mob/user)
	if( user.used_intent.type == /datum/intent/grab )
		return
	if( user.used_intent.type == /datum/intent/unarmed/shove )
		return ..()
	if(!is_operational())
		return ..()
	user.set_machine(src)
	var/list/dat = list("<TITLE>Dye Station Control Panel</TITLE><BR>")
	if(!inserted)
		dat += "No item inserted."
	else
		dat += "Item inserted: [inserted]<HR>"
		dat += "<A href='byond://?src=\ref[src];select=1'>Select new color.</A><BR>"
		dat += "Color: <font color='[activecolor]'>&#9899;</font>"
		dat += "<A href='byond://?src=\ref[src];paint=1'>Apply new dye.</A><BR><BR>"
		dat += "<A href='byond://?src=\ref[src];clear=1'>Bleach out the color.</A><BR><BR>"
		dat += "<A href='byond://?src=\ref[src];eject=1'>Remove item.</A><BR><BR>"

	var/datum/browser/menu = new(user, "colormate","Dye Station", 400, 400, src)
	menu.set_content(dat.Join(""))
	menu.open()

/obj/machinery/simple_dye_bin/Topic(href, href_list)
	if(!(. = ..()))
		return

	add_fingerprint(usr)

	if(href_list["close"])
		usr << browse(null, "window=colormate")
		return

	if(href_list["select"])
		var/choice = input(usr,"Choose your dye:","Dyes",null) as null|anything in selectable_colors
		if(!choice)
			return
		activecolor = selectable_colors[choice]
		updateUsrDialog()

	if(href_list["paint"])
		if(!inserted)
			return
		apply_dye(usr, inserted, activecolor)
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		updateUsrDialog()

	if(href_list["clear"])
		if(!inserted)
			return
		inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
		updateUsrDialog()

	if(href_list["eject"])
		if(!inserted)
			return
		inserted.forceMove(get_turf(usr))
		inserted = null
		playsound(src, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)
		updateUsrDialog()
		icon_state = "dye_bin"
		update_icon()

/obj/machinery/simple_dye_bin/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(prob(L.STASTR * 8))
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks over [src], ruining the contents!</span>", \
				"<span class='warning'>I kick over [src], ruining the contents!</span>")
			new /obj/effect/decal/cleanable/dyes(get_turf(src))
			var/obj/item/roguebin/I = new /obj/item/roguebin (loc)
			I.kover = TRUE
			I.update_icon()
			qdel(src)

		else
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")

/*	.................   Dyes   ................... */
/obj/item/luxury_dyes
	name = "luxury dyes"
	desc = "Adding these to a existing cheap dye bin will let you use even the rarest, most expensive dyes. Rare imported dyes."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "luxury_dyes"
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.8
	sellprice = 30
/obj/item/luxury_dyes/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/dyes(get_turf(src))
	..()
	qdel(src)

/obj/item/cheap_dyes
	name = "cheap dyes"
	desc = "Adding these to a wooden bin will let you use it to dye clothing. Made from ash with several jacksberries or swampweed mixed in."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "cheap_dyes"
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.7
	sellprice = 3
/obj/item/cheap_dyes/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/dyes(get_turf(src))
	..()
	qdel(src)
