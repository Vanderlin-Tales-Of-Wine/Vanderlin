/* Contains the basic help/disarm/grab/harm intents.
 *
 */

/datum/intent/help
	name = "touch"
	icon_state = "intouch"
	chargetime = 0
	noaa = TRUE

	intent_flags = (INTENT_UNDODGEABLE)

	misscost = 0
	releasedrain = 0
	rmb_ranged = TRUE

/datum/intent/help/rmb_ranged(mob/target, mob/user)
	if(!istype(target))
		return

	user.visible_message( \
		span_green("[user] waves friendly at [target]."), \
		span_green("I wave friendly at [target]."), \
		ignored_mobs = list(target) \
	)

	target.waved(user)

/datum/intent/shove
	name = "shove"
	icon_state = "inshove"
	attack_verb = list("shoves", "pushes")
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	misscost = 5
	releasedrain = 10
	item_damage_type = "blunt"

/datum/intent/shove/rmb_ranged(mob/target, mob/user)
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
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	releasedrain = 10
	misscost = 5

	intent_flags = (INTENT_UNPARRYABLE)

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

/datum/intent/punch
	name = "punch"
	icon_state = "inpunch"
	attack_verb = list("punches", "jabs", "clocks", "strikes")
	chargetime = 0
	animname = "punch"
	hitsound = list('sound/combat/hits/punch/punch (1).ogg', 'sound/combat/hits/punch/punch (2).ogg', 'sound/combat/hits/punch/punch (3).ogg')
	misscost = 5
	releasedrain = 5
	swingdelay = 0
	rmb_ranged = TRUE
	blade_class = BCLASS_PUNCH
	miss_text = "swings a fist at the air!"
	miss_sound = "punchwoosh"
	item_damage_type = "blunt"

/datum/intent/punch/rmb_ranged(mob/target, mob/user)
	if(!istype(target))
		return

	user.visible_message( \
		"<span class='red'>[user] taunts [target]!</span>", \
		"<span class='warning'>I taunt [target]!</span>", \
		ignored_mobs = list(target) \
	)

	target.taunted(user)
