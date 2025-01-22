
/datum/antagonist/bandit
	name = "Bandit"
	roundend_category = "bandits"
	antagpanel_category = "Bandit"
	job_rank = ROLE_BANDIT
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "bandit"
	var/tri_amt
	var/contrib
	confess_lines = list("FREEDOM!!!", "I WILL NOT LIVE IN YOUR WALLS!", "I WILL NOT FOLLOW YOUR RULES!")

/datum/antagonist/bandit/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/bandit))
		return "<span class='boldnotice'>Another free man. My ally.</span>"

/datum/antagonist/bandit/on_gain()
	owner.special_role = "Bandit"
	move_to_spawnpoint()
	forge_objectives()
	. = ..()
	finalize_bandit()
	equip_bandit()

/datum/antagonist/bandit/proc/finalize_bandit()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
	var/mob/living/carbon/human/H = owner.current
	ADD_TRAIT(H, TRAIT_BANDITCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_VILLAIN, TRAIT_GENERIC)
	H.set_patron(/datum/patron/inhumen/matthios)

/datum/antagonist/bandit/greet()
	to_chat(owner.current, "<span class='alertsyndie'>I am a BANDIT!</span>")
	to_chat(owner.current, "<span class='info'>Long ago I did a crime worthy of my bounty being hung on the wall outside of the local inn.</span>")
	owner.announce_objectives()
	..()

/datum/antagonist/bandit/proc/forge_objectives()
	return

/proc/isbandit(mob/living/M)
	return istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/bandit)

/datum/antagonist/bandit/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.bandit_starts))

/datum/antagonist/bandit/proc/equip_bandit()

	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Bandit"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	return TRUE

