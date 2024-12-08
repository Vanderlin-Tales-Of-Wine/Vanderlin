/obj/effect/proc_holder/spell/invoked/shepherd
	name = "Shepherd"
	range = 7
	overlay_state = "psy"
	releasedrain = 50
	chargedrain = 0
	chargetime = 0
	charge_max = 10 SECONDS
	sound = 'sound/magic/swap.ogg'
	associated_skill = /datum/skill/magic/holy
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokeholy
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/shepherd/cast(list/targets, mob/living/user)
	..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/turf/T = get_turf(target)
		var/turf/H = get_turf(user)
		if(T && H)
			playsound(T, 'sound/magic/swap.ogg', 100)
			user.forceMove(T)
			target.forceMove(H)
			return TRUE
	return FALSE
