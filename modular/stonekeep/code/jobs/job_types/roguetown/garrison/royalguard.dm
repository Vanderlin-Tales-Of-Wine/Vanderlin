/datum/job/roguetown/royalguard
	title = "Royal Guard"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	"Humen",
	"Changeling",
	"Skylancer",
	"Ogrun")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	display_order = JDO_ROYALGUARD
	whitelist_req = FALSE
	bypass_lastclass = TRUE

	outfit = /datum/outfit/job/roguetown/royalguard

	tutorial = "A lower-ranking zamurai serving the warrior caste that became adrift during a expedition, \
	keeping their trusty steed. They are expected to uphold their oficial duties and following the strict \
	martial code of the Abyssal Tide, at least on paper."

	give_bank_account = 30
	min_pq = 0
	selection_color = "#920909"

	cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

/datum/job/roguetown/royalguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/tabard/knight/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "knight's tabard ([index])"
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/haramaki/odoshi/zamurai))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "zamurai's odoshi ([index])"
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		if(H.dna.species?.id != "abyssariad")
			var/honorary = "Sir"
			if(H.gender == FEMALE)
				honorary = "Dame"
			H.real_name = "[honorary] [prev_real_name]"
			H.name = "[honorary] [prev_name]"
		else
			var/original_first_name
			var/original_clan
			var/honorary = "-dono" //The organization for that one is different of the Rockhillian counterpart.

			var/index = findtext(prev_real_name, " of ") // If no "of" is found, apply honorific to the full name instead. Someone made a snowflake.
			if(index)
				original_first_name = copytext(prev_real_name, 1, index)
				original_clan = copytext(prev_real_name, index)
				H.real_name = "[original_first_name][honorary][original_clan]"
			else // If no "of" is found, apply honorific to the full name instead.
				H.real_name = "[prev_real_name][honorary]"

			H.name = H.real_name // Sync `name` with the modified `real_name`

/datum/outfit/job/roguetown/royalguard/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, span_warning( "<span class='userdanger'>I am a noble storm-hardened Zamurai. I hold the blood oath of my ancestors, bound to the throne - I serve the ruler's clan with utmost devotion, let death find me before dishonoring my pact.</span>"))
	pants = /obj/item/clothing/under/chainlegs/sendan
	neck = null //Abyssariads rarely uses gorgets. For that they use menpos.
	mask = /obj/item/clothing/face/kaizoku/menpo
	cloak = /obj/item/clothing/cloak/stabard/haramaki/odoshi/zamurai
	shirt = /obj/item/clothing/shirt/looseshirt
	armor = /obj/item/clothing/armor/brigandine/oyoroi/royal
	shoes = /obj/item/clothing/shoes/boots/armor/light/kusaritabi
	belt = /obj/item/storage/belt/kaizoku/leather/daisho/random
	beltr = /obj/item/weapon/sword/uchigatana
	backr = /obj/item/storage/backpack/satchel
	r_hand = /obj/item/weapon/polearm/halberd/bardiche/naginata
	backl = /obj/item/weapon/shield/tower/metal/abyssal
	if(prob(30))
		head = /obj/item/clothing/head/helmet/visored/zunari
	else
		head = /obj/item/clothing/head/helmet/sallet/tosei_kabuto
	if(findtext(H.real_name, " Clanless"))
		to_chat(H, "<span class='warning'>The King acquired my clan - so I have to belong to one before reaching this royal duty I serve.</span>")
		clanfication(H)
	H.cmode_music = list('modular/stonekeep/kaizoku/sound/combat/combat_changeling.ogg','modular/stonekeep/kaizoku/sound/combat/combat_stormwarrior.ogg','modular/stonekeep/kaizoku/sound/combat/combat_searaider.ogg','modular/stonekeep/kaizoku/sound/combat/combat_oldtides.ogg','modular/stonekeep/kaizoku/sound/combat/combat_decapitator.ogg','modular/stonekeep/kaizoku/sound/combat/combat_emperor.ogg','modular/stonekeep/kaizoku/sound/combat/combat_traditional.ogg','modular/stonekeep/kaizoku/sound/combat/combat_navalretainers.ogg','modular/stonekeep/kaizoku/sound/combat/combat_kyudo.ogg')

	if(H.dna.species.name == "Ogrun")
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		r_hand = /obj/item/weapon/mace/goden/steel/tetsubo
	else
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.cmode_music = list('modular/stonekeep/kaizoku/sound/combat/combat_changeling.ogg','modular/stonekeep/kaizoku/sound/combat/combat_stormwarrior.ogg','modular/stonekeep/kaizoku/sound/combat/combat_searaider.ogg','modular/stonekeep/kaizoku/sound/combat/combat_oldtides.ogg','modular/stonekeep/kaizoku/sound/combat/combat_decapitator.ogg','modular/stonekeep/kaizoku/sound/combat/combat_emperor.ogg','modular/stonekeep/kaizoku/sound/combat/combat_traditional.ogg','modular/stonekeep/kaizoku/sound/combat/combat_navalretainers.ogg','modular/stonekeep/kaizoku/sound/combat/combat_kyudo.ogg')

	H.change_stat("strength", 2)
	H.change_stat("perception", 2)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1)

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
