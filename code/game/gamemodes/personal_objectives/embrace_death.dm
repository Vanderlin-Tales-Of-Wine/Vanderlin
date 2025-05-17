/datum/objective/embrace_death
	name = "Embrace Death"
	triumph_count = 0

/datum/objective/embrace_death/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.mind.AddSpell(new /obj/effect/proc_holder/spell/self/embrace_death)
	update_explanation_text()

/datum/objective/embrace_death/update_explanation_text()
	explanation_text = "Your time has come. Embrace death through Necra's gift to achieve final rest and secure your soul."

/obj/effect/proc_holder/spell/self/embrace_death
	name = "Embrace Death"
	overlay_state = "necra_gift"
	antimagic_allowed = TRUE
	recharge_time = 0
	invocation = "NECRA, EMBRACE ME!"
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

	if(!do_after(user, 15 SECONDS, target = user))
		to_chat(user, span_warning("The ritual was interrupted!"))
		return FALSE

	confirm = alert(user, "LAST WARNING: This will KILL YOU PERMANENTLY. Proceed?", "Final Embrace", "Embrace Death", "Cancel")
	if(confirm != "Embrace Death")
		return FALSE

	user.say("NECRA, TAKE ME!", forced = "necra_ritual")
	playsound(user, 'sound/magic/churn.ogg', 100)
	user.death()
	ADD_TRAIT(user, TRAIT_NECRA_CURSE, "necra_ritual")

	var/mob/dead/observer/ghost = user.get_ghost()
	if(!ghost)
		ghost = user.get_spirit()
	if(ghost && istype(ghost, /mob/living/carbon/spirit))
		var/mob/living/carbon/spirit/spirit = ghost
		spirit.paid = TRUE
		to_chat(spirit, span_rose("Necra has guaranteed your passage to the next life. Move on when you are ready."))

	if(user.mind)
		var/datum/objective/embrace_death/objective = locate() in user.mind.get_all_objectives()
		if(objective && !objective.completed)
			objective.completed = TRUE
			user.adjust_triumphs(3)
			adjust_storyteller_influence("Necra", 25)
			objective.escalate_objective()

	return TRUE
