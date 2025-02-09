/*	.................   Luxury dye bin   ................... */
/obj/machinery/dye_bin
	name = "dye bin"
	desc = "A wooden barrel with various dyes, used to stain clothes into new colors."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "dye_bin"
	density = TRUE
	anchored = FALSE
	max_integrity = 80
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	var/final/atom/movable/inserted = null
	var/final/active_color = null
	/// Allow holder'd mobs
	var/allow_mobs = TRUE

	/// Packs that this bin will initialize with
	var/list/initial_packs = list(/obj/item/dye_pack/cheap)
	/// List of all colors currently usable in this bin.
	/// Recompiled when inserted_packs changes.
	var/list/selectable_colors = list()

/obj/machinery/dye_bin/luxury
	icon_state = "dye_bin_luxury"
	initial_packs = list(/obj/item/dye_pack/luxury)

/obj/machinery/dye_bin/Initialize(mapload, obj/item/dye_pack/inserted_pack)
	. = ..()
	if(mapload || !inserted_pack)
		for(var/pack_path in initial_packs)
			var/obj/item/dye_pack/new_pack = new pack_path()
			add_dye_pack(new_pack)
	else
		add_dye_pack(inserted_pack)

	active_color = selectable_colors[pick(selectable_colors)] //lol

/obj/machinery/dye_bin/Destroy()
	layer = 2.8 //?
	icon_state = "washbin_destroy"
	density = FALSE
	return ..()

/obj/machinery/dye_bin/proc/add_dye_pack(obj/item/dye_pack/new_pack)
	new_pack.forceMove(src) //GIVE ME THAT
	selectable_colors |= new_pack.selectable_colors
	qdel(new_pack)

/obj/machinery/dye_bin/proc/apply_dye(mob/living/carbon/human/user, obj/item/clothing/item_to_dye, color)
	if (!item_to_dye || !color)
		return
	if (item_to_dye.detail_tag)
		item_to_dye.detail_color = color
		item_to_dye.update_icon()
	else
		item_to_dye.add_atom_colour(color, FIXED_COLOUR_PRIORITY)

/obj/machinery/dye_bin/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/dye_pack))
		. = TRUE
		var/obj/item/dye_pack/pack = I
		user.visible_message( \
			span_info("[user] begins to add [pack] to [src]..."), \
			span_info("I begin to add [pack] to [src]...") \
		)
		if(do_after(user, 3 SECONDS, target = src))
			add_dye_pack(pack)

		return


	if(!I.sewrepair) // ????
		if(I.force < 8) // ?????????
			to_chat(user, span_warning("I do not think this item can be dyed this way."))
		return ..()

	/* ---------- */
	. = TRUE

	if(istype(I, /obj/item/clothing/head/mob_holder))
		if(!allow_mobs)
			to_chat(user, span_warning("I could not fit [I] into [src]."))
			return
		var/obj/item/clothing/head/mob_holder/fellow = I
		fellow.release() //is this not a bug?

	if(user.mind?.get_skill_level(/datum/skill/misc/sewing) <= 2) // We're not letting people with 0 knowledge in sewing do dying, so they don't step on the toes of the seamstress
		to_chat(user, span_warning("I do not know enough about this craft..."))
		return
	if(inserted)
		to_chat(user, span_warning("There is already something inside the dye bin."))
		return
	if(!user.transferItemToLoc(I, src))
		to_chat(user, span_warning("I can not let go of [I]!"))
		return

	user.visible_message( \
		span_notice("[user] inserts [I] into [src]."), \
		span_notice("I insert [I] into [src].") \
	)
	inserted = I
	icon_state = "dye_bin_full"
	updateUsrDialog()

/obj/machinery/dye_bin/attack_hand(mob/living/user)
	ui_interact(user)

/obj/machinery/dye_bin/AllowDrop()
	return FALSE

