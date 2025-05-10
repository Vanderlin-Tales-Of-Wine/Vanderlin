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

/obj/effect/proc_holder/spell/self/flight
	name = "Take Flight"
	desc = ""
	overlay_state = "orison"
	antimagic_allowed = TRUE
	invocation_type = "none"
	var/flying = FALSE

/obj/effect/proc_holder/spell/self/flight/cast(list/targets, mob/user = usr)
	..()
	flying = !flying
	switch(flying)
		if(TRUE)
			name = "Descend"
			start_flying(user)
		else
			name = "Take Flight"
			stop_flying(user)
	return TRUE

/obj/effect/proc_holder/spell/self/flight/proc/stop_flying(mob/living/user)

	if(!do_after(user, 5 SECONDS, user))
		flying = !flying
		name = "Descend"
		return

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
	sprite_accessories = list(
		/datum/sprite_accessory/wings/large/harpyswept,
		)
