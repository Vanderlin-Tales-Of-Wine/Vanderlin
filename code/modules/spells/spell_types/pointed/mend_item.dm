/datum/action/cooldown/spell/mend_item
	name = "Mend Item"
	desc = "Use arcyne energy to mend an item."
	point_cost = 1
	sound = 'sound/magic/whiteflame.ogg'


	attunements = list(
		/datum/attunement/life = 1.2
	)

	charge_time = 3 SECONDS
	cooldown_time = 30 SECONDS
	spell_cost = 40

	/// Amount to repair by
	var/repair_percent = 0.25

/datum/action/cooldown/spell/mend_item/is_valid_target(atom/cast_on)
	return isitem(cast_on)

/datum/action/cooldown/spell/mend_item/cast(obj/item/cast_on)
	. = ..()
	var/integrity = cast_on.obj_integrity
	var/max_integrity = cast_on.max_integrity
	if(integrity >= max_integrity)
		to_chat(owner, span_info("\The [cast_on] appears to be in pefect condition."))
		return
	var/new_intregrity =  min(max_integrity, integrity + (max_integrity * repair_percent))
	cast_on.visible_message(span_info("[cast_on] glows in a faint green light."))

	if(cast_on.obj_broken == TRUE)
		cast_on.obj_broken = FALSE
