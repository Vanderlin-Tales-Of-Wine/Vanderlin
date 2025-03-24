/datum/antagonist/vampire/lord
	name = "Vampire Lord"
	antag_hud_name = "Vspawn"
	confess_lines = list(
		"I AM ANCIENT!",
		"I AM THE LAND!",
		"FIRSTBORNE CHILD OF KAIN!",
	)
	var/vamplevel = 0
	var/ascended = FALSE
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates
	var/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform/gas

/datum/antagonist/vampire/lord/on_gain()
	owner.purge_combat_knowledge()
	. = ..()

	ADD_TRAIT(owner.current, TRAIT_HEAVYARMOR, "[type]")

	owner.current.verbs |= /mob/living/carbon/human/proc/demand_submission
	owner.current.verbs |= /mob/living/carbon/human/proc/punish_spawn
	equip()
	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "Lord"), 5 SECONDS)

/datum/antagonist/vampire/lord/on_removal()
	if(!isnull(batform))
		owner.current.RemoveSpell(batform)
		QDEL_NULL(batform)
	. = ..()


/datum/antagonist/vampire/lord/greet()
	to_chat(owner.current, span_userdanger("I am ancient. I am the Land. And I am now awoken to trespassers upon my domain."))
	. = ..()

/datum/antagonist/vampire/lord/equip()
	. = ..()

	var/mob/living/carbon/human/H = owner.current
	var/obj/item/organ/eyes/eyes = owner.current.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(owner.current,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(owner.current)
	H.equipOutfit(/datum/outfit/job/vamplord)
	H.set_patron(/datum/patron/psydon) //Servant forever of he who is forgotten.

	return TRUE

/datum/antagonist/vampire/lord/on_life(mob/user)
	if(ascended)
		return
	vitae = team.vitae_pool.current
	. = ..()

/datum/antagonist/vampire/lord/exposed_to_sunlight()
	var/mob/living/carbon/human/H = owner
	to_chat(H, span_warning("Astrata spurns me! I must get out of her rays!")) // VLord is more punished for daylight excursions.
	var/turf/N = H.loc
	if(N.can_see_sky())
		if(N.get_lumcount() > 0.15)
			H.fire_act(3)
			handle_vitae(-500)
	to_chat(H, span_warning("That was too close. I must avoid the sun."))

/datum/antagonist/vampire/lord/handle_vitae(change, tribute)
	team.vitae_pool.update_pool(change)
	. = ..()

/datum/antagonist/vampire/lord/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vlord_starts))

/datum/antagonist/vampire/lord/proc/grow_in_power()
	if(vamplevel >= 3)
		return

	switch(++vamplevel)
		if(1)
			batform = new
			owner.current.AddSpell(batform)
			for(var/obj/structure/vampire/portalmaker/S in GLOB.vampire_objects)
				S.unlocked = TRUE
			for(var/statkey in MOBSTATS)
				owner.current.change_stat(statkey, 2)
			to_chat(owner, "<font color='red'>I am refreshed and have grown stronger. The visage of the bat is once again available to me. I can also once again access my portals.</font>")
		if(2)
			owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodsteal)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
			owner.adjust_skillrank(/datum/skill/magic/blood, 3, TRUE)
			gas = new
			owner.current.AddSpell(gas)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			to_chat(owner, "<font color='red'>My power is returning. I can once again access my spells. I have also regained usage of my mist form.</font>")
		if(3)
			for(var/obj/structure/vampire/necromanticbook/S in GLOB.vampire_objects)
				S.unlocked = TRUE
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_strength
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
			owner.current.RemoveSpell(/obj/effect/proc_holder/spell/targeted/transfix)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix/master)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			to_chat(owner, span_notice("My dominion over others minds and my own body returns to me. I am nearing perfection. The armies of the dead shall now answer my call."))
		if(4)
			owner.current.visible_message("<font color='red'>[owner.current] is enveloped in dark crimson, a horrific sound echoing in the area. They are evolved.</font>","<font color='red'>I AM ANCIENT, I AM THE LAND. EVEN THE SUN BOWS TO ME.</font>")
			ascended = TRUE
			SSmapping.retainer.ascended = TRUE
			for(var/datum/mind/thrall in SSmapping.retainer.vampires)
				if(thrall.special_role == "Vampire Spawn")
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_strength
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
					thrall.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
					for(var/S in MOBSTATS)
						thrall.current.change_stat(S, 2)

/datum/outfit/job/vamplord/pre_equip(mob/living/carbon/human/H)
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
	pants = /obj/item/clothing/pants/tights/black
	shirt = /obj/item/clothing/shirt/vampire
	belt = /obj/item/storage/belt/leather/plaquegold
	head  = /obj/item/clothing/head/vampire
	beltl = /obj/item/key/vampire
	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel/black
	H.ambushable = FALSE

/*------VERBS-----*/

// NEW VERBS
/mob/living/carbon/human/proc/demand_submission()
	set name = "Demand Submission"
	set category = "VAMPIRE"
	if(SSmapping.retainer.king_submitted)
		to_chat(src, span_warning("I am already the Master of Vanderlin."))
		return

	var/mob/living/carbon/ruler = SSticker.rulermob

	if(!ruler || (get_dist(src, ruler) > 1))
		to_chat(src, span_warning("The Master of Vanderlin is not beside me."))
		return

	if(ruler.stat <= CONSCIOUS)
		to_chat(src, span_warning("[ruler] is still conscious."))
		return

	switch(alert(ruler, "Submit and Pledge Allegiance to Lord [name]?", "SUBMISSION", "Yes", "No"))
		if("Yes")
			SSmapping.retainer.king_submitted = TRUE
		if("No")
			to_chat(ruler, span_boldnotice("I refuse!"))
			to_chat(src, span_boldnotice("[p_they(TRUE)] refuse[ruler.p_s()]!"))

/mob/living/carbon/human/proc/punish_spawn()
	set name = "Punish Minion"
	set category = "VAMPIRE"

	var/list/possible = list()
	for(var/datum/mind/V in SSmapping.retainer.vampires)
		if(V.special_role == "Vampire Spawn")
			possible[V.current.real_name] = V.current
	for(var/datum/mind/D in SSmapping.retainer.death_knights)
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
			addtimer(CALLBACK(choice, TYPE_PROC_REF(/mob/living, dust)), 10 SECONDS)
	visible_message(span_danger("[src] reaches out, gripping [choice]'s soul, inflicting punishment!"), ignored_mobs = list(choice))

/mob/proc/death_knight_spawn()
	SEND_SOUND(src, sound('sound/misc/notice (2).ogg'))
	if(alert(src, "A Vampire Lord is summoning you from the Underworld.", "Be Risen?", "Yes", "No") == "Yes")
		if(!has_world_trait(/datum/world_trait/death_knight))
			to_chat(src, span_warning("Another soul was chosen."))
		returntolobby()
