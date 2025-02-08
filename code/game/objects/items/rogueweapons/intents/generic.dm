/* Generic actions. */

/* TOOLS */
/datum/intent/use
	name = "use"
	icon_state = "inuse"
	blade_class = BCLASS_PUNCH

	item_damage_type = "blunt"
	intent_flags = (INTENT_UNDODGEABLE | INTENT_UNPARRYABLE)
	noaa = TRUE
	no_attack = TRUE

	misscost = 0
	releasedrain = 0

/* WEAPONS */
/datum/intent/hit
	name = "hit"
	icon_state = "instrike"
	attack_verb = list("hits", "strikes")

	item_damage_type = "blunt"

	chargetime = 0
	swingdelay = 0

/datum/intent/stab
	name = "stab"
	icon_state = "instab"
	attack_verb = list("stabs")
	animname = "stab"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')

	blade_class = BCLASS_STAB
	item_damage_type = "stab"

	chargetime = 0
	swingdelay = 0

/datum/intent/pick
	name = "pick"
	icon_state = "inpick"
	attack_verb = list("picks","impales")
	hitsound = list('sound/combat/hits/pick/genpick (1).ogg', 'sound/combat/hits/pick/genpick (2).ogg')

	item_damage_type = "stab"
	animname = "strike"

	blade_class = BCLASS_PICK
	chargetime = 0
	swingdelay = 3

/datum/intent/shoot //shooting crossbows or other guns, no parrydrain
	name = "shoot"
	icon_state = "inshoot"
	tranged = 1
	warnie = "aimwarn"
	chargetime = 0.1
	no_early_release = FALSE
	item_damage_type = "stab"
	noaa = TRUE
	charging_slowdown = 2
	warnoffset = 20

/datum/intent/shoot/prewarning()
	if(masteritem && mastermob)
		mastermob.visible_message(span_warning("[mastermob] aims [masteritem]!"))

/datum/intent/arc
	name = "arc"
	icon_state = "inarc"
	tranged = 1
	warnie = "aimwarn"
	item_damage_type = "blunt"
	chargetime = 0
	no_early_release = FALSE
	noaa = TRUE
	charging_slowdown = 3
	warnoffset = 20

/// ???
/datum/intent/proc/arc_check()
	return FALSE

/datum/intent/arc/arc_check()
	return TRUE

/datum/intent/arc/prewarning()
	if(masteritem && mastermob)
		mastermob.visible_message(span_warning("[mastermob] aims [masteritem]!"))
