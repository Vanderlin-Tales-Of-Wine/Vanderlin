/// DEFINITIONS ///
#define VAMP_LEVEL_ONE 10000
#define VAMP_LEVEL_TWO 12000
#define VAMP_LEVEL_THREE 15000
#define VAMP_LEVEL_FOUR 20000

GLOBAL_LIST_EMPTY(vampire_objects)

/datum/antagonist/vampirelord
	name = "Vampire Lord"
	roundend_category = "Vampires"
	antagpanel_category = "Vampire"
	job_rank = ROLE_VAMPIRE
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "vampire"
	confess_lines = list(
		"I AM ANCIENT",
		"I AM THE LAND",
		"FIRSTBORNE CHILD OF KAIN!",
	)
	var/isspawn = FALSE
	var/disguised = FALSE
	var/ascended = FALSE
	var/starved = FALSE
	var/sired = FALSE
	var/vamplevel = 0
	var/vitae = 1000
	var/vmax = 2000
	var/obj/structure/vampire/bloodpool/mypool
	var/last_transform
	var/cache_skin
	var/cache_eyes
	var/cache_hair
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates
	var/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform/gas

/datum/antagonist/vampirelord/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampirelord/lesser))
		return span_boldnotice("A vampire spawn.")
	if(istype(examined_datum, /datum/antagonist/vampirelord))
		return span_boldnotice("A Vampire Lord!.")
	if(istype(examined_datum, /datum/antagonist/zombie))
		return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return span_boldnotice("Another deadite.")

/datum/antagonist/vampirelord/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)

/datum/antagonist/vampirelord/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)

/datum/antagonist/vampirelord/on_gain()
	var/datum/game_mode/C = SSticker.mode
	C.vampires |= owner
	. = ..()
	owner.special_role = name
	move_to_spawnpoint()
	ADD_TRAIT(owner.current, TRAIT_CRITICAL_WEAKNESS, "[type]") //half assed but necessary otherwise these guys be invincible
	ADD_TRAIT(owner.current, TRAIT_STRONGBITE, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOSTAMINA, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOPAIN, "[type]")
	ADD_TRAIT(owner.current, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(owner.current, TRAIT_STEELHEARTED, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOSLEEP, "[type]")
	ADD_TRAIT(owner.current, TRAIT_VAMPMANSION, "[type]")

	ADD_TRAIT(owner.current, TRAIT_VAMP_DREAMS, "[type]")
	owner.current.cmode_music = 'sound/music/cmode/antag/CombatThrall.ogg'
	var/obj/item/organ/eyes/eyes = owner.current.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(owner.current,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(owner.current)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix)
	owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
	owner.current.verbs |= /mob/living/carbon/human/proc/vampire_telepathy
	vamp_look()
	if(isspawn)
		owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button
		add_objective(/datum/objective/vlordserve)
		finalize_vampire_lesser()
		for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
			mypool = mansion
		equip_spawn()
		greet()
		if(!sired)
			addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, spawn_pick_class), "VAMPIRE SPAWN"), 5 SECONDS)
	else
		forge_vampirelord_objectives()
		finalize_vampire()
		owner.current.verbs |= /mob/living/carbon/human/proc/demand_submission
		owner.current.verbs |= /mob/living/carbon/human/proc/punish_spawn
		for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
			mypool = mansion
		equip_lord()
		addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "VAMPIRE LORD"), 5 SECONDS)
		greet()
	return ..()

