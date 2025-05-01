/datum/job/goblin
	title = "Goblin"
	tutorial = ""
	flag = GRAVETENDER
	//department_flag = PEASANTS
	job_flags = (JOB_EQUIP_RANK)
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/npc/goblin
	give_bank_account = FALSE

/datum/outfit/job/goblin/equip(mob/living/carbon/human/H, visualsOnly, announce, latejoin, datum/outfit/outfit_override, client/preference_source)
	. = ..()
	return  H.change_mob_type(/mob/living/carbon/human/species/goblin/cave, delete_old_mob = TRUE)

/datum/job/goblin/after_spawn(mob/living/spawned, client/player_client)
	..()

	var/mob/living/carbon/human/H = spawned
	H.set_species(/datum/species/goblin/cave)
	if(spawned.mind)
		spawned.mind.special_role = "goblin"
		spawned.mind.current.job = null
	if(H.dna && H.dna.species)
		H.dna.species.species_traits |= NOBLOOD
		H.dna.species.soundpack_m = new /datum/voicepack/goblin()
		H.dna.species.soundpack_f = new /datum/voicepack/goblin()
	var/obj/item/bodypart/head/headdy = H.get_bodypart("head")
	if(headdy)
		headdy.icon = 'icons/roguetown/mob/monster/goblins.dmi'
		headdy.icon_state = "[H.dna.species.id]_head"
		headdy.headprice = rand(7,20)
	H.regenerate_limb(BODY_ZONE_R_ARM)
	H.regenerate_limb(BODY_ZONE_L_ARM)
	H.remove_all_languages()
	H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
	H.update_a_intents()
	H.grant_undead_eyes()
	H.ambushable = FALSE
	H.underwear = "Nude"
	if(H.charflaw)
		QDEL_NULL(H.charflaw)
	H.update_body()
	H.faction = list(FACTION_ORCS)
	H.name = "goblin"
	H.real_name = "goblin"
	ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	H.grant_language(/datum/language/hellspeak)
