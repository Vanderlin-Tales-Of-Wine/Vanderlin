////// Roguetown version of the kitchen spike
#define VIABLE_MOB_CHECK(X) (isliving(X))
/obj/structure/meathook
	name = "meathook"
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "meathook"
	desc = "A hook used to secure livestock for butchering."
	density = TRUE
	anchored = TRUE
	max_integrity = 250
	buckle_lying = 0
	can_buckle = 1

	var/draining_blood = FALSE

/obj/structure/meathook/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(istype(I, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/container = I
		if(!container.is_open_container())
			return
		container.forceMove(get_turf(src))
		to_chat(user, span_notice("You place [I] under [src]"))

/obj/structure/meathook/examine(mob/user)
	. = ..()
	if(has_buckled_mobs())
		var/mob/living/L = buckled_mobs[1]
		if(L.stat == DEAD)
			if(L.blood_drained >= 60)
				if(L.skinned)
					. += span_warning("[L] has been fully drained of blood and skinned. I can butcher it with a cleaver.")
				else
					. += span_warning("[L] has had its blood fully drained. I can skin it with a knife.")
			else
				if(draining_blood && L.blood_drained > 0)
					. += span_warning("[L] is having its blood drained. If I try to skin or butcher it now, I may lose some parts.")
				else
					. += span_warning("There is a corpse ready to be worked on. I might need a knife for this.")

/obj/structure/meathook/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/meathook/attack_hand(mob/user)
	if(VIABLE_MOB_CHECK(user.pulling) && !has_buckled_mobs())
		var/mob/living/L = user.pulling
		L.visible_message(span_danger("[user] starts hanging [L] on [src]!"), span_danger("[user] starts hanging you on [src]]!"), span_hear("I hear the sound of clanging chains..."))
		if(do_after(user, 12 SECONDS, src))
			if(has_buckled_mobs())
				return
			if(L.buckled)
				return
			if(user.pulling != L)
				return
			playsound(src.loc, 'sound/foley/butcher.ogg', 25, TRUE)
			L.visible_message(span_danger("[user] hangs [L] on [src]!"), span_danger("[user] hangs you on [src]]!"))
			L.forceMove(drop_location())
			L.emote("scream")
			L.add_splatter_floor()
			L.adjustBruteLoss(30)
			L.setDir(2)
			buckle_mob(L, force=1)
			var/matrix/m90 = matrix(L.transform)
			m90.Turn(90)
			m90.Translate(12,12)
			animate(L, transform = m90, time = 3)
			L.pixel_y = L.get_standard_pixel_x_offset(180)
	else if (has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			user_unbuckle_mob(L, user)
	else
		..()

/obj/structure/meathook/user_buckle_mob(mob/living/M, mob/user, check_loc)
	return

/obj/structure/meathook/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(buckled_mob)
		var/mob/living/M = buckled_mob
		if (M != user)
			M.visible_message(span_notice("[user] is trying to pull [M] free of [src]!"),\
				span_notice("[user] is trying to pull me off [src]! It hurts!"),\
				span_hear("I hear the sound of torn flesh and whimpering..."))
			if(!do_after(user, 30 SECONDS, src))
				if(M && M.buckled)
					M.visible_message(span_notice("[user] fails to free [M]!"),\
					span_notice("[user] fails to pull me off of [src]!"))
				return
		else
			M.visible_message(span_warning("[M] struggles to break free from [src]!"),\
				span_notice("I struggle to break free from [src], tearing my legs! (Stay still for two minutes.)"),\
				span_hear("I hear the sound of torn flesh and whimpering..."))
			M.adjustBruteLoss(30)
			if(!do_after(M, 2 MINUTES, src))
				if(M && M.buckled)
					to_chat(M, span_warning("I fail to free myself!"))
				return
			if(!M.buckled)
				return
		release_mob(M)

/obj/structure/meathook/process()
	if(!length(buckled_mobs) || !draining_blood)
		STOP_PROCESSING(SSmachines, src)
		return
	var/mob/living/L = buckled_mobs[1]
	if(L.blood_drained > 60)
		L.blood_drained = 60
		draining_blood = FALSE
		STOP_PROCESSING(SSmachines, src)
		return
	L.blood_drained++

	var/obj/item/reagent_containers/container = locate(/obj/item/reagent_containers) in get_turf(src)
	playsound(get_turf(src), 'sound/misc/bleed (3).ogg', 100, FALSE)
	if(container && container.is_open_container() && container.reagents.total_volume < container.reagents.maximum_volume)
		container.reagents.add_reagent(/datum/reagent/blood, 5)
	else
		var/obj/effect/decal/cleanable/blood/puddle/P = locate() in get_turf(src)
		if(P)
			P.blood_vol += 5
			P.update_icon()
		else
			var/obj/effect/decal/cleanable/blood/drip/D = locate() in get_turf(src)
			if(D)
				D.blood_vol += 5
				D.drips++
				D.update_icon()
			else
				new /obj/effect/decal/cleanable/blood/drip(get_turf(src))

/obj/structure/meathook/proc/release_mob(mob/living/M)
	var/matrix/m270 = matrix(M.transform)
	m270.Turn(270)
	m270.Translate(-12,-12)
	animate(M, transform = m270, time = 3)
	M.pixel_y = M.get_standard_pixel_y_offset(180)
	M.adjustBruteLoss(30)
	src.visible_message(span_danger("[M] falls free of [src]!"))
	unbuckle_mob(M,force=1)
	M.emote("scream")
	M.AdjustParalyzed(20)
	draining_blood = FALSE

/obj/structure/meathook/Destroy()
	if(has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			release_mob(L)
	return ..()

/obj/structure/meathook/deconstruct()
	new /obj/item/grown/log/tree/small(loc, 1)
	new /obj/item/rope(loc, 1)
	qdel(src)

/obj/structure/meathook/proc/butchery(mob/living/user, mob/living/simple_animal/butchery_target)
	var/list/butcher = list()
	if(butchery_target.butcher_results)
		if(user.mind.get_skill_level(/datum/skill/labor/butchering) <= 1)
			if(prob(50))
				butcher = butchery_target.botched_butcher_results // chance to get shit result
			else
				butcher =butchery_target.butcher_results
		if(user.mind.get_skill_level(/datum/skill/labor/butchering) == 3)
			if(prob(10))
				butcher = butchery_target.perfect_butcher_results // small chance to get great result
			else
				butcher = butchery_target.butcher_results
		if(user.mind.get_skill_level(/datum/skill/labor/butchering) == 4)
			if(prob(50))
				butcher = butchery_target.perfect_butcher_results // decent chance to get great result
			else
				butcher = butchery_target.butcher_results
		else
			if(user.mind.get_skill_level(/datum/skill/labor/butchering) == 5)
				butcher = butchery_target.perfect_butcher_results
			else
				butcher = butchery_target.butcher_results

	if(!draining_blood && butchery_target.blood_drained < 60)
		if(!(user.used_intent.type == /datum/intent/dagger/cut || user.used_intent.type == /datum/intent/sword/cut || user.used_intent.type == /datum/intent/axe/cut))
			return
		var/cut_time = 4 SECONDS - (0.5 SECONDS * user.mind?.get_skill_level(/datum/skill/labor/butchering))
		to_chat(user, span_notice("I prepare to drain [butchery_target]'s blood by cutting the skin..."))
		if(do_after(user, cut_time, src, (IGNORE_HELD_ITEM)))
			butchery_target.blood_drained++
			START_PROCESSING(SSmachines, src)
			draining_blood = TRUE
		return

	if(!butchery_target.skinned && (user.used_intent.type == /datum/intent/dagger/cut || user.used_intent.type == /datum/intent/sword/cut || user.used_intent.type == /datum/intent/axe/cut))
		var/cut_time = 6 SECONDS - (0.5 SECONDS * user.mind?.get_skill_level(/datum/skill/labor/butchering))
		to_chat(user, span_notice("I start to skin [butchery_target]."))
		if(do_after(user, cut_time, src, (IGNORE_HELD_ITEM)))
			var/first_fail = TRUE
			for(var/listed_item in butcher)
				if(ispath(listed_item, /obj/item/natural/hide) || ispath(listed_item, /obj/item/natural/fur))
					if(prob(40 + (user.mind?.get_skill_level(/datum/skill/labor/butchering) * 10) - (60 - butchery_target.blood_drained)))
						butcher[listed_item] += round(butcher[listed_item] * 0.5)
					if(prob(10 + (user.mind?.get_skill_level(/datum/skill/labor/butchering) * 5)) - (60 - butchery_target.blood_drained))
						butcher[listed_item] += round(butcher[listed_item] * 0.5)
					if(prob((60 - butchery_target.blood_drained)))
						if(first_fail)
							to_chat(user, span_notice("The flowing blood got in the way and messed up some of the skin."))
							first_fail = FALSE
						butcher[listed_item] -= round(butcher[listed_item] * 0.5)
					for(var/i in 1 to butcher[listed_item])
						var/obj/item/I = new listed_item(get_turf(user))
						I.add_mob_blood(butchery_target)
					butcher -= listed_item
			var/boon = user.mind.get_learning_boon(/datum/skill/labor/butchering)
			var/amt2raise = user.STAINT
			user.mind.add_sleep_experience(/datum/skill/labor/butchering, amt2raise * boon, FALSE)
			butchery_target.skinned = TRUE
		return

	if(!butchery_target.skinned)
		return

	if(user.used_intent.type == /datum/intent/dagger/chop/cleaver)
		var/cut_time = 6 SECONDS - (0.5 SECONDS * user.mind?.get_skill_level(/datum/skill/labor/butchering))
		to_chat(user, span_notice("I start to butcher [butchery_target]."))
		if(do_after(user, cut_time, src, (IGNORE_HELD_ITEM)))
			var/first_fail = TRUE
			for(var/listed_item in butcher)
				if(ispath(listed_item, /obj/item/reagent_containers/food/snacks/rogue/meat) || ispath(listed_item, /obj/item/reagent_containers/food/snacks/fat))
					if(prob(40 + (user.mind?.get_skill_level(/datum/skill/labor/butchering) * 10) - (60 - butchery_target.blood_drained)))
						butcher[listed_item] += round(butcher[listed_item] * 0.5)
					if(prob(10 + (user.mind?.get_skill_level(/datum/skill/labor/butchering) * 5)) - (60 - butchery_target.blood_drained))
						butcher[listed_item] += round(butcher[listed_item] * 0.5)
					if(prob((60 - butchery_target.blood_drained)))
						if(first_fail)
							to_chat(user, span_notice("The flowing blood got in the way and messed up some of the meat."))
							first_fail = FALSE
						butcher[listed_item] -= round(butcher[listed_item] * 0.5)
					for(var/i in 1 to butcher[listed_item])
						var/obj/item/I = new listed_item(get_turf(user))
						I.add_mob_blood(butchery_target)
						var/rotstuff = FALSE
						var/datum/component/rot/simple/CR = butchery_target.GetComponent(/datum/component/rot/simple)
						if(CR)
							if(CR.amount >= 10 MINUTES)
								rotstuff = TRUE
						if(rotstuff)
							var/obj/item/reagent_containers/food/snacks/F = I
							F.become_rotten()
					butcher -= listed_item
			for(var/listed_item in butcher)
				for(var/i in 1 to butcher[listed_item])
					var/obj/item/I = new listed_item(get_turf(user))
					I.add_mob_blood(butchery_target)
			butchery_target.gib()
			draining_blood = FALSE
			var/boon = user.mind.get_learning_boon(/datum/skill/labor/butchering)
			var/amt2raise = user.STAINT
			user.mind.add_sleep_experience(/datum/skill/labor/butchering, amt2raise * boon, FALSE)

#undef VIABLE_MOB_CHECK
