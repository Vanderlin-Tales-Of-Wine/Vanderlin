/mob/living/simple_animal/hostile/retaliate/fae/dryad	//Make this cause giant vine tangled messes
	icon = 'icons/mob/summonable/32x64.dmi'
	name = "dryad"
	icon_state = "dryad"
	icon_living = "dryad"
	icon_dead = "vvd"
	summon_primer = "You are a dryad, a large sized fae. You spend time tending to forests, guarding sacred ground from tresspassers. Now you've been pulled from your home into a new world, that is decidedly less wild and natural. How you react to these events, only time can tell."
	tier = 3
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 6
	see_in_dark = 6
	move_to_delay = 12
	base_intents = list(/datum/intent/simple/elementalt2_unarmed)
	butcher_results = list()
	faction = list("fae")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 650
	maxHealth = 650
	melee_damage_lower = 20
	melee_damage_upper = 30
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	base_constitution = 18
	base_constitution = 18
	base_strength = 14
	base_speed = 4
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = "plantcross"
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	ranged = FALSE
	var/vine_cd

/mob/living/simple_animal/hostile/retaliate/fae/dryad/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the watcher
	return

/mob/living/simple_animal/hostile/retaliate/fae/dryad/MoveToTarget(list/possible_targets)//Step 5, handle movement between us and our target
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
		if(world.time >= src.vine_cd + 100)
			vine()
			src.vine_cd = world.time
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

/mob/living/simple_animal/hostile/retaliate/fae/dryad/proc/vine()
	target.visible_message(span_boldwarning("Vines spread out from [src]!"))
	for(var/turf/turf as anything in RANGE_TURFS(3,src.loc))
		new /obj/structure/vine(turf)

/mob/living/simple_animal/hostile/retaliate/fae/dryad/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/melded/t1(deathspot)
	new /obj/item/natural/iridescentscale(deathspot)
	new /obj/item/natural/iridescentscale(deathspot)
	new /obj/item/natural/heartwoodcore(deathspot)
	new /obj/item/natural/heartwoodcore(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	update_icon()
	spill_embedded_objects()
	qdel(src)
