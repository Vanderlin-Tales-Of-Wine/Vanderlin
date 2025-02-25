GLOBAL_VAR_INIT(year, time2text(world.realtime,"YYYY"))
GLOBAL_VAR_INIT(year_integer, text2num(year)) // = 2013???

/mob/living/carbon/human/Topic(href, href_list)
	if(href_list["inspect_limb"] && (isobserver(usr) || usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)))
		var/list/msg = list()
		var/mob/user = usr
		var/checked_zone = check_zone(href_list["inspect_limb"])
		var/obj/item/bodypart/bodypart = get_bodypart(checked_zone)
		if(bodypart)
			var/list/bodypart_status = bodypart.inspect_limb(user)
			if(length(bodypart_status))
				msg += bodypart_status
			else
				msg += "<B>[capitalize(bodypart.name)]:</B>"
				msg += "[bodypart] is healthy."
		else
			msg += "<B>[capitalize(parse_zone(checked_zone))]:</B>"
			msg += span_dead("Limb is missing!")
		to_chat(usr, span_info("[msg.Join("\n")]"))

	if(href_list["check_hb"] && (isobserver(usr) || usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)))
		if(!isobserver(usr))
			usr.visible_message(span_info("[usr] tries to hear [src]'s heartbeat."))
			if(!do_after(usr, 3 SECONDS, src))
				return
		var/list/following_my_heart = check_heartbeat(usr)
		to_chat(usr, span_info("[following_my_heart.Join("\n")]"))

	if(href_list["embedded_object"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["embedded_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = locate(href_list["embedded_object"]) in L.embedded_objects
		if(!I) //no item, no limb, or item is not in limb or in the person anymore
			return
		var/time_taken = I.embedding.embedded_unsafe_removal_time*I.w_class
		if(usr == src)
			usr.visible_message(span_warning("[usr] attempts to remove [I] from [usr.p_their()] [L.name]."),span_warning("I attempt to remove [I] from my [L.name]..."))
		else
			usr.visible_message(span_warning("[usr] attempts to remove [I] from [src]'s [L.name]."),span_warning("I attempt to remove [I] from [src]'s [L.name]..."))
		if(do_after(usr, time_taken, src))
			if(QDELETED(I) || QDELETED(L) || !L.remove_embedded_object(I))
				return
			L.receive_damage(I.embedding.embedded_unsafe_removal_pain_multiplier*I.w_class)//It hurts to rip it out, get surgery you dingus.
			usr.put_in_hands(I)
			emote("pain", TRUE)
			playsound(loc, 'sound/foley/flesh_rem.ogg', 100, TRUE, -2)
			if(usr == src)
				usr.visible_message(span_notice("[usr] rips [I] out of [usr.p_their()] [L.name]!"), span_notice("I successfully remove [I] from my [L.name]."))
			else
				usr.visible_message(span_notice("[usr] rips [I] out of [src]'s [L.name]!"), span_notice("I successfully remove [I] from [src]'s [L.name]."))

	if(href_list["bandage"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["bandaged_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = L.bandage
		if(!I)
			return
		if(usr == src)
			usr.visible_message(span_warning("[usr] starts unbandaging [usr.p_their()] [L.name]."),span_warning("I start unbandaging [L.name]..."))
		else
			usr.visible_message(span_warning("[usr] starts unbandaging [src]'s [L.name]."),span_warning("I start unbandaging [src]'s [L.name]..."))
		if(do_after(usr, 5 SECONDS, src))
			if(QDELETED(I) || QDELETED(L) || (L.bandage != I))
				return
			L.remove_bandage()
			usr.put_in_hands(I)

	if(href_list["item"]) //canUseTopic check for this is handled by mob/Topic()
		var/slot = text2num(href_list["item"])
		if(slot in check_obscured_slots(TRUE))
			to_chat(usr, span_warning("I can't reach that! Something is covering it."))
			return

	if(href_list["undiesthing"]) //canUseTopic check for this is handled by mob/Topic()
		if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
			to_chat(usr, span_warning("I can't reach that! Something is covering it."))
			return
		if(underwear == "Nude")
			return
		if(do_after(usr, 5 SECONDS, src))
			cached_underwear = underwear
			underwear = "Nude"
			update_body()
			var/obj/item/undies/U
			if(gender == MALE)
				U = new/obj/item/undies(get_turf(src))
			else
				U = new/obj/item/undies/f(get_turf(src))
			U.color = underwear_color
			if(iscarbon(usr))
				var/mob/living/carbon/C = usr
				C.put_in_hands(U)

	if(href_list["pockets"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)) //TODO: Make it match (or intergrate it into) strippanel so you get 'item cannot fit here' warnings if mob_can_equip fails
		var/pocket_side = href_list["pockets"]
		var/pocket_id = (pocket_side == "right" ? SLOT_R_STORE : SLOT_L_STORE)
		var/obj/item/pocket_item = (pocket_id == SLOT_R_STORE ? r_store : l_store)
		var/obj/item/place_item = usr.get_active_held_item() // Item to place in the pocket, if it's empty

		var/delay_denominator = 1
		if(pocket_item && !(pocket_item.item_flags & ABSTRACT))
			if(HAS_TRAIT(pocket_item, TRAIT_NODROP))
				to_chat(usr, span_warning("I try to empty [src]'s [pocket_side] pocket, it seems to be stuck!"))
			to_chat(usr, span_notice("I try to empty [src]'s [pocket_side] pocket."))
		else if(place_item && place_item.mob_can_equip(src, usr, pocket_id, 1) && !(place_item.item_flags & ABSTRACT))
			to_chat(usr, span_notice("I try to place [place_item] into [src]'s [pocket_side] pocket."))
			delay_denominator = 4
		else
			return

		if(do_after(usr, POCKET_STRIP_DELAY/delay_denominator, src)) //placing an item into the pocket is 4 times faster
			if(pocket_item)
				if(pocket_item == (pocket_id == SLOT_R_STORE ? r_store : l_store)) //item still in the pocket we search
					dropItemToGround(pocket_item)
			else
				if(place_item)
					if(place_item.mob_can_equip(src, usr, pocket_id, FALSE, TRUE))
						usr.temporarilyRemoveItemFromInventory(place_item, TRUE)
						equip_to_slot(place_item, pocket_id, TRUE)
					//do nothing otherwise
				//updating inv screen after handled by living/Topic()
		else
			// Display a warning if the user mocks up
			to_chat(src, span_warning("I feel your [pocket_side] pocket being fumbled with!"))
	return ..() //end of this massive fucking chain. TODO: make the hud chain not spooky. - Yeah, great job doing that.

/mob/living/proc/check_heartbeat(mob/user)
	var/list/message = list()
	if(stat >= DEAD)
		message += "<B>No heartbeat...</B>"
	else
		message += "<B>The heart is still beating.</B>"
	var/list/soul_message = soul_examine(user)
	if(soul_message)
		message += soul_message
	return message

/mob/living/proc/soul_examine(mob/user)
	var/list/message = list()
	if(stat >= DEAD)
		if(suiciding)
			message += span_deadsay("[p_they(TRUE)] commited suicide... Nothing can be done...")
		if(isobserver(user) || HAS_TRAIT(user, TRAIT_SOUL_EXAMINE))
			if(!key && !get_ghost(TRUE))
				message += span_deadsay("[p_their(TRUE)] soul has departed for the Underworld.")
			else
				message += span_deadsay("[p_they(TRUE)] [p_are()] still earthbound.")
	return message
