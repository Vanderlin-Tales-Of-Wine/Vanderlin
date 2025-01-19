////click cooldowns, in tenths of a second, used for various combat actions
//#define CLICK_CD_EXHAUSTED 35
//#define CLICK_CD_MELEE 12
//#define CLICK_CD_RANGE 4
//#define CLICK_CD_RAPID 2

/datum/intent
	var/name = "intent"
	var/desc = ""
//	icon = 'icons/mob/roguehud.dmi'		so you can find the icons
	var/icon_state = "instrike"
	var/list/attack_verb = list("hits", "strikes")
	var/obj/item/masteritem
	var/mob/living/mastermob
	var/unarmed = FALSE
	var/intent_type
	var/animname = "strike"
	var/blade_class = BCLASS_BLUNT
	var/list/hitsound = list('sound/combat/hits/blunt/bluntsmall (1).ogg', 'sound/combat/hits/blunt/bluntsmall (2).ogg')
	var/canparry = TRUE
	var/candodge = TRUE
	var/iparrybonus = 0
	var/idodgebonus = 0
	var/chargetime = 0 //if above 0, this attack must be charged to reach full damage
	var/chargedrain = 0 //how mcuh fatigue is removed every second when at max charge
	var/releasedrain = 1 //drain when we go off, regardless
	var/misscost = 1	//extra drain from missing only, ALSO APPLIED IF ENEMY DODGES
	var/tranged = 0
	var/noaa = FALSE //turns off auto aiming, also turns off the 'swooshes'
	var/warnie = ""
	var/pointer = 'icons/effects/mousemice/human_attack.dmi'
	var/clickcd = CLICK_CD_MELEE //the cd invoked clicking on stuff with this intent
	var/recovery = 0		//RTD unable to move for this duration after an attack without becoming off balance
	var/list/charge_invocation //list of stuff to say while charging
	var/no_early_release = FALSE //we can't shoot off early
	var/movement_interrupt = FALSE //we cancel charging when changing mob direction, for concentration spells
	var/rmb_ranged = FALSE //we execute a proc with the same name when rmbing at range with no offhand intent selected
	var/tshield = FALSE //probably needed or something
	var/datum/looping_sound/chargedloop = null
	var/keep_looping = TRUE
	var/damfactor = 1 //multiplied by weapon's force for damage
	var/penfactor = 0 //see armor_penetration
	var/charging_slowdown = 0
	var/warnoffset = 0
	var/swingdelay = 0
	var/no_attack = FALSE //causes a return in /attack() but still allows to be used in attackby(
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
	inspec += "<br><span class='notice'><b>[name]</b> intent</span>"
	if(desc)
		inspec += "\n[desc]"
	if(reach != 1)
		inspec += "\n<b>Reach:</b> [reach]"
	if(damfactor != 1)
		inspec += "\n<b>Damage:</b> [damfactor]"
	if(penfactor)
		inspec += "\n<b>Armor Penetration:</b> [penfactor]"
	if(get_chargetime())
		inspec += "\n<b>Charge Time</b>"
	if(movement_interrupt)
		inspec += "\n<b>Interrupted by Movement</b>"
	if(no_early_release)
		inspec += "\n<b>No Early Release</b>"
	if(chargedrain)
		inspec += "\n<b>Drain While Charged:</b> [chargedrain]"
	if(releasedrain)
		inspec += "\n<b>Drain On Release:</b> [releasedrain]"
	if(misscost)
		inspec += "\n<b>Drain On Miss:</b> [misscost]"
	if(clickcd != CLICK_CD_MELEE)
		inspec += "\n<b>Recovery Time:</b> "
		if(clickcd < CLICK_CD_MELEE)
			inspec += "Quick"
		if(clickcd > CLICK_CD_MELEE)
			inspec += "Slow"

	inspec += "<br>----------------------"

	to_chat(user, "[inspec.Join()]")

/datum/intent/proc/get_chargetime()
	if(chargetime)
		return chargetime
	else
		return 0

/datum/intent/proc/get_chargedrain()
	if(chargedrain)
		return chargedrain
	else
		return 0

/datum/intent/proc/get_releasedrain()
	if(releasedrain)
		return releasedrain
	else
		return 0

/datum/intent/proc/parrytime()
	return 0

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

/datum/intent/proc/height2limb(height as num)
	var/list/returned
	switch(height)
		if(2)
			returned += list(BODY_ZONE_HEAD)
		if(1)
			returned += list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_CHEST)
		if(0)
			returned += list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	return returned

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


/datum/intent/use
	name = "use"
	icon_state = "inuse"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	canparry = FALSE
	misscost = 0
	no_attack = TRUE
	releasedrain = 0
	blade_class = BCLASS_PUNCH
	item_damage_type = "blunt"

