
/mob/living/simple_animal/hostile/retaliate/rogue/cow
	icon = 'icons/roguetown/mob/monster/cow.dmi'
	name = "moo-beast"
	desc = "The grail of many farmers. Commonfolk associate the motherly sow with Eora, and the raging bull with Ravox."
	icon_state = "cow"
	icon_living = "cow"
	icon_dead = "cow_dead"
	icon_gib = "cow_gib"

	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/bull
	faction = list("cows")
	gender = FEMALE
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_hear = list("brays.")
	emote_see = list("shakes its head.", "chews her cud.")

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
						/obj/item/natural/hide = 1,
						/obj/item/alch/sinew = 1,
						/obj/item/alch/bone = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 6,
						/obj/item/natural/hide = 2,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 8,
						/obj/item/natural/hide = 3,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)

	health = FEMALE_MOOBEAST_HEALTH
	maxHealth = FEMALE_MOOBEAST_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/produce/wheat,
					/obj/item/reagent_containers/food/snacks/produce/oat,
					/obj/item/reagent_containers/food/snacks/produce/turnip,
					/obj/item/reagent_containers/food/snacks/produce/cabbage)
	pooptype = /obj/item/natural/poo/cow
	var/milkies = TRUE
	tame_chance = 25
	bonus_tame_chance = 15

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "stomps"
	attack_verb_simple = "stomps"
	melee_damage_lower = 10
	melee_damage_upper = 12
	TOTALSPD = 4
	TOTALCON = 4
	TOTALSTR = 4
	childtype = list(/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet = 95,
					/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/bullet = 5)
	remains_type = /obj/effect/decal/remains/cow


/mob/living/simple_animal/hostile/retaliate/rogue/cow/Initialize()
	..()
	if(milkies)
		udder = new()

/mob/living/simple_animal/hostile/retaliate/rogue/cow/Destroy()
	qdel(udder)
	udder = null
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/cow/attackby(obj/item/O, mob/user, params)
	if(!stat && istype(O, /obj/item/reagent_containers/glass))
//		changeNext_move(20) // milking sound length
		if(udder)
			udder.milkAnimal(O, user)
			return 1
	else
		return ..()

/obj/effect/decal/remains/cow
	name = "remains"
	gender = PLURAL
	icon_state = "skele"
	icon = 'icons/roguetown/mob/monster/cow.dmi'

/mob/living/simple_animal/hostile/retaliate/rogue/cow/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/cow/aggro (1).ogg','sound/vo/mobs/cow/aggro (2).ogg','sound/vo/mobs/cow/aggro (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/cow/pain (1).ogg','sound/vo/mobs/cow/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/cow/death (1).ogg','sound/vo/mobs/cow/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/cow/idle (1).ogg','sound/vo/mobs/cow/idle (2).ogg','sound/vo/mobs/cow/idle (3).ogg','sound/vo/mobs/cow/idle (4).ogg','sound/vo/mobs/cow/idle (5).ogg')


/mob/living/simple_animal/hostile/retaliate/rogue/cow/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
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

/mob/living/simple_animal/hostile/retaliate/rogue/cow/attack_hand(mob/living/carbon/M)
	if(!stat && M.used_intent.type == INTENT_DISARM && icon_state != icon_dead && !has_buckled_mobs())
		M.visible_message("<span class='warning'>[M] tips over [src].</span>",
			"<span class='notice'>I tip over [src].</span>")
		to_chat(src, span_danger("I am tipped over by [M]!"))
		Paralyze(60, ignore_canstun = TRUE)
		icon_state = "[initial(icon_state)]_tip"
		spawn(60)
			if(!stat && M)
				icon_state = icon_living
	else
		..()

/mob/living/simple_animal/hostile/retaliate/rogue/cow/Life()
	. = ..()
	if(.)
		if(food > 0)
			if(udder)
				if(production > 0)
					production--
					udder.generateMilk()


/mob/living/simple_animal/hostile/retaliate/rogue/bull
	icon = 'icons/roguetown/mob/monster/cow.dmi'
	name = "moo-beast bull"
	desc = "Rambunctious as the war-saint himself, a depiction of the moo-beast bull looms on the standard of the Valorian city-state called Andalvia."
	icon_state = "bull"
	icon_living = "bull"
	icon_dead = "bull_dead"
	icon_gib = "bull_gib"

	faction = list("cows")
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_hear = list("chews.")
	emote_see = list("shakes his head.", "chews his cud.")

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
						/obj/item/alch/sinew = 1,
						/obj/item/alch/bone = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 7,
						/obj/item/natural/hide = 3,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 9,
						/obj/item/natural/hide = 4,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)

	health = MALE_MOOBEAST_HEALTH
	maxHealth = MALE_MOOBEAST_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/produce/wheat,
					/obj/item/reagent_containers/food/snacks/produce/oat,
					/obj/item/reagent_containers/food/snacks/produce/turnip,
					/obj/item/reagent_containers/food/snacks/produce/cabbage)
	pooptype = /obj/item/natural/poo/cow

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "gores"
	attack_verb_simple = "gores"
	melee_damage_lower = 25
	melee_damage_upper = 45
	retreat_distance = 0
	minimum_distance = 0
	TOTALCON = 20
	TOTALSTR = 12
	TOTALSPD = 2
	remains_type = /obj/effect/decal/remains/cow

/mob/living/simple_animal/hostile/retaliate/rogue/bull/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/cow/aggro (1).ogg','sound/vo/mobs/cow/aggro (2).ogg','sound/vo/mobs/cow/aggro (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/cow/pain (1).ogg','sound/vo/mobs/cow/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/cow/death (1).ogg','sound/vo/mobs/cow/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/cow/idle (1).ogg','sound/vo/mobs/cow/idle (2).ogg','sound/vo/mobs/cow/idle (3).ogg','sound/vo/mobs/cow/idle (4).ogg','sound/vo/mobs/cow/idle (5).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/bull/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/bull/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
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

/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet
	name = "calf"
	desc = "So cute!"
	icon_state = "cowlet"
	icon_living = "cowlet"
	icon_dead = "cowlet_dead"
	icon_gib = "cowlet_gib"

	animal_species = null
	mob_size = MOB_SIZE_SMALL
	pass_flags = PASSTABLE | PASSMOB

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
								/obj/item/natural/hide = 1)

	health = CALF_HEALTH
	maxHealth = CALF_HEALTH
	milkies = FALSE

	base_intents = list(/datum/intent/simple/headbutt)
	melee_damage_lower = 1
	melee_damage_upper = 6
	TOTALCON = 5
	TOTALSTR = 5
	TOTALSPD = 5
	defprob = 50
	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/cow

/mob/living/simple_animal/hostile/retaliate/rogue/cow/cowlet/bullet
	desc = "So cute! Be careful of those horns, though."
	icon_state = "bullet"
	icon_living = "bullet"
	icon_dead = "bullet_dead"
	icon_gib = "bullet_gib"

	gender = MALE

	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/bull
