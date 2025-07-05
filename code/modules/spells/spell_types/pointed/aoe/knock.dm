
/datum/action/cooldown/spell/aoe/knock
	name = "Knock"
	desc = "This spell opens nearby doors and closets."
	button_icon_state = "knock"

	school = SCHOOL_TRANSMUTATION
	cooldown_time = 10 SECONDS
	cooldown_reduction_per_rank = 2 SECONDS

	invocation = "AULIE OXIN FIERA"
	invocation_type = INVOCATION_WHISPER

	aoe_radius = 3

	attunements = list(
		/datum/attunement/aeromancy = 0.2,
	)

/datum/action/cooldown/spell/aoe/knock/get_things_to_cast_on(atom/center)
	return RANGE_TURFS(aoe_radius, center)

/datum/action/cooldown/spell/aoe/knock/cast_on_thing_in_aoe(turf/victim, atom/caster)
	SEND_SIGNAL(victim, COMSIG_ATOM_MAGICALLY_UNLOCKED, src, caster)
