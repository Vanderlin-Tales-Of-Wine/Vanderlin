/obj/structure/roguemachine/submission
	name = "HOLE OF SUBMISSION"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "submit"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/roguemachine/submission/attackby(obj/item/P, mob/user, params)
/*	if(GLOB.feeding_hole_wheat_count < 5)
		user << "You hear squeaks coming from the hole, but it seems inactive."

		return*/
	if(ishuman(user))
/*		if(user.mind.assigned_role == "Mercenary")
			playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
			user.visible_message("<span class='notice'>These cursed local contraptions confound me.")
			return
This is a filter that blocks use of the machine for that role. Could be expanded, made more complex, made for races or whatever.*/
		var/mob/living/carbon/human/H = user
		if(istype(P, /obj/item/natural/bundle))
			say("Single item entries only. Please unstack.")
			return
		if(istype(P, /obj/item/roguecoin))
			if(H in SStreasury.bank_accounts)
				SStreasury.generate_money_account(P.get_real_price(), H)
				qdel(P)
				playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
				return
			else
				say("No account found. Submit your fingers to a meister for inspection.")
		else
			for(var/datum/roguestock/R in SStreasury.stockpile_datums)
				if(istype(P,R.item_type))
					if(!R.check_item(P))
						continue
					var/amt = R.get_payout_price(P)
					if(!R.transport_item)
						R.held_items += 1 //stacked logs need to check for multiple
						qdel(P)
						stock_announce("[R.name] has been stockpiled.")
					else
						var/area/A = GLOB.areas_by_type[R.transport_item]
						if(!A)
							say("Couldn't find where to send the submission.")
							return
						//This item is now listed as submitted to the stockpile.
						P.submitted_to_stockpile = TRUE
						var/list/turfs = list()
						for(var/turf/T in A)
							turfs += T
						var/turf/T = pick(turfs)
						P.forceMove(T)
						playsound(T, 'sound/misc/hiss.ogg', 100, FALSE, -1)
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					flick("submit_anim",src)
					if(amt)
						if(!SStreasury.give_money_account(amt, H, "+[amt] from [R.name] bounty"))
							say("No account found. Submit your fingers to a meister for inspection.")
					return
	return ..()

/obj/item/proc/get_stockpiled_amount()
	return 1

/obj/structure/roguemachine/submission/attack_hand(mob/living/user)
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

	for(var/datum/roguestock/bounty/R in SStreasury.stockpile_datums)
		contents += "[R.name] - [R.payout_price][R.percent_bounty ? "%" : ""]"
		contents += "<BR>"

	contents += "<BR>"

	for(var/datum/roguestock/stockpile/R in SStreasury.stockpile_datums)
		contents += "[R.name] - [R.payout_price] - [R.demand2word()]"
		contents += "<BR>"

	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 220)
	popup.set_content(contents)
	popup.open()

/obj/structure/roguemachine/submission/attack_right(mob/living/user) // Allows a way to sell piles without clicking 40 times. Simply dump out a pile, stand on top, and right click
	var/turf/T = get_turf(user)
	for(var/obj/item/P in get_turf(T))
		if(do_after(user, 1 SECONDS, src))
			src.attackby(P, user)

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
	else if(istype(P, /obj/item/reagent_containers/food/snacks/rogue/meat/steak))
		// Handle the steak item and spawn bigrat
		qdel(P)
		playsound(src, 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
		new /mob/living/simple_animal/hostile/retaliate/rogue/bigrat(loc)
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
