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
		to_chat(user, span_warning("You must hold a leech in your hands to transform it!"))
		return FALSE

	if(istype(target, /obj/item/natural/worms/leech/abyssoid))
		to_chat(user, span_warning("This leech is already blessed by Abyssor!"))
		return FALSE

	if(user.blood_volume < BLOOD_VOLUME_BAD)
		to_chat(user, span_warning("You don't have enough blood to sacrifice!"))
		return FALSE

	user.visible_message(span_warning("[user] begins stragely murmuring over [target]..."), \
						span_notice("You begin the transformation ritual, offering your blood to Abyssor."))

	if(!do_after(user, 10 SECONDS, target = user))
		to_chat(user, span_warning("The ritual was interrupted!"))
		return FALSE

	if(!(target in hand_items))
		to_chat(user, span_warning("You must keep holding the leech during the ritual!"))
		return FALSE

	if(user.blood_volume < BLOOD_VOLUME_BAD)
		to_chat(user, span_warning("You don't have enough blood to complete the ritual!"))
		return FALSE

	user.blood_volume = max(user.blood_volume - 70, 0)
	var/obj/item/natural/worms/leech/abyssoid/new_leech = new(user.drop_location())
	qdel(target)
	user.put_in_hands(new_leech)

	user.visible_message(span_warning("[user] completes the ritual, transforming the leech!"), \
						span_red("The leech transforms into a holy abyssoid leech!"))
	SEND_SIGNAL(user, COMSIG_ABYSSOID_CREATED)

	return ..()
