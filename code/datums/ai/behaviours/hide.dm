
/datum/ai_behavior/hide
	required_distance = 1

/datum/ai_behavior/hide/perform(seconds_per_tick, datum/ai_controller/controller, target_key, hunger_timer_key)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	if(living_pawn.icon_state != "Trollso")
		living_pawn.icon_state = "Trollso"

	finish_action(controller, TRUE)
