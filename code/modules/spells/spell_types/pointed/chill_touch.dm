// TODO make this a projectile jesus
/datum/action/cooldown/spell/chill_touch
	name = "Chill Touch"
	desc = "A skeletal hand grips your target, the targetted zone changes the effect."
	sound = 'sound/magic/whiteflame.ogg'

	point_cost = 2
	attunements = list(
		/datum/attunement/ice = 0.3,
		/datum/attunement/death = 0.2,
	)

	invocation = "Be torn apart!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 4 SECONDS
	charge_drain = 0
	charge_slowdown = 1
	cooldown_time = 60 SECONDS
	spell_cost = 50

/datum/action/cooldown/spell/chill_touch/is_valid_target(atom/cast_on)
	return iscarbon(cast_on)

/datum/action/cooldown/spell/chill_touch/cast(mob/living/carbon/cast_on)
	. = ..()
	var/obj/item/bodypart/bodypart = cast_on.get_bodypart(owner.zone_selected)
	if(bodypart)
		return
	var/obj/item/chilltouch/hand = new
	hand.attach_target(cast_on, bodypart)
	cast_on.visible_message(
		span_warning("A skeletal hand grips [cast_on]'s [bodypart]!"),
		span_danger("A skeletal hand grips my [bodypart]!"),
	)

/obj/item/chilltouch
	name = "Skeletal Hand"
	desc = "A ghostly, skeletal hand which moves of it's own accord."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bounty"

	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10

	var/oxy_drain = 2
	var/curprocs = 0
	var/procsmax = 180
	var/mob/living/carbon/host //who are we stuck to?
	var/obj/item/bodypart/bodypart //where are we stuck to?

	embedding = list(
		"embedded_unsafe_removal_time" = 50,
		"embedded_pain_chance" = 0,
		"embedded_pain_multiplier" = 0,
		"embed_chance" = 100,
		"embedded_fall_chance" = 0,
	)
	item_flags = DROPDEL
	destroy_sound = 'sound/magic/vlightning.ogg'

/obj/item/chilltouch/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/chilltouch/Destroy()
	STOP_PROCESSING(SSobj, src)
	host = null
	bodypart = null
	return ..()

/obj/item/chilltouch/proc/attach_target(mob/living/carbon/target, /obj/item/bodypart/limb)
	if(!istype(target))
		qdel(src)
		return
	if(istype(bodypart))
		qdel(src)
		return
	host = target
	bodypart = limb
	bodypart.add_embedded_object(src, silent = TRUE, crit_message = FALSE)

// This is awful
/obj/item/chilltouch/process()
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
			if(BODY_ZONE_CHEST)
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