// OLD AND EDITED
/datum/antagonist/vampirelord/proc/equip_lord()
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Vampire Spawn"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)
	for(var/datum/mind/MF in get_minds("Death Knight"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
	var/obj/item/organ/eyes/eyes = owner.current.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(owner.current,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(owner.current)
	H.equipOutfit(/datum/outfit/job/roguetown/vamplord)
	H.set_patron(/datum/patron/psydon) //Servant forever of he who is forgotten.

	return TRUE

/datum/antagonist/vampirelord/proc/equip_spawn()
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Vampire Spawn"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)
	for(var/datum/mind/MF in get_minds("Death Knight"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	owner.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	owner.current.ambushable = FALSE

/mob/living/carbon/human/proc/spawn_pick_class()
	var/list/classoptions = list("Bard", "Fisher", "Hunter", "Miner", "Peasant", "Carpenter", "Cheesemaker", "Blacksmith", "Carpenter", "Thief", "Treasure Hunter", "Mage")
	var/list/visoptions = list()

	for(var/T in 1 to 5)
		var/picked = pick(classoptions)
		visoptions |= picked

	var/selected = input(src, "Which class was I?", "VAMPIRE SPAWN") as anything in visoptions

	for(var/datum/advclass/A in SSrole_class_handler.sorted_class_categories[CTAG_ALLCLASS])
		if(A.name == selected)
			equipOutfit(A.outfit)
			return

/datum/outfit/job/roguetown/vamplord/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	pants = /obj/item/clothing/under/roguetown/tights/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/vampire
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	head  = /obj/item/clothing/head/roguetown/vampire
	beltl = /obj/item/key/vampire
	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel/black
	H.ambushable = FALSE

////////Outfits////////


/datum/antagonist/vampirelord/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,span_danger("I am no longer a [job_rank]!"))
	owner.special_role = null
	if(!isnull(batform))
		owner.current.RemoveSpell(batform)
		QDEL_NULL(batform)
	return ..()

/datum/antagonist/vampirelord/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

/datum/antagonist/vampirelord/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/vampirelord/proc/forge_vampirelord_objectives()
	var/list/primary = pick(list("1", "2","3"))
	var/list/secondary = pick(list("1", "2", "3"))
	switch(primary)
		if("1")
			var/datum/objective/vampirelord/conquer/T = new
			objectives += T
		if("2")
			var/datum/objective/vampirelord/ascend/T = new
			objectives += T
		if("3")
			var/datum/objective/vampirelord/destroy/T = new
			objectives += T
	switch(secondary)
		if("1")
			var/datum/objective/vampirelord/infiltrate/one/T = new
			objectives += T
		if("2")
			var/datum/objective/vampirelord/infiltrate/two/T = new
			objectives += T
		if("3")
			var/datum/objective/vampirelord/spread/T = new
			objectives += T
	var/datum/objective/vlordsurvive/survive = new
	objectives += survive

/datum/antagonist/vampirelord/greet()
	to_chat(owner.current, span_userdanger("I am ancient. I am the Land. And I am now awoken to these trespassers upon my domain."))
	owner.announce_objectives()
	..()

/datum/antagonist/vampirelord/lesser/greet()
	to_chat(owner.current, span_userdanger("We are awakened from our slumber, Spawn of the feared Vampire Lord."))
	owner.announce_objectives()

/datum/antagonist/vampirelord/proc/finalize_vampire()
	owner.current.forceMove(pick(GLOB.vlord_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)


/datum/antagonist/vampirelord/proc/finalize_vampire_lesser()
	if(!sired)
		owner.current.forceMove(pick(GLOB.vspawn_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)


/datum/antagonist/vampirelord/proc/vamp_look()
	var/mob/living/carbon/human/V = owner.current
	cache_skin = V.skin_tone
	cache_eyes = V.eye_color
	cache_hair = V.hair_color
	V.skin_tone = "c9d3de"
	V.hair_color = "181a1d"
	V.facial_hair_color = "181a1d"
	V.eye_color = "ff0000"
	V.update_body()
	V.update_hair()
	V.update_body_parts(redraw = TRUE)
	V.mob_biotypes = MOB_UNDEAD
	if(isspawn)
		V.vampire_disguise()

/datum/antagonist/vampirelord/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		return
	if(H.advsetup)
		return
	if(!isspawn)
		vitae = mypool.current
	if(ascended)
		return
	if(world.time % 5)
		if(GLOB.tod != "night")
			if(isturf(H.loc))
				var/turf/T = H.loc
				if(T.can_see_sky())
					if(T.get_lumcount() > 0.15)
						if(!isspawn)
							to_chat(H, span_warning("Astrata spurns me! I must get out of her rays!")) // VLord is more punished for daylight excursions.
							var/turf/N = H.loc
							if(N.can_see_sky())
								if(N.get_lumcount() > 0.15)
									H.fire_act(3)
									handle_vitae(-500)
							to_chat(H, span_warning("That was too close. I must avoid the sun."))
						else if (isspawn && !disguised)
							H.fire_act(1,5)
							handle_vitae(-10)

	if(H.on_fire)
		if(disguised)
			last_transform = world.time
			H.vampire_undisguise(src)
		H.freak_out()

	if(H.stat)
		if(istype(H.loc, /obj/structure/closet/crate/coffin))
			H.fully_heal()

	if(vitae > 0)
		H.blood_volume = BLOOD_VOLUME_NORMAL
		if(vitae < 200)
			if(disguised)
				to_chat(H, span_warning("My disguise fails!"))
				H.vampire_undisguise(src)
	handle_vitae(-1)

/datum/antagonist/vampirelord/proc/handle_vitae(change, tribute)
	var/tempcurrent = vitae
	if(!isspawn)
		mypool.update_pool(change)
	if(isspawn)
		if(change > 0)
			tempcurrent += change
			if(tempcurrent > vmax)
				tempcurrent = vmax // to prevent overflow
		if(change < 0)
			tempcurrent += change
			if(tempcurrent < 0)
				tempcurrent = 0 // to prevent excessive negative.
		vitae = tempcurrent
	if(tribute)
		mypool.update_pool(tribute)
	if(vitae <= 20)
		if(!starved)
			to_chat(owner, span_userdanger("I starve, my power dwindles! I am so weak!"))
			starved = TRUE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, -5)
	else
		if(starved)
			starved = FALSE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 5)

/datum/antagonist/vampirelord/proc/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vlord_starts))

/datum/antagonist/vampirelord/proc/grow_in_power()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	switch(vamplevel)
		if(0)
			vamplevel = 1
			batform = new
			owner.current.AddSpell(batform)
			for(var/obj/structure/vampire/portalmaker/S in GLOB.vampire_objects)
				S.unlocked = TRUE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			for(var/obj/structure/vampire/bloodpool/B in GLOB.vampire_objects)
				B.nextlevel = VAMP_LEVEL_TWO
			to_chat(owner, "<font color='red'>I am refreshed and have grown stronger. The visage of the bat is once again available to me. I can also once again access my portals.</font>")
		if(1)
			vamplevel = 2
			owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodsteal)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
			owner.adjust_skillrank(/datum/skill/magic/blood, 3, TRUE)
			gas = new
			owner.current.AddSpell(gas)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			for(var/obj/structure/vampire/bloodpool/B in GLOB.vampire_objects)
				B.nextlevel = VAMP_LEVEL_THREE
			to_chat(owner, "<font color='red'>My power is returning. I can once again access my spells. I have also regained usage of my mist form.</font>")
		if(2)
			vamplevel = 3
			for(var/obj/structure/vampire/necromanticbook/S in GLOB.vampire_objects)
				S.unlocked = TRUE
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_strength
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
			owner.current.RemoveSpell(/obj/effect/proc_holder/spell/targeted/transfix)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix/master)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			for(var/obj/structure/vampire/bloodpool/B in GLOB.vampire_objects)
				B.nextlevel = VAMP_LEVEL_FOUR
			to_chat(owner, "<font color='red'>My dominion over others minds and my own body returns to me. I am nearing perfection. The armies of the dead shall now answer my call.</font>")
		if(3)
			vamplevel = 4
			owner.current.visible_message("<font color='red'>[owner.current] is enveloped in dark crimson, a horrific sound echoing in the area. They are evolved.</font>","<font color='red'>I AM ANCIENT, I AM THE LAND. EVEN THE SUN BOWS TO ME.</font>")
			ascended = TRUE
			C.ascended = TRUE
			for(var/datum/mind/thrall in C.vampires)
				if(thrall.special_role == "Vampire Spawn")
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_strength
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
					thrall.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
					for(var/S in MOBSTATS)
						thrall.current.change_stat(S, 2)
	return

