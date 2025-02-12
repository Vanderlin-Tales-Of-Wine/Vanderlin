/* Alt-intents, the ones used via MMB. */

/datum/intent/bite
	name = "bite"
	attack_verb = list("bites")

	item_damage_type = "stab"
	intent_flags = (INTENT_UNARMED)

	chargedrain = 0
	chargetime = 0
	swingdelay = 0

/datum/intent/jump
	name = "jump"
	pointer = 'icons/effects/mousemice/human_jump.dmi'

	intent_flags = (INTENT_UNDODGEABLE | INTENT_UNPARRYABLE)
	noaa = TRUE

	chargedrain = 0
	chargetime = 0

/datum/intent/kick
	name = "kick"
	pointer = 'icons/effects/mousemice/human_kick.dmi'
	animname = "kick"

	item_damage_type = "blunt"
	intent_flags = (INTENT_UNARMED)

	swingdelay = 5
	misscost = 20

/datum/intent/steal
	name = "steal"
	intent_flags = (INTENT_UNDODGEABLE | INTENT_UNPARRYABLE)

	chargedrain = 0
	chargetime = 0
	noaa = TRUE

/datum/intent/give
	name = "give"
	pointer = 'icons/effects/mousemice/human_give.dmi'
	intent_flags = (INTENT_UNDODGEABLE | INTENT_UNPARRYABLE)

	chargedrain = 0
	chargetime = 0
	noaa = TRUE

/* ----------- */


/datum/intent/spell
	name = "spell"
	tranged = 1
	chargedrain = 0
	chargetime = 0
	warnie = "aimwarn"
	warnoffset = 0

// No clue why these are here
/datum/looping_sound/invokegen
	mid_sounds = list('sound/magic/charging.ogg')
	mid_length = 130
	volume = 100
	extra_range = 3

/datum/looping_sound/invokefire
	mid_sounds = list('sound/magic/charging_fire.ogg')
	mid_length = 130
	volume = 100
	extra_range = 3

/datum/looping_sound/invokelightning
	mid_sounds = list('sound/magic/charging_lightning.ogg')
	mid_length = 130
	volume = 100
	extra_range = 3

/datum/looping_sound/invokeholy
	mid_sounds = list('sound/magic/holycharging.ogg')
	mid_length = 320
	volume = 100
	extra_range = 3

/datum/looping_sound/flailswing
	mid_sounds = list('sound/combat/wooshes/flail_swing.ogg')
	mid_length = 7
	volume = 100
