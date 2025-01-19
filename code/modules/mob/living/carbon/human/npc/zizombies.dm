/mob/living/carbon/human/species/zizombie
	name = "rotten zizombie"

	icon = 'icons/roguetown/mob/monster/zizombie.dmi'
	icon_state = "zizombie"
	race = /datum/species/zizombie
	gender = PLURAL
	bodyparts = list(/obj/item/bodypart/chest/zizombie, /obj/item/bodypart/head/zizombie, /obj/item/bodypart/l_arm/zizombie,
					/obj/item/bodypart/r_arm/zizombie, /obj/item/bodypart/r_leg/zizombie, /obj/item/bodypart/l_leg/zizombie)
	rot_type = /datum/component/rot/corpse/zizombie
	ambushable = FALSE
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw, /datum/intent/simple/bite, /datum/intent/kick)
	possible_rmb_intents = list()

/mob/living/carbon/human/species/zizombie/npc
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15 //they can dodge easily, but have a cooldown on it
	canparry = TRUE
	flee_in_pain = FALSE
	wander = FALSE


/mob/living/carbon/human/species/zizombie/ambush/after_creation()
	..()
	job = "Ambush zizombie"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/zizombie/npc/random)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/obj/item/bodypart/chest/zizombie
	dismemberable = 1
/obj/item/bodypart/l_arm/zizombie
	dismemberable = 1
/obj/item/bodypart/r_arm/zizombie
	dismemberable = 1
/obj/item/bodypart/r_leg/zizombie
	dismemberable = 1
/obj/item/bodypart/l_leg/zizombie
	dismemberable = 1

/obj/item/bodypart/head/zizombie/update_icon_dropped()
	return

/obj/item/bodypart/head/zizombie/get_limb_icon(dropped, hideaux = FALSE)
	return

/obj/item/bodypart/head/zizombie/skeletonize()
	. = ..()
	icon_state = "zizombie_head_s"
	sellprice = 2

/mob/living/carbon/human/species/zizombie/update_body()
	remove_overlay(BODY_LAYER)
	if(!dna || !dna.species)
		return
	var/datum/species/zizombie/G = dna.species
	if(!istype(G))
		return
	icon_state = ""
	var/list/standing = list()
	var/mutable_appearance/body_overlay
	var/obj/item/bodypart/chesty = get_bodypart("chest")
	var/obj/item/bodypart/headdy = get_bodypart("head")
	if(!headdy)
		if(chesty && chesty.skeletonized)
			body_overlay = mutable_appearance(icon, "zizombie_head_s", -BODY_LAYER)
		else
			body_overlay = mutable_appearance(icon, "[G.raceicon]_decap", -BODY_LAYER)
	else
		if(chesty && chesty.skeletonized)
			body_overlay = mutable_appearance(icon, "zizombie_skel", -BODY_LAYER)
		else
			body_overlay = mutable_appearance(icon, "[G.raceicon]", -BODY_LAYER)

	if(body_overlay)
		standing += body_overlay
	if(standing.len)
		overlays_standing[BODY_LAYER] = standing

	apply_overlay(BODY_LAYER)
	dna.species.update_damage_overlays()

/mob/living/carbon/human/species/zizombie/proc/update_wearable()
	remove_overlay(ARMOR_LAYER)

	var/list/standing = list()
	var/mutable_appearance/body_overlay
	if(wear_armor)
		body_overlay = mutable_appearance(icon, "[wear_armor.item_state]", -ARMOR_LAYER)
		if(body_overlay)
			standing += body_overlay
	if(head)
		body_overlay = mutable_appearance(icon, "[head.item_state]", -ARMOR_LAYER)
		if(body_overlay)
			standing += body_overlay
	if(standing.len)
		overlays_standing[ARMOR_LAYER] = standing

	apply_overlay(ARMOR_LAYER)

/mob/living/carbon/human/species/zizombie/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

/mob/living/carbon/human/species/zizombie/handle_combat()
	if(mode == AI_HUNT)
		if(prob(1))
			emote("rage")
	. = ..()

/mob/living/carbon/human/species/zizombie/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)

/mob/living/carbon/human/species/zizombie/handle_combat()
	if(mode == AI_HUNT)
		if(prob(1))
			emote("scream")
	. = ..()

