/obj/effect/proc_holder/spell/invoked/vicious_mimicry
	name = "Vicious Mimicry"
	desc = "Speak as a target in range."
	overlay_state = "mimicry"
	invocation_type = "none"
	charge_max = 1 MINUTES
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/xylix)
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/vicious_mimicry/cast(list/targets,mob/user = usr)
	if(!isliving(targets[1]))
		return FALSE
	var/mob/living/victim = targets[1]
	if(victim.anti_magic_check())
		to_chat(user, span_warning("Your manipulation of [victim] failed!"))
		return ..()
	var/forced_speak = input(user, "What should they say?", "Vicious Mimicry")
	if(!forced_speak)
		return FALSE
	to_chat(user, span_userdanger("Your mouth starts to move on its own!"))
	victim.say(forced_speak, forced = "spell")
	victim.log_message("[user] has forced [victim] to say '[forced_speak]' with Vicious Mimicry!")
	user.log_message("[user] has forced [victim] to say '[forced_speak]' with Vicious Mimicry!")
	return ..()
