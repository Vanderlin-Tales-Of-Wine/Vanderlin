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
	var/final/atom/movable/inserted = null
	var/final/activecolor = null
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

/*	.................   Dyes   ................... */

/obj/item/dye_pack //abstract
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.7
	var/list/selectable_colors = list()

/obj/item/dye_pack/examine(mob/user)
	. = ..()
	. += span_info("Putting these into a wooden bin will turn it into a dye bin.")
	. += span_info("Putting these into an existing dye bin will add the colors into it.")
	var/colors_ref = "byond://?src=[REF(src)];action=colors"
	. += span_notice("I could look at the selection of <a href=[colors_ref]>colors</a>...")

/obj/item/dye_pack/Topic(href, href_list)
	. = ..()
	switch(href_list["action"])
		if("colors")
			if(!length(selectable_colors))
				to_chat(usr, span_warning("I am looking at [src], but there are no colors?"))
				to_chat(usr, span_ooc("<i>This is a bug. Please report this on the GitHub.</i>"))
				return

			var/list/message_parts = list(span_notice("I can discern these colors..."))
			for(var/key in selectable_colors)
				var/value = selectable_colors[key]

				var/entry = span_notice("- <font color='[value]'>[key]</font>")
				message_parts += entry

			to_chat(usr, message_parts.Join("\n"))

/obj/item/dye_pack/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	new /obj/effect/decal/cleanable/dyes(get_turf(src))
	. = ..()
	qdel(src)

/obj/item/dye_pack/luxury
	name = "luxury dyes"
	desc = "Extravagant, colorful dyes hailing from all across Psydonia, from Grenzelhoft to Heartfelt."
	icon_state = "luxury_dyes"
	sellprice = 30
	selectable_colors = list(
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

		"Royal Black" ="#2f352f", //
		"Royal Red" ="#813434", //
		"Royal Majenta" ="#822b52", //
		//"Bark Brown"="#685542",
		//"Bog Green" ="#4f693b",
		"Mage Green" ="#60794a",
		"Royal Teal" ="#3b817a", //
		"Pear Yellow" ="#a19f52",
		"Mage Yellow" ="#a79730",
		"Fyritius Orange" ="#9b7540",
		"Mage Orange" ="#935329",
		"Royal Purple" ="#865c9c", //
		"Mage Blue" ="#454fa6",

		"Salmon" ="#70545e",
		"Russet" ="#583f2c",
		"Yellow Ochre" ="#685e3b",
		"Red Ochre" = "#573936",
		"Maroon" ="#533727",
		"Swampweed" ="#00713d",
		"Ocean" ="#45749d"
	)

/obj/item/dye_pack/cheap
	name = "cheap dyes"
	desc = "A handful of muted dyes made from natural elements."
	icon_state = "cheap_dyes"
	sellprice = 3

	selectable_colors = list(
		"Bleach" ="#ffffff",
		"Ash Grey" ="#676262",
		"Chalk White" ="#c7c0b5",
		"Linen" ="#a1a17a",

		"Soot Black" ="#414145",
		//"Royal Black" ="#2f352f",
		"Winestain Red" ="#673c3c",
		//"Royal Red" ="#8f3636",
		//"Royal Majenta" ="#822b52",
		"Peasant Brown" ="#634f44",
		"Chestnut" ="#604631",
		"Bark Brown" ="#685542", //
		"Mud Brown" ="#6f5f4d",
		"Old Leather" ="#473f39",
		"Spring Green" ="#41493a",
		"Bog Green" ="#4f693b", //
		//"Royal Teal" ="#3b817a",
		"Berry Blue" ="#39404d",
		"Pear Yellow" ="#a19f52",
		"Fyritius Orange" ="#9b7540",
		//"Royal Purple" ="#865c9c"
	)
