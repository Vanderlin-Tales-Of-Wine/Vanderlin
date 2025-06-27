/obj/effect/proc_holder/spell/self/embrace_death
	name = "Embrace Death"
	overlay_state = "necra"
	antimagic_allowed = TRUE
	uses_mana = FALSE
	recharge_time = 0
	invocation = "NECRA, I AM READY!"
	invocation_type = "shout"
	sound = 'sound/ambience/noises/genspooky (1).ogg'

/obj/effect/proc_holder/spell/self/embrace_death/cast(mob/living/carbon/human/user)
	if(user.stat == DEAD)
		to_chat(user, span_warning("You're already dead!"))
		return FALSE

	var/confirm = alert(user, "This will END YOUR CHARACTER PERMANENTLY. Are you absolutely sure?", "Embrace Death", "Yes", "No")
	if(confirm != "Yes")
		return FALSE

	user.visible_message(span_userdanger("[user] begins chanting Necra's last rites!"), \
						span_userdanger("You feel Necra's presence as you start the final ritual..."))

	if(!do_after(user, 10 SECONDS, target = user))
		to_chat(user, span_warning("The ritual was interrupted!"))
		return FALSE

	confirm = alert(user, "LAST WARNING: This will KILL YOU PERMANENTLY. Proceed?", "Final Embrace", "Embrace Death", "Cancel")
	if(confirm != "Embrace Death")
		return FALSE

	user.say("NECRA, EMBRACE ME!", forced = "necra_ritual")
	playsound(user, 'sound/magic/churn.ogg', 100)
	ADD_TRAIT(user, TRAIT_NECRA_CURSE, "necra_ritual")
	ADD_TRAIT(user, TRAIT_BURIED_COIN_GIVEN, "necra_ritual")
	user.death()

	if(user.mind)
		var/datum/objective/embrace_death/objective = locate() in user.mind.get_all_objectives()
		if(objective && !objective.completed)
			objective.completed = TRUE
			user.adjust_triumphs(objective.triumph_count)
			adjust_storyteller_influence("Necra", 25)
			objective.escalate_objective()

	return ..()
