/datum/migrant_role/sk/grenzelhoft/count
	name = "Grenzelhoft Count"
	greet_text = "A Count hailing from the Grenzelhoft Imperiate, here on an official visit to the Peninsula of Vanderlin alongside his beloved convoy and spouse."
	allowed_sexes = list(MALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	outfit = /datum/outfit/job/sk_migration/grenz_count
	grant_lit_torch = TRUE

/datum/migrant_role/sk/grenzelhoft/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.forestroad_starts_starts))

/datum/outfit/job/sk_migration/grenz_count/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	wrists = /obj/item/clothing/neck/psycross/g
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/armor/brigandine
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/weapon/sword/sabre/dec
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
	id = /obj/item/clothing/ring/gold
	shirt = /obj/item/clothing/shirt/grenzelhoft
	pants = /obj/item/clothing/pants/grenzelpants
	neck = /obj/item/clothing/neck/gorget
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Count"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/combat_grenzelhoft.ogg'

/datum/migrant_role/sk/grenzelhoft/countess
	name = "Grenzelhoft Countess"
	greet_text = "A Countess hailing from the Grenzelhoft Imperiate, here on an official visit to the Isle of the Enigma alongside her beloved convoy and husband."
	allowed_sexes = list(FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	outfit = /datum/outfit/job/sk_migration/grenz_countess
	grant_lit_torch = TRUE

/datum/outfit/job/sk_migration/grenz_countess/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	wrists = /obj/item/clothing/neck/psycross/g
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/armor/gambeson/heavy/dress/alt
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/weapon/sword/rapier/dec
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
	id = /obj/item/clothing/ring/gold
	shirt = /obj/item/clothing/shirt/grenzelhoft
	pants = /obj/item/clothing/pants/grenzelpants
	neck = /obj/item/clothing/neck/gorget
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Countess"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

/datum/migrant_role/sk/grenzelhoft/preacher
	name = "Grenzelhoft Preacher"
	greet_text =  "A devout follower of Psydon, you came to this land with nothing more than the clothes on your back and the faith in your heart. Sway these nonbelievers to the right path!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	outfit = /datum/outfit/job/sk_migration/grenz_preacher
	grant_lit_torch = TRUE

/datum/outfit/job/sk_migration/grenz_preacher/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/shirt/undershirt/priest
	pants = /obj/item/clothing/pants/tights/black
	neck = /obj/item/clothing/neck/psycross
	head = /obj/item/clothing/head/brimmed
	r_hand = /obj/item/book/psybibble
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
		H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

/datum/migrant_role/sk/grenzelhoft/swordmaster
	name = "Grenzelhoft Swordmaster"
	greet_text = "Your liege, the count and the countess have both took the duty gaved by the Kaiser itself to voyage to the Isle of Enigma, ensure their survival and obey their orders."
	allowed_sexes = list(MALE)
	allowed_races = list("Humen", "Dwarf")
	outfit = /datum/outfit/job/sk/adventurer/swordmaster

/datum/migrant_role/sk/grenzelhoft/mercenary
	name = "Grenzelhoft Mercenary"
	greet_text = "You have been paid well by the count to guard his entourage."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Humen", "Dwarf")
	outfit = /datum/advclass/mercenary/sk/grenzelhoft


/datum/migrant_wave/grenzelhoft_visit
	name = "The Grenzelhoft visit"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/heartfelt)
	weight = 25
	downgrade_wave = /datum/migrant_wave/grenzelhoft_visit_down
	roles = list(
		/datum/migrant_role/sk/grenzelhoft/count = 1,
		/datum/migrant_role/sk/grenzelhoft/countess = 1,
		/datum/migrant_role/sk/grenzelhoft/swordmaster = 1,
		/datum/migrant_role/sk/grenzelhoft/mercenary = 1)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a diplomatic envoy."

/datum/migrant_wave/grenzelhoft_visit_down
	name = "The Grenzelhoft visit"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sk/grenzelhoft/count = 1,
		/datum/migrant_role/sk/grenzelhoft/preacher = 1,
		/datum/migrant_role/sk/grenzelhoft/swordmaster = 1)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a diplomatic envoy. The envoys wife dislikes travel so she stayed at home, and his mercenaries have deserted, such are the challenges of travel. At least a wandering prelate has joined, though their sermons are getting tiresome."
