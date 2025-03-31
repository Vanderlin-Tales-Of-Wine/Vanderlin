/datum/migrant_role/sk/zizo/herald
	name = "Tiefling Herald"
	greet_text = "In a epiphany your ancestral link with Zizo awoke, and as if guided by fate hellgoblins appeared to serve you in your quest to spread the influence of Zizo, a echo of the Apotheosis war."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Tiefling"
	)
	outfit = /datum/outfit/job/sk_migration/antag/zherald
	grant_lit_torch = FALSE
	antag_datum = /datum/antagonist/zizocultist/leader

/datum/migrant_role/sk/zizo/herald/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.zizo_starts))

/datum/outfit/job/sk_migration/antag/zherald/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/furlinedboots
	wrists = /obj/item/clothing/wrists/bracers/copper
	head = /obj/item/clothing/head/helmet/ironpot/marauder
	r_hand = /obj/item/weapon/whip/antique
	neck = /obj/item/clothing/neck/coif
	armor = /obj/item/clothing/armor/leather/jacket/sea/marauder
	gloves =  /obj/item/clothing/gloves/leather
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/reagent_containers/glass/bottle/stronghealthpot
	beltl = /obj/item/weapon/knife/dagger/steel/dirk
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/polearm/spear/stone/copper
	pants = /obj/item/clothing/pants/trou/leather/heavy
	backpack_contents = list(/obj/item/sleepingbag = 1, /obj/item/natural/cloth = 1, /obj/item/needle/thorn = 1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)

		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)

		H.change_stat(STATKEY_STR, 4)
		H.change_stat(STATKEY_END, 3)
		H.change_stat(STATKEY_CON, 3)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_CABAL, TRAIT_GENERIC)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Herald"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		H.set_patron(/datum/patron/inhumen/zizo)
		H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'

/datum/migrant_role/sk/zizo/hellgoblin
	name = "Hellgoblin Servant"
	greet_text = "Like the days of yore, you serve the Herald and Zizo fanatically, not because of some oath or reward, but because it is your nature. Aid the cult of Zizo, destroy livestock, defile the purity of this hateful world whose very air stings your skin, your body made of things not belonging in this world, and not wanted here."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Changeling","Skylancer","Ogrun","Undine"
	)
	outfit = /datum/outfit/job/sk_migration/antag/zhellgobbo
	grant_lit_torch = FALSE
//	antag_datum = /datum/antagonist/hellgoblin

/datum/outfit/job/sk_migration/antag/zhellgobbo/pre_equip(mob/living/carbon/human/H, visualsOnly, announce, latejoin, datum/outfit/outfit_override, client/preference_source)
	. = ..()
	return  H.change_mob_type(new_type = /mob/living/carbon/human/species/goblin/npc/hell, location = H.loc, new_name = "Hell goblin", delete_old_mob = TRUE)

/datum/migrant_role/sk/zizo/hellgoblin/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(L)
		var/mob/living/carbon/human/H = L

		H.set_species(/datum/species/goblin/hell)
		H.change_mob_type(/mob/living/carbon/human/species/goblin/npc/hell, delete_old_mob = TRUE)
/*
		if(M.mind)
			M.mind.special_role = "goblin"
			M.mind.assigned_role = "goblin"
			M.mind.current.job = null
		if(H.dna && H.dna.species)
			H.dna.species.species_traits |= NOBLOOD
			H.dna.species.soundpack_m = new /datum/voicepack/goblin()
			H.dna.species.soundpack_f = new /datum/voicepack/goblin()
		H.regenerate_limb(BODY_ZONE_R_ARM)
		H.regenerate_limb(BODY_ZONE_L_ARM)
		H.update_body()
		H.update_hair()
		H.update_body_parts(redraw = TRUE)

		H.faction = list("orcs", "zizo")
		H.name = "goblin"
		H.real_name = "goblin"
*/
		H.remove_all_languages()
		H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
		H.update_a_intents()

		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.ambushable = FALSE
		H.underwear = "Nude"
		if(H.charflaw)
			QDEL_NULL(H.charflaw)



		ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
		H.grant_language(/datum/language/hellspeak)
		H.set_patron(/datum/patron/inhumen/zizo)
		H.forceMove(pick(GLOB.zizo_starts))

/datum/outfit/job/stonekeep/antag/zhellgobbo/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = rand(10, 12)
	H.TOTALPER = rand(5, 7)
	H.TOTALINT = rand(1, 4)
	H.TOTALCON = rand(10, 12)
	H.TOTALEND = rand(10, 12)
	H.TOTALSPD = rand(12, 15)
	armor = pick(/obj/item/clothing/armor/leather/goblin,  /obj/item/clothing/armor/leather/hide/goblin)
	head = pick(/obj/item/clothing/head/helmet/goblin, /obj/item/clothing/head/helmet/leather/goblin)
	r_hand = pick(/obj/item/weapon/mace/spiked, /obj/item/weapon/flail, /obj/item/weapon/sword/sabre/scythe)
	l_hand = /obj/item/weapon/shield/wood
	belt = /obj/item/storage/belt/leather/rope/survival
	shoes = /obj/item/clothing/shoes/sandals
	neck = pick(/obj/item/clothing/neck/gorget, /obj/item/clothing/neck/coif)


/datum/migrant_wave/zizo_cult
	name = "The Cult of Apotheosis"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/varyag_raiders, /datum/migrant_wave/zizo_cult)
	weight = 25
	downgrade_wave = /datum/migrant_wave/zizo_cult_down
	roles = list(
		/datum/migrant_role/sk/zizo/herald = 2,
//		/datum/migrant_role/sk/zizo/hellgoblin = 2
		)
	greet_text = "Zizo is your master, and too long has these lands been allowed to forget."

/datum/migrant_wave/zizo_cult_down
	name = "The Cult of Apotheosis"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/varyag_raiders, /datum/migrant_wave/zizo_cult)
	can_roll = FALSE
	roles = list(
//		/datum/migrant_role/sk/zizo/herald = 1,
		/datum/migrant_role/sk/zizo/hellgoblin = 1
)
	greet_text = "Zizo is your master, and too long has these lands been allowed to forget."









/*



/datum/antagonist/hellgoblin
	name = "Zizoid Lackey"
	roundend_category = "zizoid cultists"
	antagpanel_category = "Zizoid Cult"
	job_rank = ROLE_ZIZOIDCULTIST
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "cultist"
	confess_lines = list(
		"DEATH TO THE TEN!",
		"PRAISE ZIZO!",
		"I AM THE FUTURE!",
		"NO GODS! ONLY MASTERS!",
	)

/datum/antagonist/zizocultist/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/zizocultist/leader))
		return "<span class='boldnotice'>OUR LEADER!</span>"
	if(istype(examined_datum, /datum/antagonist/zizocultist))
		return "<span class='boldnotice'>A lackey for the future.</span>"
	if(istype(examined_datum, /datum/antagonist/assassin))
		return "<span class='boldnotice'>A GRAGGAROID! A CULTIST OF GRAGGAR!</span>"

/datum/antagonist/zizocultist/on_gain()
	. = ..()
	var/mob/living/carbon/human/H = owner.current
	SSmapping.retainer.cultists |= owner
	H.set_patron(/datum/patron/inhumen/zizo)

	owner.special_role = "Zizoid Lackey"
	H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'

	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_VILLAIN, TRAIT_GENERIC)

	add_objective(/datum/objective/zizoserve)

*/
