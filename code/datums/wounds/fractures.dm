/datum/wound/fracture
	name = "fracture"
	check_name = "<span class='bone'><B>FRACTURE</B></span>"
	severity = WOUND_SEVERITY_SEVERE
	crit_message = list(
		"The bone shatters!",
		"The bone is broken!",
		"The %BODYPART is mauled!",
		"The bone snaps through the skin!",
	)
	sound_effect = "wetbreak"
	whp = 40
	woundpain = 60
	mob_overlay = "frac"
	can_sew = FALSE
	can_cauterize = FALSE
	disabling = TRUE
	critical = TRUE
	sleep_healing = 0 // no sleep healing that is dumb

	werewolf_infection_probability = 0
	/// Whether or not we can be surgically set
	var/can_set = TRUE
	/// Emote we use when applied
	var/gain_emote = "paincrit"

/datum/wound/fracture/get_visible_name(mob/user)
	. = ..()
	if(passive_healing)
		. += " <span class='green'>(set)</span>"

/datum/wound/fracture/can_stack_with(datum/wound/other)
	if(istype(other, /datum/wound/fracture) && (type == other.type))
		return FALSE
	return TRUE

/datum/wound/fracture/on_mob_gain(mob/living/affected)
	. = ..()
	if(gain_emote)
		affected.emote(gain_emote, TRUE)
	affected.Slowdown(20)
	shake_camera(affected, 2, 2)

/datum/wound/fracture/proc/set_bone()
	if(!can_set)
		return FALSE
	sleep_healing = max(sleep_healing, 1)
	passive_healing = max(passive_healing, 1)
	heal_wound(initial(whp)/1.6) //heal a little more than of maximum fracture
	can_set = FALSE
	return TRUE

/datum/wound/fracture/head
	name = "cranial fracture"
	check_name = "<span class='bone'><B>SKULLCRACK</B></span>"
	crit_message = list(
		"The skull shatters in a gruesome way!",
		"The head is smashed!",
		"The skull is broken!",
		"The skull caves in!",
	)
	sound_effect = "headcrush"
	whp = 80
	sleep_healing = 0
	/// Most head fractures are serious enough to cause paralysis
	var/paralysis = FALSE
	/// Some head fractures are so serious they cause instant death
	var/mortal = FALSE
	/// Funny easter egg
	var/dents_brain = TRUE

/datum/wound/fracture/head/New()
	. = ..()
	if(dents_brain && prob(1))
		name = "dentbrain"
		check_name = "<span class='bone'><B>DENTBRAIN</B></span>"

/datum/wound/fracture/head/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(affected, TRAIT_DISFIGURED, "[type]")
	if(paralysis)
		ADD_TRAIT(affected, TRAIT_NO_BITE, "[type]")
		ADD_TRAIT(affected, TRAIT_PARALYSIS, "[type]")
		ADD_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")
		ADD_TRAIT(affected, TRAIT_DEAF, "[type]")
		ADD_TRAIT(affected, TRAIT_NOPAIN, "[type]")
		affected.become_nearsighted()
		if(iscarbon(affected))
			var/mob/living/carbon/carbon_affected = affected
			carbon_affected.update_disabled_bodyparts()
	if(mortal && HAS_TRAIT(affected, TRAIT_CRITICAL_WEAKNESS))
		affected.death()

/datum/wound/fracture/head/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_DISFIGURED, "[type]")
	if(paralysis)
		REMOVE_TRAIT(affected, TRAIT_NO_BITE, "[type]")
		REMOVE_TRAIT(affected, TRAIT_PARALYSIS, "[type]")
		REMOVE_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")
		REMOVE_TRAIT(affected, TRAIT_DEAF, "[type]")
		REMOVE_TRAIT(affected, TRAIT_NOPAIN, "[type]")
		affected.cure_nearsighted()
		if(iscarbon(affected))
			var/mob/living/carbon/carbon_affected = affected
			carbon_affected.update_disabled_bodyparts()

/datum/wound/fracture/head/on_life()
	. = ..()
	owner.stuttering = max(owner.stuttering, 5)

/datum/wound/fracture/head/brain
	name = "depressed cranial fracture"
	crit_message = list(
		"The cranium is fractured!",
		"The cranium is cracked!",
		"The cranium is torn!",
	)
	whp = 150
	paralysis = TRUE
	mortal = TRUE
	dents_brain = TRUE

/datum/wound/fracture/head/brain/on_life()
	. = ..()
	owner.adjustOxyLoss(2.5)

