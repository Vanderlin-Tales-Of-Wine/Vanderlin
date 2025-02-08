/**
 * Simple intents used by simplemobs.
 *
 * For when we really just want them to hit stuff,
 * and don't want them to have the abilities that come with these intents.
 */
/datum/intent/simple

/datum/intent/simple/headbutt
	name = "headbutt"
	icon_state = "instrike"
	attack_verb = list("headbutts", "rams")
	animname = "smash"
	blade_class = BCLASS_BLUNT
	hitsound = "punch_hard"
	chargetime = 0
	penfactor = 13
	swingdelay = 0
	item_damage_type = "blunt"
	miss_text = "thrusts their head at nothing!"
	miss_sound = PUNCHWOOSH

/datum/intent/simple/claw
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("slashes", "claws")
	animname = "claw"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 5
	swingdelay = 1
	miss_text = "slashes the air!"
	item_damage_type = "slash"

/datum/intent/simple/peck
	name = "peck"
	icon_state = "instrike"
	attack_verb = list("pecks", "scratches")
	animname = "blank22"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 2
	swingdelay = 1
	miss_text = "pecks the air!"
	item_damage_type = "stab"

/datum/intent/simple/bite
	name = "bite"
	icon_state = "instrike"
	attack_verb = list("bites")
	animname = "bite"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 0
	swingdelay = 1
	item_damage_type = "stab"
	miss_text = "bites the air!"

//Applies no wounds.
/datum/intent/simple/touch
	name = "touch"
	icon_state = "instrike"
	attack_verb = list("grasps", "touches", "taps")
	animname = "blank22"
	blade_class = null
	hitsound = "punch_hard"
	chargetime = 0
	penfactor = 25
	swingdelay = 1

/datum/intent/simple/sting
	name = "sting"
	icon_state = "instrike"
	attack_verb = list("stings")
	animname = "blank22"
	blade_class = BCLASS_STAB
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 1
	swingdelay = 0

	intent_flags = (INTENT_UNPARRYABLE | INTENT_UNDODGEABLE)

	miss_text = "stings the air!"
	item_damage_type = "stab"

/datum/intent/simple/bigbite
	name = "big bite"
	icon_state = "instrike"
	attack_verb = list("gnashes", "viciously bites")
	animname = "bite"
	blade_class = BCLASS_CHOP
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 20
	swingdelay = 1
	item_damage_type = "stab"
	miss_text = "bites the air!"
	miss_sound = PUNCHWOOSH

/datum/intent/simple/stab
	name = "stab"
	icon_state = "instrike"
	attack_verb = list("impales", "stabs")
	animname = "stab"
	blade_class = BCLASS_STAB
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 25
	swingdelay = 1
	miss_text = "stabs the air!"
	item_damage_type = "stab"

/datum/intent/simple/axe
	name = "hack"
	icon_state = "instrike"
	attack_verb = list("hacks at", "chops at", "bashes")
	animname = "chop"
	blade_class = BCLASS_CUT
	hitsound = list("genchop", "genslash")
	chargetime = 0
	penfactor = 0
	swingdelay = 3
	item_damage_type = "slash"

/datum/intent/simple/spear
	name = "spear"
	icon_state = "instrike"
	attack_verb = list("stabs", "skewers", "bashes")
	animname = "stab"
	blade_class = BCLASS_CUT
	hitsound = list("genthrust", "genstab")
	chargetime = 0
	penfactor = 0
	swingdelay = 3
	item_damage_type = "stab"

/datum/intent/simple/wereclaw
	name = "claw"
	icon_state = "instrike"
	attack_verb = list("claws", "pecks")
	animname = "claw"
	blade_class = BCLASS_CHOP
	hitsound = "genslash"
	chargetime = 0
	penfactor = 10
	swingdelay = 3
	miss_text = "slashes the air!"
	miss_sound = BLADEWOOSH_LARGE
	item_damage_type = "slash"

/datum/intent/simple/werebite
	name = "bite"
	icon_state = "instrike"
	attack_verb = list("bites")
	animname = "bite"
	blade_class = BCLASS_BITE
	hitsound = "smallslash"
	chargetime = 0
	penfactor = 30
	swingdelay = 3
	miss_text = "bites the air!"
	miss_sound = PUNCHWOOSH
	item_damage_type = "stab"
