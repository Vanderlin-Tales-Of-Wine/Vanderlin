/mob/living/carbon/human/species/werewolf
	race = /datum/species/werewolf
	footstep_type = FOOTSTEP_MOB_HEAVY
	var/datum/language_holder/stored_language
	var/list/stored_skills
	var/list/stored_experience

/mob/living/carbon/human/species/werewolf/male
	gender = MALE

/mob/living/carbon/human/species/werewolf/female
	gender = FEMALE

/datum/species/werewolf
	name = "werewolf"
	id = "werewolf"
	species_traits = list(NO_UNDERWEAR,NOEYESPRITES)
	inherent_traits = list(TRAIT_NOSTAMINA, TRAIT_RESISTHEAT,TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_NODISMEMBER)
	inherent_biotypes = MOB_HUMANOID
	no_equip = list(SLOT_SHIRT, SLOT_HEAD, SLOT_WEAR_MASK, SLOT_ARMOR, SLOT_GLOVES, SLOT_SHOES, SLOT_PANTS, SLOT_CLOAK, SLOT_BELT, SLOT_BACK_R, SLOT_BACK_L, SLOT_S_STORE)
	nojumpsuit = 1
	sexes = 1
	offset_features = list(OFFSET_HANDS = list(0,2), OFFSET_HANDS_F = list(0,2))
	soundpack_m = /datum/voicepack/werewolf
	soundpack_f = /datum/voicepack/werewolf
	specstats = list("strength" = 5, "perception" = 5, "intelligence" = -3, "constitution" = 5, "endurance" = 5, "speed" = 3, "fortune" = 0)
	specstats_f = list("strength" = 5, "perception" = 5, "intelligence" = -3, "constitution" = 5, "endurance" = 5, "speed" = 3, "fortune" = 0)
	enflamed_icon = "widefire"
	mutanteyes = /obj/item/organ/eyes/night_vision/werewolf
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	bleed_mod = 0.2
	pain_mod = 0.2

/datum/species/werewolf/send_voice(mob/living/carbon/human/H)
	playsound(get_turf(H), pick('sound/vo/mobs/wwolf/wolftalk1.ogg','sound/vo/mobs/wwolf/wolftalk2.ogg'), 100, TRUE, -1)

/datum/species/werewolf/regenerate_icons(mob/living/carbon/human/H)
	H.icon = 'icons/roguetown/mob/monster/werewolf.dmi'
	H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/wereclaw, /datum/intent/simple/werebite)
	if(H.gender == MALE)
		H.icon_state = "wwolf_m"
	else
		H.icon_state = "wwolf_f"
	H.update_damage_overlays()
	return TRUE

/datum/species/werewolf/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.remove_all_languages()
	C.grant_language(/datum/language/beast)

/datum/species/werewolf/update_damage_overlays(mob/living/carbon/human/H)
	H.remove_overlay(DAMAGE_LAYER)
	var/list/hands = list()
	var/mutable_appearance/inhand_overlay = mutable_appearance("[H.icon_state]-dam", layer=-DAMAGE_LAYER)
	var/burnhead = 0
	var/brutehead = 0
	var/burnch = 0
	var/brutech = 0
	var/obj/item/bodypart/affecting = H.get_bodypart(BODY_ZONE_HEAD)
	if(affecting)
		burnhead = (affecting.burn_dam / affecting.max_damage)
		brutehead = (affecting.brute_dam / affecting.max_damage)
	affecting = H.get_bodypart(BODY_ZONE_CHEST)
	if(affecting)
		burnch = (affecting.burn_dam / affecting.max_damage)
		brutech = (affecting.brute_dam / affecting.max_damage)
	var/usedloss = 0
	if(burnhead > usedloss)
		usedloss = burnhead
	if(brutehead > usedloss)
		usedloss = brutehead
	if(burnch > usedloss)
		usedloss = burnch
	if(brutech > usedloss)
		usedloss = brutech
	inhand_overlay.alpha = 255 * usedloss
	testing("damalpha [inhand_overlay.alpha]")
	hands += inhand_overlay
	H.overlays_standing[DAMAGE_LAYER] = hands
	H.apply_overlay(DAMAGE_LAYER)
	return TRUE

/datum/species/werewolf/random_name(gender,unique,lastname)
	return "WEREVOLF"

/datum/species/werewolf/check_species_weakness(obj/item, mob/living/attacker, mob/living/parent)
	if(parent.has_status_effect(/datum/status_effect/debuff/silver_curse))
		return 0.75
	return 0