/datum/wound/fracture/head/eyes
	name = "orbital fracture"
	crit_message = list(
		"The orbital bone is fractured!",
		"The orbital bone is cracked!",
	)
	paralysis = FALSE
	mortal = TRUE
	dents_brain = FALSE

/datum/wound/fracture/head/ears
	name = "temporal fracture"
	crit_message = list(
		"The temporal bone is fractured!",
		"The temporal bone is cracked!",
	)
	paralysis = FALSE
	mortal = TRUE
	dents_brain = FALSE

/datum/wound/fracture/head/nose
	name = "nasal fracture"
	crit_message = list(
		"The nasal bone is fractured!",
		"The nasal bone is shattered!",
	)
	paralysis = FALSE
	mortal = FALSE
	dents_brain = FALSE

/datum/wound/fracture/mouth
	name = "mandibular fracture"
	check_name = "<span class='bone'>JAW FRACTURE</span>"
	crit_message = list(
		"The mandible comes apart beautifully!",
		"The jaw is smashed!",
		"The jaw is shattered!",
		"The jaw caves in!",
	)
	whp = 50
	sleep_healing = 0

/datum/wound/fracture/mouth/on_mob_gain(mob/living/affected)
	. = ..()
	ADD_TRAIT(affected, TRAIT_NO_BITE, "[type]")
	ADD_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")

/datum/wound/fracture/mouth/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_NO_BITE, "[type]")
	REMOVE_TRAIT(affected, TRAIT_GARGLE_SPEECH, "[type]")

/datum/wound/fracture/neck
	name = "cervical fracture"
	check_name = "<span class='bone'><B>NECK</B></span>"
	crit_message = list(
		"The spine shatters in a spectacular way!",
		"The spine snaps!",
		"The spine cracks!",
		"The spine is broken!",
	)
	whp = 150
	sleep_healing = 0

/datum/wound/fracture/neck/on_mob_gain(mob/living/affected)
	. = ..()
	//fuck this is stupid
	if(!istype(affected, /mob/living/carbon/human/species/skeleton/death_arena))
		ADD_TRAIT(affected, TRAIT_PARALYSIS, "[type]")
		ADD_TRAIT(affected, TRAIT_NOPAIN, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()
	if(HAS_TRAIT(affected, TRAIT_CRITICAL_WEAKNESS))
		affected.death()

/datum/wound/fracture/neck/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_PARALYSIS, "[type]")
	REMOVE_TRAIT(affected, TRAIT_NOPAIN, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()

/datum/wound/fracture/neck/on_life()
	. = ..()
	owner.adjustOxyLoss(2.5)

/datum/wound/fracture/chest
	name = "rib fracture"
	check_name = "<span class='bone'><B>RIBS</B></span>"
	crit_message = list(
		"The ribs shatter in a splendid way!",
		"The ribs are smashed!",
		"The ribs are mauled!",
		"The ribcage caves in!",
	)
	whp = 50

/datum/wound/fracture/chest/on_mob_gain(mob/living/affected)
	. = ..()
	affected.Stun(20)

/datum/wound/fracture/groin
	name = "pelvic fracture"
	check_name = "<span class='bone'><B>PELVIS</B></span>"
	crit_message = list(
		"The pelvis shatters in a magnificent way!",
		"The pelvis is smashed!",
		"The pelvis is mauled!",
		"The pelvic floor caves in!",
	)
	whp = 50
	gain_emote = "groin"

/datum/wound/fracture/groin/New()
	. = ..()
	if(prob(1))
		name = "broken buck"
		check_name = "<span class='bone'>BUCKBROKEN</span>"
		crit_message = "The buck is broken expertly!"

/datum/wound/fracture/groin/on_mob_gain(mob/living/affected)
	. = ..()
	affected.Stun(20)
	ADD_TRAIT(affected, TRAIT_PARALYSIS_R_LEG, "[type]")
	ADD_TRAIT(affected, TRAIT_PARALYSIS_L_LEG, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()

/datum/wound/fracture/groin/on_mob_loss(mob/living/affected)
	. = ..()
	REMOVE_TRAIT(affected, TRAIT_PARALYSIS_R_LEG, "[type]")
	REMOVE_TRAIT(affected, TRAIT_PARALYSIS_L_LEG, "[type]")
	if(iscarbon(affected))
		var/mob/living/carbon/carbon_affected = affected
		carbon_affected.update_disabled_bodyparts()
