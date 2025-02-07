/datum/job/roguetown/inquisitor
	title = "Inquisitor"
	flag = PURITAN
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	allowed_sexes = list(MALE, FEMALE)

	tutorial = "A recent arrival from Grenzelhoft, you are a member of the secretive lodges that have held to the service of Psydon since the Apotheosis War. You have been sent by your leader, the Holy Bishop, to assign the local Priest in combatting the increasing number of heretics and monsters infiltrating Vanderlin."
	whitelist_req = FALSE

	outfit = /datum/outfit/job/roguetown/inquisitor
	display_order = JDO_PURITAN
	min_pq = 8
	bypass_lastclass = TRUE
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

/datum/job/roguetown/inquisitor/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(!L.mind)
		return
	if(L.mind.has_antag_datum(/datum/antagonist))
		return
	var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
	L.mind.add_antag_datum(new_antag)

/datum/outfit/job/roguetown/inquisitor
	name = "Inquisitor"
	jobtype = /datum/job/roguetown/inquisitor
	allowed_patrons = list(/datum/patron/psydon)

/datum/outfit/job/roguetown/inquisitor/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dark
	belt = /obj/item/storage/belt/rogue/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/cape/puritan
	head = /obj/item/clothing/head/roguetown/helmet/leather/inquisitor
	gloves = /obj/item/clothing/gloves/roguetown/angle
	wrists = /obj/item/clothing/neck/roguetown/psycross/silver
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/long/forgotten
	beltl = /obj/item/flashlight/flare/torch/lantern
	neck = /obj/item/clothing/neck/roguetown/bevor
	armor = /obj/item/clothing/suit/roguetown/armor/leather/splint
	backpack_contents = list(/obj/item/storage/keyring/inquisitor = 1)
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Ritter"
	if(H.gender == FEMALE)
		honorary = "Ritterin"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"
	H.confession_points = 10 // Starting with 10 points
	H.purchase_history = list() // Initialize as an empty list to track purchases
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 1)
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)
		H.set_patron(/datum/patron/psydon)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	to_chat(H,span_info("\
		-I can speak Old Psydonic with ,m before my speech.\n\
		-The Holy Bishop of the Inquisition has sent you here on a task to root out evil within this town. Make The Holy Bishop proud!\n\
		-You've also been gaven 10 favors to use at the mail machines, you can get more favor by sending signed confessions to The Holy Bishop. Spend your favors wisely.")
		)
	H.mind?.teach_crafting_recipe(/datum/crafting_recipe/roguetown/confessional)

/mob/living/carbon/human/proc/torture_victim()
	set name = "Extract Confession"
	set category = "Inquisition"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	if(!istype(I) || !ishuman(I.grabbed))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, span_warning("I won't torture myself!"))
		return
	var/painpercent = H.get_complex_pain() / (H.STAEND * 10)
	painpercent = painpercent * 100
	var/mob/living/carbon/C = H
	if(C.add_stress(/datum/stressevent/tortured))
		if(!H.stat)
			var/static/list/torture_lines = list(
				"CONFESS YOUR WRONGDOINGS!",
				"TELL ME YOUR SECRETS!",
				"SPEAK THE TRUTH!",
				"YOU WILL SPEAK!",
				"TELL ME!",
				"THE PAIN HAS ONLY BEGUN, CONFESS!",
			)
			say(pick(torture_lines), spans = list("torture"))
			testing(painpercent)
			if(painpercent >= 100)
				H.emote("painscream")
				testing("Confession time, [painpercent] pain.")
				H.confession_time("antag", src)
				return
	to_chat(src, span_warning("Not ready to speak yet."))

/mob/living/carbon/human/proc/faith_test()
	set name = "Test Faith"
	set category = "Inquisition"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	if(!istype(I) || !ishuman(I.grabbed))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, span_warning("I won't torture myself!"))
		return
	var/painpercent = (H.get_complex_pain() / (H.STAEND * 10)) * 100
	if(H.add_stress(/datum/stressevent/tortured))
		if(!H.stat)
			var/static/list/faith_lines = list(
				"DO YOU DENY PSYDON AND THE TEN?",
				"WHO IS YOUR GOD?",
				"ARE YOU FAITHFUL?",
				"TO WHICH SHEPHERD DO YOU FLOCK TO?",
			)
			say(pick(faith_lines), spans = list("torture"))
			if(painpercent >= 100)
				H.emote("painscream")
				H.confession_time("patron", src)
				return
	to_chat(src, span_warning("Not ready to speak yet."))

/mob/living/carbon/human/proc/confession_time(confession_type = "antag", mob/living/carbon/human/user)
	if(istype(src.buckled, /obj/structure/fluff/walldeco/chains)) // If the victim is on hanging chains, they cannot resist.
		confess_sins(confession_type, resist=FALSE, user=user)
		return
	var/timerid = addtimer(CALLBACK(src, PROC_REF(confess_sins), confession_type, FALSE, user), 6 SECONDS, TIMER_STOPPABLE)
	var/responsey = alert(src, "Resist torture?","TEST OF PAIN","Yes","No")
	testing("Sent resist request to [src].")
	testing(" User is [user]. confession_time")
	if(SStimer.timer_id_dict[timerid])
		deltimer(timerid)
	else
		to_chat(src, span_warning("Too late..."))
		testing("Torture timer ran out.")
		return
	if(responsey == "Yes")
		testing("[src] resisted torture.")
		confess_sins(confession_type, resist=TRUE, user=user)
	else
		testing("[src] gave into torture.")
		confess_sins(confession_type, resist=FALSE, user=user)

