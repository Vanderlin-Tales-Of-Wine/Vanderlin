/datum/charflaw/addiction/graphomaniac
	name = "Graphomaniac"
	desc = "Every little once in a while I need to write about recent events into MY diary- I've hidden it somewhere alongside my pen."
	time = 20 MINUTES // I'd say it is similar to godfearing, but this one gives you reading skill and has cooler flavor. So they have to do it twice as often compared to godfearing.
	needsate_text = "I need to write about the past events into my diary..."
	sated_text = "Writing it all down makes me feel much better..."

/datum/charflaw/addiction/graphomaniac/on_mob_creation(mob/user)
	..()
	RegisterSignal(user, COMSIG_MOB_LOGIN, PROC_REF(on_mob_login), user) // The mind doesn't exist yet so we have to do it after the mob has logged in.
	return

/datum/charflaw/addiction/graphomaniac/proc/on_mob_login(mob/user)
	UnregisterSignal(user, COMSIG_MOB_LOGIN) // And be rid of the signal, we don't want to do it again.
	if(!user.is_literate()) // At LEAST let them be able to read the diary.
		user.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	user.mind?.special_items["My Diary"] = /obj/item/paper/diary
	user.mind?.special_items["My Feather"] = /obj/item/natural/feather
	sleep(2 SECONDS)
	to_chat(user, span_warning("Graphomaniac : (Right click a Statue, Clock, Tree, or other decor to get your diary and pen)"))

// This diary should ONLY be in the game from a charflaw

/obj/item/paper/diary
	name = "diary"
	desc = "This is somebody's diary, it's quite old and has seen better daes."
	icon = 'icons/roguetown/items/books.dmi'
	icon_state = "book_0"
	var/diary_owner = null
	var/diary_base_icon_state = "book"
	var/diary_opened = FALSE
	maxlen = 10000

/obj/item/paper/diary/Initialize()
	. = ..()
	diary_base_icon_state = pick(\
		"basic_book",\
		"book",\
		"book2",\
		"book3",\
		"book4",\
		"book5",\
		"book6",\
		"book7",\
		"book8",\
	)
	update_icon_state()

/obj/item/paper/diary/update_icon_state()
	// Update Icons
	if(!diary_opened)
		icon_state = "[diary_base_icon_state]_0"
	else
		icon_state = "[diary_base_icon_state]_1"

/obj/item/paper/diary/attackby(obj/item/item, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(!diary_owner)
		attack_self(user)
		return
	if(istype(item, /obj/item/natural/thorn) || istype(item, /obj/item/natural/feather))
		if(diary_owner==user)
			if(is_blind(user))
				to_chat(user, span_warning("I want to write on [src], but I cannot see the pages."))
				return
			if(length(info) > maxlen)
				to_chat(user, span_warning("[src] is full of verba."))
				return
			if(user.can_read(src))
				format_browse(info_links, user)
				update_icon_state()
				return
		else
			to_chat(user, span_warning("Why would I want to write in somebody elses diary?."))
			return

/obj/item/paper/diary/attack_self(mob/user)
	..()
	if(!diary_owner)
		var/claim = alert(user, "Do I Claim This Diary As My Own?", "[src.name]", "No", "Yes")
		if(claim=="Yes")
			to_chat(user, span_notice("I claim [src], my name is upon it now."))
			diary_owner = user
			name = "[user.real_name]'s Diary"
			desc = "[desc] [user.real_name] is written along the spine."
			update_icon_state()
		return
	read(user)
	add_fingerprint(user)
	return ..()

/obj/item/paper/diary/read(mob/user)
	if(!diary_opened)
		return
	..()

/obj/item/paper/diary/rmb_self(mob/user)
	attack_right(user)
	return

/obj/item/paper/diary/attack_right(mob/user)
	if(!diary_opened)
		slot_flags &= ~ITEM_SLOT_HIP
		diary_opened = TRUE
		playsound(loc, 'sound/items/book_open.ogg', 100, FALSE, -1)
	else
		slot_flags |= ITEM_SLOT_HIP
		diary_opened = FALSE
		playsound(loc, 'sound/items/book_close.ogg', 100, FALSE, -1)
	update_icon()
	user.update_inv_hands()
