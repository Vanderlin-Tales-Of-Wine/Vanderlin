/datum/surgery/lux_restore
	name = "Restore Lux"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/bestow_lux,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/bestow_lux
	name = "Infuse Lux"
	implements = list(
		/obj/item/reagent_containers/lux = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 10 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_EXPERT
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'

/datum/surgery_step/bestow_lux/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat == DEAD)
		return FALSE

	if(target.get_lux_status() == LUX_HAS_LUX)
		to_chat(user, "They do not need more Lux!")
		return FALSE

/datum/surgery_step/bestow_lux/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target, span_notice("I begin to implant lux into [target]..."),
		span_notice("[user] begins to work lux into [target]'s heart."),
		span_notice("[user] begins to work lux into [target]'s heart."))
	return TRUE

/datum/surgery_step/bestow_lux/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(target.get_lux_status() == LUX_NO_LUX)
		display_results(user, target, span_notice("You cannot infuse lux into these heatens!"),
		"[user] works the lux into [target]'s innards.",
		"[user] works the lux into [target]'s innards.")
		return FALSE
	display_results(user, target, span_notice("You succeed in integrating lux into [target]'s hearth."),
		"[user] works the lux into [target]'s innards.",
		"[user] works the lux into [target]'s innards.")
	target.emote("breathgasp")
	target.Jitter(100)
	target.update_body()
	qdel(tool)
	target.remove_status_effect(/datum/status_effect/buff/lux_drained)
	return TRUE

/datum/surgery_step/bestow_lux/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	display_results(user, target, span_warning("I screwed up!"),
		span_warning("[user] screws up!"),
		span_notice("[user] works the lux into [target]'s innards."), TRUE)
	return TRUE
