// ===================================================================================
/mob/living/carbon/human/species/skeleton/after_creation()
	..()
	QDEL_NULL(sexcon)

// -------------------		SKELLY SKILLED CORE		--------------------------
/datum/outfit/job/roguetown/species/skeleton/skilled/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = rand(6,8)
	H.STASPD = rand(8,10)
	H.STACON = rand(8,10)
	H.STAEND = 12
	H.STAINT = 1

/mob/living/carbon/human/species/skeleton/skilled/after_creation()
	..()
	configure_mind()
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	d_intent = INTENT_PARRY //these ones will parry instead of dodge, the higher the skill the more powerful this is of course
	dodgetime = 2 SECONDS
	canparry = TRUE
	flee_in_pain = FALSE
	wander = FALSE
	ambushable = FALSE

/mob/living/carbon/human/species/skeleton/skilled/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)

// -------------------		UNARMED SKELLY		--------------------------
/mob/living/carbon/human/species/skeleton/skilled/unarmed
	name = "animated skeleton"

/mob/living/carbon/human/species/skeleton/skilled/unarmed/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/species/skeleton/skilled/unarmed)

/datum/outfit/job/roguetown/species/skeleton/skilled/unarmed/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(50))
		belt = /obj/item/storage/belt/leather/rope
	if(prob(50))
		shirt = /obj/item/clothing/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/shirt/undershirt/vagrant/l

	if(prob(50))
		pants = /obj/item/clothing/pants/tights/vagrant
	if(prob(50))
		pants = /obj/item/clothing/pants/tights/vagrant/l

	if(prob(20))
		r_hand = /obj/item/natural/stone
	if(prob(10))
		r_hand = /obj/item/weapon/knife/stone
	if(prob(10))
		r_hand = /obj/item/weapon/mace/woodclub

// -------------------		FIGHTER SKELLY		--------------------------
/mob/living/carbon/human/species/skeleton/skilled/fighter
	name = "animated skeleton"

/mob/living/carbon/human/species/skeleton/skilled/fighter/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/species/skeleton/skilled/fighter)

/mob/living/carbon/human/species/skeleton/skilled/fighter/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)

/datum/outfit/job/roguetown/species/skeleton/skilled/fighter/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 10
	H.STACON = 11
	var/loadout = rand(1,3)
	if(prob(50))
		belt = /obj/item/storage/belt/leather/rope
	if(prob(50))
		belt = /obj/item/storage/belt/leather

	if(prob(50))
		shirt = /obj/item/clothing/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/shirt/undershirt/vagrant/l

	if(prob(50))
		pants = /obj/item/clothing/pants/tights/vagrant
	if(prob(50))
		pants = /obj/item/clothing/pants/tights/vagrant/l

	if(prob(50))
		wrists = /obj/item/clothing/wrists/bracers/leather

	if(prob(30))
		armor = /obj/item/clothing/armor/chainmail/iron

	if(prob(30))
		armor = /obj/item/clothing/armor/leather

	if(prob(40))
		armor = /obj/item/clothing/armor/cuirass/iron/rust

	switch(loadout)
		if(1)
			r_hand = /obj/item/weapon/sword/scimitar
			l_hand = /obj/item/weapon/shield/wood
			head = /obj/item/clothing/head/helmet/leather/conical
		if(2)
			r_hand = /obj/item/weapon/mace
			l_hand = /obj/item/weapon/shield/wood
			neck = /obj/item/clothing/neck/coif
			head = /obj/item/clothing/head/helmet/skullcap
		if(3)
			r_hand = /obj/item/weapon/flail
			l_hand = /obj/item/weapon/shield/wood
			neck = /obj/item/clothing/neck/chaincoif


/mob/living/carbon/human/species/skeleton/skilled/ancient
	name = "ancient skeleton"
	skel_outfit = /datum/outfit/job/ancient_skeleton

/mob/living/carbon/human/species/skeleton/skilled/ancient/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)

/datum/outfit/job/ancient_skeleton/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 12
	H.TOTALSTR = rand(13,14)
	H.TOTALSPD = 8
	H.TOTALCON = 9
	H.TOTALEND = 15
	H.TOTALINT = 1



// ===================================================================================
// -------------------		ORC SKILLED CORE		--------------------------
/mob/living/carbon/human/species/orc/skilled
	initial_language_holder = /datum/language_holder/orc

/datum/outfit/job/roguetown/species/orc/skilled/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 13
	H.STASPD = 9
	H.STACON = 13
	H.STAEND = 13
	H.STAINT = 6


