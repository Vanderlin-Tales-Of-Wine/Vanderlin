/* Notes-
The idea is Kaizoku warriors are the garrison, a force sent from a foreign lord to support his ally.
Honor-focused, theyre supposed to swear loyalty to the monarch publically on the start of the week to reinforce this.
Archers, spearmen, scouts, theyre meant to be on par with adventurer fighters and the like, but less than rare knights and
the like.
*/
/datum/job/stonekeep/garrison
	title = "Man-at-arms"
	flag = SK_GUARD
	department_flag = GARRISON
	total_positions = 5
	spawn_positions = 5

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine"
	)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	tutorial = "You are a soldier in the town garrison, an Ashigaru from the Fog Islands. Treaties and alliances matter little to you, your Lord has ordered you to obey the local ruler and their Sheriff, maintaining order."
	display_order = GARRISON_ORDER

	outfit = /datum/outfit/job/stonekeep/garrison	//Default outfit.
	advclass_cat_rolls = list(CTAG_GARRISON = 20)	//Handles class selection.
	give_bank_account = 20
	min_pq = -10

	cmode_music = 'modular/stonekeep/kaizoku/sound/combat/combat_stormwarrior.ogg'

/datum/outfit/job/stonekeep/garrison // Reminder message
	var/oath = "<br><br><font color='#855b14'><span class='bold'>Remember to renew your oath of loyalty to the Monarch in person at the start of the week.</span></font><br><br>"

/datum/outfit/job/stonekeep/garrison/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, oath)


/datum/job/stonekeep/garrison/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(istype(H.cloak, /obj/item/clothing/cloak/stabard/haramaki/jinbaori/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "ashigaru's jinbaori ([index])"

//Universal stuff for all guards, regardless of their class selection.
/datum/outfit/job/stonekeep/garrison
	pants = /obj/item/clothing/pants/trou/tobi/random
	cloak = /obj/item/clothing/cloak/stabard/haramaki/jinbaori/guard //I can't put these somewhere else.
	shoes = /obj/item/clothing/shoes/boots/jikatabi/shinobi
	belt = /obj/item/storage/belt/kaizoku/leather/daisho/random

/datum/outfit/job/stonekeep/garrison/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.dna.species.id == "human")
		H.skin_tone = SKIN_COLOR_TROPICALDRY
		H.grant_language(/datum/language/abyssal)
	if(findtext(H.real_name, " Clanless"))
		to_chat(H, "<span class='userdanger'>If I am bound to the king, I must be one with my bloodline.</span>")
		clanfication(H)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.cmode_music = list('modular/stonekeep/kaizoku/sound/combat/combat_changeling.ogg','modular/stonekeep/kaizoku/sound/combat/combat_stormwarrior.ogg','modular/stonekeep/kaizoku/sound/combat/combat_searaider.ogg','modular/stonekeep/kaizoku/sound/combat/combat_oldtides.ogg','modular/stonekeep/kaizoku/sound/combat/combat_decapitator.ogg','modular/stonekeep/kaizoku/sound/combat/combat_emperor.ogg','modular/stonekeep/kaizoku/sound/combat/combat_traditional.ogg','modular/stonekeep/kaizoku/sound/combat/combat_navalretainers.ogg','modular/stonekeep/kaizoku/sound/combat/combat_kyudo.ogg')

/* ! ! ! Class Selection Section Below ! ! !
Design philosphy:
- Footman, specializes in using axes/maces and shields. - Medium armor
- Pikeman, specializes in polearms with some bonus stats. - Medium armor
- Archer, specializes in bow/crossbow and daggers. - Dodge expert, no armor training, some crafting stats (low)
- Fencer, specializes in swords and daggers. - Dodge expert, no armor training
*/

/datum/advclass/sk/garrison/footman
	name = "Garrison Footman"
	tutorial = "You are a footman in the garrison levy. You are well versed in holding the line with a shield while wielding a trusty sword, axe, or mace in the other hand."
	outfit = /datum/outfit/job/stonekeep/garrison/footman

	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/stonekeep/garrison/footman/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>My clan was bound to sworn to the king's cause under the Heavenly Emperor's will. As an Ashigaru retainer, their lineage is held in high regard, and I shall serve their bloodline as I would my daimyo.")
	armor = /obj/item/clothing/armor/cuirass/nanbando
	shirt = /obj/item/clothing/armor/chainmail/tatami
	mask = /obj/item/clothing/face/kaizoku/menpo/half //Abyssariads relies less in gorgets, more in masks.
	head = /obj/item/clothing/head/helmet/zijinguan //Hopefully the feather colors will be fixed.
	backr = /obj/item/weapon/shield/wood/rattan
	beltr = /obj/item/weapon/sword/scimitar/messer/dao
	beltl = /obj/item/weapon/mace/ararebo
	backpack_contents = list(/obj/item/storage/keyring/manorguard)

	//Stats for class
	H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)