// SPAWN
/datum/antagonist/vampirelord/lesser
	name = "Vampire Spawn"
	antag_hud_name = "Vspawn"
	confess_lines = list(
		"THE CRIMSON MASTER CALLS!",
		"MY MASTER COMMANDS",
		"THE SUN IS THE ANATHEMA OF OUR MASTER!",
	)
	isspawn = TRUE

/datum/antagonist/vampirelord/lesser/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vlordspawn_starts))

// NEW VERBS
/mob/living/carbon/human/proc/demand_submission()
	set name = "Demand Submission"
	set category = "VAMPIRE"
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.kingsubmit)
			to_chat(src, "I am already the Master of Enigma.")
			return
	for(var/mob/living/carbon/human/H in oview(1))
		if(SSticker.rulermob == H)
			H.receive_submission(src)

/mob/living/carbon/human/proc/receive_submission(mob/living/carbon/human/lord)
	if(stat)
		return
	switch(alert("Submit and Pledge Allegiance to Lord [lord.name]?",,"Yes","No"))
		if("Yes")
			var/datum/game_mode/chaosmode/C = SSticker.mode
			if(istype(C))
				if(!C.kingsubmit)
					C.kingsubmit = TRUE
		if("No")
			lord << span_boldnotice("They refuse!")
			src << span_boldnotice("I refuse!")

/mob/living/carbon/human/proc/vampire_telepathy()
	set name = "Telepathy"
	set category = "VAMPIRE"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/msg = input("Send a message.", "Command") as text|null
	if(!msg)
		return
	for(var/datum/mind/V in C.vampires)
		to_chat(V, span_boldnotice("A message from [src.real_name]:[msg]"))
	for(var/datum/mind/D in C.deathknights)
		to_chat(D, span_boldnotice("A message from [src.real_name]:[msg]"))
	for(var/mob/dead/observer/rogue/arcaneeye/A in GLOB.mob_list)
		to_chat(A, span_boldnotice("A message from [src.real_name]:[msg]"))

/mob/living/carbon/human/proc/punish_spawn()
	set name = "Punish Minion"
	set category = "VAMPIRE"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/possible = list()
	for(var/datum/mind/V in C.vampires)
		if(V.special_role == "Vampire Spawn")
			possible[V.current.real_name] = V.current
	for(var/datum/mind/D in C.deathknights)
		possible[D.current.real_name] = D.current
	var/name_choice = input(src, "Who to punish?", "PUNISHMENT") as null|anything in possible
	if(!name_choice)
		return
	var/mob/living/carbon/human/choice = possible[name_choice]
	if(!choice || QDELETED(choice))
		return
	var/punishmentlevels = list("Pause", "Pain", "DESTROY")
	var/punishment = input(src, "Severity?", "PUNISHMENT") as null|anything in punishmentlevels
	if(!punishment)
		return
	switch(punishment)
		if("Pain")
			to_chat(choice, span_boldnotice("You are wracked with pain as your master punishes you!"))
			choice.apply_damage(30, BRUTE)
			choice.emote_scream()
			playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
		if("Pause")
			to_chat(choice, span_boldnotice("Your body is frozen in place as your master punishes you!"))
			choice.Paralyze(300)
			choice.emote_scream()
			playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
		if("DESTROY")
			to_chat(choice, span_boldnotice("You feel only darkness. Your master no longer has use of you."))
			spawn(10 SECONDS)
				choice.emote_scream()
				choice.dust()
	visible_message(span_danger("[src] reaches out, gripping [choice]'s soul, inflicting punishment!"))

/obj/structure/vampire/portal/Crossed(atom/movable/AM)
	. = ..()
	if(istype(AM, /mob/living))
		for(var/obj/effect/landmark/vteleport/dest in GLOB.landmarks_list)
			playsound(loc, 'sound/misc/portalenter.ogg', 100, FALSE, pressure_affected = FALSE)
			AM.forceMove(dest.loc)
			break

/obj/structure/vampire/portal/sending/Crossed(atom/movable/AM)
	if(istype(AM, /mob/living))
		for(var/obj/effect/landmark/vteleportsenddest/V in GLOB.landmarks_list)
			AM.forceMove(V.loc)