/datum/intent/kick
	name = "kick"
	candodge = TRUE
	canparry = TRUE
	chargetime = 0
	chargedrain = 0
	noaa = FALSE
	swingdelay = 5
	misscost = 20
	unarmed = TRUE
	animname = "kick"
	pointer = 'icons/effects/mousemice/human_kick.dmi'
	item_damage_type = "blunt"

/datum/intent/bite
	name = "bite"
	candodge = TRUE
	canparry = TRUE
	chargedrain = 0
	chargetime = 0
	swingdelay = 0
	unarmed = TRUE
	noaa = FALSE
	attack_verb = list("bites")
	item_damage_type = "stab"

/datum/intent/jump
	name = "jump"
	candodge = FALSE
	canparry = FALSE
	chargedrain = 0
	chargetime = 0
	noaa = TRUE
	pointer = 'icons/effects/mousemice/human_jump.dmi'

/datum/intent/steal
	name = "steal"
	candodge = FALSE
	canparry = FALSE
	chargedrain = 0
	chargetime = 0
	noaa = TRUE

/datum/intent/give
	name = "give"
	candodge = FALSE
	canparry = FALSE
	chargedrain = 0
	chargetime = 0
	noaa = TRUE
	pointer = 'icons/effects/mousemice/human_give.dmi'

/datum/intent/spell
	name = "spell"
	tranged = 1
	chargedrain = 0
	chargetime = 0
	warnie = "aimwarn"
	warnoffset = 0

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


/datum/intent/hit
	name = "hit"
	icon_state = "instrike"
	attack_verb = list("hit", "strike")
	item_damage_type = "blunt"
	chargetime = 0
	swingdelay = 0

/datum/intent/stab
	name = "stab"
	icon_state = "instab"
	attack_verb = list("stab")
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	animname = "stab"
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
		mastermob.visible_message("<span class='warning'>[mastermob] aims [masteritem]!</span>")

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

/datum/intent/proc/arc_check()
	return FALSE
/datum/intent/arc/arc_check()
	return TRUE

/datum/intent/arc/prewarning()
	if(masteritem && mastermob)
		mastermob.visible_message("<span class='warning'>[mastermob] aims [masteritem]!</span>")


/datum/intent/unarmed
	unarmed = TRUE

/datum/intent/unarmed/punch
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

/datum/intent/unarmed/punch/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='red'>[user] taunts [M]!</span>", "<span class='warning'>I red [M]!</span>", ignored_mobs = targetl)
		user.emote("taunt")
		if(M.client)
			M.taunted(user)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='red'>[user] taunts me!</span>")
		else
			M.taunted(user)
	return

/datum/intent/unarmed/shove
	name = "shove"
	icon_state = "inshove"
	attack_verb = list("shoves", "pushes")
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	misscost = 5
	releasedrain = 10
	item_damage_type = "blunt"

/datum/intent/unarmed/shove/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='blue'>[user] shoos [M] away.</span>", "<span class='blue'>I shoo [M] away.</span>", ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='blue'>[user] shoos me away.</span>")
		else
			M.shood(user)
	return

/datum/intent/unarmed/grab
	name = "grab"
	icon_state = "ingrab"
	attack_verb = list("grabs")
	chargetime = 0
	noaa = TRUE
	rmb_ranged = TRUE
	releasedrain = 10
	misscost = 5
	candodge = TRUE
	canparry = FALSE
	item_damage_type = "blunt"

/datum/intent/unarmed/grab/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='green'>[user] beckons [M] to come closer.</span>", "<span class='green'>I beckon [M] to come closer.</span>", ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='green'>[user] beckons me to come closer.</span>")
		else
			M.beckoned(user)
	return

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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE

/datum/intent/unarmed/claw	// defined as attack with some AP
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("claws", "scratches", "rends", "tears")
	animname = "claw"
	blade_class = BCLASS_CUT
	hitsound = "smallslash"
	penfactor = 20
	candodge = TRUE
	canparry = TRUE
	miss_text = "claws the air!"
	miss_sound = "blunthwoosh"
	chargetime = 0
	misscost = 5
	releasedrain = 5
	swingdelay = 0
	rmb_ranged = TRUE
	item_damage_type = "slash"

/datum/intent/unarmed/ascendedclaw
	name = "claw"
	icon_state = "inclaw"
	attack_verb = list("claws", "mauls", "eviscerates")
	animname = "claw"
	blade_class = BCLASS_CHOP
	hitsound = "genslash"
	penfactor = 131
	damfactor = 40
	candodge = TRUE
	canparry = TRUE
	miss_text = "slashes the air!"
	miss_sound = "bluntwooshlarge"
	item_damage_type = "slash"

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
	candodge = FALSE
	canparry = FALSE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
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
	candodge = TRUE
	canparry = TRUE
	miss_text = "bites the air!"
	miss_sound = PUNCHWOOSH
	item_damage_type = "stab"
