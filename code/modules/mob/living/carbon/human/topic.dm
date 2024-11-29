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
			msg += "<span class='dead'>Limb is missing!</span>"
		to_chat(usr, "<span class='info'>[msg.Join("\n")]</span>")

	if(href_list["check_hb"])
		if(isobserver(usr))
			if(stat == DEAD)
				to_chat(usr, "<span class='info'><B>No heartbeat...</B></span>")
			else
				to_chat(usr, "<span class='info'><B>The heart is still beating.</B></span>")
		else if(Adjacent(usr) && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
			usr.visible_message("<span class='info'>[usr] tries to hear [src]'s heartbeat.</span>")
			if(do_after(usr, 30, needhand = 1, target = src))
				if(stat == DEAD)
					to_chat(usr, "<span class='info'><B>No heartbeat...</B>")
				else
					to_chat(usr, "<span class='info'><B>The heart is still beating.</B></span>")

	if(href_list["embedded_object"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["embedded_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = locate(href_list["embedded_object"]) in L.embedded_objects
		if(!I) //no item, no limb, or item is not in limb or in the person anymore
			return
		var/time_taken = I.embedding.embedded_unsafe_removal_time*I.w_class
		if(usr == src)
			usr.visible_message("<span class='warning'>[usr] attempts to remove [I] from [usr.p_their()] [L.name].</span>","<span class='warning'>I attempt to remove [I] from my [L.name]...</span>")
		else
			usr.visible_message("<span class='warning'>[usr] attempts to remove [I] from [src]'s [L.name].</span>","<span class='warning'>I attempt to remove [I] from [src]'s [L.name]...</span>")
		if(do_after(usr, time_taken, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || !L.remove_embedded_object(I))
				return
			L.receive_damage(I.embedding.embedded_unsafe_removal_pain_multiplier*I.w_class)//It hurts to rip it out, get surgery you dingus.
			usr.put_in_hands(I)
			emote("pain", TRUE)
			playsound(loc, 'sound/foley/flesh_rem.ogg', 100, TRUE, -2)
			if(usr == src)
				usr.visible_message("<span class='notice'>[usr] rips [I] out of [usr.p_their()] [L.name]!</span>", "<span class='notice'>I successfully remove [I] from my [L.name].</span>")
			else
				usr.visible_message("<span class='notice'>[usr] rips [I] out of [src]'s [L.name]!</span>", "<span class='notice'>I successfully remove [I] from [src]'s [L.name].</span>")

	if(href_list["bandage"] && usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		var/obj/item/bodypart/L = locate(href_list["bandaged_limb"]) in bodyparts
		if(!L)
			return
		var/obj/item/I = L.bandage
		if(!I)
			return
		if(usr == src)
			usr.visible_message("<span class='warning'>[usr] starts unbandaging [usr.p_their()] [L.name].</span>","<span class='warning'>I start unbandaging [L.name]...</span>")
		else
			usr.visible_message("<span class='warning'>[usr] starts unbandaging [src]'s [L.name].</span>","<span class='warning'>I start unbandaging [src]'s [L.name]...</span>")
		if(do_after(usr, 50, needhand = TRUE, target = src))
			if(QDELETED(I) || QDELETED(L) || (L.bandage != I))
				return
			L.remove_bandage()
			usr.put_in_hands(I)

	if(href_list["item"]) //canUseTopic check for this is handled by mob/Topic()
		var/slot = text2num(href_list["item"])
		if(slot in check_obscured_slots(TRUE))
			to_chat(usr, "<span class='warning'>I can't reach that! Something is covering it.</span>")
			return

	if(href_list["undiesthing"]) //canUseTopic check for this is handled by mob/Topic()
		if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
			to_chat(usr, "<span class='warning'>I can't reach that! Something is covering it.</span>")
			return
		if(underwear == "Nude")
			return
		if(do_after(usr, 50, needhand = 1, target = src))
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
				to_chat(usr, "<span class='warning'>I try to empty [src]'s [pocket_side] pocket, it seems to be stuck!</span>")
			to_chat(usr, "<span class='notice'>I try to empty [src]'s [pocket_side] pocket.</span>")
		else if(place_item && place_item.mob_can_equip(src, usr, pocket_id, 1) && !(place_item.item_flags & ABSTRACT))
			to_chat(usr, "<span class='notice'>I try to place [place_item] into [src]'s [pocket_side] pocket.</span>")
			delay_denominator = 4
		else
			return

		if(do_mob(usr, src, POCKET_STRIP_DELAY/delay_denominator)) //placing an item into the pocket is 4 times faster
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
			to_chat(src, "<span class='warning'>I feel your [pocket_side] pocket being fumbled with!</span>")
	return ..() //end of this massive fucking chain. TODO: make the hud chain not spooky. - Yeah, great job doing that.
