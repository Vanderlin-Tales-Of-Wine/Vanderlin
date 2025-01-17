/datum/migrant_role/grenzelhoft/invasion
	name = "Grenzelhoft Invader"
	greet_text = "Something happened in the lands of Vanderlin, now you are here and they soon won't be, make them pay for their insult to the Imperiate."
	allowed_sexes = list(MALE,FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	show_wanderer_examine = FALSE
	advclass_cat_rolls = list(CTAG_GRENZELHOFT_INVASION = 20)


/datum/advclass/grenzelhoft/invasion/duke
	name = "Grenzelhoft Duke"
	tutorial = "A Duke hailing from Grenzelhoft, war has erupted between the Imperiate and Vanderlin and now you are on a punitive expedition, Commend the army and punish the ruler of vanderlins "
	allowed_sexes = list(MALE,FEMALE)
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/invasion/grenzelhoft/duke
	category_tags = list(CTAG_GRENZELHOFT_INVASION)
	maximum_possible_slots = 1

/datum/outfit/job/roguetown/invasion/grenzelhoft/duke/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzel
	wrists = /obj/item/clothing/neck/roguetown/psycross/g
	head = /obj/item/clothing/head/roguetown/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl = /obj/item/rogueweapon/sword/sabre/dec
	beltr = /obj/item/gun/ballistic/revolver/grenadelauncher/pistol
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/gold
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	pants = /obj/item/clothing/under/roguetown/grenzelpants
	neck = /obj/item/clothing/neck/roguetown/gorget
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/veryrich = 1,/obj/item/flashlight/flare/torch/lantern = 1, /obj/projectile/bullet/reusable/bullet = 3)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Count"
		if(H.gender == FEMALE)
			honorary = "Countess"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'


/datum/advclass/grenzelhoft/invasion/knight
	name = "Grenzelhoft Knight"
	tutorial = "A Knight hailing from Grenzelhoft, war has erupted between the Imperiate and Vanderlin and now you are on a punitive expedition, Commend the army and obey the Duke "
	allowed_sexes = list(MALE)
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/invasion/grenzelhoft/knight
	category_tags = list(CTAG_GRENZELHOFT_INVASION)
	maximum_possible_slots = 3

/datum/outfit/job/roguetown/invasion/grenzelhoft/knight/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

		H.change_stat("strength", 3)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 2)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Ritter"
		if(H.gender == FEMALE)
			honorary = "Ritterin"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"

	pants = /obj/item/clothing/under/roguetown/tights/black
	backr = /obj/item/rogueweapon/sword/long/greatsword/flamberge
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	shoes = /obj/item/clothing/shoes/roguetown/boots/rare/grenzelplate
	gloves = /obj/item/clothing/gloves/roguetown/rare/grenzelplate
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	armor = /obj/item/clothing/suit/roguetown/armor/rare/grenzelplate
	backl = /obj/item/storage/backpack/rogue/satchel
	head = /obj/item/clothing/head/roguetown/rare/grenzelplate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backpack_contents = list(/obj/projectile/bullet/reusable/bullet = 3,/obj/item/gun/ballistic/revolver/grenadelauncher/pistol = 1)
	if(!H.has_language(/datum/language/oldpsydonic))
		H.grant_language(/datum/language/oldpsydonic)
		to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")

/datum/advclass/grenzelhoft/invasion/l_men_at_arms
	name = "Grenzelhoft Light Men-at-arms"
	tutorial = "A professional soldier hailing from Grenzelhoft, war has erupted between the Imperiate and Vanderlin and now you are on a punitive expedition, listen to your superiors."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	outfit = /datum/outfit/job/roguetown/invasion/grenzelhoft/l_men_at_arms
	category_tags = list(CTAG_GRENZELHOFT_INVASION)
	maximum_possible_slots = 4

	cmode_music = 'sound/music/cmode/combat_grenzelhoft.ogg'

/datum/outfit/job/roguetown/invasion/grenzelhoft/l_men_at_arms/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, pick(3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, pick(0,0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)

	if(H.gender == FEMALE)
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_SOOT_BLACK
		H.update_body()

	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	pants = /obj/item/clothing/under/roguetown/grenzelpants
	shoes = /obj/item/clothing/shoes/roguetown/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzel
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace/cudgel
	shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
	head = /obj/item/clothing/head/roguetown/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/suit/roguetown/armor/cuirass/grenzelhoft
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/sword/long/greatsword/zwei
	if(!H.has_language(/datum/language/oldpsydonic))
		H.grant_language(/datum/language/oldpsydonic)
		to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")

	H.change_stat("strength", 3)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 3)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/migrant_wave/grenzelhoft_invasion
	name = "The Grenzelhoft Invasion"
	shared_wave_type = /datum/migrant_wave/grenzelhoft_invasion
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/grenzelhoft_invasion_down
	roles = list(
		/datum/migrant_role/grenzelhoft/invasion = 8
	)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a punitive expedition envoy to make the rulers of Vanderlin repent for their insults."

/datum/migrant_wave/grenzelhoft_invasion_down
	name = "The Grenzelhoft Invasion"
	shared_wave_type = /datum/migrant_wave/grenzelhoft_invasion
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/grenzelhoft_invasion_down_one
	roles = list(
		/datum/migrant_role/grenzelhoft/invasion = 7
	)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a punitive expedition envoy to make the rulers of Vanderlin repent for their insults."

/datum/migrant_wave/grenzelhoft_invasion_down_one
	name = "The Grenzelhoft Invasion"
	shared_wave_type = /datum/migrant_wave/grenzelhoft_invasion
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/grenzelhoft_invasion_down_two
	roles = list(
		/datum/migrant_role/grenzelhoft/invasion = 6
	)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a punitive expedition envoy to make the rulers of Vanderlin repent for their insults."

/datum/migrant_wave/grenzelhoft_invasion_down_two
	name = "The Grenzelhoft Invasion"
	shared_wave_type = /datum/migrant_wave/grenzelhoft_invasion
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/grenzelhoft_invasion_down_three
	roles = list(
		/datum/migrant_role/grenzelhoft/invasion = 5
	)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a punitive expedition envoy to make the rulers of Vanderlin repent for their insults."

/datum/migrant_wave/grenzelhoft_invasion_down_three
	name = "The Grenzelhoft Invasion"
	shared_wave_type = /datum/migrant_wave/grenzelhoft_invasion
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/grenzelhoft/invasion = 4
	)
	greet_text = "The Kaiser of the Grenzelhoft Imperiate has sent a punitive expedition envoy to make the rulers of Vanderlin repent for their insults."
