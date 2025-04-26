
/datum/ai_behavior/hide
	required_distance = 1

/datum/ai_behavior/hide/perform(seconds_per_tick, datum/ai_controller/controller, target_key, hunger_timer_key)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	if(istype(controller.pawn, /mob/living/simple_animal/hostile/retaliate/troll))
		var/mob/living/simple_animal/hostile/retaliate/troll/mob = living_pawn
		mob.hide()

	finish_action(controller, TRUE)
