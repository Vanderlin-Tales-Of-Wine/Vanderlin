/mob/living/simple_animal/hostile/retaliate/rogue/spider
	icon = 'icons/roguetown/mob/monster/spider.dmi'
	name = "beespider"
	desc = "Swamp-lurking creachers with a wicked bite. They make honey from flowers and spin silk from their abdomen. Some dark elves see them as a sacred animal."
	icon_state = "honeys"
	icon_living = "honeys"
	icon_dead = "honeys-dead"

	faction = list("bugs")
	turns_per_move = 4
	move_to_delay = 2
	vision_range = 5
	aggro_vision_range = 5

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/strange = 1,
							/obj/item/natural/silk = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/strange = 1,
							/obj/item/reagent_containers/food/snacks/spiderhoney = 1,
							/obj/item/natural/silk = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/strange = 2,
							/obj/item/reagent_containers/food/snacks/spiderhoney = 2,
							/obj/item/natural/silk = 3)

	health = SPIDER_HEALTH
	maxHealth = SPIDER_HEALTH
	food_type = list(/obj/item/bodypart,
					/obj/item/organ,
					/obj/item/reagent_containers/food/snacks/rogue/meat)

	base_intents = list(/datum/intent/simple/bite)
	attack_sound = list('sound/vo/mobs/spider/attack (1).ogg','sound/vo/mobs/spider/attack (2).ogg','sound/vo/mobs/spider/attack (3).ogg','sound/vo/mobs/spider/attack (4).ogg')
	melee_damage_lower = 20
	melee_damage_upper = 25

	TOTALCON = 6
	TOTALSTR = 10
	TOTALSPD = 10

	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 35
	defdrain = 5
	attack_same = FALSE
	retreat_health = 0.2

	aggressive = TRUE
	stat_attack = UNCONSCIOUS
	body_eater = TRUE

	ai_controller = /datum/ai_controller/spider
	AIStatus = AI_OFF
	can_have_ai = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/spider/mutated
	icon = 'icons/roguetown/mob/monster/spider.dmi'
	name = "skallax spider"
	icon_state = "skallax"
	icon_living = "skallax"
	icon_dead = "skallax-dead"

	health = SPIDER_HEALTH+10
	maxHealth = SPIDER_HEALTH+10

	base_intents = list(/datum/intent/simple/bite)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/Initialize()
	. = ..()
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()

	AddElement(/datum/element/ai_flee_while_injured, 0.75, retreat_health)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)
	ADD_TRAIT(src, TRAIT_WEBWALK, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.reagents)
			L.reagents.add_reagent(/datum/reagent/toxin/venom, 1)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/find_food()
	. = ..()
	if(!.)
		return eat_bodies()

/mob/living/simple_animal/hostile/retaliate/rogue/spider/death(gibbed)
	..()
	update_icon()


/mob/living/simple_animal/hostile/retaliate/rogue/spider/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		var/mutable_appearance/eye_lights = mutable_appearance(icon, "honeys-eyes")
		eye_lights.plane = 19
		eye_lights.layer = 19
		add_overlay(eye_lights)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/spider/aggro (1).ogg','sound/vo/mobs/spider/aggro (2).ogg','sound/vo/mobs/spider/aggro (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/spider/pain.ogg')
		if("death")
			return pick('sound/vo/mobs/spider/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/spider/idle (1).ogg','sound/vo/mobs/spider/idle (2).ogg','sound/vo/mobs/spider/idle (3).ogg','sound/vo/mobs/spider/idle (4).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/spider/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/spider/Life()
	..()
	if(stat == CONSCIOUS)
		if(!target)
			if(production >= 100)
				production = 0
				visible_message("<span class='alertalien'>[src] creates some honey.</span>")
				var/turf/T = get_turf(src)
				playsound(T, pick('sound/vo/mobs/spider/speak (1).ogg','sound/vo/mobs/spider/speak (2).ogg','sound/vo/mobs/spider/speak (3).ogg','sound/vo/mobs/spider/speak (4).ogg'), 100, TRUE, -1)
				new /obj/item/reagent_containers/food/snacks/spiderhoney(T)
	if(pulledby && !tame)
		if(HAS_TRAIT(pulledby, TRAIT_WEBWALK))
			return
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/spider/simple_limb_hit(zone)
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
			return "stomach"
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