/mob/living/carbon/human/proc/confess_sins(confession_type = "antag", resist, mob/living/carbon/human/user, torture=TRUE, obj/item/paper/confession/confession_paper)
	var/static/list/innocent_lines = list(
		"I DON'T KNOW!",
		"STOP THE PAIN!!",
		"I DON'T DESERVE THIS!",
		"THE PAIN!",
		"I HAVE NOTHING TO SAY...!",
		"WHY ME?!",
	)
	var/resist_chance
	if(resist)
		to_chat(src, span_boldwarning("I attempt to resist the torture!"))
		resist_chance = (STAINT + STAEND) + 10
		if(confession_type == "antag")
			resist_chance += 25
	if(!resist || (resist_chance && !prob(resist_chance)))
		var/list/confessions = list()
		var/antag_type = null
		testing(" User is [user]. confess_sins")
		switch(confession_type)
			if("antag")
				for(var/datum/antagonist/antag in mind?.antag_datums)
					if(!length(antag.confess_lines))
						continue
					confessions += antag.confess_lines
					antag_type = antag.name
					testing("Antag type: [antag_type]")
					break // Only need one antag type
			if("patron")
				if(length(patron?.confess_lines))
					confessions += patron.confess_lines
					testing("Patron type: [patron.name]")
					antag_type = patron.name
		if(length(confessions))
			if(torture == TRUE) // Only scream your confession if it's due to torture.
				say(pick(confessions), spans = list("torture"))
			else
				say(pick(confessions))
			if(has_confessed==TRUE) // This is to check if the victim has already confessed, if so just inform the torturer and return. This is so that the Inquisitor cannot get infinite confession points and get all of the things upon getting thier first heretic.
				visible_message(span_warning("[src.name] has already signed a confession!"), "I have already signed a confession!")
				return
			var/obj/item/paper/confession/held_confession
			testing("confession paper: [confession_paper]")
			if(istype(confession_paper))
				held_confession = confession_paper
			else if(user.is_holding_item_of_type(/obj/item/paper/confession)) // This code is to process gettin a signed confession through torture.
				testing("User is holding a confession.")
				held_confession = user.is_holding_item_of_type(/obj/item/paper/confession)
			if(!held_confession?.signed) // Check to see if the confession is already signed.
				// held_confession.bad_type = "AN EVILDOER" // In case new antags are added with confession lines but have yet to be added here.
				//this is no longer reliable as all patrons have confess lines now
				switch(antag_type)
					if("Bandit")
						held_confession.bad_type = "AN OUTLAW OF THE THIEF-LORD"
						held_confession.antag = antag_type
					if("Matthios")
						held_confession.bad_type = "A FOLLOWER OF THE THIEF-LORD"
						held_confession.antag = "worshiper of " + antag_type
					if("Maniac")
						held_confession.bad_type = "A MANIAC DELUDED BY MADNESS"
						held_confession.antag = antag_type
					if("Assassin")
						held_confession.bad_type = "A DEATH CULTIST"
						held_confession.antag = antag_type
					if("Zizoid Lackey")
						held_confession.bad_type = "A SERVANT OF THE FORBIDDEN ONE"
						held_confession.antag = antag_type
					if("Zizoid Cultist")
						held_confession.bad_type = "A SERVANT OF THE FORBIDDEN ONE"
						held_confession.antag = antag_type
					if("Zizo")
						held_confession.bad_type = "A FOLLOWER OF THE FORBIDDEN ONE"
						held_confession.antag = "worshiper of " + antag_type
					if("Verewolf")
						held_confession.bad_type = "A BEARER OF DENDOR'S CURSE"
						held_confession.antag = antag_type
					if("Lesser Verewolf")
						held_confession.bad_type = "A BEARER OF DENDOR'S CURSE"
						held_confession.antag = antag_type
					if("Vampire")
						held_confession.bad_type = "A SCION OF KAINE"
						held_confession.antag = antag_type
					if("Lesser Vampire")
						held_confession.bad_type = "A SCION OF KAINE"
						held_confession.antag = antag_type
					if("Vampire Lord")
						held_confession.bad_type = "THE BLOOD-LORD OF ENIGMA"
						held_confession.antag = antag_type
					if("Vampire Spawn")
						held_confession.bad_type = "AN UNDERLING OF THE BLOOD-LORD"
						held_confession.antag = antag_type
					if("Graggar")
						held_confession.bad_type = "A FOLLOWER OF THE DARK SUN"
						held_confession.antag = "worshiper of " + antag_type
					if("Godless")
						held_confession.bad_type = "A DAMNED ANTI-THEIST"
						held_confession.antag = "worshiper of nothing"
					if("Baotha")
						held_confession.bad_type = "A FOLLOWER OF THE REMORSELESS RUINER"
						held_confession.antag = "worshiper of " + antag_type
					if("Peasant Rebel")
						return // Inquisitors don't care about peasant revolts targeting the King
					else
						return // good job you tortured an innocent person
				has_confessed = TRUE
				held_confession.signed = real_name
				held_confession.info = "THE GUILTY PARTY ADMITS THEIR SINFUL NATURE AS <font color='red'>[held_confession.bad_type]</font>. THEY WILL SERVE ANY PUNISHMENT OR SERVICE AS REQUIRED BY THE ORDER OF THE PSYCROSS UNDER PENALTY OF DEATH.<br/><br/>SIGNED,<br/><font color='red'><i>[held_confession.signed]</i></font>"
				held_confession.update_icon_state()
			return
		else
			if(torture) // Only scream your confession if it's due to torture.
				say(pick(innocent_lines), spans = list("torture"))
			else
				say(pick(innocent_lines))
			return
	to_chat(src, span_good("I resist the torture!"))
	say(pick(innocent_lines), spans = list("torture"))
	return
