
/mob/living/simple_animal/hostile/retaliate/infernal/fiend/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the fiend
	return

/mob/living/simple_animal/hostile/retaliate/infernal/fiend
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "fiend"
	icon_state = "fiend"
	icon_living = "fiend"
	icon_dead = "vvd"
	summon_primer = "You are fiend, a large sized demon from the infernal plane. You have imps and hounds at your beck and call, able to do whatever you wished. Now you've been pulled from your home into a new world, that is decidedly lacking in fire. How you react to these events, only time can tell."
	tier = 4
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 6
	move_to_delay = 10
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("infernal")
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
	base_endurance = 15
	base_constitution = 13
	base_strength = 12
	base_speed = 8
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = list('sound/misc/lava_death.ogg')
	dodgetime = 30
	aggressive = 1
	ranged = TRUE
	rapid = TRUE
	projectiletype = /obj/projectile/magic/aoe/fireball/rogue
	ranged_message = "throws fire"
	var/flame_cd = 0
	var/summon_cd = 0


/mob/living/simple_animal/hostile/retaliate/infernal/fiend/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/abyssalflame(deathspot)
	new /obj/item/natural/moltencore(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/melded/t2(deathspot)
	update_icon()
	spill_embedded_objects()
	qdel(src)

/mob/living/simple_animal/hostile/retaliate/infernal/fiend/OpenFire(atom/A)
	if(CheckFriendlyFire(A))
		return
	visible_message(span_danger("<b>[src]</b> [ranged_message] at [A]!"))

	if(world.time >= src.flame_cd + 250)
		var/mob/living/targetted = target
		create_meteors(targetted)
		src.flame_cd = world.time

	if(world.time >= src.summon_cd + 250)
		callforbackup()

		src.summon_cd = world.time

	if(rapid > 1)
		var/datum/callback/cb = CALLBACK(src, PROC_REF(Shoot), A)
		for(var/i in 1 to rapid)
			addtimer(cb, (i - 1)*rapid_fire_delay)
	else
		Shoot(A)
	ranged_cooldown = world.time + ranged_cooldown_time


/mob/living/simple_animal/hostile/retaliate/infernal/fiend/proc/create_meteors(atom/target)
	if(!target)
		return
	target.visible_message(span_boldwarning("Fire rains from the sky!"))
	var/turf/targetturf = get_turf(target)
	for(var/turf/turf as anything in RANGE_TURFS(4,targetturf))
		if(prob(20))
			new /obj/effect/temp_visual/target(turf)

/mob/living/simple_animal/hostile/retaliate/infernal/fiend/proc/callforbackup()
	var/list/spawnLists = list(/mob/living/simple_animal/hostile/retaliate/infernal/imp,/mob/living/simple_animal/hostile/retaliate/infernal/imp, /mob/living/simple_animal/hostile/retaliate/infernal/hellhound, /mob/living/simple_animal/hostile/retaliate/infernal/hellhound)
	var/reinforcement_count = 3
	src.visible_message(span_notice("[src] summons reinforcements from the infernal abyss."))
	while(reinforcement_count > 0)
		var/list/turflist = list()
		for(var/turf/t in RANGE_TURFS(1, src))
			turflist += t

		var/turf/picked = pick(turflist)


		var/spawnTypes = pick_n_take(spawnLists)
		new spawnTypes(picked)
		reinforcement_count--
		continue
