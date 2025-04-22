
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

	base_constitution = 15
	base_endurance = 15
	base_strength = 10
	base_speed = 6

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
	if(!QDELETED(target))
		return target.attack_animal(src)

/mob/living/simple_animal/hostile/retaliate/elemental/warden/proc/yeet(target)
	var/atom/throw_target = get_edge_target_turf(src, get_dir(src, target)) //ill be real I got no idea why this worked.
	var/mob/living/L = target
	L.throw_at(throw_target, 7, 4)
	L.adjustBruteLoss(20)
