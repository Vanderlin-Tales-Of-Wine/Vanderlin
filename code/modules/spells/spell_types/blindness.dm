/obj/effect/proc_holder/spell/invoked/blindness
	name = "Blindness"
	desc = "Point at a target to blind them for few seconds."
	overlay_state = "blindness"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/churn.ogg'
	invocation_type = "none"
	antimagic_allowed = TRUE
	recharge_time = 2 MINUTES
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/arcyne = 0.1
		)

/obj/effect/proc_holder/spell/invoked/blindness/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		user.visible_message(span_warning("[user] points at [target]'s eyes!"), span_warning("My eyes are covered in darkness!"))
		target.blind_eyes(3)
		return ..()
	return FALSE
