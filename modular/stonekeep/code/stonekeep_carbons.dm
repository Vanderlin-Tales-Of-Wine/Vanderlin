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
	aggressive = TRUE
	mode = AI_IDLE
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
	aggressive = TRUE
	mode = AI_IDLE
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
	aggressive= TRUE
	wander = TRUE
	aggressive= TRUE
	wander = TRUE
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
	aggressive= TRUE
	wander = FALSE


// -------------------		OUTLAW		--------------------------
/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw
//	initial_language_holder = /datum/language_holder/monkey
/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw/after_creation()
	..()
	gender = MALE
	job = "Madman"
	aggressive= TRUE
	wander = TRUE
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


// ===================================================================================
// -------------------		GOBLIN		--------------------------
/mob/living/carbon/human/species/goblin/skilled
	aggressive = TRUE
	mode = AI_IDLE
	dodgetime = 5 SECONDS
	flee_in_pain = TRUE
	canparry = TRUE
	wander = FALSE
	ambushable = FALSE

/mob/living/carbon/human/species/goblin/skilled/ambush
	simpmob_attack = 35
	simpmob_defend = 25
	wander = TRUE
	attack_speed = 2

/mob/living/carbon/human/species/goblin/skilled/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)

/mob/living/carbon/human/species/goblin/skilled/after_creation()
	..()
	configure_mind()
	d_intent = INTENT_PARRY //these ones will parry instead of dodge, the higher the skill the more powerful this is of course
	ADD_TRAIT(src, TRAIT_ZOMBIE_IMMUNE, TRAIT_GENERIC)

/mob/living/carbon/human/species/goblin/skilled/ambush/moon
	name = "moon goblin"
	race = /datum/species/goblin/moon

/mob/living/carbon/human/species/goblin/skilled/ambush/hell
	name = "hell goblin"
	race = /datum/species/goblin/hell
/mob/living/carbon/human/species/goblin/skilledambush/hell/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/npc/goblin)

/*
/mob/living/carbon/human/species/goblin/skilled/hell/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/hellspeak)
*/
/mob/living/carbon/human/species/goblin/skilled/ambush/cave
	name = "cave goblin"
	race = /datum/species/goblin/cave

/mob/living/carbon/human/species/goblin/skilledambush/cave/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/npc/goblin)

/mob/living/carbon/human/species/goblin/skilled/ambush/sea
	name = "sea goblin"
	race = /datum/species/goblin/sea



/* 	Can be put into pre_equip to lessen chance of crits, bit strong despite the low value
	H.skin_armor = new /obj/item/clothing/armor/skin_armor/weak(H)

/obj/item/clothing/armor/skin_armor/weak // since NPCs using crit weakness this is a way to give them a slightly longer life by reducing chance of crits
	slot_flags = null
	name = ""
	desc = ""
	icon_state = null
	body_parts_covered = FULL_BODY
	armor = list("melee" = 3, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
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


/mob/living/carbon/human/species/zizombie/npc_idle()
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))
	if(prob(3))
		playsound(src, pick('modular/stonekeep/sound/vo/mobs/zizombie/zmoan1.ogg','modular/stonekeep/sound/vo/mobs/zizombie/zmoan2.ogg','modular/stonekeep/sound/vo/mobs/zizombie/zmoan3.ogg'), 100, FALSE)



/mob/living/carbon/human/species/zizombie/npc/monk/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/species/zizombie/npc/monk)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = FALSE
	flee_in_pain = FALSE
	wander = TRUE

/mob/living/carbon/human/species/zizombie/npc/prior/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/species/zizombie/npc/prior)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = FALSE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/species/zizombie/npc/monk/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/trou
	armor = /obj/item/clothing/armor/leather/vest/monk
	neck = /obj/item/clothing/neck/monke
	belt = /obj/item/storage/belt/leather/rope
	shoes = /obj/item/clothing/shoes/sandals/geta
	H.TOTALSTR = 14
	H.TOTALSPD = 10
	H.TOTALCON = 10
	H.TOTALEND = 20
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)

/datum/outfit/job/species/zizombie/npc/prior/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/face/kaizoku/menpo/facemask
	armor = /obj/item/clothing/shirt/robe/prior
	wrists = /obj/item/clothing/wrists/bracers/bonebracer
	belt = /obj/item/storage/belt/leather/shalal
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/sandals/geta
	H.TOTALSTR = 15
	H.TOTALSPD = 12
	H.TOTALCON = 10
	H.TOTALEND = 20
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)





/datum/outfit/job/cryptkeeper/pre_equip(mob/living/carbon/human/H) //equipped onto Summon Greater Undead player skeletons only after the mind is added
	..()
	wrists = /obj/item/clothing/wrists/bracers/leather
	armor = /obj/item/clothing/armor/chainmail/iron
	if(prob(50))
		shirt = /obj/item/clothing/shirt/undershirt/vagrant
	else
		shirt = /obj/item/clothing/shirt/undershirt/vagrant/l
	pants = /obj/item/clothing/pants/chainlegs/iron
	head = /obj/item/clothing/head/helmet/leather
	shoes = /obj/item/clothing/shoes/boots

	H.TOTALSTR = rand(14,16)
	H.TOTALSPD = 8
	H.TOTALCON = 9
	H.TOTALEND = 15
	H.TOTALINT = 1

	//light labor skills for skeleton manual labor and some warrior-adventurer skills, equipment is still bad probably
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)

	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)

	H.set_patron(/datum/patron/inhumen/zizo)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

	H.possible_rmb_intents = list(/datum/rmb_intent/feint,\
	/datum/rmb_intent/aimed,\
	/datum/rmb_intent/strong,\
	/datum/rmb_intent/swift,\
	/datum/rmb_intent/riposte,\
	/datum/rmb_intent/weak)
	H.swap_rmb_intent(num=1) //dont want to mess with base NPCs too much out of fear of breaking them so I assigned the intents in the outfit

	if(prob(50))
		r_hand = /obj/item/weapon/sword
	else
		r_hand = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
