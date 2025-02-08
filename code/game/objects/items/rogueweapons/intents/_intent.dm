////click cooldowns, in tenths of a second, used for various combat actions
//#define CLICK_CD_EXHAUSTED 35
//#define CLICK_CD_MELEE 12
//#define CLICK_CD_RANGE 4
//#define CLICK_CD_RAPID 2

/datum/intent
	var/name = "intent"
	var/desc = ""
	//icon = 'icons/mob/roguehud.dmi'		so you can find the icons
	var/icon_state = "instrike"
	var/list/attack_verb = list("hits", "strikes")
	var/obj/item/masteritem
	var/mob/living/mastermob

	abstract_type = /datum/intent

	/// Modifiers for how this intent behaves.
	var/intent_flags = NONE

	var/animname = "strike"
	var/blade_class = BCLASS_BLUNT
	var/list/hitsound = list('sound/combat/hits/blunt/bluntsmall (1).ogg', 'sound/combat/hits/blunt/bluntsmall (2).ogg')

	var/canparry = TRUE //! DEPRECATED
	var/candodge = TRUE //! DEPRECATED
	var/noaa = FALSE //turns off auto aiming, also turns off the 'swooshes'

	var/tranged = FALSE
	var/tshield = FALSE //! probably needed or something
	var/no_attack = FALSE //causes a return in /attack() but still allows to be used in attackby(

	var/iparrybonus = 0
	var/idodgebonus = 0
	var/chargetime = 0 //if above 0, this attack must be charged to reach full damage
	var/chargedrain = 0 //how mcuh fatigue is removed every second when at max charge
	var/releasedrain = 1 //drain when we go off, regardless
	var/misscost = 1	//extra drain from missing only, ALSO APPLIED IF ENEMY DODGES
	var/warnie = ""
	var/pointer = 'icons/effects/mousemice/human_attack.dmi'
	var/clickcd = CLICK_CD_MELEE //the cd invoked clicking on stuff with this intent
	var/recovery = 0		//RTD unable to move for this duration after an attack without becoming off balance
	var/list/charge_invocation //list of stuff to say while charging
	var/no_early_release = FALSE //we can't shoot off early
	var/movement_interrupt = FALSE //we cancel charging when changing mob direction, for concentration spells
	var/rmb_ranged = FALSE //we execute a proc with the same name when rmbing at range with no offhand intent selected
	var/datum/looping_sound/chargedloop = null
	var/keep_looping = TRUE
	var/damfactor = 1 //multiplied by weapon's force for damage
	var/penfactor = 0 //see armor_penetration
	var/charging_slowdown = 0
	var/warnoffset = 0
	var/swingdelay = 0
	var/reach = 1 //In tiles, how far this weapon can reach; 1 for adjacent, which is default
	var/miss_text //THESE ARE FOR UNARMED MISSING ATTACKS
	var/miss_sound //THESE ARE FOR UNARMED MISSING ATTACKS

	var/item_damage_type = "blunt"

/datum/intent/Destroy()
	if(chargedloop)
		chargedloop.stop()
	if(mastermob.curplaying == src)
		mastermob.curplaying = null
	mastermob = null
	masteritem = null
	return ..()

/datum/intent/proc/examine(mob/user)
	var/list/inspec = list("----------------------")

	inspec += span_notice("<b>[name]</b> intent")

	if(desc)
		inspec += desc
	if(reach != 1)
		inspec += "<b>Reach:</b> [reach]"
	if(damfactor != 1)
		inspec += "<b>Damage:</b> [damfactor]"
	if(penfactor)
		inspec += "<b>Armor Penetration:</b> [penfactor]"
	if(get_chargetime())
		inspec += "<b>Charge Time</b>"
	if(movement_interrupt)
		inspec += "<b>Interrupted by Movement</b>"
	if(no_early_release)
		inspec += "<b>No Early Release</b>"
	if(chargedrain)
		inspec += "<b>Drain While Charged:</b> [chargedrain]"
	if(releasedrain)
		inspec += "<b>Drain On Release:</b> [releasedrain]"
	if(misscost)
		inspec += "<b>Drain On Miss:</b> [misscost]"
	if(clickcd != CLICK_CD_MELEE) // maybe the one time <=> could be useful
		var/recovery_time
		if(clickcd < CLICK_CD_MELEE)
			recovery_time = "Quick"
		else
			recovery_time = "Slow"
		inspec += "<b>Recovery Time:</b> [recovery_time]"

	inspec += "----------------------"

	to_chat(user, "[inspec.Join("\n")]")

/datum/intent/proc/get_chargetime()
	return chargetime

/datum/intent/proc/get_chargedrain()
	return chargedrain

/datum/intent/proc/get_releasedrain()
	return releasedrain

/datum/intent/proc/prewarning()
	return

/datum/intent/proc/rmb_ranged(atom/target, mob/user)
	return

/datum/intent/proc/can_charge()
	return TRUE

/datum/intent/proc/afterchange()
	if(masteritem)
		masteritem.damage_type = item_damage_type
		var/list/benis = hitsound
		if(benis)
			masteritem.hitsound = benis
	if(istype(mastermob, /mob/living/simple_animal))
		var/mob/living/simple_animal/master = mastermob
		master.damage_type = item_damage_type
	return

/datum/intent/New(Mastermob, Masteritem)
	..()
	if(Mastermob)
		if(isliving(Mastermob))
			mastermob = Mastermob
			if(chargedloop)
				update_chargeloop()
	if(Masteritem)
		masteritem = Masteritem

/datum/intent/proc/update_chargeloop() //what the fuck is going on here lol
	if(mastermob)
		if(chargedloop)
			if(!istype(chargedloop))
				chargedloop = new chargedloop(mastermob)

/datum/intent/proc/on_charge_start() //what the fuck is going on here lol
	if(mastermob.curplaying)
		mastermob.curplaying.chargedloop.stop()
		mastermob.curplaying = null
	if(chargedloop)
		if(!istype(chargedloop, /datum/looping_sound))
			chargedloop = new chargedloop(mastermob)
		else
			chargedloop.stop()
		chargedloop.start(chargedloop.parent)
		mastermob.curplaying = src

/datum/intent/proc/on_mouse_up()
	if(chargedloop)
		chargedloop.stop()
	if(mastermob.curplaying == src)
		mastermob.curplaying = null
