/mob/living/simple_animal/hostile/retaliate/rogue/trollbog
	icon = 'icons/roguetown/mob/monster/trolls.dmi'
	name = "bog troll"
	desc = "Elven legends say these monsters were servants of Dendor tasked to guard his realm; nowadays they are sometimes found in the company of orcs."
	icon_state = "Trolls"
	icon_living = "Troll"
	icon_dead = "Trolld"
	pixel_x = -16

	faction = list("orcs")
	footstep_type = FOOTSTEP_MOB_HEAVY
	emote_hear = null
	emote_see = null
	verb_say = "groans"
	verb_ask = "grunts"
	verb_exclaim = "roars"
	verb_yell = "roars"

	wander = FALSE		// bog trolls are ambush predators
	turns_per_move = 4
	see_in_dark = 10
	move_to_delay = 7
	vision_range = 6
	aggro_vision_range = 6

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider = 1,
						/obj/item/natural/hide = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider = 1,
						/obj/item/natural/hide = 3)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider = 2,
						/obj/item/natural/hide = 4)

	health = BOGTROLL_HEALTH
	maxHealth = BOGTROLL_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat,
					/obj/item/bodypart,
					/obj/item/organ)

	base_intents = list(/datum/intent/simple/headbutt, /datum/intent/simple/bigbite)
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	melee_damage_lower = 30
	melee_damage_upper = 50
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES

	TOTALCON = 16
	TOTALSTR = 16
	TOTALSPD = 3
	TOTALEND = 15

	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 30
	defdrain = 13
	del_on_deaggro = 99 SECONDS
	retreat_health = 0
	food_max = 250
	food = 0

	dodgetime = 45
	aggressive = TRUE
//	stat_attack = UNCONSCIOUS
	remains_type = /obj/effect/decal/remains/troll // Placeholder until Troll remains are sprited.
	body_eater = TRUE

	ai_controller = /datum/ai_controller/bog_troll
	AIStatus = AI_OFF
	can_have_ai = FALSE

	var/critvuln = FALSE


/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/Initialize()
	. = ..()
	if(critvuln)
		ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)	// bogtroll does not mind kneestingers

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/death(gibbed)
	..()
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/troll/aggro1.ogg','sound/vo/mobs/troll/aggro2.ogg')
		if("pain")
			return pick('sound/vo/mobs/troll/pain1.ogg','sound/vo/mobs/troll/pain2.ogg')
		if("death")
			return pick('sound/vo/mobs/troll/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/troll/idle1.ogg','sound/vo/mobs/troll/idle2.ogg')
		if("cidle")
			return pick('sound/vo/mobs/troll/cidle1.ogg','sound/vo/mobs/troll/aggro2.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)
	if(fire_stacks <= 0)
		adjustHealth(-rand(40,50))


/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/LoseTarget()
	..()
	if(health > 0)
		icon_state = "Trollso"

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/Moved()
	. = ..()
	if(!icon_state == "Troll")
		icon_state = "Troll"


/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/GiveTarget()
	..()
	icon_state = "Trolla"

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/simple_limb_hit(zone)
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

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/after_creation()
	..()
	var/obj/item/organ/eyes/eyes = src.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/nightmare
	eyes.Insert(src)
