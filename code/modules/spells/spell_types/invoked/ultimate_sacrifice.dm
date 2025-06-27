/obj/effect/proc_holder/spell/self/ultimate_sacrifice
	name = "Ultimate Sacrifice"
	overlay_state = "revive"
	antimagic_allowed = TRUE
	uses_mana = FALSE
	range = 1
	recharge_time = 0
	invocation = "RAVOX, HEAR MY PLEA!"
	invocation_type = "shout"

/obj/effect/proc_holder/spell/self/ultimate_sacrifice/cast(mob/living/carbon/human/user)
	if(user.stat == DEAD)
		to_chat(user, span_warning("You're already dead!"))
		return FALSE

	var/list/possible_targets = list()
	for(var/mob/living/carbon/human/H in view(7, user))
		if(H.stat == DEAD)
			possible_targets += H

	if(!possible_targets.len)
		to_chat(user, span_warning("There is no one around to revive!"))
		return FALSE

	var/mob/living/carbon/human/target = input(user, "Choose who to revive (this will kill you permanently)", "Ultimate Sacrifice") as null|anything in possible_targets
	if(!target)
		return FALSE

	var/confirm = alert(user, "Your life will be sacrificed to revive [target.real_name]. You CANNOT be revived after this. Are you absolutely sure?", "Ultimate Sacrifice", "Sacrifice Myself", "Cancel")
	if(confirm != "Sacrifice Myself")
		return FALSE

	user.visible_message(span_userdanger("[user] begins chanting Ravox's sacrificial rites!"), \
						span_userdanger("You feel Ravox's presence around you as you prepare to give your life..."))

	if(!do_after(user, 10 SECONDS, target = user))
		to_chat(user, span_warning("The ritual was interrupted!"))
		return FALSE

	confirm = alert(user, "LAST WARNING: This will KILL YOU PERMANENTLY and you CANNOT be revived. Proceed?", "Final Sacrifice", "Give My Life", "Cancel")
	if(confirm != "Give My Life" || !target || target.stat != DEAD || !Adjacent(target))
		return FALSE

	user.say("RAVOX, I GIVE MY LIFE FOR THEIRS!", forced = "ravox_ritual")
	user.emote("rage", forced = TRUE)

	var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
	if(underworld_spirit)
		var/mob/dead/observer/ghost = underworld_spirit.ghostize()
		qdel(underworld_spirit)
		ghost.mind.transfer_to(target, TRUE)
	target.grab_ghost(force = TRUE)

	target.revive(full_heal = TRUE, admin_revive = FALSE)

	playsound(user, 'sound/magic/churn.ogg', 100)
	ADD_TRAIT(user, TRAIT_NECRA_CURSE, "ravox_ritual")
	user.death()

	if(user.mind)
		var/datum/objective/ultimate_sacrifice/objective = locate() in user.mind.get_all_objectives()
		if(objective && !objective.completed)
			objective.completed = TRUE
			user.adjust_triumphs(objective.triumph_count)
			adjust_storyteller_influence("Ravox", 20)
			objective.escalate_objective()

	return ..()
