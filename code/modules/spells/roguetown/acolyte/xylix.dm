/obj/effect/proc_holder/spell/invoked/vicious_mimicry
	name = "Vicious Mimicry"
	desc = "Speak as a target in range."
	overlay_state = "mimicry"
	invocation_type = "none"
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/xylix)
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/vicious_mimicry/cast(list/targets,mob/user = usr)
	if(!isliving(targets[1]))
		return FALSE
	var/forced_speak = input(user, "What should they say?", "Vicious Mimicry")
	if(!forced_speak)
		return FALSE
	var/mob/living/victim = targets[1]
	victim.say(forced_speak, forced = "spell")
	log_admin("[user] has forced [victim] to say '[forced_speak]' with Vicious Mimicry!")
	return ..()
