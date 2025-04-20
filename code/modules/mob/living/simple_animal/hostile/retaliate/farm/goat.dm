/mob/living/simple_animal/hostile/retaliate/goat/Initialize()
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	RegisterSignal(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(on_pre_attack))
	GLOB.farm_animals++
	if(tame)
		tamed(owner)

/mob/living/simple_animal/hostile/retaliate/goat/Destroy()
	..()
	GLOB.farm_animals = max(GLOB.farm_animals - 1, 0)

/// Called when we attack something in order to piece together the intent of the AI/user and provide desired behavior. The element might be okay here but I'd rather the fluff.
/// Goats are really good at beating up plants by taking bites out of them, but we use the default attack for everything else
/mob/living/simple_animal/hostile/retaliate/goat/proc/on_pre_attack(datum/source, atom/target)
	if(is_type_in_list(target, food_type))
		eat_plant(target)
		return COMPONENT_HOSTILE_NO_ATTACK

/mob/living/simple_animal/hostile/retaliate/goat/tamed(mob/user)
	..()
	deaggroprob = 50
	if(can_buckle)
		AddComponent(/datum/component/riding/gote)

/mob/living/simple_animal/hostile/retaliate/goat/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		if(ssaddle)
			var/mutable_appearance/saddlet = mutable_appearance(icon, "saddle-f-above", 4.3)
			add_overlay(saddlet)
			saddlet = mutable_appearance(icon, "saddle-f")
			add_overlay(saddlet)
		if(has_buckled_mobs())
			var/mutable_appearance/mounted = mutable_appearance(icon, "goat_mounted", 4.3)
			add_overlay(mounted)

/mob/living/simple_animal/hostile/retaliate/goat/UniqueAttack()
	if(istype(target, /obj/structure/vine))
		var/obj/structure/vine/SV = target
		SV.eat(src)
		food = max(food + 30, food_max + 50)
		return
	return ..()

/mob/living/simple_animal/hostile/retaliate/goat
	icon = 'icons/roguetown/mob/monster/gote.dmi'
	name = "gote"
	desc = ""
	icon_state = "goat"
	icon_living = "goat"
	icon_dead = "goat_dead"
	icon_gib = "goat_gib"

	animal_species = /mob/living/simple_animal/hostile/retaliate/goatmale
	faction = list("goats")
	gender = FEMALE
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_see = list("shakes her head.", "chews her cud.")

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 2,
						/obj/item/natural/hide = 1,
						/obj/item/alch/bone = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 4,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 1,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 6,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 2,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1,
						/obj/item/natural/head/gote = 1)

	health = FEMALE_GOTE_HEALTH
	maxHealth = FEMALE_GOTE_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/produce/wheat,
					/obj/item/reagent_containers/food/snacks/produce/oat,
					/obj/item/reagent_containers/food/snacks/produce/apple,
					/obj/item/reagent_containers/food/snacks/produce/turnip,
					/obj/item/reagent_containers/food/snacks/produce/cabbage,
					/obj/item/reagent_containers/food/snacks/produce/jacksberry,
					/obj/structure/vine,
					/obj/structure/kneestingers,
					)
	tame_chance = 25
	bonus_tame_chance = 15
	pooptype = /obj/item/natural/poo/horse
	milk_reagent = /datum/reagent/consumable/milk/gote

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	melee_damage_lower = 8
	melee_damage_upper = 12
	base_speed = 4
	base_constitution = 4
	base_strength = 4
	buckle_lying = FALSE
	childtype = list(/mob/living/simple_animal/hostile/retaliate/goat/goatlet = 90, /mob/living/simple_animal/hostile/retaliate/goat/goatlet/boy = 10)
	can_buckle = TRUE
	remains_type = /obj/effect/decal/remains/cow

	ai_controller = /datum/ai_controller/gote
	AIStatus = AI_OFF
	can_have_ai = FALSE

