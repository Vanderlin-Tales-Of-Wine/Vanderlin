
/obj/item/rope
	name = "rope"
	desc = "A series of threads interwined to create a firm rope for binding, hanging and other jobs."
	gender = PLURAL
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "rope"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 3
	breakouttime = 5 SECONDS
	slipouttime = 1 MINUTES
	var/cuffsound = 'sound/blank.ogg'
	possible_item_intents = list(/datum/intent/tie)
	firefuel = 5 MINUTES
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'

/datum/intent/tie
	name = "tie"
	icon_state = "intie"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0

/obj/item/rope/Destroy()
	if(iscarbon(loc))
		var/mob/living/carbon/M = loc
		if(M.handcuffed == src)
			M.handcuffed = null
			M.update_handcuffed()
			if(M.buckled && M.buckled.buckle_requires_restraints)
				M.buckled.unbuckle_mob(M)
		if(M.legcuffed == src)
			M.legcuffed = null
			M.update_inv_legcuffed()
	return ..()

/obj/item/rope/attack(mob/living/carbon/C, mob/living/user)
	if(user.used_intent.type != /datum/intent/tie)
		..()
		return

	if(!istype(C))
		return

	if(user.aimheight > 4)
		if(!C.handcuffed)
			if(C.get_num_arms(FALSE))
				C.visible_message("<span class='warning'>[user] is trying to tie [C]'s arms with [src.name]!</span>", \
									"<span class='userdanger'>[user] is trying to tie my arms with [src.name]!</span>")

				playsound(loc, cuffsound, 100, TRUE, -2)
				if(do_after(user, 6 SECONDS * (C.surrendering ? 0.5 : 1), C) && C.get_num_arms(FALSE))
					apply_cuffs(C, user)
					C.visible_message("<span class='warning'>[user] ties [C] with [src.name].</span>", \
										"<span class='danger'>[user] ties me up with [src.name].</span>")
					SSblackbox.record_feedback("tally", "handcuffs", 1, type)
					user.mind?.adjust_experience(/datum/skill/craft/traps, C.STAINT, FALSE)
					log_combat(user, C, "handcuffed")
				else
					to_chat(user, "<span class='warning'>I fail to tie up [C]!</span>")
			else
				to_chat(user, "<span class='warning'>[C] has no arms to tie up.</span>")

	if(user.aimheight <= 4)
		if(!C.legcuffed)
			if(C.get_num_legs(TRUE) == 2)
				C.visible_message("<span class='warning'>[user] is trying to tie [C]'s legs with [src.name]!</span>", \
									"<span class='userdanger'>[user] is trying to tie my legs with [src.name]!</span>")

				playsound(loc, cuffsound, 30, TRUE, -2)
				if(do_after(user, 6 SECONDS, C) && (C.get_num_legs(FALSE) < 2))
					apply_cuffs(C, user)
					C.visible_message("<span class='warning'>[user] ties [C]'s legs with [src.name].</span>", \
										"<span class='danger'>[user] ties my legs with [src.name].</span>")
					SSblackbox.record_feedback("tally", "legcuffs", 1, type)
					user.mind?.adjust_experience(/datum/skill/craft/traps, C.STAINT, FALSE)
					log_combat(user, C, "legcuffed", TRUE)
				else
					to_chat(user, "<span class='warning'>I fail to tie up [C]!</span>")
			else
				to_chat(user, "<span class='warning'>[C] is missing two or one legs.</span>")

/obj/item/rope/proc/apply_cuffs(mob/living/carbon/target, mob/user, leg = FALSE)
	if(!leg)
		if(target.handcuffed)
			return

		if(!user.temporarilyRemoveItemFromInventory(src) )
			return

		var/obj/item/cuffs = src

		cuffs.forceMove(target)
		target.handcuffed = cuffs

		target.update_handcuffed()
		return
	else
		if(target.legcuffed)
			return

		if(!user.temporarilyRemoveItemFromInventory(src) )
			return

		var/obj/item/cuffs = src

		cuffs.forceMove(target)
		target.legcuffed = cuffs

		target.update_inv_legcuffed()
		return


/datum/intent/whip
	name = "strike"
	blade_class = BCLASS_BLUNT
	attack_verb = list("whips", "strikes", "smacks")
	penfactor = 40
	chargetime = 5

/obj/item/rope/chain
	name = "chain"
	desc = "Metal chains designed to interlock and apply the harshest confinement on the villainous."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "chain"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	force = 10
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 3
	breakouttime = 1 MINUTES
	slipouttime = 5 MINUTES
	cuffsound = 'sound/blank.ogg'
	possible_item_intents = list(/datum/intent/tie, /datum/intent/whip)
	firefuel = null
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'

/obj/item/net
	name = "net"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "net"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_WRISTS
	force = 10
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "net"
	breakouttime = 35//easy to apply, easy to break out of
	gender = NEUTER
	var/knockdown = 0

/obj/item/net/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback)
	if(!..())
		return
	playsound(src.loc,'sound/blank.ogg', 75, TRUE)

/obj/item/net/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(..() || !iscarbon(hit_atom))//if it gets caught or the target can't be cuffed,
		return//abort
	ensnare(hit_atom)

