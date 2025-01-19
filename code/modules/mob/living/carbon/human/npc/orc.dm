/mob/living/carbon/human/species/orc
	name = "orc"

	icon = 'icons/roguetown/mob/monster/Orc.dmi'
	icon_state = "orc"
	race = /datum/species/orc
	gender = MALE
	bodyparts = list(/obj/item/bodypart/chest/orc, /obj/item/bodypart/head/orc, /obj/item/bodypart/l_arm/orc,
					/obj/item/bodypart/r_arm/orc, /obj/item/bodypart/r_leg/orc, /obj/item/bodypart/l_leg/orc)
	rot_type = /datum/component/rot/corpse/orc
//	var/gob_outfit = /datum/outfit/job/roguetown/npc/orc/ambush removed to apply different classes to the orcs
	ambushable = FALSE
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/unarmed/claw, /datum/intent/simple/bite, /datum/intent/kick)
	possible_rmb_intents = list()
	vitae_pool = 1000 // Not as much vitae from them as humans to avoid vampires cheesing mobs

/mob/living/carbon/human/species/orc/npc
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15 //they can dodge easily, but have a cooldown on it
	canparry = TRUE
	flee_in_pain = FALSE

	wander = FALSE


/mob/living/carbon/human/species/orc/ambush/after_creation()
	..()
	job = "Ambush Orc"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/ambush)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/obj/item/bodypart/chest/orc
	dismemberable = 1
/obj/item/bodypart/l_arm/orc
	dismemberable = 1
/obj/item/bodypart/r_arm/orc
	dismemberable = 1
/obj/item/bodypart/r_leg/orc
	dismemberable = 1
/obj/item/bodypart/l_leg/orc
	dismemberable = 1

/obj/item/bodypart/head/orc/update_icon_dropped()
	return

/obj/item/bodypart/head/orc/get_limb_icon(dropped, hideaux = FALSE)
	return

/obj/item/bodypart/head/orc/skeletonize()
	. = ..()
	icon_state = "orc_skel_head"
	sellprice = 2

/mob/living/carbon/human/species/orc/update_body()
	remove_overlay(BODY_LAYER)
	if(!dna || !dna.species)
		return
	var/datum/species/orc/G = dna.species
	if(!istype(G))
		return
	icon_state = ""
	var/list/standing = list()
	var/mutable_appearance/body_overlay
	var/obj/item/bodypart/chesty = get_bodypart("chest")
	var/obj/item/bodypart/headdy = get_bodypart("head")
	if(!headdy)
		if(chesty && chesty.skeletonized)
			body_overlay = mutable_appearance(icon, "orc_skel_decap", -BODY_LAYER)
		else
			body_overlay = mutable_appearance(icon, "[G.raceicon]_decap", -BODY_LAYER)
	else
		if(chesty && chesty.skeletonized)
			body_overlay = mutable_appearance(icon, "orc_skel", -BODY_LAYER)
		else
			body_overlay = mutable_appearance(icon, "[G.raceicon]", -BODY_LAYER)

	if(body_overlay)
		standing += body_overlay
	if(standing.len)
		overlays_standing[BODY_LAYER] = standing

	apply_overlay(BODY_LAYER)
	dna.species.update_damage_overlays()

/mob/living/carbon/human/species/orc/proc/update_wearable()
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

/mob/living/carbon/human/species/orc/update_inv_head()
	update_wearable()
/mob/living/carbon/human/species/orc/update_inv_armor()
	update_wearable()

/mob/living/carbon/human/species/orc/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

/mob/living/carbon/human/species/orc/handle_combat()
	if(mode == AI_HUNT)
		if(prob(2))
			emote("aggro")
	. = ..()

/mob/living/carbon/human/species/orc/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)
	mind.current = src

	mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)

/mob/living/carbon/human/species/orc/handle_combat()
	if(mode == AI_HUNT)
		if(prob(2))
			emote("aggro")
	. = ..()

/mob/living/carbon/human/species/orc/after_creation()
	..()
	gender = MALE
	if(src.dna && src.dna.species)
		src.dna.species.soundpack_m = new /datum/voicepack/orc()
		var/obj/item/headdy = get_bodypart("head")
		if(headdy)
			headdy.icon = 'icons/roguetown/mob/monster/Orc.dmi'
			headdy.icon_state = "[src.dna.species.id]_head"
			headdy.sellprice = rand(15,40)
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
	faction = list("orcs")
	name = "orc"
	real_name = "orc"
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
//	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
//	blue breathes underwater, need a new specific one for this maybe organ cheque
//	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
//	if(gob_outfit)
//		var/datum/outfit/O = new gob_outfit
//		if(O)
//			equipOutfit(O)

