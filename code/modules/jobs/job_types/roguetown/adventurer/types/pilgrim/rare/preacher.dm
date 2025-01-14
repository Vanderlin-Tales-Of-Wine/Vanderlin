/datum/advclass/pilgrim/rare/preacher
	name = "Preacher"
	tutorial = "A devout follower of Psydon, you came to this land with nothing more than the clothes on your back and the faith in your heart. Sway these nonbelievers to the right path!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/preacher
	category_tags = list(CTAG_PILGRIM)
	maximum_possible_slots = 1
	pickprob = 30
	min_pq = 0

	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

/datum/outfit/job/roguetown/adventurer/preacher/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	pants = /obj/item/clothing/under/roguetown/tights/black
	neck = /obj/item/clothing/neck/roguetown/psycross
	head = /obj/item/clothing/head/roguetown/brimmed
	r_hand = /obj/item/book/rogue/psybibble
	beltl = /obj/item/handheld_bell
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
		H.set_patron(/datum/patron/psydon)
