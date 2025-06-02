/obj/effect/proc_holder/spell/invoked/haste
	name = "Haste"
	desc = "Cause a target to be magically hastened."
	cost = 3
	releasedrain = 25
	chargedrain = 1
	chargetime = 1 SECONDS
	recharge_time = 1.5 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/haste/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	spelltarget.apply_status_effect(/datum/status_effect/buff/duration_modification/haste,)
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] briefly shines yellow.")
	else
		user.visible_message("[user] mutters an incantation and they briefly shine yellow.")

	return TRUE