/mob/living/carbon/human/species/orc/skilled/after_creation()
	..()
	configure_mind()
	d_intent = INTENT_PARRY //these ones will parry instead of dodge, the higher the skill the more powerful this is of course
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ZOMBIE_IMMUNE, TRAIT_GENERIC)
	dodgetime = 2 SECONDS
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE
	ambushable = FALSE
	hair_color = "#1f1d1d"
	hairstyle = "Forsaken"

/mob/living/carbon/human/species/orc/skilled/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)

/datum/outfit/job/roguetown/npc/orc/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/tribalrag
	pants =	/obj/item/clothing/pants/loincloth/brown


// -------------------		SAVAGE ORC		--------------------------
/mob/living/carbon/human/species/orc/skilled/savage
	name = "savage orc"

/mob/living/carbon/human/species/orc/skilled/savage/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/savage)

/datum/outfit/job/roguetown/npc/orc/savage/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/tribalrag
	pants =	/obj/item/clothing/pants/loincloth/brown
	if(prob(20))
		armor = /obj/item/clothing/armor/leather/hide/orc
	if(prob(20))
		cloak = /obj/item/clothing/cloak/raincloak/brown
	if(prob(50))
		shoes = /obj/item/clothing/shoes/boots/furlinedanklets
	if(prob(20))
		head = /obj/item/clothing/head/helmet/leather

	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Dual Axe Warrior
			r_hand = /obj/item/weapon/axe/stone
		if(2) //Long Club Caveman
			r_hand = /obj/item/weapon/polearm/woodstaff
		if(3) //Club Caveman
			r_hand = /obj/item/weapon/mace/woodclub
		if(4) //dagger fighter
			r_hand = /obj/item/weapon/knife/stone
			l_hand = /obj/item/weapon/knife/stone
		if(5) //Spear hunter
			r_hand = /obj/item/weapon/polearm/spear/stone

// -------------------		SAVAGE ORC LOOTER		--------------------------
/mob/living/carbon/human/species/orc/skilled/looter
	name = "savage orc looter"

/mob/living/carbon/human/species/orc/skilled/looter/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/looter)

/datum/outfit/job/roguetown/npc/orc/looter/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/tribalrag
	pants =	/obj/item/clothing/pants/loincloth/brown
	if(prob(30))
		pants = /obj/item/clothing/pants/trou/leather
	if(prob(50))
		shoes = /obj/item/clothing/shoes/boots/furlinedboots
	if(prob(20))
		head = /obj/item/clothing/head/helmet/leather


	var/loadout = rand(1,4)
	switch(loadout)
		if(1)
			r_hand = /obj/item/weapon/pick/paxe
			armor = /obj/item/clothing/armor/cuirass/iron
			head = /obj/item/clothing/head/helmet/orc
		if(2)
			r_hand = /obj/item/weapon/flail
			l_hand = /obj/item/weapon/shield/wood
			armor = /obj/item/clothing/armor/leather/hide/orc
			head = /obj/item/clothing/head/helmet/orc
		if(3)
			r_hand = /obj/item/weapon/sword/scimitar/messer
			armor = /obj/item/clothing/armor/chainmail/iron
			head = /obj/item/clothing/head/helmet/leather/minershelm
		if(4)
			r_hand = /obj/item/weapon/mace/spiked
			l_hand = /obj/item/weapon/shield/wood
			armor = /obj/item/clothing/armor/plate/orc
			head = /obj/item/clothing/head/helmet/orc

// -------------------		SAVAGE ORC CHIEFTAIN		--------------------------
/mob/living/carbon/human/species/orc/skilled/savage_chieftain
	name = "savage orc chieftain"

/mob/living/carbon/human/species/orc/skilled/savage_chieftain/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/savage_chieftain)

/mob/living/carbon/human/species/orc/skilled/savage_chieftain/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)

