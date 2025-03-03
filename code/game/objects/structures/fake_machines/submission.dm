/obj/structure/fake_machine/submission
	name = "HOLE OF SUBMISSION"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "submit"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/fake_machine/submission/proc/attemptsell(obj/item/I, mob/H, message = TRUE, sound = TRUE)
	for(var/datum/stock/R in SStreasury.stockpile_datums)
		if(istype(I, /obj/item/natural/bundle))
			var/obj/item/natural/bundle/B = I
			if(B.stacktype == R.item_type)
				R.held_items += B.amount
				if(message == TRUE)
					stock_announce("[B.amount] units of [R.name] has been submitted to the stockpile.")
				qdel(B)
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
			continue
		else if(istype(I, R.item_type))
			if(!R.check_item(I))
				continue
			if(!R.transport_item)
				R.held_items += 1 //stacked logs need to check for multiple
				qdel(I)
				if(message == TRUE)
					stock_announce("[R.name] has been submitted to the stockpile.")
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
			else
				var/area/A = GLOB.areas_by_type[R.transport_item]
				if(!A && message == TRUE)
					say("Couldn't find where to send the submission.")
					return
				I.submitted_to_stockpile = TRUE
				var/list/turfs = list()
				for(var/turf/T in A)
					turfs += T
				var/turf/T = pick(turfs)
				I.forceMove(T)
				if(sound == TRUE)
					playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			return

/obj/structure/fake_machine/submission/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
/*	if(user.mind.assigned_role == "Mercenary")
		playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
		user.visible_message("<span class='notice'>These cursed local contraptions confound me.")
		return
This is a filter that blocks use of the machine for that role. Could be expanded, made more complex, made for races or whatever.*/
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	var/contents = "<center>SUBMISSION HOLE<BR>"

	contents += "----------<BR>"

	contents += "</center>"

	for(var/datum/stock/bounty/R in SStreasury.stockpile_datums)
		contents += "[R.name]"
		contents += "<BR>"

	contents += "<BR>"

	for(var/datum/stock/stockpile/R in SStreasury.stockpile_datums)
		contents += "[R.name]"
		contents += "<BR>"

	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 220)
	popup.set_content(contents)
	popup.open()

/obj/structure/fake_machine/submission/attackby(obj/item/P, mob/user, params)
	if(ishuman(user))
		attemptsell(P, user, TRUE, TRUE)
		return TRUE

/obj/structure/fake_machine/submission/attack_right(mob/user)
	if(ishuman(user))
		for(var/obj/I in get_turf(src))
			attemptsell(I, user, FALSE, FALSE)
		say("Bulk submission in progress...")
		playsound(loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
		playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		return TRUE

/*				//Var for keeping track of timer
GLOBAL_VAR_INIT(feeding_hole_wheat_count, 0)
GLOBAL_VAR(feeding_hole_reset_timer)
*/
			//WIP for now it does really nothing, but people will be gaslighted into thinking it does.
/obj/structure/feedinghole
	name = "FEEDING HOLE"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "feedinghole"
	density = FALSE
	pixel_y = 32

/obj/structure/feedinghole/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/reagent_containers/food/snacks/produce/wheat))
		qdel(P)
/*		if(!GLOB.feeding_hole_reset_timer || world.time > GLOB.feeding_hole_reset_timer)
			GLOB.feeding_hole_wheat_count = 0
			GLOB.feeding_hole_reset_timer = world.time + (1 MINUTES)

		GLOB.feeding_hole_wheat_count++
*/
		playsound(src, 'sound/misc/beep.ogg', 100, FALSE, -1)
		user.visible_message("<span class='notice'>[user] feeds [P] into the [src].</span>",
			"<span class='notice'>You feed the [P] into the [src].</span>")
	else if(istype(P, /obj/item/reagent_containers/food/snacks/meat/steak))
		// Handle the steak item and spawn bigrat
		qdel(P)
		playsound(src, 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
		new /mob/living/simple_animal/hostile/retaliate/bigrat(loc)
		user.visible_message("<span class='notice'>[user] feeds [P] into the [src], and something emerges!</span>",
			"<span class='danger'>You feed the [P] into the [src], and something emerges!</span>")
	else

		..()

/obj/structure/feedinghole/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	var/contents = "<center>FEEDING HOLE<BR>"

	contents += "----------<BR>"

	contents += "Feed the hole<BR>"

	contents += "</center>"

	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "FEEDINGHOLE", "", 370, 220)
	popup.set_content(contents)
	popup.open()
