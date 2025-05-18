
/mob/living/simple_animal/hostile/retaliate/infernal/hellhound
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "hell hound"
	icon_state = "hellhound"
	icon_living = "hellhound"
	icon_dead = "vvd"
	summon_primer = "You are a hellhound, a moderate sized canine made of heat and flame. You spend time in the infernal plane hunting and incinerating things to your hearts content. Now you've been pulled from your home into a new world, that is decidedly lacking in fire. How you react to these events, only time can tell."
	tier = 2
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 6
	see_in_dark = 6
	move_to_delay = 3
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("infernal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 170
	maxHealth = 170
	melee_damage_lower = 15
	melee_damage_upper = 17
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_NONE
	simple_detect_bonus = 20
	ranged = TRUE
	projectiletype = /obj/projectile/magic/firebolt
	retreat_distance = 4
	minimum_distance = 3
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	base_constitution = 7
	base_strength = 9
	base_speed = 13
	simple_detect_bonus = 20
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	dodgetime = 30
	aggressive = 1
	var/flame_cd

/mob/living/simple_animal/hostile/retaliate/infernal/hellhound/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/retaliate/infernal/hellhound/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/hellhoundfang(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	new /obj/item/natural/infernalash(deathspot)
	update_icon()
	spill_embedded_objects()
	qdel(src)


/mob/living/simple_animal/hostile/retaliate/infernal/hellhound/AttackingTarget()
	if(SEND_SIGNAL(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, target) & COMPONENT_HOSTILE_NO_PREATTACK)
		return FALSE //but more importantly return before attack_animal called
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, target)
	in_melee = TRUE
	if(!target)
		return
	if(world.time >= src.flame_cd + 100)
		var/mob/living/targetted = target
		if(!isliving(target))
			return
		targetted.adjust_fire_stacks(5)
		targetted.IgniteMob()
		targetted.visible_message(span_danger("[src] sets [target] on fire!"))
		src.flame_cd = world.time
	if(!QDELETED(target))
		return target.attack_animal(src)