/mob/living/carbon/human/species/zizombie/after_creation()
	..()
	gender = MALE
	if(src.dna && src.dna.species)
		src.dna.species.soundpack_m = new /datum/voicepack/zombie/m()
		var/obj/item/headdy = get_bodypart("head")
		if(headdy)
			headdy.icon = 'icons/roguetown/mob/monster/zizombie.dmi'
			headdy.icon_state = "[src.dna.species.id]_head"
			headdy.sellprice = rand(5)
	src.grant_language(/datum/language/common)
	var/obj/item/organ/eyes/eyes = src.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/nightmare
	eyes.Insert(src)
	src.underwear = "Nude"
	if(src.charflaw)
		QDEL_NULL(src.charflaw)
	update_body()
	faction = list("undead")
	name = "zizombie"
	real_name = "zizombie"
	mob_biotypes |= MOB_UNDEAD
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
//	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
//	blue breathes underwater, need a new specific one for this maybe organ cheque
//	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
//	if(gob_outfit)
//		var/datum/outfit/O = new gob_outfit
//		if(O)
//			equipOutfit(O)

/datum/species/zizombie
	name = "zizombie"
	id = "zizombie"
	species_traits = list(NO_UNDERWEAR,NOEYESPRITES)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE)
	nojumpsuit = 1
	sexes = 1
	damage_overlay_type = "human"
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	var/raceicon = "zizombie"

/datum/species/zizombie/update_damage_overlays(mob/living/carbon/human/H)
	return

/datum/species/zizombie/regenerate_icons(mob/living/carbon/human/H)
//	H.cut_overlays()
	H.icon_state = ""
	if(H.notransform)
		return 1
	H.update_inv_hands()
	H.update_inv_handcuffed()
	H.update_inv_legcuffed()
	H.update_fire()
	H.update_body()
	var/mob/living/carbon/human/species/zizombie/G = H
	G.update_wearable()
	H.update_transform()
	return TRUE

/datum/component/rot/corpse/zizombie/process()
	var/amt2add = 10 //1 second
	if(last_process)
		amt2add = ((world.time - last_process)/10) * amt2add
	last_process = world.time
	amount += amt2add
	var/mob/living/carbon/C = parent
	if(!C)
		qdel(src)
		return
	if(C.stat != DEAD)
		qdel(src)
		return
	var/should_update = FALSE
	if(amount > 20 MINUTES)
		for(var/obj/item/bodypart/B in C.bodyparts)
			if(!B.skeletonized)
				B.skeletonized = TRUE
				should_update = TRUE
	else if(amount > 12 MINUTES)
		for(var/obj/item/bodypart/B in C.bodyparts)
			if(!B.rotted)
				B.rotted = TRUE
				should_update = TRUE
			if(B.rotted && amount < 16 MINUTES)
				var/turf/open/T = C.loc
				if(istype(T))
					T.pollute_turf(/datum/pollutant/rot, 10)
	if(should_update)
		if(amount > 20 MINUTES)
			C.update_body()
			qdel(src)
			return
		else if(amount > 12 MINUTES)
			C.update_body()

///////////////////////////////////////////////////////////// EVENTMIN ZIZOMBIES

/mob/living/carbon/human/species/zizombie/npc/peasant/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/zizombie/npc/peasant)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/species/zizombie/npc/peasant/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 9
	H.TOTALSPD = 7
	H.TOTALCON = 10
	H.TOTALEND = 16//the zombies shouldn't get tired after all
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	pants = /obj/item/clothing/under/roguetown/tights/vagrant
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	head = /obj/item/clothing/head/roguetown/roguehood/random
	var/loadout = rand(1,6)
	switch(loadout)
		if(1) //Axe Warrior
			r_hand = /obj/item/rogueweapon/axe/iron
		if(2) //Long Stick Fighter
			r_hand = /obj/item/rogueweapon/polearm/woodstaff
		if(3) //Club Caveman
			r_hand = /obj/item/rogueweapon/mace/woodclub
		if(4) //Stabbity Stabbity your Knight is now horizontality
			r_hand =/obj/item/rogueweapon/pitchfork
		if(5) //Bonk Build
			r_hand = /obj/item/rogueweapon/thresher
		if(6) //Bonk Build
			r_hand = /obj/item/rogueweapon/hoe


///////////////////////////////////////////////////////////// EVENTMIN ZIZOMBIES
/mob/living/carbon/human/species/zizombie/npc/ambush/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/zizombie/npc/random)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/species/zizombie/npc/random/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(30))
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/roguehood/uncolored
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/iron
		shoes = /obj/item/clothing/shoes/roguetown/boots
	else
		r_hand = /obj/item/rogueweapon/mace/woodclub
		shoes = /obj/item/clothing/shoes/roguetown/boots

///////////////////////////////////////////////////////////// EVENTMIN SKELETONGS

