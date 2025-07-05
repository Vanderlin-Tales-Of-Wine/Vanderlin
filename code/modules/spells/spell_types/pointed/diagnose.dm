/datum/action/cooldown/spell/diagnose
	name = "Secular Diagnosis"
	desc = "Check the wounds of the target."
	button_icon_state = "diagnose"
	sound = 'sound/magic/diagnose.ogg'

	cast_range = 2
	associated_skill = /datum/skill/misc/medicine

	charge_required = FALSE
	cooldown_time = 15 SECONDS
	spell_cost = 0

/datum/action/cooldown/spell/diagnose/is_valid_target(atom/cast_on)
	return ishuman(cast_on)

/datum/action/cooldown/spell/diagnose/cast(mob/living/carbon/human/cast_on)
	. = ..()
	cast_on.check_for_injuries(owner, additional = TRUE)

/datum/action/cooldown/spell/diagnose/holy
	name = "Diagnosis"

	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy

	spell_cost = 10
