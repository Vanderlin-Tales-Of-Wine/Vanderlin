/* Notes-
Conscripts supposed to be low-powered and kinda fun wave. Spawns in the bog.
Idea is shit stat old guy with ok gear and great skills + peasants with random as hell stats and dogshit equipment.
Their default should be aligned with the crown and have some limited objective, currently defaulted to restoring the bog tollhouse.
*/

/datum/migrant_role/conscript/veteran
	name = "Old Veteran"
	greet_text = "An old hand at soldiering, you were sent out by the King to conscript peasants for restoring the old tollhouse in the wetlands."
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_OLD)
	allowed_races = list(
		"Humen",
		"Dwarf",
		"Half-Elf",
		"Elf")
	grant_lit_torch = FALSE
	is_foreigner = FALSE
	outfit = /datum/outfit/job/sk_migration/conscript/veteran
	advclass_cat_rolls = list(CTAG_OLDVETERAN = 20)

/datum/outfit/job/sk_migration/conscript/veteran/pre_equip(mob/living/carbon/human/H)
	..()

	pants = /obj/item/clothing/pants/trou/leather
	cloak = /obj/item/clothing/cloak/half/random
	shirt = /obj/item/clothing/shirt/undershirt/guardsecond
	armor = /obj/item/clothing/armor/medium/scale
	neck = /obj/item/clothing/neck/gorget
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/guard
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel = 1, /obj/item/signal_horn = 1, /obj/item/key/tollhouse = 1)
	switch(rand(1,2))	// ROGTODO some sort of check to prevent double blindness due to picked flaw cyclops
		if(1)
			mask = /obj/item/clothing/face/eyepatch/left
			var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
			head?.add_wound(/datum/wound/facial/eyes/left/permanent)
			H.update_fov_angles()
		else
			mask = /obj/item/clothing/face/eyepatch
			var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
			head?.add_wound(/datum/wound/facial/eyes/right/permanent)
			H.update_fov_angles()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	H.verbs |= /mob/proc/haltyell
	l_hand = /obj/item/flashlight/flare/torch/prelit

/datum/advclass/sk/veteran/club
	name = "Godendag"
	tutorial = "The godendag is your weapon of choice."
	outfit = /datum/outfit/job/stonekeep/veteran/goden
	category_tags = list(CTAG_OLDVETERAN )

/datum/outfit/job/stonekeep/veteran/goden/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/weapon/mace/goden
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)

/datum/advclass/sk/veteran/shield
	name = "Shield and Sword"
	tutorial = "A traditional choice."
	outfit = /datum/outfit/job/stonekeep/veteran/shield
	category_tags = list(CTAG_OLDVETERAN )

/datum/outfit/job/stonekeep/veteran/shield/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/weapon/shield/heater
	beltr = /obj/item/weapon/sword/arming
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)


/datum/migrant_role/conscript/peasant
	name = "Peasant Conscript"
	greet_text = "You have been conscripted to restore the old tollhouse, under the command of the Serjeant. You may not like it, but the sooner the work is done, the sooner you can return to your family."
	outfit = /datum/outfit/job/sk_migration/peasant
	allowed_races = list("Humen","Dwarf","Aasimar","Half-Elf","Elf")
	grant_lit_torch = TRUE
	is_foreigner = FALSE
	allowed_sexes = list(MALE)

/datum/outfit/job/sk_migration/peasant/pre_equip(mob/living/carbon/human/H)
	..()
	armor =  pick(/obj/item/clothing/armor/gambeson, /obj/item/clothing/armor/leather)
	shirt =  pick(/obj/item/clothing/armor/gambeson/light, /obj/item/clothing/shirt/undershirt/random, /obj/item/clothing/shirt/undershirt/uncolored)
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/simpleshoes
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/weapon/knife/villager
	var/helmet2choose = pickweight(list("Coif" = 3, "Leather" = 2, "Maille" = 1, "Cap" = 1))
	switch(helmet2choose)
		if("Coif")
			neck =	pick(/obj/item/clothing/neck/coif,/obj/item/clothing/neck/coif/cloth)
		if("Maille")
			neck =	/obj/item/clothing/neck/chaincoif
		if("Cap" )
			head = /obj/item/clothing/head/helmet/skullcap
		if("Leather")
			head = /obj/item/clothing/head/helmet/leather/conical

	var/weapon2choose = pickweight(list("Polearm" = 1, "Flail" = 1, "Godendag" = 1))
	switch(weapon2choose)
		if("Polearm")
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			if(prob(30))
				r_hand = /obj/item/weapon/polearm/spear/billhook
			else
				r_hand = /obj/item/weapon/polearm/spear
		if("Flail" )
			H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			r_hand = /obj/item/weapon/thresher/military
			backl= /obj/item/weapon/shield/wood
		if("Godendag")
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			r_hand = /obj/item/weapon/mace/goden
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, pick(0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, pick(0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, pick(0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
		H.change_stat(STATKEY_STR, pick(-1,0,1,2,3))
		H.change_stat(STATKEY_SPD, pick(-1,0,1))
		H.change_stat(STATKEY_END, pick(-1,0,1,2,3))
		H.change_stat(STATKEY_CON, pick(-1,0,1,2,3))
		H.change_stat(STATKEY_INT, pick(-4,-3,-2,-1,0,1))
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	H.verbs |= /mob/proc/haltyell


/datum/migrant_role/conscript/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.bogroad_starts))

/datum/migrant_wave/conscripts
	name = "New Conscripts"
	max_spawns = 2
	shared_wave_type = /datum/migrant_wave/knight_errant
	downgrade_wave = /datum/migrant_wave/conscripts_down
	weight = 40
	roles = list(
		/datum/migrant_role/conscript/veteran = 1,
		/datum/migrant_role/conscript/peasant = 2
	)
	greet_text = "Your task is to restore the old tollhouse and bring order to the wetlands."

/datum/migrant_wave/conscripts_down
	name = "New Conscripts"
	shared_wave_type = /datum/migrant_wave/conscripts
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/conscript/veteran = 1,
		/datum/migrant_role/conscript/peasant = 1
	)
	greet_text = "Your task is to restore the old tollhouse and bring order to the wetlands."

