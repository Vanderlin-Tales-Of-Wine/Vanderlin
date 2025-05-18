/obj/effect/proc_holder/spell/self/create_abyssoid
	name = "Create Abyssoid"
	overlay_state = "bloodsteal"
	chargedrain = 0
	chargetime = 0
	range = -1
	movement_interrupt = TRUE
	invocation_type = "none"
	miracle = FALSE
	devotion_cost = 0
	uses_mana = FALSE
	healing_miracle = FALSE

/obj/effect/proc_holder/spell/self/create_abyssoid/cast(mob/living/user)
	var/obj/item/natural/worms/leech/target
	var/list/hand_items = list(user.get_active_held_item(), user.get_inactive_held_item())

	for(var/obj/item/natural/worms/leech/leech in hand_items)
		target = leech
		break

	if(!target)
		to_chat(user, "<span class='warning'>You must hold a leech in your hands to transform it!</span>")
		return FALSE

	if(istype(target, /obj/item/natural/worms/leech/abyssoid))
		to_chat(user, "<span class='warning'>This leech is already blessed by Abyssor!</span>")
		return FALSE

	if(user.blood_volume < BLOOD_VOLUME_BAD)
		to_chat(user, "<span class='warning'>You don't have enough blood to sacrifice!</span>")
		return FALSE

	user.visible_message("<span class='warning'>[user] begins stragely murmuring over [target]...</span>", \
						"<span class='notice'>You begin the transformation ritual, offering your blood to Abyssor.</span>")

	if(!do_after(user, 10 SECONDS, target = user))
		to_chat(user, "<span class='warning'>The ritual was interrupted!</span>")
		return FALSE

	if(!(target in hand_items))
		to_chat(user, "<span class='warning'>You must keep holding the leech during the ritual!</span>")
		return FALSE

	if(user.blood_volume < BLOOD_VOLUME_BAD)
		to_chat(user, "<span class='warning'>You don't have enough blood to complete the ritual!</span>")
		return FALSE

	user.blood_volume = max(user.blood_volume - 60, 0)
	var/obj/item/natural/worms/leech/abyssoid/new_leech = new(user.drop_location())
	qdel(target)
	user.put_in_hands(new_leech)

	user.visible_message("<span class='warning'>[user] completes the ritual, transforming the leech!</span>", \
						"<span class='red'>The leech transforms into a holy abyssoid leech!</span>")
	SEND_SIGNAL(user, COMSIG_ABYSSOID_CREATED)

	return TRUE
