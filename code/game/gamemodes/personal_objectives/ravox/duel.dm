/datum/objective/ravox_duel
	name = "Honor Duels"
	var/duels_won = 0
	var/duels_required = 2

/datum/objective/ravox_duel/on_creation()
	. = ..()
	duels_required = prob(66) ? 1 : 2
	if(owner?.current)
		owner.current.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/ravox_challenge)
	update_explanation_text()

/datum/objective/ravox_duel/proc/on_duel_won()
	duels_won++
	if(duels_won >= duels_required && !completed)
		to_chat(owner.current, span_greentext("You have proven your worth in combat! Ravox is pleased!"))
		owner.current.adjust_triumphs(triumph_count * duels_required)
		completed = TRUE
		adjust_storyteller_influence("Ravox", duels_required * 10)
		escalate_objective()

/datum/objective/ravox_duel/update_explanation_text()
	explanation_text = "Win [duels_required] duel\s with honor against other warriors to prove your might!"