/datum/species/orc
	name = "orc"
	id = "orc"
	species_traits = list(NO_UNDERWEAR,NOEYESPRITES)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_CRITICAL_WEAKNESS, TRAIT_NASTY_EATER, TRAIT_LEECHIMMUNE, TRAIT_INHUMENCAMP)
	no_equip = list(SLOT_SHIRT, SLOT_WEAR_MASK, SLOT_GLOVES, SLOT_SHOES, SLOT_PANTS, SLOT_S_STORE)
	nojumpsuit = 1
	sexes = 1
	damage_overlay_type = ""
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	var/raceicon = "orc"

/datum/species/orc/update_damage_overlays(mob/living/carbon/human/H)
	return

/datum/species/orc/regenerate_icons(mob/living/carbon/human/H)
//	H.cut_overlays()
	H.icon_state = ""
	if(H.notransform)
		return 1
	H.update_inv_hands()
	H.update_inv_handcuffed()
	H.update_inv_legcuffed()
	H.update_fire()
	H.update_body()
	var/mob/living/carbon/human/species/orc/G = H
	G.update_wearable()
	H.update_transform()
	return TRUE

/datum/component/rot/corpse/orc/process()
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

/////
////
////
//// OUTFIT//////////////////
////
///

/datum/outfit/job/roguetown/npc/orc/ambush/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 13
	H.TOTALSPD = 12
	H.TOTALCON = 13
	H.TOTALEND = 13
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Stolen Tool armed raider
			r_hand = /obj/item/rogueweapon/axe/iron
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
		if(2) //Stolen Tool armed raider
			r_hand = /obj/item/rogueweapon/thresher
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
		if(3) //Stolen Tool armed raider
			r_hand = /obj/item/rogueweapon/pitchfork//removed the cudgel because it's way too good at knock people out
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
			if(prob(10))
				//head = /obj/item/clothing/head/roguetown/helmet/orc
				r_hand = /obj/item/rogueweapon/sickle
				armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
		if(4) //lightly armored sword/flail/daggers
			if(prob(50))
				head = /obj/item/clothing/head/roguetown/helmet/orc
				r_hand = /obj/item/rogueweapon/mace/spiked
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
				pants = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
				head = /obj/item/clothing/head/roguetown/helmet/leather
			if(prob(30))
				l_hand = /obj/item/rogueweapon/sword/iron
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
				head = /obj/item/clothing/head/roguetown/helmet/leather
			if(prob(23))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
				r_hand = /obj/item/rogueweapon/knife/dagger
				l_hand = /obj/item/rogueweapon/knife/dagger
				pants = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
				head = /obj/item/clothing/head/roguetown/helmet/leather
			if(prob(80))
				armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
				pants = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
				head = /obj/item/clothing/head/roguetown/helmet/leather
		if(5) //heavy armored sword/flail/shields
			if(prob(20))
				r_hand = /obj/item/rogueweapon/mace//readded the blunt weapon, this time with an very rare "slavist" orc
				l_hand = /obj/item/rogueweapon/whip
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc
			else
				r_hand = /obj/item/rogueweapon/sword/short
				l_hand = /obj/item/rogueweapon/sword/short
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc
			if(prob(80))
				head = /obj/item/clothing/head/roguetown/helmet/orc
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				pants = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
				r_hand = /obj/item/rogueweapon/flail
			else
				head = /obj/item/clothing/head/roguetown/helmet/orc
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				r_hand = /obj/item/rogueweapon/axe/battle
			if(prob(50))
				r_hand = /obj/item/rogueweapon/sword/iron
				l_hand = /obj/item/rogueweapon/shield/wood
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc
			else
				r_hand = /obj/item/rogueweapon/mace/spiked
				l_hand = /obj/item/rogueweapon/shield/wood
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc
			if(prob(30))
				r_hand = /obj/item/rogueweapon/sword/scimitar/messer
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc

//NEW ORCS WITH DIFFERENT GEAR AND SHIT
/mob/living/carbon/human/species/orc/tribal
	name = "Tribal Orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/tribal
	ambushable = FALSE

/mob/living/carbon/human/species/orc/tribal/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/tribal)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/tribal/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 13
	H.TOTALSPD = 13
	H.TOTALCON = 13
	H.TOTALEND = 13
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Dual Axe Warrior
			r_hand = /obj/item/rogueweapon/axe/stone
			l_hand = /obj/item/rogueweapon/axe/stone
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
		if(2) //Long Club Caveman
			r_hand = /obj/item/rogueweapon/polearm/woodstaff
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
		if(3) //Club Caveman
			r_hand = /obj/item/rogueweapon/mace/woodclub
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
		if(4) //dagger fighter
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			r_hand = /obj/item/rogueweapon/knife/stone
			l_hand = /obj/item/rogueweapon/knife/stone
		if(5) //Spear hunter
			r_hand = /obj/item/rogueweapon/polearm/spear/stone
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown


//////////////////////////////////////////////////////////

/mob/living/carbon/human/species/orc/warrior
	name = "Warrior Orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/warrior
	ambushable = FALSE

