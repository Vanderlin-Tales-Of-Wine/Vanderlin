/datum/ai_planning_subtree/generic_resist/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/living_pawn = controller.pawn

	if(controller.blackboard[BB_RESISTING])
		controller.queue_behavior(/datum/ai_behavior/resist) //KEEP TRYING TO RESIST
		return SUBTREE_RETURN_FINISH_PLANNING //JUST KEEP DOING IT PLEASE
	if(SHOULD_RESIST(living_pawn) && SPT_PROB(75, seconds_per_tick))
		controller.queue_behavior(/datum/ai_behavior/resist) //BRO IM ON FUCKING FIRE BRO
		return SUBTREE_RETURN_FINISH_PLANNING //IM NOT DOING ANYTHING ELSE BUT EXTINGUISH MYSELF, GOOD GOD HAVE MERCY.

/datum/ai_behavior/resist/perform(seconds_per_tick, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	living_pawn.ai_controller.set_blackboard_key(BB_RESISTING, TRUE)
	living_pawn.execute_resist()
	finish_action(controller, TRUE)
	return TRUE

/datum/ai_behavior/resist/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	if(QDELETED(living_pawn))
		return
	if(SHOULD_RESIST(living_pawn))
		living_pawn.ai_controller.set_blackboard_key(BB_RESISTING, TRUE)
	else
		living_pawn.ai_controller.set_blackboard_key(BB_RESISTING, FALSE)
