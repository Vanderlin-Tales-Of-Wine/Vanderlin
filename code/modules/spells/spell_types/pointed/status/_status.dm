/**
 * ## Status effect spells
 *
 * Spells that grant a status effect to a living mob.
 *
 * Always applies the effect onto cast_on but extra targt handling can extend cast.
 *
 * Set cooldown_time to null to inherit the duration
 */
/datum/action/cooldown/spell/status
	pointed_spell = TRUE

	/// Path of status effect to add
	var/datum/status_effect/status_effect = /datum/status_effect/buff/calm
	/// Duration of the status effect
	var/duration = 5 MINUTES
	/// If attunement strength scales the duration
	var/duration_scaling = FALSE
	/// Base duration increase, if null multiply duration by attuned strength
	var/duration_modification = 2 MINUTES

/datum/action/cooldown/spell/status/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/status/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	if(duration_scaling)
		if(duration_modification)
			duration += duration_modification * attuned_strength
		else
			duration *= attuned_strength

/datum/action/cooldown/spell/status/cast(mob/living/cast_on)
	. = ..()
	cast_on.apply_status_effect(status_effect, duration)
	cooldown_time = cooldown_time || duration
