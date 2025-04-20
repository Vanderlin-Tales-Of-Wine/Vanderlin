/datum/migrant_role/heartfelt/lord
	name = "Lord of Heartfelt"
	greet_text = "You are the Lord of Heartfelt, ruler of a once-prosperous barony now in ruin. Guided by your Magos, you journey to Vanderlin, seeking aid to restore your domain to its former glory, or perhaps claim a new throne."
	outfit = /datum/outfit/job/heartfelt/lord
	allowed_sexes = list(MALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	grant_lit_torch = TRUE

/datum/outfit/job/heartfelt/lord/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	shirt = /obj/item/clothing/shirt/undershirt
	belt = /obj/item/storage/belt/leather/black
	neck = /obj/item/clothing/neck/gorget
	head = /obj/item/clothing/head/helmet
	shoes = /obj/item/clothing/shoes/nobleboot
	pants = /obj/item/clothing/pants/tights/black
	cloak = /obj/item/clothing/cloak/heartfelt
	armor = /obj/item/clothing/armor/medium/surcoat/heartfelt
	beltr = /obj/item/storage/belt/pouch/coins/rich
	beltl = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/leather/black
	neck = /obj/item/clothing/neck/chaincoif
	beltl = /obj/item/weapon/sword/long
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_LCK, 2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
/datum/migrant_role/heartfelt/lady
	name = "Lady of Heartfelt"
	greet_text = "You are the Lady of Heartfelt, once a respected noblewoman now struggling to survive in a desolate landscape. With your home in ruins, you look to Vanderlin, hoping to find new purpose or refuge amidst the chaos."
	outfit = /datum/outfit/job/heartfelt/lady
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	grant_lit_torch = TRUE

/datum/outfit/job/heartfelt/lady/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/hennin
	neck = /obj/item/storage/belt/pouch/coins/rich
	cloak = /obj/item/clothing/cloak/heartfelt
	if(isdwarf(H))
		armor = /obj/item/clothing/shirt/dress
	else
		if(prob(66))
			armor = /obj/item/clothing/armor/gambeson/heavy/dress/alt
		else
			armor = /obj/item/clothing/armor/gambeson/heavy/dress
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr =  /obj/item/storage/belt/pouch
	ring = /obj/item/clothing/ring/silver
	shoes = /obj/item/clothing/shoes/shortboots
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, 1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_LCK, 2)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
/datum/migrant_role/heartfelt/hand
	name = "Hand of Heartfelt"
	greet_text = "You are the Hand of Heartfelt, burdened by the perception of failure in protecting your Lord's domain. Despite doubts from others, your loyalty remains steadfast as you journey to Vanderlin, determined to fulfill your duties."
	outfit = /datum/outfit/job/heartfelt/hand
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	grant_lit_torch = TRUE

/datum/outfit/job/heartfelt/hand/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/undershirt
	belt = /obj/item/storage/belt/leather/black
	shoes = /obj/item/clothing/shoes/nobleboot
	pants = /obj/item/clothing/pants/tights/black
	neck = /obj/item/clothing/neck/gorget
	armor = /obj/item/clothing/armor/medium/surcoat/heartfelt
	beltr = /obj/item/storage/belt/pouch/coins/rich
	gloves = /obj/item/clothing/gloves/leather/black
	beltl = /obj/item/weapon/sword/decorated
	beltr = /obj/item/scomstone
	backr = /obj/item/storage/backpack/satchel/heartfelt
	mask = /obj/item/clothing/face/spectacles/golden
	neck = /obj/item/clothing/neck/chaincoif
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_INT, 3)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander3.ogg'

/datum/migrant_role/heartfelt/knight
	name = "Knight of Heartfelt"
	greet_text = "You are a Knight of Heartfelt, once part of a brotherhood in service to your Lord. Now, alone and committed to safeguarding what remains of your court, you ride to Vanderlin, resolved to ensure their safe arrival."
	outfit = /datum/outfit/job/heartfelt/knight
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	grant_lit_torch = TRUE
/datum/outfit/job/heartfelt/knight/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet
	gloves = /obj/item/clothing/gloves/plate
	pants = /obj/item/clothing/pants/platelegs
	cloak = /obj/item/clothing/cloak/tabard/knight/guard
	neck = /obj/item/clothing/neck/bevor
	shirt = /obj/item/clothing/armor/chainmail
	armor = /obj/item/clothing/armor/plate/full
	shoes = /obj/item/clothing/shoes/boots/armor
	beltr = /obj/item/weapon/sword/long
	beltl = /obj/item/flashlight/flare/torch/lantern
	belt = /obj/item/storage/belt/leather/steel
	backr = /obj/item/storage/backpack/satchel/black
	if(prob(50))
		r_hand = /obj/item/weapon/polearm/eaglebeak/lucerne
	else
		r_hand = /obj/item/weapon/mace/goden/steel
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'
/datum/migrant_role/heartfelt/knight/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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
			S.name = "knight tabard ([index])"
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Sir"
		if(H.gender == FEMALE)
			honorary = "Dame"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
