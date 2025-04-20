/mob/living/simple_animal/hostile/retaliate/leylinelycan/Initialize(mapload, obj/structure/portal)
	. = ..()
	source = portal
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/leylinelycan
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "Leyline Lycan"
	desc = "A creature made of leyline energy. It is highly territorial and guards it's home leyline jealously."
	icon_state = "leycreature"
	icon_living = "leycreature"
	icon_dead = "leycreature"

	faction = list("leyline")
	emote_hear = null
	emote_see = null
	turns_per_move = 8
	see_in_dark = 9
	move_to_delay = 1
	vision_range = 9
	aggro_vision_range = 9

	butcher_results = list()

	health = 240
	maxHealth = 240
	food_type = list()

	base_intents = list(/datum/intent/simple/bite)
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	melee_damage_lower = 20
	melee_damage_upper = 30

	base_constitution = 7
	base_strength = 8
	base_speed = 15

	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 35
	defdrain = 5
	retreat_health = 0.4
	food = 0
	dodgetime = 30
	aggressive = 1
	body_eater = FALSE
	var/teleport_cooldown
	var/obj/structure/leyline/source

/mob/living/simple_animal/hostile/retaliate/leylinelycan/MoveToTarget(list/possible_targets)
	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return 0
	if(binded)
		return 0
	if(target in possible_targets)
		var/target_distance = get_dist(targets_from,target)
		if(world.time >= teleport_cooldown)
			leyline_teleport(target)
		if(ranged) //We ranged? Shoot at em
			if(!target.Adjacent(targets_from) && ranged_cooldown <= world.time) //But make sure they're not in range for a melee attack and our range attack is off cooldown
				OpenFire(target)
		if(!Process_Spacemove()) //Drifting
			walk(src,0)
			return 1
		if(retreat_distance != null) //If we have a retreat distance, check if we need to run from our target
			if(target_distance <= retreat_distance) //If target's closer than our retreat distance, run
				walk_away(src,target,retreat_distance,move_to_delay)
			else
				Goto(target,move_to_delay,minimum_distance) //Otherwise, get to our minimum distance so we chase them
		else
			Goto(target,move_to_delay,minimum_distance)
		if(target)
			if(targets_from && isturf(targets_from.loc) && target.Adjacent(targets_from)) //If they're next to us, attack
				MeleeAction()
			else
				if(rapid_melee > 1 && target_distance <= melee_queue_distance)
					MeleeAction(FALSE)
				in_melee = FALSE //If we're just preparing to strike do not enter sidestep mode
			return 1
		return 0
	else
		if(ranged_ignores_vision && ranged_cooldown <= world.time) //we can't see our target... but we can fire at them!
			OpenFire(target)
		Goto(target,move_to_delay,minimum_distance)
		FindHidden()
		return 1

/mob/living/simple_animal/hostile/retaliate/leylinelycan/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//No wounding the lycan.
	return

/mob/living/simple_animal/hostile/retaliate/leylinelycan/death(gibbed)
	..()
	source.guardian = null
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/leyline(deathspot)
	spill_embedded_objects()
	update_icon()
	qdel(src)

/obj/effect/temp_visual/lycan
	icon = 'icons/effects/effects.dmi'
	icon_state = "rift"
	duration = 3

/mob/living/simple_animal/hostile/retaliate/leylinelycan/proc/leyline_teleport(target)
	var/turf/turf_target = get_step(get_step(get_turf(target), src.dir), src.dir)
	if(!(turf_target in view(12, src)))
		return
	if(!isopenturf(turf_target))
		return
	teleport_cooldown = world.time + 70
	var/turf/source = get_turf(src)
	new /obj/effect/temp_visual/lycan(turf_target, src)
	new /obj/effect/temp_visual/lycan(source, src)
	playsound(source,'sound/misc/portalactivate.ogg', 200, 1)
	addtimer(CALLBACK(src, PROC_REF(leyline_teleport_2), turf_target, source), 0.2 SECONDS)

/mob/living/simple_animal/hostile/retaliate/leylinelycan/proc/leyline_teleport_2(turf/T, turf/source)
	animate(src, alpha = 0, time = 2, easing = EASE_OUT) //fade out
	visible_message(span_warning("[src] dives into a leyline rift!"))
	addtimer(CALLBACK(src, PROC_REF(leyline_teleport_3), T), 0.2 SECONDS)

/mob/living/simple_animal/hostile/retaliate/leylinelycan/proc/leyline_teleport_3(turf/T)
	forceMove(T)
	animate(src, alpha = 255, time = 2, easing = EASE_IN) //fade IN
	visible_message(span_warning("[src] tears it's way out of the leyline rift!"))