/datum/outfit/job/roguetown/npc/orc/savage_chieftain/pre_equip(mob/living/carbon/human/H)
	..()
	pants =	/obj/item/clothing/pants/chainlegs
	if(prob(50))
		pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots/armor
	gloves = /obj/item/clothing/gloves/chain
	neck = /obj/item/clothing/neck/chaincoif
	mask = /obj/item/clothing/face/skullmask

	var/loadout = rand(1,5)
	switch(loadout)
		if(1)
			r_hand = /obj/item/weapon/mace/steel/morningstar
			l_hand = /obj/item/weapon/sword/scimitar/messer
			armor = /obj/item/clothing/armor/chainmail/hauberk
			head = /obj/item/clothing/head/helmet/orc/warlord
		if(2)
			r_hand = /obj/item/weapon/sword/scimitar/falchion
			l_hand = /obj/item/weapon/shield/tower
			armor = /obj/item/clothing/armor/plate/orc/warlord
			head = /obj/item/clothing/head/helmet/orc/warlord
		if(3)
			r_hand = /obj/item/weapon/flail/sflail
			l_hand = /obj/item/weapon/shield/wood
			armor = /obj/item/clothing/armor/plate/orc/warlord
			head = /obj/item/clothing/head/helmet/orc/warlord
		if(4)// WE DON'T WANNA GO TO WAR TODAY BUT THE LORD OF THE LASH SAYS "NAY NAY NAY!!" WE'RE GONNA MARCH ALL DAE, ALL DAE, ALL DAE! WHERE THERE'S A WHIP THERE'S A WAY!!
			r_hand = /obj/item/weapon/whip/antique
			l_hand = /obj/item/weapon/sword/short
			armor = /obj/item/clothing/armor/plate/orc/warlord
			head = /obj/item/clothing/head/helmet/orc/warlord

/mob/living/simple_animal/hostile/orc/savage
	name = "savage orc"
	desc = ""
	icon = 'modular/stonekeep/icons/mobs/orcs.dmi'
	icon_state = "sorc1"
	icon_living = "sorc1"
	icon_dead = "sorc1"
	var/base_icon_state = "sorc"
	maxHealth = 170
	health = 170
	base_intents = list(/datum/intent/simple/spear)
	melee_damage_lower = 25
	melee_damage_upper = 30
	armor_penetration = 20
	attack_verb_continuous = list("stabs", "slashes", "skewers")
	attack_verb_simple = "stab"
	attack_sound = 'sound/blank.ogg'
	loot = list(/obj/effect/mob_spawn/human/orc/corpse/savageorc,
			/obj/item/weapon/polearm/spear/bonespear,
			/obj/effect/decal/cleanable/blood)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	speak = list("GRAAH!", "Kro!", "Bashmagh Kah!", "Zholem!", "Haha! Mogush!")
/mob/living/simple_animal/hostile/orc/savage/Initialize()
	. = ..()
	icon_state = "[base_icon_state][rand(1,4)]"
	icon_living = "[base_icon_state][rand(1,4)]"
	icon_dead = "[base_icon_state][rand(1,4)]"

/mob/living/simple_animal/hostile/orc/savage/looter
	name = "savage orc looter"
	icon_state = "lorc1"
	base_icon_state = "lorc"
	maxHealth = 200
	health = 200
	base_intents = list(/datum/intent/simple/axe)
	melee_damage_lower = 30
	melee_damage_upper = 30
	armor_penetration = 30
	loot = list(/obj/effect/mob_spawn/human/orc/corpse/savageorc,
			/obj/item/weapon/polearm/spear/bonespear,
			/obj/effect/decal/cleanable/blood)
/mob/living/simple_animal/hostile/orc/savage/looter/Initialize()
	. = ..()
	if(icon_state == "lorc2")
		loot = list(/obj/effect/mob_spawn/human/orc/corpse/savageorc,
				/obj/item/weapon/knife/stone,
				/obj/effect/decal/cleanable/blood)
	if(icon_state == "lorc3")
		loot = list(/obj/effect/mob_spawn/human/orc/corpse/savageorc,
				/obj/item/weapon/pick/paxe,
				/obj/effect/decal/cleanable/blood)
	if(icon_state == "lorc4")
		loot = list(/obj/effect/mob_spawn/human/orc/corpse/savageorc,
				/obj/item/weapon/axe,
				/obj/effect/decal/cleanable/blood)

/mob/living/simple_animal/hostile/orc/savage/chopper
	icon_state = "corc1"
	base_icon_state = "corc"
	base_intents = list(/datum/intent/simple/axe)
	melee_damage_lower = 30
	melee_damage_upper = 30
	armor_penetration = 10
	attack_verb_continuous = list("smashes", "slashes", "smacks")
	attack_verb_simple = "clubs"
	loot = list(/obj/effect/mob_spawn/human/orc/corpse/savageorc2,
			/obj/item/weapon/mace/woodclub,
			/obj/effect/decal/cleanable/blood)

