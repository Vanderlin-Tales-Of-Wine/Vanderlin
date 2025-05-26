/mob/camera/ancestral_spirit
	name = "Trapped Spirit"
	real_name = "Trapped Spirit"
	next_move_modifier = 0
	uses_intents = FALSE
	icon = 'icons/mob/cameramob.dmi'
	icon_state = "marker"
	invisibility = INVISIBILITY_OBSERVER
	mouse_opacity = MOUSE_OPACITY_ICON
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	see_invisible = SEE_INVISIBLE_LIVING
	uses_intents = FALSE
	lighting_alpha = LIGHTING_PLANE_ALPHA_INVISIBLE
	pass_flags = PASSCLOSEDTURF | PASSMOB | PASSTABLE
	next_move_modifier = 0
	var/obj/item/clothing/head/crown/serpcrown/containment
	/// beam attached to the projectile
	var/locomotion_hand_outgoing
	/// the beam pulling us in
	var/locomotion_hand_pulling
	/// the current astral projection we are controlling
	var/mob/dead/astral_projection/current_projection

	var/list/allowed_projection_objects = list(
		/obj/item/clothing/head/crown/serpcrown,
		/obj/structure/fake_machine/scomm,
	)

/mob/camera/ancestral_spirit/New(loc, crown)
	. = ..()
	containment = crown
	RegisterSignal(containment, COMSIG_MOVABLE_HEAR, PROC_REF(relay_speech_to_spirit))

/mob/camera/ancestral_spirit/Destroy()
	. = ..()
	UnregisterSignal(containment, COMSIG_MOVABLE_HEAR)

/mob/camera/ancestral_spirit/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	. = ..()
	relay_speech_to_containment(args)

/mob/camera/ancestral_spirit/proc/relay_speech_to_containment(datum/source, message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	var/list/arguments = args.Copy()
	arguments[forced] = TRUE
	containment.say(arguments)

/mob/camera/ancestral_spirit/proc/relay_speech_to_spirit(datum/source, ...)
	SIGNAL_HANDLER
	var/list/arguments = args.Copy()
	arguments.Cut(1,2)
	if(current_projection)
		current_projection.Hear(arguments)
		return
	Hear(arguments)

/obj/projectile/locomotion_hand
	name = "Cursed Hand"
	icon_state = "cursehand0"
	damage = 0
	range = 7
	speed = 0.7
	arcshot = TRUE

/mob/camera/ancestral_spirit/ClickOn(atom/A, params) // this chaining could be done on the parent instead
	. = ..()
	if(check_click_intercept(params,A))
		return

	if(SEND_SIGNAL(src, COMSIG_MOB_CLICKON, A, params) & COMSIG_MOB_CANCEL_CLICKON)
		return

	var/list/modifiers = params2list(params)

	// right click chain
	if((modifiers["right"]))
		right_click(A)
		return

	// left click chain
	else if((modifiers["left"]))
		left_click(A, modifiers)
		return

/mob/camera/ancestral_spirit/proc/left_click(atom/A, modifiers) // technically not only left click, but what matters is it's not right click
	if(modifiers["alt"])
		left_alt_click(A, modifiers)

/mob/camera/ancestral_spirit/proc/left_alt_click(atom/A, modifiers)
	locomotion(A)

/mob/camera/ancestral_spirit/proc/right_click(atom/A)
	if(ismob(A))
		recursive_projection(A)
		return

	manifest_projection(A)

/mob/camera/ancestral_spirit/proc/locomotion(atom/A)

	var/atom/hand = containment.fire_projectile(/obj/projectile/locomotion_hand, A)
	locomotion_hand_outgoing = containment.Beam(hand, icon_state = "curse0", maxdistance = 9, time = 10 SECONDS)
	RegisterSignal(hand, COMSIG_PROJECTILE_SELF_ON_HIT, PROC_REF(on_locomotion_hand_hit))
	update_overlays()

/mob/camera/ancestral_spirit/proc/on_locomotion_hand_hit(atom/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, list(COMSIG_PROJECTILE_SELF_ON_HIT))
	QDEL_NULL(locomotion_hand_outgoing)
	QDEL_NULL(locomotion_hand_pulling)
	locomotion_hand_pulling = containment.Beam(get_turf(source.loc), icon_state = "curse0", maxdistance = 9, time = 10 SECONDS)

	containment.throw_at(target = source, range = 9, speed = 0.7, spin = FALSE, callback = CALLBACK(src, PROC_REF(post_land)))

/mob/camera/ancestral_spirit/proc/post_land(datum/source)
	QDEL_NULL(locomotion_hand_pulling)

/mob/camera/ancestral_spirit/proc/recursive_projection(atom/A)
	for(var/atom/checked_atom in A.contents)
		if(manifest_projection(checked_atom))
			return TRUE

/mob/camera/ancestral_spirit/proc/manifest_projection(atom/A)
	if(!(A.type in allowed_projection_objects))
		return FALSE

	var/mob/dead/astral_projection/projection = new(A.loc, A)
	projection.spirit = src
	projection.ckey = ckey

	return TRUE
