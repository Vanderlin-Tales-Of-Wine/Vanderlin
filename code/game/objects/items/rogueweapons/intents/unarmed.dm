/* Contains the basic help/disarm/grab/harm intents.
 *
 */

/datum/intent/help
	name = "touch"
	icon_state = "intouch"
	noaa = TRUE
	rmb_ranged = TRUE

	intent_flags = (INTENT_UNARMED | INTENT_UNDODGEABLE)

	misscost = 0
	releasedrain = 0

/datum/intent/help/rmb_ranged(mob/target, mob/user)
	if(!istype(target))
		return

	user.visible_message( \
		span_green("[user] waves friendly at [target]."), \
		span_green("I wave friendly at [target]."), \
		ignored_mobs = list(target) \
	)

	target.waved(user)

/datum/intent/disarm
	name = "shove"
	icon_state = "inshove"
	attack_verb = list("shoves", "pushes")
	noaa = TRUE
	rmb_ranged = TRUE

	intent_flags = (INTENT_UNARMED)

	misscost = 5
	releasedrain = 10
	item_damage_type = "blunt"

/datum/intent/disarm/rmb_ranged(mob/target, mob/user)
	if(!istype(target))
		return

	user.visible_message( \
		span_blue("[user] shoos [target] away."), \
		span_blue("I shoo [target] away."), \
		ignored_mobs = list(target) \
	)

	target.shood(user)

/datum/intent/grab
	name = "grab"
	icon_state = "ingrab"
	attack_verb = list("grabs")
	noaa = TRUE
	rmb_ranged = TRUE

	intent_flags = (INTENT_UNARMED | INTENT_UNPARRYABLE)

	releasedrain = 10
	misscost = 5
	item_damage_type = "blunt"

/datum/intent/grab/rmb_ranged(mob/target, mob/user)
	if(!istype(target))
		return

	user.visible_message( \
		span_green("[user] beckons [target] to come closer."), \
		span_green("I beckon [target] to come closer."), \
		ignored_mobs = list(target) \
	)

	target.beckoned(user)

/datum/intent/harm
	name = "punch"
	icon_state = "inpunch"
	attack_verb = list("punches", "jabs", "clocks", "strikes")
	animname = "punch"
	hitsound = list('sound/combat/hits/punch/punch (1).ogg', 'sound/combat/hits/punch/punch (2).ogg', 'sound/combat/hits/punch/punch (3).ogg')
	miss_text = "swings a fist at the air!"
	miss_sound = "punchwoosh"

	intent_flags = (INTENT_UNARMED)

	misscost = 5
	releasedrain = 5
	rmb_ranged = TRUE
	blade_class = BCLASS_PUNCH
	item_damage_type = "blunt"

/datum/intent/harm/rmb_ranged(mob/target, mob/user)
	if(!istype(target))
		return

	user.visible_message( \
		span_red("[user] taunts [target]!"), \
		span_warning("I taunt [target]!"), \
		ignored_mobs = list(target) \
	)

	target.taunted(user)

/datum/intent/harm/claw
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("claws", "scratches", "rends", "tears")
	animname = "claw"
	hitsound = "smallslash"
	miss_text = "claws the air!"
	miss_sound = "blunthwoosh"

	blade_class = BCLASS_CUT
	item_damage_type = "slash"
	penfactor = 20


/// Zizo ascended harm intent.
/datum/intent/harm/claw/ascended
	attack_verb = list("claws", "mauls", "eviscerates")
	hitsound = "genslash"
	miss_text = "slashes the air!"
	miss_sound = "bluntwooshlarge"

	blade_class = BCLASS_CHOP
	penfactor = 131
	damfactor = 40
	item_damage_type = "slash"