/mob/living/carbon/human/species/zizombie/npc/warrior/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/zizombie/npc/warrior)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/species/zizombie/npc/warrior/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 10
	H.TOTALSPD = 7
	H.TOTALCON = 10
	H.TOTALEND = 16//the zizombies shouldn't get tired after all
	var/loadout = rand(1,6)
	switch(loadout)
		if(1) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/shield/wood
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(2)//zizombie Warrior
			r_hand = /obj/item/rogueweapon/mace
			l_hand = /obj/item/rogueweapon/shield/wood
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(3) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/flail
			l_hand = /obj/item/rogueweapon/shield/wood
			shoes = /obj/item/clothing/shoes/roguetown/boots
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
		if(4) //zizombie Warrior
			r_hand =/obj/item/rogueweapon/polearm/spear
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			shoes = /obj/item/clothing/shoes/roguetown/boots
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(5) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/sword/sabre
			l_hand = /obj/item/rogueweapon/knife/dagger
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			shoes = /obj/item/clothing/shoes/roguetown/boots
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(6) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/sword/scimitar/messer
			l_hand = /obj/item/rogueweapon/knife/dagger
			shoes = /obj/item/clothing/shoes/roguetown/boots
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			head = /obj/item/clothing/head/roguetown/helmet/skullcap

///////////////////////////////////////////////////////////// EVENTMIN ZOMBIE MILITIA
/mob/living/carbon/human/species/zizombie/npc/militiamen/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/zizombie/npc/militiamen)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/species/zizombie/npc/militiamen/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 10
	H.TOTALSPD = 7
	H.TOTALCON = 10
	H.TOTALEND = 16//the zizombies shouldn't get tired after all
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/sword/iron
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			cloak = /obj/item/clothing/cloak/stabard/guard
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(2) //zizombie Warrior
			r_hand =/obj/item/rogueweapon/polearm/spear
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			cloak = /obj/item/clothing/cloak/stabard/guard
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(3) //zizombie Warrior
			r_hand =/obj/item/rogueweapon/knife/cleaver/combat
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			cloak = /obj/item/clothing/cloak/stabard/guard
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(4) //zizombie Warrior
			r_hand =/obj/item/rogueweapon/knife/hunting
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			cloak = /obj/item/clothing/cloak/stabard/guard
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(5) //zizombie Warrior
			r_hand =/obj/item/rogueweapon/axe/iron
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			belt = /obj/item/storage/belt/rogue/leather
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
			pants = /obj/item/clothing/under/roguetown/tights/vagrant
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			cloak = /obj/item/clothing/cloak/stabard/guard
			head = /obj/item/clothing/head/roguetown/helmet/kettle

///////////////////////////////////////////////////////////// EVENTMIN ZOMBIE GRENZELHOFT MERCENARIES
/mob/living/carbon/human/species/zizombie/npc/GRENZEL/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/species/zizombie/npc/GRENZEL)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE




/datum/outfit/job/roguetown/species/zizombie/npc/GRENZEL/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 12
	H.TOTALSPD = 7
	H.TOTALCON = 10
	H.TOTALEND = 20//the zizombies shouldn't get tired after all
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/sword/long/greatsword/zwei
			pants = /obj/item/clothing/under/roguetown/grenzelpants
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			gloves = /obj/item/clothing/gloves/roguetown/angle/grenzel
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
			head = /obj/item/clothing/head/roguetown/helmet/kettle
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/grenzelhoft
			backl = /obj/item/storage/backpack/rogue/satchel
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		if(2) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/polearm/halberd
			pants = /obj/item/clothing/under/roguetown/grenzelpants
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			gloves = /obj/item/clothing/gloves/roguetown/angle/grenzel
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
			head = /obj/item/clothing/head/roguetown/helmet/sallet
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/grenzelhoft
			backl = /obj/item/storage/backpack/rogue/satchel
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		if(3) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/polearm/eaglebeak
			pants = /obj/item/clothing/under/roguetown/grenzelpants
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			gloves = /obj/item/clothing/gloves/roguetown/angle/grenzel
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
			head = /obj/item/clothing/head/roguetown/helmet/sallet
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/grenzelhoft
			backl = /obj/item/storage/backpack/rogue/satchel
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		if(4) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/sword/short
			l_hand = /obj/item/rogueweapon/knife/dagger
			pants = /obj/item/clothing/under/roguetown/grenzelpants
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			gloves = /obj/item/clothing/gloves/roguetown/angle/grenzel
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
			head = /obj/item/clothing/head/roguetown/helmet/sallet
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/grenzelhoft
			backl = /obj/item/storage/backpack/rogue/satchel
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		if(5) //zizombie Warrior
			r_hand = /obj/item/rogueweapon/axe/battle
			pants = /obj/item/clothing/under/roguetown/grenzelpants
			shoes = /obj/item/clothing/shoes/roguetown/boots/armor/light
			gloves = /obj/item/clothing/gloves/roguetown/angle/grenzel
			belt = /obj/item/storage/belt/rogue/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/grenzelhoft
			head = /obj/item/clothing/head/roguetown/helmet/sallet
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/grenzelhoft
			backl = /obj/item/storage/backpack/rogue/satchel
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather



