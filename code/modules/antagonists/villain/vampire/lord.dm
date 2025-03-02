/datum/antagonist/vampire/lord
	name = "Vampire Lord"
	antag_hud_name = "Vspawn"
	confess_lines = list(
		"I AM ANCIENT!",
		"I AM THE LAND!",
		"FIRSTBORNE CHILD OF KAIN!",
	)
	var/obj/structure/vampire/bloodpool/mypool
	var/list/datum/antagonist/vampire/lesser/thralls = list()

/datum/antagonist/vampire/lord/on_gain()
	. = ..()

	forge_objectives()
	owner.current.verbs |= /mob/living/carbon/human/proc/demand_submission
	owner.current.verbs |= /mob/living/carbon/human/proc/punish_spawn
	for(var/obj/structure/vampire/bloodpool/mansion in GLOB.vampire_objects)
		mypool = mansion
	equip()
	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "[type]"), 5 SECONDS)

/datum/antagonist/vampire/lord/greet()
	to_chat(owner.current, span_userdanger("I am ancient. I am the Land. And I am now awoken to these trespassers upon my domain."))
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
	vitae = mypool.current
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
	mypool.update_pool(change)
	if(tribute)
		mypool.update_pool(tribute)
	. = ..()

/datum/antagonist/vampire/lord/proc/forge_objectives()
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

/datum/antagonist/vampire/lord/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vlord_starts))

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
