/obj/effect/proc_holder/spell/invoked/chilltouch5e
	name = "Chill Touch"
	desc = "A skeletal hand grips your target, the targetted zone changes the effect."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3 SECONDS
	recharge_time = 50 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Be torn apart!"
	invocation_type = "shout"

	attunements = list(
		/datum/attunement/ice = 0.3,
	)


// Notes: sorcerer, warlock, wizard
/obj/effect/proc_holder/spell/invoked/chilltouch5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/bodypart = target.get_bodypart(user.zone_selected)
		if(!bodypart)
			return FALSE
		var/obj/item/chilltouch5e/hand = new(target)
		hand.host = target
		hand.bodypart = bodypart
		hand.forceMove(target)
		bodypart.add_embedded_object(hand, silent = TRUE, crit_message = FALSE)
		target.visible_message(span_warning("A skeletal hand grips [target]'s [bodypart]!"), span_danger("A skeletal hand grips my [bodypart]!"))
		return TRUE
	return FALSE

/obj/item/chilltouch5e
	name = "Skeletal Hand"
	desc = "A ghostly, skeletal hand which moves of it's own accord."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bounty"

	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10

	var/oxy_drain = 2
	var/pleasure = 5 //pleasurable quicker since they bleed inevitably due embed
	var/curprocs = 0
	var/procsmax = 180
	var/mob/living/host //who are we stuck to?
	var/obj/item/bodypart/bodypart //where are we stuck to?

	embedding = list(
		"embedded_unsafe_removal_time" = 50,
		"embedded_pain_chance" = 0,
		"embedded_pain_multiplier" = 0,
		"embed_chance" = 100,
		"embedded_fall_chance" = 0)
	item_flags = DROPDEL
	destroy_sound = 'sound/magic/vlightning.ogg'

/obj/item/chilltouch5e/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/chilltouch5e/process()
	var/hand_proc = pick(1,2,3,4,5)
	var/mult = pick(1,2)
	var/mob/living/target = host
	if(!is_embedded)
		host = null
		return PROCESS_KILL
	if(curprocs >= procsmax)
		host = null
		return PROCESS_KILL
	if(!host)
		qdel(src)
		return FALSE
	curprocs++
	if(hand_proc == 1)
		switch(bodypart.name)
			if(BODY_ZONE_HEAD) //choke
				to_chat(host, "<span class='warning'>[host] is choked by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/shove.ogg'), 100, FALSE, -1)
				host.emote("choke")

				target.adjustOxyLoss(oxy_drain*mult*2)
			if(BODY_ZONE_CHEST) //pleasure if erp, hurt if not
				to_chat(host, "<span class='danger'>[host] is pummeled by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/hits/punch/punch_hard (1).ogg','sound/combat/hits/punch/punch_hard (2).ogg','sound/combat/hits/punch/punch_hard (3).ogg'), 100, FALSE, -1)
				target.adjustBruteLoss(oxy_drain*mult*3)
			else
				to_chat(host, "<span class='danger'>[host]'s [bodypart] is twisted by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/hits/punch/punch (1).ogg','sound/combat/hits/punch/punch (2).ogg','sound/combat/hits/punch/punch (3).ogg'), 100, FALSE, -1)
				target.apply_damage(oxy_drain*mult*3, BRUTE, bodypart)
				if(bodypart.can_be_disabled)
					bodypart.update_disabled()
	return FALSE