/obj/structure/vampire/portal/sending/Destroy()
	for(var/obj/effect/landmark/vteleportsenddest/V in GLOB.landmarks_list)
		qdel(V)
	for(var/obj/structure/vampire/portalmaker/P in GLOB.vampire_objects)
		P.sending =  FALSE
	return ..()

/obj/structure/vampire/portalmaker/proc/create_portal_return(aname,duration)
	for(var/obj/effect/landmark/vteleportdestination/Vamp in GLOB.landmarks_list)
		if(Vamp.amuletname == aname)
			var/obj/structure/vampire/portal/P = new(Vamp.loc)
			P.duration = duration
			P.spawntime = world.time
			P.visible_message(span_boldnotice("A sickening tear is heard as a sinister portal emerges."))
		qdel(Vamp)

/obj/structure/vampire/portalmaker/proc/create_portal(choice,duration)
	sending = TRUE
	for(var/obj/effect/landmark/vteleportsending/S in GLOB.landmarks_list)
		var/obj/structure/vampire/portal/sending/P = new(S.loc)
		P.visible_message(span_boldnotice("A sickening tear is heard as a sinister portal emerges."))

/obj/structure/vampire/portal/Initialize()
	. = ..()
	set_light(3, 2, 20, l_color = LIGHT_COLOR_BLOOD_MAGIC)
	playsound(loc, 'sound/misc/portalopen.ogg', 100, FALSE, pressure_affected = FALSE)

	addtimer(CALLBACK(src, PROC_REF(delete)), 60 SECONDS)

/obj/structure/vampire/portal/proc/delete()
	visible_message(span_boldnotice("[src] shudders before rapidly closing."))
	qdel(src)

/obj/structure/vampire/portal/sending/Destroy()
	for(var/obj/structure/vampire/portalmaker/PM in GLOB.vampire_objects)
		PM.sending = FALSE
	. = ..()

/obj/structure/vampire/bloodpool/Initialize()
	. = ..()
	set_light(3, 3, 20, l_color = LIGHT_COLOR_BLOOD_MAGIC)

/obj/structure/vampire/bloodpool/examine(mob/user)
	. = ..()
	to_chat(user, span_boldnotice("Blood level: [current]"))

/obj/structure/vampire/bloodpool/attack_hand(mob/living/user)
	var/datum/antagonist/vampirelord/lord = user.mind.has_antag_datum(/datum/antagonist/vampirelord)
	if(user.mind.special_role != "Vampire Lord")
		return
	var/choice = input(user,"What to do?", "VANDERLIN") as anything in useoptions|null
	switch(choice)
		if("Grow Power")
			if(lord.vamplevel == 4)
				to_chat(user, "I'm already max level!")
				return
			if(alert(user, "Increase vampire level? Cost:[nextlevel]","","Yes","No") == "Yes")
				if(!check_withdraw(-nextlevel))
					to_chat(user, "I don't have enough vitae!")
					return
				if(do_after(user, 10 SECONDS))
					lord.handle_vitae(-nextlevel)
					lord.grow_in_power()
					user.playsound_local(get_turf(src), 'sound/misc/batsound.ogg', 100, FALSE, pressure_affected = FALSE)
		if("Shape Amulet")
			if(alert(user, "Craft a new amulet Cost:500","","Yes","No") == "Yes")
				if(!check_withdraw(-500))
					to_chat(user, "I don't have enough vitae!")
					return
				if(do_after(user, 10 SECONDS))
					lord.handle_vitae(-500)
					var/naming = input(user, "Select a name for the amulet.", "VANDERLIN") as text|null
					var/obj/item/clothing/neck/roguetown/portalamulet/P = new(src.loc)
					if(naming)
						P.name = naming
					user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)
		if("Shape Armor")
			if(alert(user, "Craft a new set of armor? Cost:5000","","Yes","No") == "Yes")
				if(!check_withdraw(-5000))
					to_chat(user, "I don't have enough vitae!")
					return
				if(do_after(user, 10 SECONDS))
					lord.handle_vitae(-5000)
					new /obj/item/clothing/under/roguetown/platelegs/vampire (src.loc)
					new /obj/item/clothing/under/roguetown/platelegs/vampire (src.loc)
					new /obj/item/clothing/suit/roguetown/armor/haubergon_vampire (src.loc)
					new /obj/item/clothing/suit/roguetown/armor/cuirass/vampire (src.loc)
					new /obj/item/clothing/shoes/roguetown/boots/armor/vampire (src.loc)
					new /obj/item/clothing/head/roguetown/helmet/heavy/savoyard (src.loc)
				user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)

/obj/structure/vampire/bloodpool/proc/update_pool(change)
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/tempmax = 8000
	if(istype(C))
		for(var/datum/mind/V in C.vampires)
			if(V.special_role == "vampirespawn")
				tempmax += 4000
		if(maximum != tempmax)
			maximum = tempmax
			if(current > maximum)
				current = maximum
	if(debug)
		maximum = 999999
		current = 999999
	if(change)
		current += change

/obj/structure/vampire/bloodpool/proc/check_withdraw(change)
	if(change < 0)
		if(abs(change) > current)
			return FALSE
		return TRUE