/mob/living/simple_animal/hostile/orc/savage/bow
	name = "savage orc archer"
	icon_state = "borc1"
	base_icon_state = "borc"
	projectiletype = /obj/projectile/bullet/reusable/arrow/orc
	projectilesound = 'sound/combat/Ranged/flatbow-shot-01.ogg'
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	ranged_cooldown_time = 60
	check_friendly_fire = 1
	loot = list(/obj/effect/mob_spawn/human/orc/corpse/savageorc2,
			/obj/item/gun/ballistic/revolver/grenadelauncher/bow,
			/obj/item/ammo_casing/caseless/arrow = 3,
			/obj/effect/decal/cleanable/blood)
	maxHealth = 100
	health = 100

	can_have_ai = FALSE //disable native ai
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/orc_ranged
// ===================================================================================

/datum/job/stonekeep/madman
	title = "Madman"

/mob/living/carbon/human/species/human/northern/bum
	dodgetime = 3 SECONDS
	var/outlaw
	var/minded

/mob/living/carbon/human/species/human/northern/bum/ambush
	dodgetime = 5 SECONDS

/mob/living/carbon/human/species/human/northern/bum/ambush/outlaw
	outlaw = TRUE
/mob/living/carbon/human/species/human/northern/bum/ambush/outlaw/after_creation()
	..()
	gender = MALE
	job = "Madman"
	equipOutfit(new /datum/outfit/job/roguetown/human_npc/outlaw)

/datum/outfit/job/roguetown/human_npc/skilled/pre_equip(mob/living/carbon/human/H)
	H.STASTR = rand(8,10)
	H.STASPD = rand(8,10)
	H.STACON = rand(8,10)
	H.STAEND = rand(8,10)
	H.STAINT = 7

/mob/living/carbon/human/species/human/northern/bum/skilled
	minded = TRUE
/mob/living/carbon/human/species/human/northern/bum/skilled/after_creation(mob/living/carbon/C)
	..()
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ZOMBIE_IMMUNE, TRAIT_GENERIC)
	configure_mind()
	d_intent = INTENT_PARRY //these ones will parry instead of dodge, the higher the skill the more powerful this is of course

	dodgetime = 4 SECONDS
	canparry = TRUE

/mob/living/carbon/human/species/human/northern/bum/skilled/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)


// -------------------		BUM		--------------------------
/mob/living/carbon/human/species/human/northern/bum/skilled/madman/after_creation()
	..()
	job = "Beggar"
	wander = FALSE

// -------------------		OUTLAW		--------------------------
/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw
//	initial_language_holder = /datum/language_holder/monkey
/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw/after_creation()
	..()
	gender = MALE
	job = "Madman"
	equipOutfit(new /datum/outfit/job/roguetown/human_npc/outlaw)


/datum/outfit/job/roguetown/human_npc/outlaw/post_equip(mob/living/carbon/human/H)
	..()
	H.real_name = "Outlaw"
	H.name = "Outlaw"