/mob/living/simple_animal/hostile/retaliate/goat/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/goat/aggro (1).ogg','sound/vo/mobs/goat/aggro (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/goat/pain (1).ogg','sound/vo/mobs/goat/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/goat/death (1).ogg','sound/vo/mobs/goat/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/goat/idle (1).ogg','sound/vo/mobs/goat/idle (2).ogg','sound/vo/mobs/goat/idle (3).ogg')

/mob/living/simple_animal/hostile/retaliate/goat/simple_limb_hit(zone)
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

/mob/living/simple_animal/hostile/retaliate/goatmale
	icon = 'icons/roguetown/mob/monster/gote.dmi'
	name = "male gote"
	icon_state = "goatmale"
	icon_living = "goatmale"
	icon_dead = "goatmale_dead"
	icon_gib = "goatmale_gib"

	faction = list("goats")
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_see = list("shakes his head.", "chews his cud.")
	turns_per_move = 3

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 3,
						/obj/item/natural/hide = 1,
						/obj/item/alch/sinew = 1,
						/obj/item/alch/bone = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 4,
						/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 1,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 6,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 2,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1,
						/obj/item/natural/head/gote = 1)

	health = MALE_GOTE_HEALTH
	maxHealth = MALE_GOTE_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/produce/wheat,
					/obj/item/reagent_containers/food/snacks/produce/oat,
					/obj/item/reagent_containers/food/snacks/produce/apple,
					/obj/item/reagent_containers/food/snacks/produce/turnip,
					/obj/item/reagent_containers/food/snacks/produce/cabbage,
					/obj/item/reagent_containers/food/snacks/produce/jacksberry,
					/obj/structure/vine,
					/obj/structure/kneestingers,
					)
	pooptype = /obj/item/natural/poo/horse

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	melee_damage_lower = 14
	melee_damage_upper = 22
	retreat_distance = 0
	minimum_distance = 0
	base_constitution = 7
	base_strength = 12
	base_speed = 2

	can_buckle = TRUE
	buckle_lying = FALSE
	tame_chance = 25
	bonus_tame_chance = 15
	remains_type = /obj/effect/decal/remains/cow

	ai_controller = /datum/ai_controller/gote
	AIStatus = AI_OFF
	can_have_ai = FALSE

/mob/living/simple_animal/hostile/retaliate/goatmale/Initialize()
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	RegisterSignal(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(on_pre_attack))

/// Called when we attack something in order to piece together the intent of the AI/user and provide desired behavior. The element might be okay here but I'd rather the fluff.
/// Goats are really good at beating up plants by taking bites out of them, but we use the default attack for everything else
/mob/living/simple_animal/hostile/retaliate/goatmale/proc/on_pre_attack(datum/source, atom/target)
	if(is_type_in_list(target, food_type))
		eat_plant(target)
		return COMPONENT_HOSTILE_NO_ATTACK

/mob/living/simple_animal/hostile/retaliate/goatmale/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		if(ssaddle)
			var/mutable_appearance/saddlet = mutable_appearance(icon, "saddle-above", 4.3)
			add_overlay(saddlet)
			saddlet = mutable_appearance(icon, "saddle")
			add_overlay(saddlet)
		if(has_buckled_mobs())
			var/mutable_appearance/mounted = mutable_appearance(icon, "goatmale_mounted", 4.3)
			add_overlay(mounted)

/mob/living/simple_animal/hostile/retaliate/goatmale/tamed(mob/user)
	..()
	deaggroprob = 20
	if(can_buckle)
		AddComponent(/datum/component/riding/gote)

/mob/living/simple_animal/hostile/retaliate/goatmale/Initialize()
	..()
	GLOB.farm_animals++
	if(tame)
		tamed(owner)

/mob/living/simple_animal/hostile/retaliate/goatmale/Destroy()
	..()
	GLOB.farm_animals = max(GLOB.farm_animals - 1, 0)

/mob/living/simple_animal/hostile/retaliate/goatmale/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/goat/aggro (1).ogg','sound/vo/mobs/goat/aggro (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/goat/pain (1).ogg','sound/vo/mobs/goat/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/goat/death (1).ogg','sound/vo/mobs/goat/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/goat/idle (1).ogg','sound/vo/mobs/goat/idle (2).ogg','sound/vo/mobs/goat/idle (3).ogg')

/mob/living/simple_animal/hostile/retaliate/goatmale/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/proc/eat_plant(obj/target)
	if(istype(target, /obj/structure/vine))
		target:eat(src)
		food = max(food + 30, 100)
	if(istype(target, /obj/structure/kneestingers))
		qdel(target)
		food = max(food + 30, 100)


/mob/living/simple_animal/hostile/retaliate/goatmale/simple_limb_hit(zone)
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

/mob/living/simple_animal/hostile/retaliate/goat/goatlet
	icon = 'icons/roguetown/mob/monster/gote.dmi'
	name = "gotelet"
	desc = ""
	icon_state = "goatlet"
	icon_living = "goatlet"
	icon_dead = "goatlet_dead"
	icon_gib = "goatlet_gib"

	animal_species = null
	gender = FEMALE
	mob_size = MOB_SIZE_SMALL
	pass_flags = PASSTABLE | PASSMOB

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mince/beef = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 1,
							/obj/item/natural/hide = 1)

	health = CALF_HEALTH
	maxHealth = CALF_HEALTH
	milk_reagent = null

	base_intents = list(/datum/intent/simple/headbutt)
	melee_damage_lower = 1
	melee_damage_upper = 6
	base_constitution = 5
	base_strength = 5
	base_speed = 5
	defprob = 50

	adult_growth = /mob/living/simple_animal/hostile/retaliate/goat
	can_buckle = FALSE



/mob/living/simple_animal/hostile/retaliate/goat/goatlet/boy
	icon_state = "goatletboy"
	icon_living = "goatletboy"
	icon_dead = "goatletboy_dead"
	icon_gib = "goatletboyt_gib"

	gender = MALE

	adult_growth = /mob/living/simple_animal/hostile/retaliate/goatmale

