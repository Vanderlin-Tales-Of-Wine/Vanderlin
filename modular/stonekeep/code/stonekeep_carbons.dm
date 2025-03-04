// ===================================================================================
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
	wander = TRUE
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
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather

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


// ===================================================================================
// -------------------		ORC SKILLED CORE		--------------------------
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


/mob/living/carbon/human/species/orc/skilled/after_creation(mob/living/carbon/C)
	..()
	C.remove_all_languages()
	C.grant_language(/datum/language/orcish)
	to_chat(C, "<span class='info'>I can speak Orcish with ,g before my speech.</span>")


// -------------------		SAVAGE ORC		--------------------------
/mob/living/carbon/human/species/orc/skilled/savage
	name = "savage orc"

/mob/living/carbon/human/species/orc/skilled/savage/after_creation()
	..()
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/savage)

/datum/outfit/job/roguetown/npc/orc/savage/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(20))
		armor = /obj/item/clothing/armor/leather/hide/orc
	if(prob(20))
		pants =	/obj/item/clothing/pants/loincloth/brown
	if(prob(20))
		cloak = /obj/item/clothing/cloak/raincloak/brown
	if(prob(20))
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
	if(prob(20))
		pants =	/obj/item/clothing/pants/loincloth/brown
	if(prob(20))
		pants = /obj/item/clothing/pants/trou/leather

	if(prob(20))
		shoes = /obj/item/clothing/shoes/boots/furlinedanklets
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
	if(prob(20))
		pants =	/obj/item/clothing/pants/loincloth/brown
	if(prob(20))
		pants = /obj/item/clothing/pants/trou/leather

	if(prob(20))
		shoes = /obj/item/clothing/shoes/boots/furlinedanklets
	if(prob(20))
		head = /obj/item/clothing/head/helmet/leather

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
/*
/mob/living/carbon/human/species/human/northern/bum/skilled
	race = /datum/species/human/northern/npc

/datum/species/human/northern/npc
	armor = list("melee" = 3, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
*/

GLOBAL_LIST_INIT(outlaw_quotes, world.file2list("strings/rt/outlawlines.txt"))
GLOBAL_LIST_INIT(outlaw_aggro, world.file2list("strings/rt/outlawaggrolines.txt"))

/mob/living/carbon/human/species/human/northern/bum
	aggressive=0
	mode = AI_IDLE
	faction = list("bums", "station")
	ambushable = FALSE
	dodgetime = 3 SECONDS
	flee_in_pain = TRUE
	possible_rmb_intents = list()

	wander = FALSE
	var/outlaw

/mob/living/carbon/human/species/human/northern/bum/ambush
	aggressive=1
	wander = TRUE
	dodgetime = 5 SECONDS

/datum/outfit/job/roguetown/human_npc/skilled/pre_equip(mob/living/carbon/human/H)
	H.STASTR = rand(8,10)
	H.STASPD = rand(8,10)
	H.STACON = rand(8,10)
	H.STAEND = rand(8,10)
	H.STAINT = 7

/mob/living/carbon/human/species/human/northern/bum/skilled/after_creation(mob/living/carbon/C)
	..()
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ZOMBIE_IMMUNE, TRAIT_GENERIC)
	configure_mind()
	d_intent = INTENT_PARRY //these ones will parry instead of dodge, the higher the skill the more powerful this is of course
	aggressive = FALSE
	mode = AI_IDLE
	dodgetime = 4 SECONDS
	canparry = TRUE

	flee_in_pain = TRUE
	wander = FALSE
	ambushable = FALSE
	faction = list("bums", "station")
	C.grant_language(/datum/language/common)

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
/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw/after_creation()
	..()
	job = "Beggar"
	aggressive= TRUE
	wander = TRUE
	equipOutfit(new /datum/outfit/job/roguetown/human_npc/skilled/outlaw)
	outlaw = TRUE	// just for the right say strings

/datum/outfit/job/roguetown/human_npc/skilled/outlaw
	name = "Outlaw"

/datum/outfit/job/roguetown/human_npc/skilled/outlaw/pre_equip(mob/living/carbon/human/H)
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
		gloves = /obj/item/clothing/gloves/fingerless
	if(prob(10))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(10))
		neck = /obj/item/storage/belt/pouch/coins/poor

	var/head = rand(1,6)
	switch(head)
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

	var/armor = rand(1,5)
	switch(armor)
		if(1)
			armor = /obj/item/clothing/armor/gambeson/light
			pants = /obj/item/clothing/pants/trou/leather
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

	var/weapon = rand(1,6)
	switch(weapon)
		if(1)
			r_hand = /obj/item/weapon/axe/iron
		if(2)
			r_hand = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
		if(3)
			r_hand = /obj/item/weapon/mace/copperbludgeon
		if(4)
			r_hand =/obj/item/weapon/pitchfork
		if(5)
			r_hand = /obj/item/weapon/thresher/military
		if(6)
			r_hand = /obj/item/weapon/sword/short


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

/mob/living/carbon/human/species/goblin/skilled/hell/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/hellspeak)

/mob/living/carbon/human/species/goblin/skilled/ambush/cave
	name = "cave goblin"
	race = /datum/species/goblin/cave

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
/datum/intent/simple/trollsmash
	name = "trollsmash"
	icon_state = "instrike"
	attack_verb = list("hammer-punches", "smashes", "headbutts", "rams")
	animname = "blank22"
	blade_class = BCLASS_BLUNT
	hitsound = "punch_hard"
	chargetime = 0
	penfactor = 13
	swingdelay = 4 SECONDS
	candodge = TRUE
	canparry = FALSE

/*
/mob/living/simple_animal/hostile/retaliate/troll
	base_intents = list(/datum/intent/simple/trollrip, /datum/intent/simple/trollsmash)

/mob/living/simple_animal/hostile/retaliate/trollbog
	base_intents = list(/datum/intent/simple/trollsmash, /datum/intent/simple/trollrip)

/mob/living/simple_animal/hostile/retaliate/wolf
	base_intents = list(/datum/intent/simple/critterbite)

/mob/living/simple_animal/hostile/retaliate/bigrat
	base_intents = list(/datum/intent/simple/critterbite)
*/
/datum/intent/simple/trollrip
	name = "trollrip"
	icon_state = "instrike"
	attack_verb = list("claws", "gnashes", "viciously bites")
	animname = "blank22"
	blade_class = BCLASS_CHOP
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 20
	swingdelay = 2 SECONDS
	candodge = TRUE
	canparry = TRUE

/datum/intent/simple/critterbite
	name = "bite"
	icon_state = "instrike"
	attack_verb = list("bites")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 5
	swingdelay = 1.5 SECONDS
	candodge = TRUE
	canparry = TRUE

/datum/intent/simple/claw_strong
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("slashes", "claws")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 5
	swingdelay = 2 SECONDS
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"

/datum/intent/simple/claw_quick
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("slashes", "claws")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 3
	swingdelay = 1 SECONDS
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