/datum/outfit/job/roguetown/human_npc/outlaw/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = 10
	H.STAEND = 10

	shirt = /obj/item/clothing/shirt/undershirt/vagrant
	if(prob(30))
		shirt = /obj/item/clothing/shirt/undershirt/vagrant/l
	if(prob(30))
		shirt = /obj/item/clothing/shirt/undershirt/random
	pants = /obj/item/clothing/pants/tights/random
	if(prob(30))
		pants = /obj/item/clothing/pants/tights/vagrant
	if(prob(30))
		pants = /obj/item/clothing/pants/tights/vagrant/l
	shoes = /obj/item/clothing/shoes/simpleshoes
	if(prob(30))
		shoes = /obj/item/clothing/shoes/boots
	if(prob(30))
		belt = /obj/item/storage/belt/leather/rope
		beltl = /obj/item/weapon/knife/villager
	if(prob(10))
		belt = /obj/item/storage/belt/leather
		beltr = /obj/item/reagent_containers/powder/moondust
	if(prob(10))
		cloak = /obj/item/clothing/cloak/raincloak/brown
	if(prob(10))
		cloak = /obj/item/clothing/cloak/wickercloak
	if(prob(10))
		gloves = /obj/item/clothing/gloves/fingerless
	if(prob(10))
		wrists = /obj/item/clothing/wrists/bracers/leather
	if(prob(10))
		neck = /obj/item/storage/belt/pouch/coins/poor
	if(prob(10))
		neck = /obj/item/clothing/neck/bogcowl
	if(prob(10))
		head = /obj/item/clothing/face/facemask/prisoner

	var/headgear = rand(1,6)
	switch(headgear)
		if(1)
			head = /obj/item/clothing/head/knitcap
			mask = /obj/item/clothing/face/shepherd
		if(2)
			head = /obj/item/clothing/head/strawhat
			mask = /obj/item/clothing/face/shepherd/rag
		if(3)
			head = /obj/item/clothing/head/menacing
		if(4)
			head = /obj/item/clothing/head/armingcap
		if(5)
			head = /obj/item/clothing/head/helmet/leather
		if(6)
			head = /obj/item/clothing/head/roguehood/uncolored

	var/wornarmor = rand(1,5)
	switch(wornarmor)
		if(1)
			armor = /obj/item/clothing/armor/gambeson/light
			pants = /obj/item/clothing/pants/trou
		if(2)
			armor = /obj/item/clothing/shirt/rags
			pants = /obj/item/clothing/pants/trou/leather
		if(3)
			armor = /obj/item/clothing/armor/gambeson
		if(4)
			armor = /obj/item/clothing/armor/leather/vest
			neck = /obj/item/clothing/neck/coif
		if(5)
			armor = /obj/item/clothing/armor/leather/jacket

	var/wieldweapon = rand(1,6)
	switch(wieldweapon)
		if(1)
			r_hand = /obj/item/weapon/axe/iron
		if(2)
			r_hand = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
		if(3)
			r_hand = /obj/item/weapon/mace/copperbludgeon
		if(4)
			r_hand =/obj/item/weapon/polearm/woodstaff/quarterstaff/iron
		if(5)
			r_hand = /obj/item/weapon/thresher/military
		if(6)
			r_hand = /obj/item/weapon/sword/short
			l_hand = /obj/item/weapon/shield/wood




/*
/mob/living/carbon/human/species/goblin/skilled/hell/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/hellspeak)
*/


// ===================================================================================
/*	..................	Zizombie Modifications   ................... */
/mob/living/carbon/human/species/zizombie
	icon = 'modular/stonekeep/icons/mobs/zizombie.dmi'
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw)
	possible_mmb_intents = list(INTENT_STEAL, INTENT_JUMP, INTENT_KICK, INTENT_BITE)
	possible_rmb_intents = list(/datum/rmb_intent/feint, /datum/rmb_intent/swift, /datum/rmb_intent/riposte, /datum/rmb_intent/weak)
	a_intent = INTENT_HELP
	attack_speed = 2

/mob/living/carbon/human/species/zizombie/after_creation()
	..()
	QDEL_NULL(sexcon)

/*
/mob/living/carbon/human/species/zizombie/npc_idle()
	playsound(src, pick('modular/stonekeep/sound/vo/mobs/zizombie/zmoan1.ogg','modular/stonekeep/sound/vo/mobs/zizombie/zmoan2.ogg','modular/stonekeep/sound/vo/mobs/zizombie/zmoan3.ogg'), 100, FALSE)
*/


/mob/living/simple_animal/hostile/zizombie
	name = "zizombie"
	desc = ""
	icon = 'modular/stonekeep/icons/mobs/zizombie.dmi'
	icon_state = "zombie1"
	icon_living = "zombie1"
	icon_dead = "zombie_dead"
	gender = MALE
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = 1
	speak_chance = 5
	turns_per_move = 1
	move_to_delay = 1
	TOTALCON = 14
	TOTALSTR = 12
	TOTALSPD = 10
	maxHealth = 180
	health = 180
	harm_intent_damage = 15
	melee_damage_lower = 22
	melee_damage_upper = 27
	vision_range = 7
	aggro_vision_range = 9
	retreat_distance = 0
	minimum_distance = 0
	limb_destroyer = 1
	base_intents = list(/datum/intent/simple/claw)
	attack_verb_continuous = "rips"
	attack_verb_simple = "rend"
	attack_sound = 'sound/combat/wooshes/bladed/wooshmed (1).ogg'
	dodge_sound = 'sound/combat/dodge.ogg'
	canparry = FALSE
	candodge = TRUE
	dodge_prob = 15
	d_intent = INTENT_DODGE
	speak_emote = list("moans")
	faction = list("Zizo")
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	del_on_death = FALSE

	can_have_ai = FALSE //disable native ai
	AIStatus = AI_OFF
	ai_controller = /datum/ai_controller/orc

	remains_type = /obj/effect/decal/remains/neu/human

