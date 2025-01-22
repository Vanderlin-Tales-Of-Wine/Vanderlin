/datum/surgery/healing
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/heal,
		/datum/surgery_step/cauterize,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/heal
	name = "Repair body"
	implements = list(
		TOOL_SUTURE = 80,
		TOOL_HEMOSTAT = 60,
		TOOL_IMPROVISED_HEMOSTAT = 50,
		TOOL_SCREWDRIVER = 50,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 4 SECONDS
	requires_tech = TRUE
	replaced_by = /datum/surgery_step
	repeating = TRUE
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED
	skill_min = SKILL_LEVEL_APPRENTICE
	skill_median = SKILL_LEVEL_APPRENTICE
	/// How much brute damage we heal per completion
	var/brutehealing = 0
	/// How much burn damage we heal per completion
	var/burnhealing = 0
	/**
	 * Heals an extra point of damager per X missing damage of type (burn damage for burn healing, brute for brute)
	 * Smaller Number = More Healing!
	 */
	var/missinghpbonus = 0

/datum/surgery_step/heal/validate_tech(mob/user, mob/living/target, target_zone, datum/intent/intent)
	if(!brutehealing && !burnhealing)
		return FALSE
	return ..()

/datum/surgery_step/heal/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(!.)
		return
	if(!((brutehealing && target.getBruteLoss()) || (burnhealing && target.getFireLoss())))
		return FALSE

/datum/surgery_step/heal/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/woundtype
	if(brutehealing && burnhealing)
		woundtype = "wounds"
	else if(brutehealing)
		woundtype = "bruises"
	else //why are you trying to 0,0...?
		woundtype = "burns"
	display_results(user, target, "<span class='notice'>I attempt to patch some of [target]'s [woundtype].</span>",
			"<span class='notice'>[user] attempts to patch some of [target]'s [woundtype].</span>",
			"<span class='notice'>[user] attempts to patch some of [target]'s [woundtype].</span>")
	return TRUE

/datum/surgery_step/heal/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	var/umsg = "You succeed in fixing some of [target]'s wounds" //no period, add initial space to "addons"
	var/tmsg = "[user] fixes some of [target]'s wounds" //see above
	var/healing_multiplier = 1
	switch(user.mind?.get_skill_level(skill_used))
		if(SKILL_LEVEL_JOURNEYMAN)
			healing_multiplier = 1.1
		if(SKILL_LEVEL_EXPERT)
			healing_multiplier = 1.3
		if(SKILL_LEVEL_MASTER)
			healing_multiplier = 1.4
		if(SKILL_LEVEL_LEGENDARY)
			healing_multiplier = 1.5
	var/urhealedamt_brute = brutehealing * healing_multiplier
	var/urhealedamt_burn = burnhealing * healing_multiplier
	if(missinghpbonus)
		if(target.stat != DEAD)
			urhealedamt_brute += round((target.getBruteLoss()/ missinghpbonus),0.1)
			urhealedamt_burn += round((target.getFireLoss()/ missinghpbonus),0.1)
		else //less healing bonus for the dead since they're expected to have lots of damage to begin with (to make TW into defib not TOO simple)
			urhealedamt_brute += round((target.getBruteLoss()/ (missinghpbonus*5)),0.1)
			urhealedamt_burn += round((target.getFireLoss()/ (missinghpbonus*5)),0.1)
	if(!get_location_accessible(target, target_zone))
		urhealedamt_brute *= 0.55
		urhealedamt_burn *= 0.55
		umsg += " as best as you can while they have clothing on"
		tmsg += " as best as they can while [target] has clothing on"
	target.heal_bodypart_damage(urhealedamt_brute,urhealedamt_burn)
	display_results(user, target, "<span class='notice'>[umsg].</span>",
		"[tmsg].",
		"[tmsg].")
	return TRUE

/datum/surgery_step/heal/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	display_results(user, target, "<span class='warning'>I screwed up!</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] fixes some of [target]'s wounds.</span>", TRUE)
	var/urdamageamt_burn = brutehealing * 0.8
	var/urdamageamt_brute = burnhealing * 0.8
	if(missinghpbonus)
		urdamageamt_brute += round((target.getBruteLoss()/(missinghpbonus*2)),0.1)
		urdamageamt_burn += round((target.getFireLoss()/(missinghpbonus*2)),0.1)

	target.take_bodypart_damage(urdamageamt_brute, urdamageamt_burn)
	return TRUE

/********************BRUTE STEPS********************/
/datum/surgery_step/heal/brute/basic
	name = "Tend bruises"
	brutehealing = 10
	missinghpbonus = 7.5
	requires_tech = FALSE
	replaced_by = /datum/surgery_step/heal/brute/upgraded

/datum/surgery_step/heal/brute/upgraded
	name = "Tend bruises (Adv.)"
	brutehealing = 10
	missinghpbonus = 5
	requires_tech = TRUE
	replaced_by = /datum/surgery_step/heal/brute/upgraded/femto

/datum/surgery_step/heal/brute/upgraded/femto
	name = "Tend bruises (Exp.)"
	brutehealing = 10
	missinghpbonus = 2.5
	requires_tech = TRUE
	replaced_by = null

/********************BURN STEPS********************/
/datum/surgery_step/heal/burn/basic
	name = "Tend burns"
	burnhealing = 10
	missinghpbonus = 7.5
	requires_tech = FALSE
	replaced_by = /datum/surgery_step/heal/burn/upgraded

/datum/surgery_step/heal/burn/upgraded
	name = "Tend burns (Adv.)"
	burnhealing = 10
	missinghpbonus = 5
	requires_tech = TRUE
	replaced_by = /datum/surgery_step/heal/burn/upgraded/femto

/datum/surgery_step/heal/burn/upgraded/femto
	name = "Tend burns (Exp.)"
	burnhealing = 10
	missinghpbonus = 2.5
	requires_tech = TRUE
	replaced_by = null

/********************COMBO STEPS********************/
/datum/surgery_step/heal/combo
	name = "Tend damage"
	brutehealing = 6
	burnhealing = 6
	missinghpbonus = 7.5
	requires_tech = FALSE
	replaced_by = /datum/surgery_step/heal/combo/upgraded

/datum/surgery_step/heal/combo/upgraded
	name = "Tend damage (Adv.)"
	brutehealing = 6
	burnhealing = 6
	missinghpbonus = 5
	requires_tech = TRUE
	replaced_by = /datum/surgery_step/heal/combo/upgraded/femto

/datum/surgery_step/heal/combo/upgraded/femto
	name = "Tend damage (Exp.)"
	brutehealing = 6
	burnhealing = 6
	missinghpbonus = 2.5
	requires_tech = TRUE
	replaced_by = null

/datum/surgery_step/heal/combo/upgraded/femto/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	display_results(user, target, "<span class='warning'>I screwed up!</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] fixes some of [target]'s wounds.</span>", TRUE)
	target.take_bodypart_damage(5,5)
	return TRUE
