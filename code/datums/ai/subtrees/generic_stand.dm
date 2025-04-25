/datum/ai_planning_subtree/generic_stand/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/living_pawn = controller.pawn

	if(SHOULD_STAND(living_pawn) && SPT_PROB(50, seconds_per_tick) && !HAS_TRAIT(living_pawn, TRAIT_FLOORED))
		controller.queue_behavior(/datum/ai_behavior/stand) //BRO IM ON FUCKING FIRE BRO
		return SUBTREE_RETURN_FINISH_PLANNING //IM NOT DOING ANYTHING ELSE BUT EXTINGUISH MYSELF, GOOD GOD HAVE MERCY.

/datum/ai_behavior/stand/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/carbon/human/living_pawn = controller.pawn
	living_pawn.npc_stand()
	finish_action(controller, TRUE)
	return TRUE