/obj/machinery/dye_bin/ui_interact(mob/living/user)
	if(!is_operational())
		return
	user.set_machine(src)
	var/list/dat = list("<STYLE> * {text-align: center;} </STYLE>")
	if(!inserted)
		dat += "No item inserted."
	else
		var/ref = REF(src)
		dat += "Item inserted: \the [inserted]<BR>"
		dat += "<A href='byond://?src=[ref];action=eject'>Remove item.</A>"
		dat += "<HR>"
		dat += "Color: <font color='[active_color]'>&#9899;</font>"
		dat += "<BR>"
		dat += "<A href='byond://?src=[ref];action=paint'>Apply new dye.</A> | "
		dat += "<A href='byond://?src=[ref];action=select'>Select new color.</A> | "
		dat += "<A href='byond://?src=[ref];action=clear'>Bleach out the color.</A>"

	var/datum/browser/menu = new(user, "colormate","<CENTER>[src]</CENTER>", 400, 400, src)
	menu.set_content(dat.Join())
	menu.open()

/obj/machinery/dye_bin/Topic(href, href_list)
	. = ..()
	if(!.)
		return

	var/mob/living/user = usr
	if(!istype(user))
		return
	add_fingerprint(user)

	switch(href_list["action"])
		if("close")
			user << browse(null, "window=colormate")
			return

		if("select")
			var/choice = input(user,"Choose your dye:", "Dyes", null) as null|anything in selectable_colors
			if(!choice)
				return
			active_color = selectable_colors[choice]

		if("paint")
			if(!inserted)
				return
			playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
			user.visible_message( \
				span_notice("[user] begins to dye [inserted]..."), \
				span_notice("I begin to dye [inserted]..."), \
				span_hear("I hear something moving in water.") \
			)
			if(do_after(user, 5 SECONDS, target = src))
				apply_dye(user, inserted, active_color)

		if("clear")
			if(!inserted)
				return
			playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 50, FALSE)
			user.visible_message( \
				span_notice("[user] begins to bleach [inserted]..."), \
				span_notice("I begin to bleach [inserted]..."), \
				span_hear("I hear something moving in water.") \
			)
			if(do_after(user, 5 SECONDS, target = src))
				inserted.remove_atom_colour(FIXED_COLOUR_PRIORITY)

		if("eject")
			if(!inserted)
				return
			inserted.forceMove(get_turf(user))
			var/removed = inserted
			inserted = null

			user.put_in_hands(removed)
			user.visible_message( \
				span_notice("[user] removes [removed] from [src]."), \
				span_notice("I remove [removed] from [src].") \
			)
			playsound(src, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)
			icon_state = initial(icon_state)
			update_icon()

	updateUsrDialog()

/obj/machinery/dye_bin/onkick(mob/living/user)
	if(!istype(user))
		return

	playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
	user.visible_message( \
		span_warning("[user] kicks [src]!"), \
		span_warning("I kick [src]!"), \
		span_warning("I hear a loud bang!") \
	)

	if(prob(user.STASTR * 8))
		visible_message( \
			span_warning("[p_they()] fall[p_s()] over, spilling out [p_their()] contents!"), \
			null, \
			span_warning("Something was knocked over!")
		)
		new /obj/effect/decal/cleanable/dyes(get_turf(src))
		var/obj/item/roguebin/I = new(loc)
		I.kover = TRUE
		I.update_icon()
		qdel(src)

/*	.................   Dyes   ................... */

/obj/item/dye_pack //abstract
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "bait" //placeholder
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.7
	var/list/selectable_colors = list()

/obj/item/dye_pack/examine(mob/user)
	. = ..()
	. += span_info("Putting these into a wooden bin will turn it into a dye bin.")
	. += span_info("Putting these into an existing dye bin will add the colors into it.")
	var/colors_ref = "byond://?src=[REF(src)];action=colors"
	. += span_info(span_notice("I could look at the selection of <a href=[colors_ref]>colors</a>...")) //ew

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

				var/entry = span_info("- <font color='[value]'>[key]</font>")
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
	gender = PLURAL
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
		//"Fyritius Orange" ="#9b7540",
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
	gender = PLURAL
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
		"Fyritius Orange" ="#9b7540", //
		//"Royal Purple" ="#865c9c"
	)