/mob/living/simple_animal/hostile/zizombie/Initialize()
	. = ..()
	if(icon_state == "zombie1")
		icon_state = "zombie[rand(1,4)]"
		icon_living = "[icon_state]"

/mob/living/simple_animal/hostile/zizombie/Life()
	. = ..()
	if(!target)
		if(prob(3))
			emote(pick( "moan"), TRUE)

/mob/living/simple_animal/hostile/zizombie/get_sound(input)
	switch(input)
		if("moan")
			return pick('sound/vo/mobs/zombie/idle (1).ogg','sound/vo/mobs/zombie/idle (2).ogg','sound/vo/mobs/zombie/idle (3).ogg')
		if("death")
			return pick('sound/vo/mobs/zombie/death (1).ogg','sound/vo/mobs/zombie/death (2).ogg','sound/vo/mobs/zombie/death (3).ogg')
		if("aggro")
			return pick('sound/vo/mobs/zombie/firescream (1).ogg','sound/vo/mobs/zombie/firescream (2).ogg','sound/vo/mobs/zombie/firescream (3).ogg')

/mob/living/simple_animal/hostile/zizombie/death(gibbed)
	emote("death")
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/effect/decal/remains/neu/human(deathspot)
	update_icon()
	sleep(10)
	qdel(src)


/mob/living/simple_animal/hostile/zizombie/monk
	name = "zizombie monk"
	icon_state = "zizombie_monk"
	icon_living = "zizombie_monk"

/mob/living/simple_animal/hostile/zizombie/prior
	name = "zizombie prior"
	icon_state = "zizombie_prior"
	icon_living = "zizombie_prior"



// ===================================================================================
/*	..................	The Insane Jester   ................... */

/mob/living/carbon/human/species/abyssariad/ogrun/insane
	ai_controller = /datum/ai_controller/human_bum/aggressive
	faction = list("xylix")
	ambushable = FALSE
	dodgetime = 10
	flee_in_pain = FALSE
	possible_rmb_intents = list()
	wander = FALSE

/mob/living/carbon/human/species/abyssariad/ogrun/insane/Initialize()
	. = ..()
	AddElement(/datum/element/ai_retaliate)

/mob/living/carbon/human/species/abyssariad/ogrun/insane/after_creation()
	..()
	job = "Madman"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/xylixjester)
	configure_mind()
	d_intent = INTENT_PARRY //these ones will parry instead of dodge, the higher the skill the more powerful this is of course
	real_name = "The Mad Piper"
	name = "The Mad Piper"

/mob/living/carbon/human/species/abyssariad/ogrun/insane/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 5, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)

/datum/outfit/job/xylixjester/pre_equip(mob/living/carbon/human/H)
	..()
	H.STASTR = rand(10,18)
	H.STASPD = rand(9,18)
	H.STACON = rand(8,18)
	H.STAEND = rand(8,18)
	H.STALUC = 18
	H.STAINT = 7
	H.set_patron(/datum/patron/divine/xylix)

/obj/item/clothing/head/jester/artefact
	name = "blessed jester hat"
	desc = "Keeps funny people warm, and perhaps safe. If Xylix feels like it."
	adventurer_artefact = TRUE
	armor = ARMOR_PADDED_GOOD
	max_integrity = INTEGRITY_STRONG
	body_parts_covered = FULL_BODY

/obj/item/clothing/head/jester/artefact/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(user.patron == /datum/patron/divine/xylix)
		if(slot == SLOT_HEAD && istype(user))
			user.apply_status_effect(/datum/status_effect/buff/xylix_cap)
			body_parts_covered = FULL_BODY
		else
			user.remove_status_effect(/datum/status_effect/buff/xylix_cap)

	else
		body_parts_covered = COVERAGE_SKULL
		return

/obj/item/clothing/head/jester/artefact/dropped(mob/living/user, slot)
	. = ..()
	user.remove_status_effect(/datum/status_effect/buff/xylix_cap)

/datum/status_effect/buff/xylix_cap
	id = "xylixcap"
	alert_type = /atom/movable/screen/alert/status_effect/buff/xylix_cap
	effectedstats = list("luck" = 2)
	duration = 180 MINUTES

/atom/movable/screen/alert/status_effect/buff/xylix_cap
	name = "I feel lucky"
	desc = "<span class='nicegreen'>My hat attracts lucky waves from Xylix...</span>\n"
	icon = 'icons/mob/actions/roguespells.dmi'
	icon_state = ""
