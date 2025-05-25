/atom/proc/fading_leap_up()
	var/matrix/M = matrix()
	var/loop_count = 15
	while(loop_count > 0)
		loop_count--
		animate(src, transform = M, pixel_z = src.pixel_z + 12, alpha = src.alpha - 17, time = 1, loop = 1, easing = LINEAR_EASING)
		M.Scale(1.2,1.2)
		sleep(0.1 SECONDS)
	alpha = 0
	return TRUE

//inverse of above
/atom/proc/fading_leap_down()
	var/matrix/M = matrix()
	var/loop_count = 12
	M.Scale(15,15)
	while(loop_count > 0)
		loop_count--
		animate(src, transform = M, pixel_z = src.pixel_z - 12, alpha = src.alpha + 17, time = 1, loop = 1, easing = LINEAR_EASING)
		M.Scale(0.8,0.8)
		sleep(0.1 SECONDS)
	animate(src, transform = M, pixel_z = 0, alpha = 255, time = 1, loop = 1, easing = LINEAR_EASING)
	M.Scale(1,1)

/obj/effect/flyer_shadow
	name = ""
	desc = "A shadow cast from something flying above."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shadow"
	anchored = TRUE
	layer = BELOW_MOB_LAYER
	alpha = 180
	var/mob/living/flying_mob
	var/obj/effect/proc_holder/spell/self/flight/flight_spell

/obj/effect/flyer_shadow/Initialize()
	. = ..()
	transform = matrix() * 0.75 // Make the shadow slightly smaller
	add_filter("shadow_blur", 1, list("type" = "blur", "size" = 1))


/obj/effect/flyer_shadow/attackby(obj/item/W, mob/user, params)
	if(is_pointy_weapon(W) && flying_mob && flight_spell)
		user.visible_message(span_warning("[user] prepares to thrust [W] upward at [flying_mob]!"),
						   span_warning("You prepare to thrust [W] upward at [flying_mob]!"))

		if(do_after(user, 1 SECONDS, target = src))
			var/obj/item/I = user.get_active_held_item()
			if(!I || !is_pointy_weapon(I) || !flying_mob || !flight_spell)
				return

			var/attack_damage = I.force
			user.visible_message(span_warning("[user] thrusts [I] upward, striking [flying_mob]!"),
							   span_warning("You thrust [I] upward, striking [flying_mob]!"))

			flying_mob.apply_damage(attack_damage, BRUTE)

			if(flight_spell.flying && prob(attack_damage * 1.5))
				to_chat(flying_mob, span_userdanger("The attack knocks you out of the air!"))
				flight_spell.stop_flying(flying_mob)
				flying_mob.Knockdown(3 SECONDS)

			return TRUE
	return ..()

/proc/is_pointy_weapon(obj/item/I)
	if(!istype(I))
		return FALSE
	return(I.reach >= 2) && (I.sharpness == IS_SHARP || I.w_class >= WEIGHT_CLASS_NORMAL)

/obj/effect/flyer_shadow/Destroy()
	flying_mob = null
	flight_spell = null
	return ..()

/obj/effect/proc_holder/spell/self/flight
	name = "Take Flight"
	desc = ""
	overlay_state = "flight"
	antimagic_allowed = TRUE
	invocation_type = "none"
	var/flying = FALSE
	var/obj/effect/flyer_shadow/shadow

/obj/effect/proc_holder/spell/self/flight/cast(list/targets, mob/living/user = usr)
	..()
	flying = !flying
	switch(flying)
		if(TRUE)
			name = "Descend"
			start_flying(user)
		else
			if(user.get_encumbrance() > 0.7)
				to_chat(user, span_warning("I am too heavy to take off."))
				return TRUE
			name = "Take Flight"
			if(!do_after(user, 5 SECONDS, user))
				flying = !flying
				name = "Descend"
				return TRUE
			stop_flying(user)
	return TRUE

/obj/effect/proc_holder/spell/self/flight/proc/stop_flying(mob/living/user)
	var/turf/turf = get_turf(user)
	if(isopenspace(turf))
		turf = GET_TURF_BELOW(turf)
	if(turf != get_turf(user))
		user.alpha = 0
		user.forceMove(turf)
		user.pixel_z = 156
		user.fading_leap_down()
		user.pixel_z = 0
	user.movement_type &= ~FLYING
	UnregisterSignal(user, list(COMSIG_ATOM_WAS_ATTACKED, COMSIG_MOVABLE_MOVED, COMSIG_LIVING_STATUS_STUN, COMSIG_LIVING_STATUS_UNCONSCIOUS, COMSIG_LIVING_STATUS_UNCONSCIOUS, COMSIG_LIVING_STATUS_PARALYZE, COMSIG_LIVING_STATUS_IMMOBILIZE, COMSIG_LIVING_STATUS_SLEEP))

	if(shadow)
		QDEL_NULL(shadow)

