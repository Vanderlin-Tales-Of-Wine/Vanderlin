/* Generic actions. */

/* ------TOOLS------ */
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

/* ------WEAPONS------ */
/* MELEE */

/// The most generic intent.
/datum/intent/hit
	name = "hit"
	icon_state = "instrike"
	attack_verb = list("hits", "strikes")

	item_damage_type = "blunt"

	chargetime = 0
	swingdelay = 0

/// Slice something.
/datum/intent/cut
	name = "cut"
	icon_state = "incut"
	attack_verb = list("cuts", "slashes")
	hitsound = list('sound/combat/hits/bladed/smallslash (1).ogg', 'sound/combat/hits/bladed/smallslash (2).ogg', 'sound/combat/hits/bladed/smallslash (3).ogg')
	animname = "cut"

	item_damage_type = "slash"
	blade_class = BCLASS_CUT

/// Swing at something.
/datum/intent/chop
	name = "chop"
	icon_state = "inchop"
	attack_verb = list("chops", "hacks")
	animname = "chop"
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')

	item_damage_type = "slash"
	blade_class = BCLASS_CHOP

/// Skewer something. Implies the object is big and long.
/datum/intent/impale
	name = "impale"
	icon_state = "instab"
	attack_verb = list("stabs")
	animname = "stab"
	warnie = "mobwarning" // I think it's supposed to be here?
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	blade_class = BCLASS_STAB
	item_damage_type = "stab"

/// Thrust into something. Implies the object is small and short.
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

/datum/intent/snip // The salvaging intent! Used only for the scissors for now!
	name = "snip"
	icon_state = "insnip"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0
	no_attack = TRUE
	releasedrain = 0
	blade_class = BCLASS_PUNCH

/* RANGED */
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
