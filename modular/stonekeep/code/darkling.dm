/datum/component/darkling
	var/current_light_stress = 0															///Currently accumulated light stress for this darkling component
	var/last_light_stress = 0																///Value of last light stress tick, used for determining blinding effects
	var/max_light_stress = 100																///Maximum allowed light stress that the darkling can accumulate
	var/next_blind																			///World time when the darkling is able to be blinded again by bright lights

/datum/component/darkling/Initialize(...)
	. = ..()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	ADD_TRAIT(parent, TRAIT_DARKLING, TRAIT_GENERIC)										//Makes us sleepy during the day, since we're creatures of the dark
	RegisterSignal(parent, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(update_light_stress))		//Light stress accumulation
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(check_light_on_move))				//So that we get more immediate blinding, but don't make walking stress us faster
	next_blind = world.time + 45 SECONDS 													//Giving fresh darklings enough time to get to cover or at least put their hood up before getting blinded
	if(ishuman(parent))
		var/mob/living/carbon/human/character = parent
		var/obj/item/clothing/head/roguehood/random/hood = new /obj/item/clothing/head/roguehood/random(get_turf(character))
		character.put_in_hands(hood, forced = TRUE)
		character.equip_to_slot_if_possible(hood, SLOT_WEAR_MASK, FALSE, TRUE, FALSE, TRUE, TRUE)

//Proc used for updating light stress, occurs every health update so around once every 2 seconds
/datum/component/darkling/proc/update_light_stress()
	var/mob/living/carbon/darkling
	//Closing our eyes or being blind/blindfolded lets us recovery very quickly
	if(darkling.eyesclosed || darkling.eye_blind)
		src.current_light_stress -= 1.5
		if(darkling.IsSleeping())
			src.current_light_stress -= 5 	//Sleeping restores us much quicker
		return
	var/incoming_light_stress = get_light_stress_value(darkling)
	src.current_light_stress = clamp(current_light_stress + incoming_light_stress, 0, max_light_stress)
	if(incoming_light_stress > 0.2 && incoming_light_stress - last_light_stress > 0.5) 	//Checks if we've just barreled into the light
		try_blind_darkling(darkling)
	src.last_light_stress = incoming_light_stress
	apply_stress_effects(darkling)


//Triggers on movement. This is mostly so that getting blinded by lights is more responsive, instead of having to linger beside them
/datum/component/darkling/proc/check_light_on_move()
	var/mob/living/carbon/darkling
	var/light_stress = get_light_stress_value(darkling)
	if(light_stress > 0.2 && light_stress - last_light_stress > 0.5) //Checks if we've just barreled into the light
		try_blind_darkling(darkling)

//Used to blind us when exposed to strong lights. Has a cooldown between blindings.
/datum/component/darkling/proc/try_blind_darkling()
	var/mob/living/carbon/darkling
	//So that we aren't spamming people too much
	if(next_blind > world.time || get_face_covered(darkling))
		return
	//Gives us a nasty bump in light stress
	current_light_stress = clamp(current_light_stress + 5, 0, max_light_stress)
	darkling.blur_eyes(15)
	next_blind = world.time + (rand(30 SECONDS, 60 SECONDS) * (darkling.STACON/10)) //Con determines how frequently you can get blinded
	to_chat(parent, span_danger("My eyes water at the sudden exposure to bright light! Maybe I should "))

//Applies the effects of our current light stress accumulation threshold
/datum/component/darkling/proc/apply_stress_effects()
	var/mob/living/carbon/darkling
	//Small buff when in the dark and fully rested
	if(src.current_light_stress == 0)
		var/turf/T = get_turf(parent)
		var/light_amount = T.get_lumcount()
		if(light_amount <= 0.1)
			darkling.apply_status_effect(/datum/status_effect/buff/darkling_darkly)
	//Eye strain debuff
	if(src.current_light_stress > 30)
		darkling.add_stress(/datum/stressevent/darkling_toobright)
		darkling.apply_status_effect(/datum/status_effect/debuff/darkling_glare)
	//Migraines
	if(src.current_light_stress > 75)
		darkling.overlay_fullscreen("painflash", /atom/movable/screen/fullscreen/painflash)
		darkling.overlay_fullscreen("brute", /atom/movable/screen/fullscreen/brute, 1)
		darkling.add_stress(/datum/stressevent/darkling_migraine)
		darkling.apply_status_effect(/datum/status_effect/debuff/darkling_migraine)

//Calculates incoming light stress based on turf lumcount and character stats
/datum/component/darkling/proc/get_light_stress_value()
	var/mob/living/carbon/darkling
	var/turf/T = get_turf(parent)
	var/light_amount = T.get_lumcount()
	var/resistance_multiplier = 1
	resistance_multiplier += get_face_covered(darkling)
	resistance_multiplier += darkling.get_eye_protection()
	var/light_resistance = (0.6 * (darkling.STAEND/10)) * resistance_multiplier
	var/light_multiplier = 1
	if(GLOB.tod == "day" && isturf(darkling.loc))
		var/turf/loc = darkling.loc
		if(light_amount > 0.5 && loc.can_see_sky())
			light_multiplier += 0.5
	var/incoming_light_stress = (light_amount * light_multiplier - light_resistance)
	return incoming_light_stress


/datum/component/darkling/proc/get_face_covered()
	var/mob/living/carbon/darkling
	if((darkling.wear_mask && (darkling.wear_mask.flags_inv & HIDEFACE)) || (darkling.head && (darkling.head.flags_inv & HIDEFACE)))
		return 1

/datum/component/darkling/Destroy()
	REMOVE_TRAIT(parent, TRAIT_DARKLING, TRAIT_GENERIC)
	UnregisterSignal(parent, COMSIG_LIVING_HEALTH_UPDATE)
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	. = ..()
