/datum/objective/coin_flip
	name = "Xylix's Gamble"
	triumph_count = 0
	var/required_coin_type = /obj/item/coin/gold
	var/winning_side = null // Will be set to either "heads" or "tails" randomly
	var/coin_flipped = FALSE

/datum/objective/coin_flip/on_creation()
	. = ..()
	winning_side = prob(50) ? "heads" : "tails"
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_COIN_FLIPPED, PROC_REF(handle_coin_flip))
	update_explanation_text()

/datum/objective/coin_flip/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_COIN_FLIPPED)
	return ..()

/datum/objective/coin_flip/proc/handle_coin_flip(datum/source, mob/user, obj/item/coin/coin, outcome)
	SIGNAL_HANDLER

	if(completed || !istype(coin, required_coin_type))
		return

	coin_flipped = TRUE

	if(outcome == winning_side)
		complete_objective(TRUE)
	else
		complete_objective(FALSE)

/datum/objective/coin_flip/proc/complete_objective(success)
	if(completed)
		return

	completed = TRUE

	var/mob/living/user = owner.current
	if(!istype(user))
		return

	if(success)
		to_chat(user, span_greentext("The coin landed on [winning_side]! Xylix smiles upon your luck!"))
		user.adjust_triumphs(1)
		adjust_storyteller_influence("Xylix", 15)
	else
		to_chat(user, span_redtext("The coin didn't land on [winning_side]... Better luck next time."))
		adjust_storyteller_influence("Xylix", -5) // Small penalty for failure

	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_COIN_FLIPPED)

/datum/objective/coin_flip/update_explanation_text()
	explanation_text = "Flip a gold coin (zenar). If it lands on [winning_side], you win Xylix's favor."