/obj/effect/proc_holder/spell/self/flight/proc/start_flying(mob/living/user)
	if(!do_after(user, 5 SECONDS, user))
		flying = !flying
		name = "Take Flight"
		return
	var/turf/turf = get_turf(user)
	if(isopenspace(GET_TURF_ABOVE(turf)))
		turf = GET_TURF_ABOVE(turf)
	user.movement_type |= FLYING
	if(turf != get_turf(user))
		user.fading_leap_up()
		user.pixel_z = 0
		user.pixel_w = 0
		user.transform = null
		user.alpha = 255
		user.forceMove(turf)

		var/turf/below_turf = GET_TURF_BELOW(turf)
		shadow = new /obj/effect/flyer_shadow(below_turf)
		shadow.flying_mob = user
		shadow.flight_spell = src
		RegisterSignal(user, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_shadow))

	RegisterSignal(user, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(check_damage))
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(check_movement))

	RegisterSignal(user, COMSIG_LIVING_STATUS_IMMOBILIZE, PROC_REF(stop_flying))
	RegisterSignal(user, COMSIG_LIVING_STATUS_UNCONSCIOUS, PROC_REF(stop_flying))
	RegisterSignal(user, COMSIG_LIVING_STATUS_KNOCKDOWN, PROC_REF(stop_flying))
	RegisterSignal(user, COMSIG_LIVING_STATUS_PARALYZE, PROC_REF(stop_flying))
	RegisterSignal(user, COMSIG_LIVING_STATUS_STUN, PROC_REF(stop_flying))
	RegisterSignal(user, COMSIG_LIVING_STATUS_SLEEP, PROC_REF(stop_flying))

/obj/effect/proc_holder/spell/self/flight/proc/check_damage(mob/living/user, mob/attacker, damage)
	if(prob(damage))
		to_chat(user, span_warning("The hit knocks you out of the air!"))
		stop_flying(user)
		user.Knockdown(2 SECONDS)

/obj/effect/proc_holder/spell/self/flight/proc/check_movement(mob/living/user)
	if(user.movement_type & FLYING)
		if(user.get_encumbrance() > 0.7)
			to_chat(user, span_warning("I am too heavy to fly."))
			stop_flying(user)
			return

		if(!user.adjust_stamina(-3))
			to_chat(user, span_warning("You're too exhausted to keep flying!"))
			stop_flying(user)

		if(shadow)
			if(!istransparentturf(get_turf(user)))
				shadow.alpha= 0
			else
				shadow.alpha = 255

			var/turf/below_turf = GET_TURF_BELOW(get_turf(user))
			if(below_turf)
				shadow.forceMove(below_turf)
		else
			var/turf/below_turf = GET_TURF_BELOW(get_turf(user))
			if(below_turf && istransparentturf(get_turf(user)))
				shadow = new /obj/effect/flyer_shadow(below_turf)
				shadow.flying_mob = user
				shadow.flight_spell = src
				RegisterSignal(user, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_shadow))

/obj/effect/proc_holder/spell/self/flight/proc/cleanup_shadow(mob/living/user)
	SIGNAL_HANDLER

	if(shadow)
		QDEL_NULL(shadow)

/obj/item/organ/wings
	name = "wings"
	desc = "A pair of wings. Those may or may not allow you to fly... or at the very least flap."
	visible_organ = TRUE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS
	///What species get flights thanks to those wings. Important for moth wings
	var/list/flight_for_species
	///Whether a wing can be opened by the *wing emote. The sprite use a "_open" suffix, before their layer
	var/can_open
	///Whether an openable wing is currently opened
	var/is_open
	///Whether the owner of wings has flight thanks to the wings
	var/granted_flight

/obj/item/organ/wings/flight
	var/obj/effect/proc_holder/spell/self/flight/flight

/obj/item/organ/wings/flight/on_life()
	. = ..()
	if(!granted_flight && owner)
		if(!owner?.mind?.has_spell(flight.type))
			owner.AddElement(/datum/element/relay_attackers)
			owner.mind.AddSpell(flight)
			granted_flight = TRUE

/obj/item/organ/wings/flight/Insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	if(!flight)
		flight = new
	M.mind?.AddSpell(flight)

/obj/item/organ/wings/flight/Remove(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	if(flight)
		M.mind?.RemoveSpell(flight)
	granted_flight = FALSE

/datum/customizer/organ/wings
	name = "Wings"
	abstract_type = /datum/customizer/organ/wings

/datum/customizer_choice/organ/wings
	name = "Wings"
	organ_type = /obj/item/organ/wings
	organ_slot = ORGAN_SLOT_WINGS
	abstract_type = /datum/customizer_choice/organ/wings

/obj/item/organ/wings/anthro
	name = "wild-kin wings"

/datum/customizer/organ/wings/harpy
	customizer_choices = list(/datum/customizer_choice/organ/wings/harpy)
	allows_disabling = FALSE

/datum/customizer_choice/organ/wings/harpy
	name = "Wings"
	organ_type = /obj/item/organ/wings/flight
	allows_accessory_color_customization = FALSE
	sprite_accessories = list(
		/datum/sprite_accessory/wings/large/harpyswept,
		)
