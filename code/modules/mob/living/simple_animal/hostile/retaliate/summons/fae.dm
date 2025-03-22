/mob/living/simple_animal/hostile/retaliate/fae/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/fae/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/fae/simple_limb_hit(zone)
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

/mob/living/simple_animal/hostile/retaliate/fae/sprite
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "sprite"
	icon_state = "sprite"
	icon_living = "sprite"
	icon_dead = "vvd"
	summon_primer = "You are a sprite, a small fae. You spend time wandering the wilds. Now you've been pulled from your home into a new world, that is decidedly less wild and natural. How you react to these events, only time can tell."
	tier = 1
	gender = FEMALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 6
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/unarmed/claw)
	butcher_results = list()
	faction = list("fae")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 50
	maxHealth = 50
	ranged = FALSE
	melee_damage_lower = 10
	melee_damage_upper = 20
	vision_range = 8
	aggro_vision_range = 11
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 3
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STAEND = 6
	STACON = 6
	STASTR = 2
	STASPD = 17
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = 'sound/combat/hits/bladed/smallslash (1).ogg'
	attack_verb_continuous = "jabs"
	attack_verb_simple = "jab"
	dodgetime = 60
	aggressive = 1
	var/drug_cd


/mob/living/simple_animal/hostile/retaliate/fae/sprite/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/fae/sprite/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	update_icon()
	sleep(1)
	qdel(src)



/mob/living/simple_animal/hostile/retaliate/fae/sprite/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/fae/glimmerwing
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "glimmerwing"
	icon_state = "glimmerwing"
	icon_living = "glimmerwing"
	icon_dead = "vvd"
	summon_primer = "You are a glimmerwing, a moderate sized fae. You spend time wandering forests, cursing unweary travellers. Now you've been pulled from your home into a new world, that is decidedly less wild and natural. How you react to these events, only time can tell."
	tier = 2
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 6
	see_in_dark = 6
	move_to_delay = 6
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("fae")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 170
	maxHealth = 170
	melee_damage_lower = 15
	melee_damage_upper = 17
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	ranged = FALSE
	retreat_distance = 0
	minimum_distance = 0
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 7
	STASTR = 9
	STASPD = 15
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = list()
	dodgetime = 40
	aggressive = 1
	var/drug_cd

/mob/living/simple_animal/hostile/retaliate/fae/glimmerwing/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/fae/glimmerwing/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/iridescentscale(deathspot)
	new /obj/item/natural/iridescentscale(deathspot)
	new /obj/item/natural/iridescentscale(deathspot)
	new /obj/item/natural/iridescentscale(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	update_icon()
	spill_embedded_objects()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/fae/glimmerwing/AttackingTarget()
	if(SEND_SIGNAL(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, target) & COMPONENT_HOSTILE_NO_PREATTACK)
		return FALSE //but more importantly return before attack_animal called
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, target)
	in_melee = TRUE
	if(!target)
		return
	if(world.time >= src.drug_cd + 25 SECONDS)
		var/mob/living/targetted = target
		targetted.apply_status_effect(/datum/status_effect/buff/seelie_drugs)
		targetted.visible_message(span_danger("[src] dusts [target] with some kind of powder!"))
		targetted.adjustToxLoss(15)
		src.drug_cd = world.time
	return target.attack_animal(src)

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
	STACON = 18
	STACON = 18
	STASTR = 14
	STASPD = 4
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


/mob/living/simple_animal/hostile/retaliate/fae/sylph/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the fiend
	return

/mob/living/simple_animal/hostile/retaliate/fae/sylph
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "sylph"
	icon_state = "sylph"
	icon_living = "sylph"
	icon_dead = "vvd"
	tier = 4
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("fae")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 700
	maxHealth = 700
	melee_damage_lower = 20
	melee_damage_upper = 30
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	retreat_distance = 4
	minimum_distance = 4
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 13
	STASTR = 12
	STASPD = 8
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = null
	dodgetime = 40
	aggressive = 1
	ranged = TRUE
	rapid = 3
	projectiletype = /obj/projectile/magic/frostbolt/greater
	ranged_message = "throws icey magick"
	var/shroom_cd = 0
	var/summon_cd = 0

/obj/projectile/magic/frostbolt/greater
	name = "greater frostbolt"
	damage = 25
	range = 6
	speed = 6 //higher is slower

/mob/living/simple_animal/hostile/retaliate/fae/sylph/OpenFire(atom/A)
	if(CheckFriendlyFire(A))
		return
	visible_message(span_danger("<b>[src]</b> [ranged_message] at [A]!"))

	if(world.time >= shroom_cd + 25 SECONDS)
		var/mob/living/targetted = target
		create_shroom(targetted)
		src.shroom_cd = world.time
	if(rapid > 1)
		var/datum/callback/cb = CALLBACK(src, PROC_REF(Shoot), A)
		for(var/i in 1 to rapid)
			addtimer(cb, (i - 1)*rapid_fire_delay)
	else
		Shoot(A)
	ranged_cooldown = world.time + ranged_cooldown_time


/mob/living/simple_animal/hostile/retaliate/fae/sylph/proc/create_shroom(atom/target)
	target.visible_message(span_boldwarning("Kneestingers pop out from the ground around [src]!"))
	if(!target)
		return
	for(var/turf/turf as anything in RANGE_TURFS(3,src.loc))
		if(prob(30))
			new /obj/structure/kneestingers(turf)


/mob/living/simple_animal/hostile/retaliate/fae/sylph/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/sylvanessence(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/melded/t2(deathspot)
	new /obj/item/natural/iridescentscale(deathspot)
	new /obj/item/natural/heartwoodcore(deathspot)
	new /obj/item/natural/fairydust(deathspot)
	new /obj/item/natural/fairydust(deathspot)

	update_icon()
	spill_embedded_objects()
	qdel(src)