/obj/item/net/proc/ensnare(mob/living/carbon/C)
	if(!C.legcuffed && C.get_num_legs(FALSE) >= 2)
		visible_message("<span class='danger'>\The [src] ensnares [C]!</span>")
		C.legcuffed = src
		forceMove(C)
		C.update_inv_legcuffed()
		SSblackbox.record_feedback("tally", "handcuffs", 1, type)
		to_chat(C, "<span class='danger'>\The [src] entraps you!</span>")
		C.Knockdown(knockdown)
		C.apply_status_effect(/datum/status_effect/debuff/netted)
		playsound(src, 'sound/blank.ogg', 50, TRUE)

// Failsafe in case the item somehow ends up being destroyed
/obj/item/net/Destroy()
	if(iscarbon(loc))
		var/mob/living/carbon/M = loc
		if(M.legcuffed == src)
			M.legcuffed = null
			M.update_inv_legcuffed()
			if(M.has_status_effect(/datum/status_effect/debuff/netted))
				M.remove_status_effect(/datum/status_effect/debuff/netted)
	return ..()

/obj/structure/noose
	name = "noose"
	desc = "Abandon all hope."
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	pixel_y = 10
	icon_state = "noose"
	can_buckle = 1
	layer = 4.26
	max_integrity = 10
	buckle_lying = FALSE
	buckle_prevents_pull = TRUE
	max_buckled_mobs = 1
	anchored = TRUE
	density = FALSE
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	static_debris = list(/obj/item/rope = 1)
	breakoutextra = 10 MINUTES
	buckleverb = "tie"

/obj/structure/noose/gallows
	name = "gallows"
	desc = "Stranded and hanging, limp and dead."
	icon_state = "gallows"
	pixel_y = 0
	max_integrity = 9999

/obj/structure/noose/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(has_buckled_mobs())
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			if(buckled_mob.has_gravity())
				buckled_mob.visible_message("<span class='danger'>[buckled_mob] falls over and hits the ground!</span>")
				to_chat(buckled_mob, "<span class='userdanger'>You fall over and hit the ground!</span>")
				buckled_mob.adjustBruteLoss(10)
				buckled_mob.Knockdown(60)
	return ..()

/obj/structure/noose/user_buckle_mob(mob/living/M, mob/user, check_loc)
	if(!in_range(user, src) || user.stat != CONSCIOUS || !iscarbon(M))
		return FALSE

	if (!M.get_bodypart("head"))
		to_chat(user, "<span class='warning'>[M] has no head!</span>")
		return FALSE

	M.visible_message("<span class='danger'>[user] attempts to tie \the [src] over [M]'s neck!</span>")
	if(do_after(user, (user == M ? 0 : 5 SECONDS), M))
		if(buckle_mob(M))
			user.visible_message("<span class='warning'>[user] ties \the [src] over [M]'s neck!</span>")
			if(user == M)
				to_chat(M, "<span class='userdanger'>I tie \the [src] over my neck...</span>")
			else
				to_chat(M, "<span class='userdanger'>[user] ties \the [src] over my neck!</span>")
			playsound(user.loc, 'sound/foley/noosed.ogg', 50, 1, -1)
			return TRUE
	user.visible_message("<span class='warning'>[user] fails to tie \the [src] over [M]'s neck!</span>")
	to_chat(user, "<span class='warning'>I fail to tie \the [src] over [M]'s neck.</span>")
	return FALSE

/obj/structure/noose/post_buckle_mob(mob/living/M)
	if(has_buckled_mobs())
		START_PROCESSING(SSobj, src)
		M.set_mob_offsets("bed_buckle", _x = 0, _y = 10)

/obj/structure/noose/post_unbuckle_mob(mob/living/M)
	STOP_PROCESSING(SSobj, src)
	M.reset_offsets("bed_buckle")

/obj/structure/noose/process()
	if(!has_buckled_mobs())
		STOP_PROCESSING(SSobj, src)
		return
	for(var/m in buckled_mobs)
		var/mob/living/buckled_mob = m
		if(buckled_mob.has_gravity())
			if(buckled_mob.get_bodypart("head"))
				if(buckled_mob.stat != DEAD)
					if(locate(/obj/structure/chair) in get_turf(src)) // So you can kick down the chair and make them hang, and stuff.
						return
					if(!HAS_TRAIT(buckled_mob, TRAIT_NOBREATH))
						buckled_mob.adjustOxyLoss(10)
						if(prob(20))
							buckled_mob.emote("gasp")
					if(prob(25))
						var/flavor_text = list("<span class='danger'>[buckled_mob]'s legs flail for anything to stand on.</span>",\
												"<span class='danger'>[buckled_mob]'s hands are desperately clutching the noose.</span>",\
												"<span class='danger'>[buckled_mob]'s limbs sway back and forth with diminishing strength.</span>")
						buckled_mob.visible_message(pick(flavor_text))
					playsound(buckled_mob.loc, 'sound/foley/noose_idle.ogg', 30, 1, -3)
				else
					if(prob(1))
						var/obj/item/bodypart/head/head = buckled_mob.get_bodypart("head")
						if(head.brute_dam >= 50)
							if(head.dismemberable)
								head.dismember()
			else
				buckled_mob.visible_message("<span class='danger'>[buckled_mob] drops from the noose!</span>")
				buckled_mob.Knockdown(60)
				buckled_mob.pixel_y = initial(buckled_mob.pixel_y)
				buckled_mob.pixel_x = initial(buckled_mob.pixel_x)
				unbuckle_all_mobs(force=1)
