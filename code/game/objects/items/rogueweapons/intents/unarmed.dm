/datum/intent/unarmed

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

/datum/intent/unarmed/help
	name = "touch"
	icon_state = "intouch"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0
	releasedrain = 0
	rmb_ranged = TRUE

/datum/intent/unarmed/help/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='green'>[user] waves friendly at [M].</span>", "<span class='green'>I wave friendly at [M].</span>", ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='green'>[user] gives me a friendly wave.</span>")
	return

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
	candodge = TRUE
	canparry = TRUE
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