/mob/living/carbon/human/species/orc/warrior/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/warrior)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/warrior/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 13
	H.TOTALSPD = 13
	H.TOTALCON = 14
	H.TOTALEND = 14
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Marauder with Sword and Shield
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/shield/wood
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/leather
		if(2) //Marauder with Axe and Shield
			r_hand = /obj/item/rogueweapon/axe/iron
			l_hand = /obj/item/rogueweapon/shield/wood
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/leather
		if(3) //Club Caveman
			r_hand = /obj/item/rogueweapon/flail
			l_hand = /obj/item/rogueweapon/sword/scimitar/messer
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/leather
		if(4) //dagger fighter
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/sword/short
			head = /obj/item/clothing/head/roguetown/helmet/leather
		if(5) //Marauder Ironblade
			if(prob(50))
				r_hand = /obj/item/rogueweapon/mace/spiked
				l_hand = /obj/item/rogueweapon/shield/wood
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc
			else
				r_hand = /obj/item/rogueweapon/mace/spiked
				l_hand = /obj/item/rogueweapon/sword/scimitar/messer
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc
				cloak = /obj/item/clothing/cloak/raincloak/brown
			if(prob(30))
				r_hand = /obj/item/rogueweapon/axe/iron
				armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
				head = /obj/item/clothing/head/roguetown/helmet/orc
				cloak = /obj/item/clothing/cloak/raincloak/brown




///////////////////////////////////////////////////////////////////////////////////////

/mob/living/carbon/human/species/orc/marauder
	name = "Marauder Orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/marauder
	ambushable = FALSE

/mob/living/carbon/human/species/orc/marauder/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/marauder)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/marauder/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 12
	H.TOTALSPD = 12
	H.TOTALCON = 13
	H.TOTALEND = 13
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Marauder with Sword and Shield
			r_hand = /obj/item/rogueweapon/sword/iron
			l_hand = /obj/item/rogueweapon/axe/iron
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/orc
		if(2) //Marauder with Axe and Shield
			r_hand = /obj/item/rogueweapon/axe/battle
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/orc
		if(3) //Warhammer Caveman
			r_hand = /obj/item/rogueweapon/mace/goden/steel/warhammer
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/orc
		if(4) //dagger fighter
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			r_hand = /obj/item/rogueweapon/mace/steel
			l_hand = /obj/item/rogueweapon/shield/tower
			head = /obj/item/clothing/head/roguetown/helmet/orc
		if(5) //Marauder Ironblade
			r_hand = /obj/item/rogueweapon/polearm/halberd/bardiche
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc
			cloak = /obj/item/clothing/cloak/raincloak/brown
			head = /obj/item/clothing/head/roguetown/helmet/orc


///////////////////////////////////////////////////////////////////////////////////////
/mob/living/carbon/human/species/orc/warlord
	name = "Warlord Orc"
	var/loadout = /datum/outfit/job/roguetown/npc/orc/warlord
	ambushable = FALSE

/mob/living/carbon/human/species/orc/warlord/after_creation()
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/warlord)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE

/datum/outfit/job/roguetown/npc/orc/warlord/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = 14
	H.TOTALSPD = 14
	H.TOTALCON = 14
	H.TOTALEND = 14
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //Halberd Warlord
			r_hand = /obj/item/rogueweapon/polearm/halberd
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc/warlord
			head = /obj/item/clothing/head/roguetown/helmet/orc/warlord
		if(2) //Greatsword Warlord
			r_hand = /obj/item/rogueweapon/sword/long/greatsword
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc/warlord
			head = /obj/item/clothing/head/roguetown/helmet/orc/warlord
		if(3) // WE DON'T WANNA GO TO WAR TODAY BUT THE LORD OF THE LASH SAYS "NAY NAY NAY!!" WE'RE GONNA MARCH ALL DAE, ALL DAE, ALL DAE! WHERE THERE'S A WHIP THERE'S A WAY!!
			r_hand = /obj/item/rogueweapon/whip/antique
			l_hand = /obj/item/rogueweapon/sword/short
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc/warlord
			head = /obj/item/clothing/head/roguetown/helmet/orc/warlord
		if(4) // Big Sword and Big Shield
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc/warlord
			r_hand = /obj/item/rogueweapon/sword/scimitar/falchion
			l_hand = /obj/item/rogueweapon/shield/tower
			head = /obj/item/clothing/head/roguetown/helmet/orc/warlord
		if(5) //Anti Knight STR Build
			r_hand = /obj/item/rogueweapon/flail/sflail
			armor = /obj/item/clothing/suit/roguetown/armor/plate/orc/warlord
			head = /obj/item/clothing/head/roguetown/helmet/orc/warlord

/mob/living/carbon/human/species/orc/warlord/skilled/after_creation() //these ones dont parry, but still get good weapon skills
	..()
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/npc/orc/warlord)
	aggressive=1
	mode = AI_IDLE
	dodgetime = 15
	canparry = TRUE
	flee_in_pain = FALSE
	wander = TRUE
	configure_mind()
