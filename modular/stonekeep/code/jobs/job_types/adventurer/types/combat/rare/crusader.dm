/datum/advclass/combat/sk/crusader
	name = "Totod Order Emissary"
	tutorial = "The Crusaders are knights who have pledged \
	their wealth and lands to the Church, taking up the banner \
	of the Totod Order dedicated to retaking Valoria. \
	Three cults provide knights for the Order: Astrata, Necra and Psydon. \
	You were sent to Enigma by the Order to get any and all assistance from the faithful for the Crusade."
	allowed_sexes = list(MALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	allowed_patrons = list(/datum/patron/divine/astrata, /datum/patron/divine/necra, /datum/patron/psydon)
	outfit = /datum/outfit/job/sk/adventurer/crusader
	category_tags = list(CTAG_ADVENTURER)
	maximum_possible_slots = 1
	pickprob = 10
	min_pq = 0

/datum/outfit/job/sk/adventurer/crusader
	allowed_patrons = list(/datum/patron/divine/astrata, /datum/patron/divine/necra, /datum/patron/psydon)

/datum/outfit/job/sk/adventurer/crusader/pre_equip(mob/living/carbon/human/H)
	..()

	head = /obj/item/clothing/head/helmet/heavy/crusader
	neck = /obj/item/clothing/neck/coif/cloth
	armor = /obj/item/clothing/armor/chainmail/hauberk
	cloak = /obj/item/clothing/cloak/cape/crusader
	gloves = /obj/item/clothing/gloves/chain
	shirt = /obj/item/clothing/shirt/tunic/random
	pants = /obj/item/clothing/pants/chainlegs
	shoes = /obj/item/clothing/shoes/boots/armor/light
	backr = /obj/item/weapon/shield/tower/metal
	backl = /obj/item/clothing/cloak/cape/crusader
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/weapon/sword/silver
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/rich = 1)

	switch(H.patron?.name)
		if("Astrata")
			cloak = /obj/item/clothing/cloak/stabard/crusader // Gold for Astrata
			wrists = /obj/item/clothing/neck/psycross/silver/astrata
		if("Necra")
			cloak = /obj/item/clothing/cloak/stabard/templar/necra
			wrists = /obj/item/clothing/neck/psycross/silver/necra
		if("Psydon")
			head = /obj/item/clothing/head/helmet/heavy/psydonbarbute
			wrists = /obj/item/clothing/neck/psycross/silver
			cloak = /obj/item/clothing/cloak/stabard/crusader
		else // Failsafe
			cloak = /obj/item/clothing/cloak/stabard/crusader
			wrists = /obj/item/clothing/neck/psycross/silver

	H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)
	H.change_stat("strength", 1)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	// Finally, grant us the language

	if(!H.has_language(/datum/language/oldpsydonic))
		H.grant_language(/datum/language/oldpsydonic)
		to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")

/datum/outfit/job/sk/adventurer/crusader // Reminder message
	var/tutorial = "<br><br><font color='#bdc34a'><span class='bold'>You have been sent from the Totod Order on a mission to aid your struggle against the Blood Barons somehow. The details of your mission may vary, perhaps to find allies, funding, or a agent of the enemy...</span></font><br><br>"

/datum/outfit/job/sk/adventurer/crusader/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, tutorial)


/obj/item/clothing/cloak/stabard/crusader
	name = "surcoat of the golden order"
	desc = "A surcoat drenched in charcoal water, golden thread stitched in the style of Psydon's Knights of Old Psydonia."
	icon_state = "crusader_surcoat"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/crusader.dmi'

/obj/item/clothing/cloak/stabard/crusader/t
	name = "surcoat of the silver order"
	desc = "A surcoat drenched in charcoal water, white cotton stitched in the symbol of Psydon."
	icon_state = "crusader_surcoatt2"

/obj/item/clothing/cloak/cape/crusader
	name = "desert cape"
	desc = "Zybantu is known for it's legacies in tailoring, this particular cape is interwoven with fine stained silks and leather - a sand elf design, renown for it's style and durability."
	icon_state = "crusader_cloak"
	icon = 'icons/roguetown/clothing/special/crusader.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/crusader.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/crusader.dmi'


/obj/item/clothing/cloak/cape/crusader/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/cloak/lord)

/obj/item/clothing/cloak/cape/crusader/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE
	..()

/obj/item/clothing/cloak/cape/crusader/dropped(mob/living/carbon/human/user)
	..()
	if(QDELETED(src))
		return
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))