/datum/advclass/sk/garrison/spearman
	name = "Garrison Spearman"
	tutorial = "Chosen for size and brawn, wielding polearms. You are less fleet of foot compared to the rest, but you are burly and well practiced with spears, pikes, billhooks - all the various polearms for striking enemies from a distance."
	outfit = /datum/outfit/job/stonekeep/garrison/spearman

	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/stonekeep/garrison/spearman/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>My clan was bound to sworn to the king's cause under the Heavenly Emperor's will. As an Ashigaru retainer, their lineage is held in high regard, and I shall serve their bloodline as I would my daimyo.")
	armor = /obj/item/clothing/armor/chainmail/tatami
	shirt = /obj/item/clothing/armor/gambeson/ruankai
	neck = /obj/item/clothing/neck/gorget
	head = /obj/item/clothing/head/helmet/kaizoku/jingasa
	beltr = /obj/item/weapon/sword/scimitar/messer/dao
	backpack_contents = list(/obj/item/storage/keyring/manorguard)

	//Stats for class
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, -1) // Stronk and gets training in hard hitting polearms, but slower

	var/weapontype = pickweight(list("Spear" = 6, "Bardiche" = 4)) // Rolls for either a spear or a bardiche
	switch(weapontype)
		if("Spear")
			var/obj/item/weapon/polearm/spear/yari/P = new()
			H.put_in_hands(P, forced = TRUE)
		if("Bardiche")
			var/obj/item/weapon/polearm/halberd/bardiche/naginata/P = new()
			H.put_in_hands(P, forced = TRUE)

/datum/advclass/sk/garrison/archer
	name = "Garrison Archer"
	tutorial = "You are an archer in the garrison levy. Your training with bows and crossbows makes you a formidable threat when perched atop the walls or rooftops, raining arrows or bolts down upon foes with impunity."
	outfit = /datum/outfit/job/stonekeep/garrison/archer

	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/stonekeep/garrison/archer/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>My clan was bound to sworn to the king's cause under the Heavenly Emperor's will. As an Ashigaru retainer, their lineage is held in high regard, and I shall serve their bloodline as I would my daimyo.")
	armor = /obj/item/clothing/armor/gambeson/heavy/deelcoat
	shirt = /obj/item/clothing/shirt/shortshirt/merc
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/hankyu
	head = /obj/item/clothing/head/tengai/gasa
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/military
	wrists = /obj/item/clothing/wrists/bracers/leather/khudagach
	beltr = /obj/item/ammo_holder/quiver/arrows
	beltl = /obj/item/weapon/knife/steel/tanto
	backpack_contents = list(/obj/item/storage/keyring/manorguard)

	//Stats for class
	H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

/datum/advclass/sk/garrison/scout
	name = "Garrison Scout"
	tutorial = "You are a fencer in the garrison levy. If nothing else you know a simple truth, there are few problems that cannot be resolved with quick feet and the precise application of a deft blade."
	outfit = /datum/outfit/job/stonekeep/garrison/scout

	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/stonekeep/garrison/scout/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>My clan was bound to sworn to the king's cause under the Heavenly Emperor's will. As an Ashigaru retainer, their lineage is held in high regard, and I shall serve their bloodline as I would my daimyo.")
	armor = /obj/item/clothing/armor/leather/splint/kikko
	shirt = /obj/item/clothing/shirt/shortshirt/merc
	beltr = /obj/item/weapon/sword/rapier
	head = /obj/item/clothing/head/tengai/gasa
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/military
	beltl = /obj/item/weapon/knife/steel/tanto
	backpack_contents = list(/obj/item/storage/keyring/manorguard)

	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

