/mob/living/simple_animal/hostile/retaliate/elemental/collossus
	icon = 'icons/mob/summonable/64x64.dmi'
	name = "earthen collossus"
	icon_state = "collossus"
	icon_living = "collossus"
	icon_dead = "vvd"
	summon_primer = "You are an collossus, a massive elemental. Elementals such as yourself are immeasurably old. Now you've been pulled from your home into a new world, that is decidedly less peaceful then your carefully guarded plane. How you react to these events, only time can tell."
	tier = 4
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 16
	base_intents = list(/datum/intent/simple/elementalt2_unarmed)
	butcher_results = list()
	faction = list("elemental")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 1500
	maxHealth = 1500
	melee_damage_lower = 40
	melee_damage_upper = 70
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	ranged = TRUE
	projectiletype = /obj/projectile/earthenchunk
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	ranged = TRUE
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = 'sound/combat/hits/onstone/wallhit.ogg'
	pixel_x = -32
	dodgetime = 0
	aggressive = 1

	base_constitution = 20
	base_endurance = 20
	base_strength = 16
	base_speed = 3

	var/stomp_cd

/mob/living/simple_animal/hostile/retaliate/elemental/collossus/MoveToTarget(list/possible_targets)//Step 5, handle movement between us and our target
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
				if(world.time >= stomp_cd + 25 SECONDS)
					stomp(target)
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



/mob/living/simple_animal/hostile/retaliate/elemental/collossus/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/elemental/collossus/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/elementalrelic(deathspot)
	update_icon()
	spill_embedded_objects()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/elemental/collossus/proc/stomp(target)
	for (var/mob/living/stomped in view(1, src))
		new	/obj/effect/temp_visual/stomp(stomped)
		var/atom/throw_target = get_edge_target_turf(src, get_dir(src, stomped)) //ill be real I got no idea why this worked.
		var/mob/living/L = stomped
		L.throw_at(throw_target, 7, 4)
		L.adjustBruteLoss(20)
	stomp_cd = world.time

/obj/projectile/earthenchunk
	name = "Elemental Chunk"
	icon_state = "rock"
	damage = 30
	damage_type = BRUTE
	flag = "magic"
	range = 10
	speed = 16 //higher is slower

/obj/effect/temp_visual/stomp
	icon = 'icons/effects/effects.dmi'
	icon_state = "phaseout"
	light_outer_range = 2
	duration = 5
	layer = ABOVE_ALL_MOB_LAYER //this doesnt render above mobs? it really should

/obj/projectile/earthenchunk/on_hit(target)
	. = ..()
	var/list/spawnLists = list(/mob/living/simple_animal/hostile/retaliate/elemental/crawler,/mob/living/simple_animal/hostile/retaliate/elemental/crawler, /mob/living/simple_animal/hostile/retaliate/elemental/crawler)
	var/reinforcement_count = 3
	if(prob(20))
		src.visible_message(span_notice("[src] breaks apart, scattering minor elementals about!"))
		while(reinforcement_count > 0)
			var/list/turflist = list()
			for(var/turf/t in RANGE_TURFS(1, src))
				turflist += t

			var/turf/picked = pick(turflist)


			var/spawnTypes = pick_n_take(spawnLists)
			new spawnTypes(picked)
			reinforcement_count--
			continue

	qdel(src)
