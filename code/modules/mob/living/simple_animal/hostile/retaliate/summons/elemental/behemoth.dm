
/mob/living/simple_animal/hostile/retaliate/elemental/behemoth
	icon = 'icons/mob/summonable/32x64.dmi'
	name = "earthen behemoth"
	summon_primer = "You are an behemoth, a large elemental. Elementals such as yourself often lead groups of wardens in defending your plane. Now you've been pulled from your home into a new world, that is decidedly less peaceful then your carefully guarded plane. How you react to these events, only time can tell."
	icon_state = "behemoth"
	icon_living = "behemoth"
	tier = 3
	icon_dead = "vvd"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 15
	base_intents = list(/datum/intent/simple/elementalt2_unarmed)
	butcher_results = list()
	faction = list("elemental")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 800
	maxHealth = 800
	melee_damage_lower = 55
	melee_damage_upper = 80
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = 'sound/combat/hits/onstone/wallhit.ogg'
	dodgetime = 30
	aggressive = 1

	base_constitution = 17
	base_endurance = 17
	base_strength = 13
	base_speed = 5

	var/rock_cd

/mob/living/simple_animal/hostile/retaliate/elemental/behemoth/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/elemental/behemoth/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/elementalfragment(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	update_icon()
	spill_embedded_objects()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/elemental/behemoth/AttackingTarget()
	if(SEND_SIGNAL(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, target) & COMPONENT_HOSTILE_NO_PREATTACK)
		return FALSE //but more importantly return before attack_animal called
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, target)
	in_melee = TRUE
	if(!target)
		return
	addtimer(CALLBACK(src,PROC_REF(yeet),target), 1 SECONDS)
	if(!QDELETED(target))
		return target.attack_animal(src)

/obj/effect/temp_visual/marker
	icon = 'icons/effects/effects.dmi'
	icon_state = "trap"
	light_outer_range = 2
	duration = 1.5 SECONDS
	layer = ABOVE_ALL_MOB_LAYER //this doesnt render above mobs? it really should


/mob/living/simple_animal/hostile/retaliate/elemental/behemoth/MoveToTarget(list/possible_targets)//Step 5, handle movement between us and our target
	stop_automated_movement = 1
	if(!target || !CanAttack(target))
		LoseTarget()
		return 0
	if(binded)
		return 0
	if(target in possible_targets)
		var/target_distance = get_dist(targets_from,target)
		if(ranged) //We ranged? Shoot at em
			if(!target.Adjacent(targets_from) && ranged_cooldown <= world.time) //But make sure they're not in range for a melee attack and our range attack is off cooldown
				OpenFire(target)
		if(!Process_Spacemove()) //Drifting
			walk(src,0)
			return 1
		if(world.time >= src.rock_cd + 200)
			quake()
			src.rock_cd = world.time
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

/mob/living/simple_animal/hostile/retaliate/elemental/behemoth/proc/quake()
	var/turf/focalpoint = get_turf(target)
	for (var/turf/open/visual in view(1, focalpoint))
		new /obj/effect/temp_visual/marker(visual)
	sleep(1.5 SECONDS)
	for (var/mob/living/screenshaken in view(1, focalpoint))
		shake_camera(screenshaken, 5, 5)
	for (var/mob/living/shaken in view(1, focalpoint))
		to_chat(shaken, span_danger("<B>The ground ruptures beneath your feet!</B>"))
		shaken.Paralyze(50)
		var/obj/structure/flora/rock/giant_rock = new(get_turf(shaken))
		QDEL_IN(giant_rock, 200)

/mob/living/simple_animal/hostile/retaliate/elemental/behemoth/proc/yeet(target)
	var/atom/throw_target = get_edge_target_turf(src, get_dir(src, target)) //ill be real I got no idea why this worked.
	if(isliving(target))
		var/mob/living/L = target
		L.throw_at(throw_target, 7, 4)
		L.adjustBruteLoss(30)

/datum/intent/simple/elementalt2_unarmed
	name = "elemental unarmed"
	icon_state = "instrike"
	attack_verb = list("punches", "strikes", "kicks", "steps on", "crushes")
	animname = "blank22"
	blade_class = BCLASS_SMASH
	hitsound = null
	chargetime = 0
	penfactor = 15
	swingdelay = 3
	candodge = TRUE
