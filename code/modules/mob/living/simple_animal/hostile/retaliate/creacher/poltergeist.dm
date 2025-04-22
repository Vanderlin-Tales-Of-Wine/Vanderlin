/////////
// Copy of the mob I did on Stalker 13, more-or-less. Same function here. Refluffed and changed slightly. - Carl
/////////
/mob/living/simple_animal/hostile/retaliate/poltergeist
	name = "poltergeist"
//Newer sprite unused until we can get resize to properly work 100% of the time.
//Maybe it does and I'm braindead, but I 'unno.
	icon = 'icons/roguetown/mob/monster/poltergeist.dmi'
	icon_state = "polter0"
	icon_living = "polter0"
	icon_dead = "polter_initial"
//End of sprite rant.
	gender = PLURAL
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 2
	see_in_dark = 6
	move_to_delay = 5
	base_intents = list(/datum/intent/simple/claw)
	faction = list("poltergeist")
	mob_biotypes = MOB_UNDEAD
	health = 80//Low health because it's impossible to be hit as is. Use Churn Undead to get rid of a haunting.
	maxHealth = 80
	melee_damage_lower = 5
	melee_damage_upper = 10
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	retreat_distance = 6
	minimum_distance = 4
	base_constitution = 5
	base_strength = 5
	base_speed = 20
	deaggroprob = 0
	defprob = 95
	defdrain = 10
	dodgetime = 30
	aggressive = 1
//Can't hit most of the time with thrown objects against prone mobs, so it's commented out. Maybe return later.
//	stat_attack = UNCONSCIOUS
	var/timer = 0
	var/flick_timer = 0

/mob/living/simple_animal/hostile/retaliate/poltergeist/Initialize()
	. = ..()
	timer = rand(1,5)
	flick_timer = rand(1,15)

/mob/living/simple_animal/hostile/retaliate/poltergeist/Life()
	..()
	timer--
	flick_timer--
	if(timer == 0)
		polter()
		timer = rand(1,5)
	if(flick_timer == 0)
		flick("polter1", src)
		flick_timer = rand(1,15)

/mob/living/simple_animal/hostile/retaliate/poltergeist/proc/polter()
	if(stat != DEAD)
		for(var/mob/living/carbon/human/H in view(15, src))
			var/most_violent = -1
			var/obj/item/throwing
			for(var/obj/item/I in view(15, get_turf(H)))
				if(I.anchored)
					continue
				if(I.throwforce > most_violent)
					most_violent = I.throwforce
					throwing = I
			if(throwing)
				playsound(src, pick('sound/vo/mobs/poltergeist/polter_damage0.ogg',
							'sound/vo/mobs/poltergeist/polter_damage1.ogg',
							'sound/vo/mobs/poltergeist/polter_damage2.ogg'))
				throwing.throw_at(H, 8, 2)

/mob/living/simple_animal/hostile/retaliate/poltergeist/death()
	..()
	gib()

/mob/living/simple_animal/hostile/retaliate/poltergeist/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/poltergeist/polter_damage0.ogg','sound/vo/mobs/poltergeist/polter_damage1.ogg','sound/vo/mobs/poltergeist/polter_damage2.ogg')
		if("pain")
			return pick('sound/vo/mobs/poltergeist/polter_damage0.ogg','sound/vo/mobs/poltergeist/polter_damage1.ogg','sound/vo/mobs/poltergeist/polter_damage2.ogg')
		if("death")
			return pick('sound/vo/mobs/poltergeist/polter_damage0.ogg','sound/vo/mobs/poltergeist/polter_damage1.ogg','sound/vo/mobs/poltergeist/polter_damage2.ogg')
		if("idle")
			return pick('sound/vo/mobs/poltergeist/polter_idle.ogg')
		if("cidle")
			return pick('sound/vo/mobs/poltergeist/polter_idle.ogg')