/*
/datum/outfit/job/roguetown/bandit/pre_equip(mob/living/carbon/human/H)
	..()
	H.become_blind("TRAIT_GENERIC")
	var/classes = list("Deserter","Poacher","Brigand")
	var/classchoice = input("Choose your background", "Available backgrounds") as anything in classes

	switch(classchoice)

		if("Deserter") //well armored, polearm skill, shield skill. The heavy melee class.
			H.set_blindness(0)
			to_chat(H, span_warning("You were once a soldier employed under a lord, and left illegally. You're capable with armor, shields, and polearms."))
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)

			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			beltr = /obj/item/clothing/mask/rogue/shepherd/rag
			beltl = /obj/item/rogueweapon/knife/hunting

			if(H.age == AGE_OLD) //old deserters are experts with polearms
				H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)

			var/helmet2choose = pickweight(list("Volfhelm" = 5, "Skullcap" = 2, "Barbute" = 1))
			switch(helmet2choose)
				if("Volfhelm")
					head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
				if("Skullcap")
					head = /obj/item/clothing/head/roguetown/helmet/skullcap
				if("Barbute") // big roller
					head = /obj/item/clothing/head/roguetown/helmet/heavy/rust

			var/armor2choose = pickweight(list("Rusty halfplate" = 2, "Chainmail" = 1))
			switch(armor2choose)
				if("Rusty halfplate")
					armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron/rust
				if("Chainmail")
					armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron

			var/weapon2choose = pickweight(list("Spear" = 2, "Bardiche" = 1))
			switch(weapon2choose)
				if("Spear")
					backr = /obj/item/rogueweapon/polearm/spear
				if("Bardiche")
					backr = /obj/item/rogueweapon/polearm/halberd/bardiche

			switch(pick(1,2))
				if (1) //worse leg protection, better neck protection, and a face mask
					pants = /obj/item/clothing/under/roguetown/trou/leather
					neck = /obj/item/clothing/neck/roguetown/chaincoif
					mask = /obj/item/clothing/mask/rogue/facemask
				if (2) //better leg protection, worse neck protection
					pants = /obj/item/clothing/under/roguetown/chainlegs/iron
					neck = /obj/item/clothing/neck/roguetown/chaincoif/iron

		if("Poacher") //good perception, speed, bow skill, and knife skill. Also some cooking and skincrafting since they are poachers. The speedy ranged class.
			H.set_blindness(0)
			to_chat(H, span_warning("You illegally hunt within the lands of others, and are quite good at it."))
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("perception", 2)
			H.change_stat("speed", 2)

			armor = /obj/item/clothing/suit/roguetown/armor/gambeson
			pants = /obj/item/clothing/under/roguetown/trou/leather
			beltr = /obj/item/rogueweapon/knife/hunting
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltl = /obj/item/ammo_holder/quiver/arrows
			mask = /obj/item/clothing/mask/rogue/shepherd/rag

			var/helmet2choose = pickweight(list("Hood" = 1, "Volfhelm" = 1))
			switch(helmet2choose)
				if("Hood")
					head = /obj/item/clothing/head/roguetown/roguehood
					neck = /obj/item/clothing/neck/roguetown/coif
					if(H.age == AGE_OLD) //old poachers also saved up for a better coif
						head = /obj/item/clothing/neck/roguetown/chaincoif/iron
				if("Volfhelm")
					head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm

			if(H.age == AGE_OLD) //old poachers are better at their jobs
				H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
				H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
				H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)

			switch(pick(1,2,3))
				if (1)
					beltr = /obj/item/rogueweapon/knife/hunting
				if (2)
					beltr = /obj/item/rogueweapon/knife/cleaver
				if (3)
					beltr = /obj/item/rogueweapon/knife/dagger

		if("Brigand") //good sword skill, shield skill, flail skill, mace skill, slightly speedy. Kind of an all rounder.
			H.set_blindness(0)
			to_chat(H, span_warning("You are experienced with using swords and clubs to threaten and rob others."))
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.change_stat("strength", 2)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 1)
			H.change_stat("speed", 1)

			neck = /obj/item/clothing/neck/roguetown/coif
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			pants = /obj/item/clothing/under/roguetown/trou/leather
			beltl = /obj/item/clothing/mask/rogue/shepherd/rag
			neck = /obj/item/clothing/neck/roguetown/coif

			var/helmet2choose = pickweight(list("Leather helmet" = 2, "Volfhelm" = 2, "Coif" = 1))
			switch(helmet2choose)
				if("Leather helmet")
					head = /obj/item/clothing/head/roguetown/helmet/leather/conical
				if("Volfhelm")
					head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
				if("Coif")
					head = /obj/item/clothing/neck/roguetown/chaincoif/iron

			switch(pick(1,2))
				if (1)
					armor = /obj/item/clothing/suit/roguetown/armor/leather
				if (2)
					armor = /obj/item/clothing/suit/roguetown/armor/leather/hide

			if(H.age == AGE_OLD) //old brigands have been in the business for so long that they have managed to pick up some better gear along the way
				armor = /obj/item/clothing/suit/roguetown/armor/leather/splint
				mask = /obj/item/clothing/mask/rogue/facemask

			switch(pick(1,2,3,4))
				if (1)
					beltr = /obj/item/rogueweapon/sword/iron
				if (2)
					beltr = /obj/item/rogueweapon/flail
				if (3)
					beltr = /obj/item/rogueweapon/mace
				if (4)
					beltr = /obj/item/rogueweapon/sword/scimitar/messer

	H.cure_blind("TRAIT_GENERIC")

	// The commmon skills shared between all bandits
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)

	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)

	H.mind.teach_crafting_recipe(/datum/crafting_recipe/bandit_volfhelm)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cult_hood)

	// The commmon gear shared between all bandits
	belt = /obj/item/storage/belt/rogue/leather/bandit
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/flashlight/flare/torch/metal)

	switch(pick(1,3))
		if (1 to 2)
			gloves = /obj/item/clothing/gloves/roguetown/leather
			shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		if (3)
			gloves = /obj/item/clothing/gloves/roguetown/angle
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black

	H.change_stat("intelligence", -1)
	var/obj/item/bodypart/B = H.get_bodypart("head")
	if(B)
		B.sellprice = rand(44, 88)

	H.ambushable = FALSE
*/

/datum/antagonist/bandit/roundend_report()
	if(owner?.current)
		var/amt = tri_amt
		var/the_name = owner.name
		if(ishuman(owner.current))
			var/mob/living/carbon/human/H = owner.current
			the_name = H.real_name
		if(!amt)
			to_chat(world, "[the_name] was a bandit.")
		else
			to_chat(world, "[the_name] was a bandit. He stole [amt] triumphs worth of loot.")
	return
/*
	var/traitorwin = TRUE

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(!objective.check_completion())
				traitorwin = FALSE
			count += objective.triumph_count

	if(!count)
		count = 1

	if(traitorwin)
		owner.adjust_triumphs(count)
		to_chat(owner.current, "<span class='greentext'>I've TRIUMPHED!</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(owner.current, "<span class='redtext'>I've failed to satisfy my greed.</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
*/

/*	.................   Unique Bandit recipes   ................... */
/datum/crafting_recipe/bandit_volfhelm
	name = "(Bandit) Volfhelm"
	time = 4 SECONDS
	reqs = list(/obj/item/natural/fur/volf = 2)
	result = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	category = CAT_NONE

/datum/crafting_recipe/cult_hood
	name = "(Cult) Ominous Hood"
	time = 4 SECONDS
	reqs = list(/obj/item/natural/hide = 1)
	result = /obj/item/clothing/head/roguetown/helmet/leather/hood_ominous
	category = CAT_NONE

