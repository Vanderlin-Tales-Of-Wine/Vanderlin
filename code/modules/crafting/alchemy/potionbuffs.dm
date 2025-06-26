/atom/movable/screen/alert/status_effect/buff/alch
	desc = "Power rushes through your veins."
	icon_state = "buff"

/datum/status_effect/buff/alch/strengthpot/weak
	effectedstats = list(STATKEY_STR = 1)

/datum/status_effect/buff/alch/strengthpot
	id = "strpot"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alch/strengthpot
	effectedstats = list(STATKEY_STR = 3)
	duration = 930

/atom/movable/screen/alert/status_effect/buff/alch/strengthpot
	name = "Strength"
	icon_state = "buff"

/datum/status_effect/buff/alch/perceptionpot/weak
	effectedstats = list(STATKEY_PER = 1)

/datum/status_effect/buff/alch/perceptionpot
	id = "perpot"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alch/perceptionpot
	effectedstats = list(STATKEY_PER = 3)
	duration = 3000

/atom/movable/screen/alert/status_effect/buff/alch/perceptionpot
	name = "Perception"
	icon_state = "buff"

/datum/status_effect/buff/alch/intelligencepot
	id = "intpot"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alch/intelligencepot
	effectedstats = list(STATKEY_INT = 3)
	duration = 3000

/atom/movable/screen/alert/status_effect/buff/alch/intelligencepot
	name = "Intelligence"
	icon_state = "buff"

/datum/status_effect/buff/alch/constitutionpot/weak
	effectedstats = list(STATKEY_CON = 1)

/datum/status_effect/buff/alch/constitutionpot
	id = "conpot"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alch/constitutionpot
	effectedstats = list(STATKEY_CON = 3)
	duration = 930

/atom/movable/screen/alert/status_effect/buff/alch/constitutionpot
	name = "Constitution"
	icon_state = "buff"

/datum/status_effect/buff/alch/endurancepot/weak
	effectedstats = list(STATKEY_END = 1)

/datum/status_effect/buff/alch/endurancepot
	id = "endpot"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alch/endurancepot
	effectedstats = list(STATKEY_END = 3)
	duration = 930

/atom/movable/screen/alert/status_effect/buff/alch/endurancepot
	name = "Endurance"
	icon_state = "buff"


/atom/movable/screen/alert/status_effect/buff/artemisia_luck
	name = "Artemisia Fortune"
	icon_state = "buff"

/datum/status_effect/buff/alch/artemisia_luck
	id = "artemisia_luck"
	alert_type = /atom/movable/screen/alert/status_effect/buff/artemisia_luck
	effectedstats = list(STATKEY_SPD = 1, STATKEY_LCK = 1)
	duration = 930

/datum/status_effect/buff/alch/speedpot
	id = "spdpot"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alch/speedpot
	effectedstats = list(STATKEY_SPD = 3)
	duration = 930

/atom/movable/screen/alert/status_effect/buff/alch/speedpot
	name = "Speed"
	icon_state = "buff"

/datum/status_effect/buff/alch/fortunepot
	id = "forpot"
	alert_type = /atom/movable/screen/alert/status_effect/buff/alch/fortunepot
	effectedstats = list(STATKEY_LCK = 3)
	duration = 3000

/atom/movable/screen/alert/status_effect/buff/alch/fortunepot
	name = "Fortune"
	icon_state = "buff"