/obj/structure/vampire/portalmaker/attack_hand(mob/living/user)
	var/list/possibleportals = list()
	var/list/sendpossibleportals = list()
	var/datum/antagonist/vampirelord/lord = user.mind.has_antag_datum(/datum/antagonist/vampirelord)
	if(user.mind.special_role != "Vampire Lord")
		return
	if(!lord.mypool.check_withdraw(-1000))
		to_chat(user, "This costs 1000 vitae, I lack that.")
		return
	if(!unlocked)
		to_chat(user, "I've yet to regain this aspect of my power!")
		return
	var/list/choices = list("Return", "Sending", "CANCEL")
	var/inputportal = input(user, "Which type of portal?", "Portal Type") as anything in choices
	switch(inputportal)
		if("Return")
			for(var/obj/item/clothing/neck/roguetown/portalamulet/P in GLOB.vampire_objects)
				possibleportals += P
			var/atom/choice = input(user, "Choose an area to open the portal", "Choices") as null|anything in possibleportals
			if(!choice)
				return
			user.visible_message("[user] begins to summon a portal.", "I begin to summon a portal.")
			if(do_after(user, 3 SECONDS))
				lord.handle_vitae(-1000)
				if(istype(choice, /obj/item/clothing/neck/roguetown/portalamulet))
					var/obj/item/clothing/neck/roguetown/portalamulet/A = choice
					A.uses -= 1
					var/obj/effect/landmark/vteleportdestination/VR = new(A.loc)
					VR.amuletname = A.name
					create_portal_return(A.name, 3000)
					user.playsound_local(get_turf(src), 'sound/misc/portalactivate.ogg', 100, FALSE, pressure_affected = FALSE)
					if(A.uses <= 0)
						A.visible_message("[A] shatters!")
						qdel(A)
		if("Sending")
			if(sending)
				to_chat(user, "A portal is already active!")
				return
			for(var/obj/item/clothing/neck/roguetown/portalamulet/P in GLOB.vampire_objects)
				sendpossibleportals += P
			var/atom/choice = input(user, "Choose an area to open the portal to", "Choices") as null|anything in sendpossibleportals
			if(!choice)
				return
			user.visible_message("[user] begins to summon a portal.", "I begin to summon a portal.")
			if(do_after(user, 3 SECONDS))
				lord.handle_vitae(-1000)
				if(istype(choice, /obj/item/clothing/neck/roguetown/portalamulet))
					var/obj/item/clothing/neck/roguetown/portalamulet/A = choice
					A.uses -= 1
					var/turf/G = get_turf(A)
					new /obj/effect/landmark/vteleportsenddest(G.loc)
					if(A.uses <= 0)
						A.visible_message("[A] shatters!")
						qdel(A)
					create_portal()
					user.playsound_local(get_turf(src), 'sound/misc/portalactivate.ogg', 100, FALSE, pressure_affected = FALSE)
		if("CANCEL")
			return
/* DISABLED FOR NOW
/obj/item/clothing/neck/roguetown/portalamulet/attack_self(mob/user)
	. = ..()
	if(alert(user, "Create a portal?", "PORTAL GEM", "Yes", "No") == "Yes")
		uses -= 1
		var/obj/effect/landmark/vteleportdestination/Vamp = new(loc)
		Vamp.amuletname = name
		for(var/obj/structure/vampire/portalmaker/P in GLOB.vampire_objects)
			P.create_portal_return(name, 3000)
		user.playsound_local(get_turf(src), 'sound/misc/portalactivate.ogg', 100, FALSE, pressure_affected = FALSE)
		if(uses <= 0)
			visible_message("[src] shatters!")
			qdel(src)
*/
/obj/structure/vampire/scryingorb/attack_hand(mob/living/carbon/human/user)
	if(user.mind.special_role == "Vampire Lord")
		user.visible_message("<font color='red'>[user]'s eyes turn dark red, as they channel the [src]</font>", "<font color='red'>I begin to channel my consciousness into a Predator's Eye.</font>")
		if(do_after(user, 6 SECONDS))
			user.scry(can_reenter_corpse = 1, force_respawn = FALSE)
	if(user.mind.special_role == "Vampire Spawn")
		to_chat(user, "I don't have the power to use this!")

/obj/structure/vampire/necromanticbook/attack_hand(mob/living/carbon/human/user)
	var/datum/antagonist/vampirelord/lord = user.mind.has_antag_datum(/datum/antagonist/vampirelord)
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(user.mind.special_role == "Vampire Lord")
		if(!unlocked)
			to_chat(user, "I have yet to regain this aspect of my power!")
			return
		var/choice = input(user,"What to do?", "VANDERLIN") as anything in useoptions|null
		switch(choice)
			if("Create Death Knight")
				if(alert(user, "Create a Death Knight? Cost:5000","","Yes","No") == "Yes")
					if(C.deathknights.len >= 3)
						to_chat(user, "You cannot summon any more death knights.")
						return
					if(!lord.mypool.check_withdraw(-5000))
						to_chat(user, "I don't have enough vitae!")
						return
					if(do_after(user, 10 SECONDS))
						to_chat(user, "I have summoned a knight from the underworld. I need only wait for them to materialize.")
						C.deathknightspawn = TRUE
						for(var/mob/dead/observer/D in GLOB.player_list)
							D.death_knight_spawn()
						for(var/mob/living/carbon/spirit/D in GLOB.player_list)
							D.death_knight_spawn()
				user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)
			if("Steal the Sun")
				if(sunstolen)
					to_chat(user, "The sun is already stolen!")
					return
				if(GLOB.tod == "night")
					to_chat(user, "It's already night!")
					return
				if(alert(user, "Force Enigma into Night? Cost:5000","","Yes","No") == "Yes")
					if(!lord.mypool.check_withdraw(-2500))
						to_chat(user, "I don't have enough vitae!")
						return
					if(do_after(user, 10 SECONDS))
						GLOB.todoverride = "night"
						sunstolen = TRUE
						settod()
						spawn(6000)
							GLOB.todoverride = null
							sunstolen = FALSE
						priority_announce("The Sun is torn from the sky!", "Terrible Omen", 'sound/misc/astratascream.ogg')
						addomen(OMEN_SUNSTEAL)
						for(var/mob/living/carbon/human/astrater in GLOB.human_list)
							if(!istype(astrater.patron, /datum/patron/divine/astrata) || !length(astrater.mind?.antag_datums))
								continue
							to_chat(astrater, span_userdanger("You feel the pain of [astrater.patron.name]!"))
							astrater.emote_scream()

	if(user.mind.special_role == "Vampire Spawn")
		to_chat(user, "I don't have the power to use this!")

