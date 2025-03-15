/mob/living/simple_animal/hostile/retaliate/elemental/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/elemental/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/elemental/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/mob/living/simple_animal/hostile/retaliate/elemental/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the elementals
	return

/datum/intent/simple/elemental_unarmed
	name = "elemental unarmed"
	icon_state = "instrike"
	attack_verb = list("punches", "strikes", "rolls on", "crushes")
	animname = "blank22"
	blade_class = BCLASS_BLUNT
	hitsound = null
	chargetime = 0
	penfactor = 10
	swingdelay = 3
	candodge = TRUE
	canparry = TRUE

/mob/living/simple_animal/hostile/retaliate/elemental/crawler
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "earthen crawler"
	summon_primer = "You are an crawler, a small elemental. Elementals such as yourself spend immeasurable time wandering about within your plane. Now you've been pulled from your home into a new world, that is decidedly less peaceful then your carefully guarded plane. How you react to these events, only time can tell."
	icon_state = "crawler"
	icon_living = "crawler"
	tier = 1
	icon_dead = "vvd"
	gender = MALE
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 8
	base_intents = list(/datum/intent/simple/elemental_unarmed)
	butcher_results = list()
	faction = list("elemental")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 120
	maxHealth = 120
	melee_damage_lower = 15
	melee_damage_upper = 17
	vision_range = 8
	aggro_vision_range = 11
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 13
	STAEND = 13
	STASTR = 8
	STASPD = 8
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = 'sound/combat/hits/onstone/wallhit.ogg'
	attack_verb_continuous = "pounds"
	attack_verb_simple = "pounds"
	dodgetime = 0
	aggressive = 1


/mob/living/simple_animal/hostile/retaliate/elemental/crawler/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/elemental/crawler/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	update_icon()
	sleep(1)
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/elemental/warden
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "earthen Warden"
	icon_state = "warden"
	icon_living = "warden"
	icon_dead = "vvd"
	summon_primer = "You are an warden, a moderate elemental. Elementals such as yourself guard your plane from intrusion zealously. Now you've been pulled from your home into a new world, that is decidedly less peaceful then your carefully guarded plane. How you react to these events, only time can tell."
	tier = 2
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 12
	base_intents = list(/datum/intent/simple/elemental_unarmed)
	butcher_results = list()
	faction = list("elemental")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 240
	maxHealth = 240
	melee_damage_lower = 15
	melee_damage_upper = 17
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	simple_detect_bonus = 20
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 15
	STAEND = 15
	STASTR = 10
	STASPD = 6
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	rapid = TRUE
	attack_sound = 'sound/combat/hits/onstone/wallhit.ogg'
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/elemental/warden/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/elemental/warden/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/elementalshard(deathspot)
	new /obj/item/natural/elementalshard(deathspot)
	new /obj/item/natural/elementalshard(deathspot)
	new /obj/item/natural/elementalshard(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	new /obj/item/natural/elementalmote(deathspot)
	update_icon()
	spill_embedded_objects()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/elemental/warden/AttackingTarget()
	if(SEND_SIGNAL(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, target) & COMPONENT_HOSTILE_NO_PREATTACK)
		return FALSE //but more importantly return before attack_animal called
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, target)
	in_melee = TRUE
	if(!target)
		return
	yeet(target)
	return target.attack_animal(src)

/mob/living/simple_animal/hostile/retaliate/elemental/warden/proc/yeet(target)
	var/atom/throw_target = get_edge_target_turf(src, get_dir(src, target)) //ill be real I got no idea why this worked.
	var/mob/living/L = target
	L.throw_at(throw_target, 7, 4)
	L.adjustBruteLoss(20)


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
	STACON = 17
	STAEND = 17
	STASTR = 13
	STASPD = 5
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
	STACON = 20
	STAEND = 20
	STASTR = 16
	STASPD = 3
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
