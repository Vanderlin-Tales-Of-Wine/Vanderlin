/datum/objective/coin_flip
	name = "Flip Coin"
	var/obj/item/coin/required_coin_type = /obj/item/coin/gold
	var/winning_side

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

/datum/objective/coin_flip/proc/handle_coin_flip(datum/source, mob/user, obj/item/coin/our_coin, outcome)
	SIGNAL_HANDLER

	if(completed || !owner?.current || !istype(our_coin, required_coin_type))
		return

	if(outcome == winning_side)
		complete_objective(TRUE, our_coin)
	else
		complete_objective(FALSE, our_coin)

/datum/objective/coin_flip/proc/complete_objective(success, obj/item/coin/our_coin)
	if(completed)
		return

	var/mob/living/user = owner.current
	if(!istype(user))
		return

	if(success)
		if(prob(50))
			to_chat(user, span_greentext("The coin landed on the winning side! You won the game and earned Xylix's favor!"))
			user.adjust_triumphs(triumph_count)
			adjust_storyteller_influence("Xylix", 10)
		else
			change_rules(our_coin)
			return
	else
		to_chat(user, span_redtext("Sadly, the coin didn't land on the winning side... Better luck next time! Xylix takes the coin!"))
		qdel(our_coin)
		return

	completed = TRUE
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_COIN_FLIPPED)

/datum/objective/coin_flip/update_explanation_text()
	explanation_text = "Xylix wants to play a game! Simply flip a [initial(required_coin_type.name)] and see if you win! Only Xylix knows the rules! Or do they?"

/datum/objective/coin_flip/proc/change_rules(obj/item/coin/our_coin)
	var/list/coin_types = list(/obj/item/coin/copper, /obj/item/coin/silver, /obj/item/coin/gold) - required_coin_type
	var/obj/item/coin/new_coin_type = pick(coin_types)

	if(prob(80))
		to_chat(owner.current, span_notice("Oops, that wasn't actually the right coin! it was supposed to be a [initial(new_coin_type.name)]!"))
	else
		to_chat(owner.current, span_notice("Oops, that wasn't actually the right coin! it was supposed to be a [initial(new_coin_type.name)]! Wait, where did the coin go?"))
		qdel(our_coin)
	required_coin_type = new_coin_type
	update_explanation_text()
	owner.announce_personal_objectives()