/mob/proc/death_knight_spawn()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	SEND_SOUND(src, sound('sound/misc/notice (2).ogg'))
	if(alert(src, "A Vampire Lord is summoning you from the Underworld.", "Be Risen?", "Yes", "No") == "Yes")
		if(!C.deathknightspawn)
			to_chat(src, span_warning("Another soul was chosen."))
		returntolobby()

// DEATH KNIGHT ANTAG
/datum/antagonist/skeleton/knight
	name = "Death Knight"
	increase_votepwr = FALSE

/datum/antagonist/skeleton/knight/on_gain()
	. = ..()
	owner.current.verbs |= /mob/living/carbon/human/proc/vampire_telepathy
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Vampire Spawn"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)
	for(var/datum/mind/MF in get_minds("Death Knight"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)
	add_objective(/datum/objective/vlordserve)
	greet()
/datum/antagonist/skeleton/knight/greet()
	to_chat(owner.current, span_userdanger("I am returned to serve. I will obey, so that I may return to rest."))
	owner.announce_objectives()
	..()

/datum/antagonist/skeleton/knight/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

/datum/antagonist/skeleton/knight/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/skeleton/knight/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(objective.check_completion())
				to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
			else
				to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
				traitorwin = FALSE
			count += objective.triumph_count
	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_greentext("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, span_redtext("The [special_role_text] has FAILED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

/datum/antagonist/vampirelord/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(isspawn) // don't need to spam up the chat with all spawn
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count
	else
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_greentext("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, span_redtext("The [special_role_text] has FAILED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

// NEW OBJECTS/STRUCTURES
/obj/item/clothing/neck/roguetown/portalamulet
	name = "Gate Amulet"
	icon_state = "bloodtooth"
	icon = 'icons/roguetown/clothing/neck.dmi'
	var/uses = 3

/obj/item/clothing/neck/roguetown/portalamulet/Initialize()
	GLOB.vampire_objects |= src
	. = ..()

/obj/item/clothing/neck/roguetown/portalamulet/Destroy()
	GLOB.vampire_objects -= src
	return ..()

/obj/structure/vampire
	icon = 'icons/roguetown/topadd/death/vamp-lord.dmi'
	var/unlocked = FALSE
	density = TRUE

/obj/structure/vampire/Initialize()
	GLOB.vampire_objects |= src
	. = ..()

/obj/structure/vampire/Destroy()
	GLOB.vampire_objects -= src
	return ..()

/obj/structure/vampire/bloodpool
	name = "Crimson Crucible"
	icon_state = "vat"
	var/maximum = 8000
	var/current = 8000
	var/nextlevel = VAMP_LEVEL_ONE
	var/debug = FALSE
	var/list/useoptions = list("Grow Power", "Shape Amulet", "Shape Armor")

/obj/structure/vampire/scryingorb // Method of spying on the town
	name = "Eye of Night"
	icon_state = "scrying"

/obj/structure/vampire/necromanticbook // Used to summon undead to attack town/defend manor.
	name = "Tome of Souls"
	icon_state = "tome"
	var/list/useoptions = list("Create Death Knight", "Steal the Sun")
	var/sunstolen = FALSE

/obj/structure/vampire/portalmaker
	name = "Rift Gate"
	icon_state = "obelisk"
	var/sending = FALSE

/obj/structure/vampire/portal
	name = "Eerie Portal"
	icon_state = "portal"
	var/duration = 999
	var/spawntime = null
	density = 0

/obj/structure/vampire/portal/sending
	name = "Eerie Portal"
	icon_state = "portal"
	duration = 999
	spawntime = null
	var/turf/destloc
// LANDMARKS

/obj/effect/landmark/start/vampirelord
	name = "Vampire Lord"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampirelord/Initialize()
	. = ..()
	GLOB.vlord_starts += loc

/obj/effect/landmark/start/vampirespawn
	name = "Vampire Spawn"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampireknight
	name = "Death Knight"
	icon_state = "arrow"
	jobspawn_override = list("Death Knight")
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampirespawn/Initialize()
	. = ..()
	GLOB.vspawn_starts += loc

/obj/effect/landmark/vteleport
	name = "Teleport Destination"
	icon_state = "x2"

/obj/effect/landmark/vteleportsending
	name = "Teleport Sending"
	icon_state = "x2"

/obj/effect/landmark/vteleportdestination
	name = "Return Destination"
	icon_state = "x2"
	var/amuletname

/obj/effect/landmark/vteleportsenddest
	name = "Sending Destination"
	icon_state = "x2"
// SCRYING Since it has so many unique procs
/mob/dead/observer/rogue/arcaneeye
	sight = 0
	see_in_dark = 2

	misting = 0
	var/mob/living/carbon/human/vampirelord = null
	icon_state = "arcaneeye"
	draw_icon = FALSE
	hud_type = /datum/hud/eye

/mob/proc/scry(can_reenter_corpse = 1, force_respawn = FALSE, drawskip)
	stop_sound_channel(CHANNEL_HEARTBEAT) //Stop heartbeat sounds because You Are A Ghost Now
	SSdroning.kill_rain(client)
	SSdroning.kill_loop(client)
	SSdroning.kill_droning(client)
	stop_sound_channel(CHANNEL_HEARTBEAT) //Stop heartbeat sounds because You Are A Ghost Now
	var/mob/dead/observer/rogue/arcaneeye/eye = new(src)	// Transfer safety to observer spawning proc.
	SStgui.on_transfer(src, eye) // Transfer NanoUIs.
	eye.can_reenter_corpse = can_reenter_corpse
	eye.vampirelord = src
	eye.ghostize_time = world.time
	eye.key = key
	return eye

/mob/dead/observer/rogue/arcaneeye/proc/scry_tele()
	set category = "Arcane Eye"
	set name = "Teleport"
	set desc= "Teleport to a location"
	set hidden = 0

	if(!isobserver(usr))
		to_chat(usr, span_warning("You're not an Eye!"))
		return
	var/list/filtered = list()
	for(var/V in GLOB.sortedAreas)
		var/area/A = V
		if(!A.hidden)
			filtered += A
	var/area/thearea  = input("Area to jump to", "VANDERLIN") as null|anything in filtered

	if(!thearea)
		return

	var/list/L = list()
	for(var/turf/T in get_area_turfs(thearea.type))
		L+=T

	if(!L || !L.len)
		to_chat(usr, span_warning("No area available."))
		return

	usr.forceMove(pick(L))
	update_parallax_contents()

/mob/dead/observer/rogue/arcaneeye/Initialize()
	. = ..()
	set_invisibility(GLOB.observer_default_invisibility)
	verbs += list(
		/mob/dead/observer/rogue/arcaneeye/proc/scry_tele,
		/mob/dead/observer/rogue/arcaneeye/proc/cancel_scry,
		/mob/dead/observer/rogue/arcaneeye/proc/eye_down,
		/mob/dead/observer/rogue/arcaneeye/proc/eye_up,
		/mob/dead/observer/rogue/arcaneeye/proc/vampire_telepathy)
	testing("BEGIN LOC [loc]")
	name = "Arcane Eye"
	grant_all_languages()

/mob/dead/observer/rogue/arcaneeye/proc/cancel_scry()
	set category = "Arcane Eye"
	set name = "Cancel Eye"
	set desc= "Return to Body"

	if(vampirelord)
		vampirelord.ckey = ckey
		qdel(src)
	else
		to_chat(src, "My body has been destroyed! I'm trapped!")

/mob/dead/observer/rogue/arcaneeye/Crossed(mob/living/L)
	if(istype(L, /mob/living/carbon/human))
		var/mob/living/carbon/human/V = L
		var/holyskill = V.mind.get_skill_level(/datum/skill/magic/holy)
		var/magicskill = V.mind.get_skill_level(/datum/skill/magic/arcane)
		if(magicskill >= 2)
			to_chat(V, "<font color='red'>An ancient and unusual magic looms in the air around you.</font>")
			return
		if(holyskill >= 2)
			to_chat(V, "<font color='red'>An ancient and unholy magic looms in the air around you.</font>")
			return
		if(prob(20))
			to_chat(V, "<font color='red'>You feel like someone is watching you, or something.</font>")
			return

/mob/dead/observer/rogue/arcaneeye/proc/vampire_telepathy()
	set name = "Telepathy"
	set category = "Arcane Eye"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/msg = input("Send a message.", "Command") as text|null
	if(!msg)
		return
	for(var/datum/mind/V in C.vampires)
		to_chat(V, span_boldnotice("A message from [src.real_name]:[msg]"))
	for(var/datum/mind/D in C.deathknights)
		to_chat(D, span_boldnotice("A message from [src.real_name]:[msg]"))
	for(var/mob/dead/observer/rogue/arcaneeye/A in GLOB.mob_list)
		to_chat(A, span_boldnotice("A message from [src.real_name]:[msg]"))

/mob/dead/observer/rogue/arcaneeye/proc/eye_up()
	set category = "Arcane Eye"
	set name = "Move Up"

	if(zMove(UP, TRUE))
		to_chat(src, span_notice("I move upwards."))

/mob/dead/observer/rogue/arcaneeye/proc/eye_down()
	set category = "Arcane Eye"
	set name = "Move Down"

	if(zMove(DOWN, TRUE))
		to_chat(src, span_notice("I move down."))

/mob/dead/observer/rogue/arcaneeye/Move(NewLoc, direct)
	if(world.time < next_gmove)
		return
	next_gmove = world.time + 3

	if(updatedir)
		setDir(direct)//only update dir if we actually need it, so overlays won't spin on base sprites that don't have directions of their own
	var/oldloc = loc

	if(NewLoc)
		var/NewLocTurf = get_turf(NewLoc)
		if(istype(NewLocTurf, /turf/closed/mineral/rogue/bedrock)) // prevent going out of bounds.
			return
		forceMove(NewLoc)
		update_parallax_contents()
	else
		forceMove(get_turf(src))  //Get out of closets and such as a ghost
		if((direct & NORTH) && y < world.maxy)
			y++
		else if((direct & SOUTH) && y > 1)
			y--
		if((direct & EAST) && x < world.maxx)
			x++
		else if((direct & WEST) && x > 1)
			x--

	Moved(oldloc, direct)

// Spells
/obj/effect/proc_holder/spell/targeted/transfix
	name = "Transfix"
	overlay_state = "transfix"
	releasedrain = 100
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	include_user = 0
	max_targets = 1

/obj/effect/proc_holder/spell/targeted/transfix/cast(list/targets, mob/user = usr)
	var/msg = input("Soothe them. Dominate them. Speak and they will succumb.", "Transfix") as text|null
	if(length(msg) < 10)
		to_chat(user, span_userdanger("This is not enough!"))
		return FALSE
	var/bloodskill = user.mind.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d8")
	user.say(msg)
	for(var/mob/living/carbon/human/L in targets)
		var/datum/antagonist/vampirelord/VD = L.mind.has_antag_datum(/datum/antagonist/vampirelord)
		var/willpower = round(L.STAINT / 4)
		var/willroll = roll("[willpower]d6")
		if(VD)
			return
		if(L.cmode)
			willroll += 10
		var/found_psycross = FALSE
		for(var/obj/item/clothing/neck/roguetown/psycross/silver/I in L.contents) //Subpath fix.
			found_psycross = TRUE
			break

		if(bloodroll >= willroll)
			if(found_psycross == TRUE)
				to_chat(L, "<font color='white'>The silver psycross shines and protect me from the unholy magic.</font>")
				to_chat(user, span_userdanger("[L] has my BANE!It causes me to fail to ensnare their mind!"))
			else
				L.drowsyness = min(L.drowsyness + 50, 150)
				switch(L.drowsyness)
					if(0 to 50)
						to_chat(L, "You feel like a curtain is coming over your mind.")
						to_chat(user, "Their mind gives way slightly.")
						L.Slowdown(20)
					if(50 to 100)
						to_chat(L, "Your eyelids force themselves shut as you feel intense lethargy.")
						L.Slowdown(50)
						L.eyesclosed = TRUE
						for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
							eyet.update_icon(L)
						L.become_blind("eyelids")
						to_chat(user, "They will not be able to resist much more.")
					if(100 to INFINITY)
						to_chat(L, span_userdanger("You can't take it anymore. Your legs give out as you fall into the dreamworld."))
						to_chat(user, "They're mine now.")
						L.Slowdown(50)
						L.eyesclosed = TRUE
						for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
							eyet.update_icon(L)
						L.become_blind("eyelids")
						sleep(50)
						L.Sleeping(600)

		if(willroll >= bloodroll)
			if(found_psycross == TRUE)
				to_chat(L, "<font color='white'>The silver psycross shines and protect me from the unholy magic.</font>")
				to_chat(user, span_userdanger("[L] has my BANE!It causes me to fail to ensnare their mind!"))
			else
				to_chat(user, "I fail to ensnare their mind.")
			if(willroll - bloodroll >= 3)
				if(found_psycross == TRUE)
					to_chat(L, "<font color='white'> The silver psycross shines and protect me from the blood magic, the one who used blood magic was [user]!</font>")
				else
					to_chat(user, "I fail to ensnare their mind.")
					to_chat(L, "I feel like someone or something unholy is messing with my head. I should get out of here!")
					var/holyskill = L.mind.get_skill_level(/datum/skill/magic/holy)
					var/arcaneskill = L.mind.get_skill_level(/datum/skill/magic/arcane)
					if(holyskill + arcaneskill >= 1)
						to_chat(L, "I feel like the unholy magic came from [user]. I should use my magic or miracles on them.")

/obj/effect/proc_holder/spell/targeted/transfix/master
	name = "Subjugate"
	overlay_state = "transfixmaster"
	releasedrain = 1000
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	include_user = 0
	max_targets = 0

/obj/effect/proc_holder/spell/targeted/transfix/master/cast(list/targets, mob/user = usr)
	var/msg = input("Soothe them. Dominate them. Speak and they will succumb.", "Transfix") as text|null
	if(length(msg) < 10)
		to_chat(user, span_userdanger("This is not enough!"))
		return FALSE
	var/bloodskill = user.mind.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d10")
	user.say(msg)
	user.visible_message("<font color='red'>[user]'s eyes glow a ghastly red as they project their will outwards!</font>")
	for(var/mob/living/carbon/human/L in targets)
		var/datum/antagonist/vampirelord/VD = L.mind.has_antag_datum(/datum/antagonist/vampirelord)
		var/willpower = round(L.STAINT / 4)
		var/willroll = roll("[willpower]d6")
		if(VD)
			return
		if(L.cmode)
			willroll += 15
		if(bloodroll >= willroll)
			L.drowsyness = min(L.drowsyness + 50, 150)
			switch(L.drowsyness)
				if(0 to 50)
					to_chat(L, "You feel like a curtain is coming over your mind.")
					L.Slowdown(20)
				if(50 to 100)
					to_chat(L, "Your eyelids force themselves shut as you feel intense lethargy.")
					L.Slowdown(50)
					L.eyesclosed = TRUE
					for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
						eyet.update_icon(L)
					L.become_blind("eyelids")
				if(100 to INFINITY)
					to_chat(L, span_userdanger("You can't take it anymore. Your legs give out as you fall into the dreamworld."))
					L.eyesclosed = TRUE
					for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
						eyet.update_icon(L)
					L.become_blind("eyelids")
					L.Slowdown(50)
					sleep(50)
					L.Sleeping(300)