/datum/migrant_role/heartfelt/magos
	name = "Magos of Heartfelt"
	greet_text = "You are the Magos of Heartfelt, renowned for your arcane knowledge yet unable to foresee the tragedy that befell your home. Drawn by a guiding star to Vanderlin, you seek answers and perhaps a new purpose in the wake of destruction."
	outfit = /datum/outfit/job/heartfelt/magos
	allowed_races = list("Humen")
	grant_lit_torch = TRUE

/datum/outfit/job/heartfelt/magos
	allowed_patrons = list(/datum/patron/divine/noc)
/datum/outfit/job/heartfelt/magos/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/talkstone
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/shirt/robe/black
	pants = /obj/item/clothing/pants/tights/random
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/book/granter/spellbook/expert
	ring = /obj/item/clothing/ring/gold
	r_hand = /obj/item/weapon/polearm/woodstaff
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/reagent_containers/glass/bottle/poison,/obj/item/reagent_containers/glass/bottle/healthpot)
	ADD_TRAIT(H, TRAIT_SEEPRICES, "[type]")
	H.cmode_music = 'sound/music/cmode/nobility/CombatCourtMagician.ogg'
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_CON, -1)
		H.change_stat(STATKEY_INT, 4)
		if(H.age == AGE_OLD)
			H.change_stat(STATKEY_SPD, -1)
			H.change_stat(STATKEY_PER, 1)
			if(ishumannorthern(H))
				belt = /obj/item/storage/belt/leather/plaquegold
				cloak = null
				head = /obj/item/clothing/head/wizhat
				armor = /obj/item/clothing/shirt/robe/wizard
				H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
		var/list/spells = list(/obj/effect/proc_holder/spell/invoked/projectile/fireball/greater, /obj/effect/proc_holder/spell/invoked/projectile/fireball, /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt, /obj/effect/proc_holder/spell/invoked/projectile/fetch)
		for(var/S in spells)
			H.mind.AddSpell(new S)
/datum/migrant_role/heartfelt/prior
	name = "Prior of Heartfelt"
	greet_text = "The Prior of Heartfelt, you were destined for ascension within the Church, but fate intervened with the barony's downfall, delaying it indefinitely. Still guided by the blessings of Astrata, you journey to Vanderlin, determined to offer what aid and solace you can."
	outfit = /datum/outfit/job/heartfelt/prior
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	grant_lit_torch = TRUE
/datum/outfit/job/heartfelt/prior
	allowed_patrons = list(/datum/patron/divine/astrata)
/datum/outfit/job/heartfelt/prior/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE
	neck = /obj/item/clothing/neck/psycross/silver
	shirt = /obj/item/clothing/shirt/undershirt/priest
	pants = /obj/item/clothing/pants/tights/black
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/storage/belt/pouch/coins/mid
	armor = /obj/item/clothing/shirt/robe/priest
	cloak = /obj/item/clothing/cloak/chasuble
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/needle/blessed = 1,
	)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_CON, -1)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, -1)
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.grant_spells_priest(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

/datum/migrant_wave/heartfelt
	name = "The Court of Heartfelt"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	weight = 25
	downgrade_wave = /datum/migrant_wave/heartfelt_down
	roles = list(
		/datum/migrant_role/heartfelt/lord = 1,
		/datum/migrant_role/heartfelt/lady = 1,
		/datum/migrant_role/heartfelt/hand = 1,
		/datum/migrant_role/heartfelt/knight = 1,
		/datum/migrant_role/heartfelt/magos = 1,
		/datum/migrant_role/heartfelt/prior = 1,
	)
	greet_text = "Fleeing disaster, you have come together as a court, united in a final effort to restore the former glory and promise of Heartfelt. Stay close and watch out for each other, for all of your sakes!"
/datum/migrant_wave/heartfelt_down
	name = "The Court of Heartfelt"
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/heartfelt/lord = 1,
		/datum/migrant_role/heartfelt/lady = 1,
		/datum/migrant_role/heartfelt/hand = 1,
	)
	greet_text = "Fleeing disaster, you have come together as a court, united in a final effort to restore the former glory and promise of Heartfelt. Stay close and watch out for each other, for all of your sakes! Your Knight, Magos and Prior died on the way here..."
