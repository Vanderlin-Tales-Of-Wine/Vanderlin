// Necrite
/obj/effect/proc_holder/spell/targeted/burialrite
	name = "Burial Rites"
	range = 5
	overlay_state = "consecrateburial"
	releasedrain = 30
	charge_max = 300
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Undermaiden grant thee passage forth and spare the trials of the forgotten."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 15

/obj/effect/proc_holder/spell/targeted/burialrite/cast(list/targets,mob/user = usr)
	if(user.is_holding_item_of_type(/obj/item/rogueweapon/knife/dagger/steel/profane)) // If you are holding an assassin's cursed dagger, break it and free the souls contained within, sending them into the lukewarm arms of Necra.
		var/obj/item/rogueweapon/knife/dagger/steel/profane/held_profane = user.is_holding_item_of_type(/obj/item/rogueweapon/knife/dagger/steel/profane)
		var/saved_souls = held_profane.release_profane_souls(user) // Releases the trapped souls and breaks the dagger. Gets the number of souls saved by destroying the dagger.
		user.adjust_triumphs(saved_souls) // Every soul saved earns you a big fat triumph.
	for(var/obj/structure/closet/dirthole/H in view(1))
		if(H.stage != 4)
			continue
		if(!H.contents)
			continue
		for(var/mob/living/carbon/human/A in H.contents)
			A.funeral = TRUE
			if(A.mind && A.mind.has_antag_datum(/datum/antagonist/zombie))
				A.mind.remove_antag_datum(/datum/antagonist/zombie)
			user.visible_message("My funeral rites have been performed!", "[user] consecrates the grave!")
		for(var/obj/structure/closet/crate/coffin/C)
			for(var/mob/living/carbon/human/B in C.contents)
				B.funeral = TRUE
	return ..()

/obj/effect/proc_holder/spell/targeted/churn
	name = "Churn Undead"
	range = 5
	overlay_state = "necra"
	releasedrain = 30
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psycross)
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Undermaiden rebukes!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 60

/obj/effect/proc_holder/spell/targeted/churn/cast(list/targets,mob/living/user = usr)
	var/prob2explode = 100
	if(user && user.mind)
		prob2explode = 0
		for(var/i in 1 to user.mind.get_skill_level(/datum/skill/magic/holy))
			prob2explode += 80
	for(var/mob/living/L in targets)
		var/isvampire = FALSE
		var/iszombie = FALSE
		if(L.stat == DEAD)
			continue
		if(L.mind)
			var/datum/antagonist/vampirelord/lesser/V = L.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			if(V)
				if(!V.disguised)
					isvampire = TRUE
			if(L.mind.has_antag_datum(/datum/antagonist/zombie))
				iszombie = TRUE
			if(L.mind.special_role == "Vampire Lord")
				user.visible_message("<span class='warning'>[L] overpowers being churned!</span>", "<span class='userdanger'>[L] is too strong, I am churned!</span>")
				user.Stun(50)
				user.throw_at(get_ranged_target_turf(user, get_dir(user,L), 7), 7, 1, L, spin = FALSE)
				return
		if((L.mob_biotypes & MOB_UNDEAD) || isvampire || iszombie)
			L.visible_message("<span class='warning'>[L] is being churned by Necra's grip...</span>", "<span class='danger'>I'm being churned by Necra's grip...</span>")
			var/undead_prob = prob2explode
			if(isvampire)
				undead_prob -= 20
			if(prob(undead_prob))
				L.visible_message("<span class='warning'>[L] HAS BEEN CHURNED BY NECRA'S GRIP!</span>", "<span class='danger'>I'VE BEEN CHURNED BY NECRA'S GRIP!</span>")
				explosion(get_turf(L), light_impact_range = 1, flame_range = 1, smoke = FALSE)
				L.Stun(50)
			else
				L.visible_message("<span class='warning'>[L] resists being churned!</span>", "<span class='userdanger'>I resist being churned!</span>")
	return ..()
