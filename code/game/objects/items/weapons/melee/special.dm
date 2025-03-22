/obj/item/weapon/lordscepter
	force = 20
	force_wielded = 20
	possible_item_intents = list(/datum/intent/lordbash, /datum/intent/lord_electrocute, /datum/intent/lord_silence)
	gripped_intents = list(/datum/intent/lordbash)
	name = "master's rod"
	desc = "Bend the knee."
	icon_state = "scepter"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	resistance_flags = FIRE_PROOF|LAVA_PROOF // Nigh indestructible due to how important it is
	associated_skill = /datum/skill/combat/axesmaces
	smeltresult = null // No
	melting_material = null
	swingsound = BLUNTWOOSH_MED
	minstr = 5
	blade_dulling = DULLING_BASHCHOP

	grid_height = 96
	grid_width = 32

/datum/intent/lordbash
	name = "bash"
	blade_class = BCLASS_BLUNT
	icon_state = "inbash"
	attack_verb = list("bashes", "strikes")
	penfactor = 10
	item_damage_type = "blunt"

/datum/intent/lord_electrocute
	name = "electrocute"
	blade_class = null
	icon_state = "inuse"
	tranged = TRUE
	noaa = TRUE

/datum/intent/lord_silence
	name = "silence"
	blade_class = null
	icon_state = "inuse"
	tranged = TRUE
	noaa = TRUE

/obj/item/weapon/lordscepter/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -10,"sy" = -7,"nx" = 11,"ny" = -6,"wx" = -1,"wy" = -6,"ex" = 3,"ey" = -6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -1,"sy" = -4,"nx" = 1,"ny" = -3,"wx" = -1,"wy" = -6,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 20,"wturn" = 18,"eturn" = -19,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 0,"sy" = 2,"nx" = 1,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 4,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/obj/item/weapon/lordscepter/afterattack(atom/target, mob/user, flag)
	. = ..()
	if(get_dist(user, target) > 7)
		return
	user.changeNext_move(CLICK_CD_MELEE)


	if(ishuman(user))
		var/mob/living/carbon/human/HU = user

		if(!is_lord_job(HU.mind?.assigned_role))
			to_chat(user, "<span class='danger'>The rod doesn't obey me.</span>")
			return

		if(ishuman(target))
			var/mob/living/carbon/human/H = target

			user.visible_message("<span class='warning'>[user] points [src] at [target].</span>")

			if(H == HU)
				return

			if(H.anti_magic_check())
				return

			if(!((H.mind?.assigned_role.title in GLOB.noble_positions) || (H.mind?.assigned_role.title in GLOB.garrison_positions)))
				return

			if(istype(user.used_intent, /datum/intent/lord_electrocute))
				HU.visible_message("<span class='warning'>[HU] electrocutes [H] with \the [src].</span>")
				user.Beam(target, icon_state = "lightning[rand(1, 12)]", time = 0.5 SECONDS) // LIGHTNING
				playsound(user, 'sound/magic/lightningshock.ogg', 70, TRUE)
				H.electrocute_act(5, src)
				log_message("[HU] has shocked [H] with the master's rod!", LOG_ATTACK)
				to_chat(H, "<span class='danger'>I'm electrocuted by the scepter!</span>")
				return

			if(istype(user.used_intent, /datum/intent/lord_silence))
				HU.visible_message("<span class='warning'>[HU] silences [H] with \the [src].</span>")
				H.set_silence(20 SECONDS)
				log_message("[HU] has silenced [H] with the master's rod!", LOG_ATTACK)
				to_chat(H, "<span class='danger'>I'm silenced by the scepter!</span>")
				return

/obj/item/weapon/mace/stunmace
	force = 15
	force_wielded = 15
	name = "stunmace"
	icon_state = "stunmace0"
	desc = "A dwarven invention, a mace that bears tiny soul-gems that imbue the crown of the mace with lightning mana."
	gripped_intents = null
	w_class = WEIGHT_CLASS_NORMAL
	possible_item_intents = list(/datum/intent/mace/strike/stunner, /datum/intent/mace/smash/stunner)
	wbalance = 0
	minstr = 5
	wdefense = 0
	var/charge = 100
	var/on = FALSE

/datum/intent/mace/strike/stunner/afterchange()
	var/obj/item/weapon/mace/stunmace/I = masteritem
	if(I)
		if(I.on)
			hitsound = list('sound/items/stunmace_hit (1).ogg','sound/items/stunmace_hit (2).ogg')
		else
			hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	. = ..()

/datum/intent/mace/smash/stunner/afterchange()
	var/obj/item/weapon/mace/stunmace/I = masteritem
	if(I)
		if(I.on)
			hitsound = list('sound/items/stunmace_hit (1).ogg','sound/items/stunmace_hit (2).ogg')
		else
			hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	. = ..()

/obj/item/weapon/mace/stunmace/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/weapon/mace/stunmace/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/weapon/mace/stunmace/funny_attack_effects(mob/living/target, mob/living/user, nodmg)
	. = ..()
	if(on)
		target.electrocute_act(5, src)
		charge -= 33
		if(charge <= 0)
			on = FALSE
			charge = 0
			update_icon()
			if(user.a_intent)
				var/datum/intent/I = user.a_intent
				if(istype(I))
					I.afterchange()

/obj/item/weapon/mace/stunmace/update_icon()
	if(on)
		icon_state = "stunmace1"
	else
		icon_state = "stunmace0"

/obj/item/weapon/mace/stunmace/attack_self(mob/user)
	if(on)
		on = FALSE
	else
		if(charge <= 33)
			to_chat(user, "<span class='warning'>It's out of mana.</span>")
			return
		user.visible_message("<span class='warning'>[user] flicks [src] on.</span>")
		on = TRUE
		charge--
	playsound(user, pick('sound/items/stunmace_toggle (1).ogg','sound/items/stunmace_toggle (2).ogg','sound/items/stunmace_toggle (3).ogg'), 100, TRUE)
	if(user.a_intent)
		var/datum/intent/I = user.a_intent
		if(istype(I))
			I.afterchange()
	update_icon()
	add_fingerprint(user)

/obj/item/weapon/mace/stunmace/process()
	if(on)
		charge--
	else
		if(charge < 100)
			charge++
	if(charge <= 0)
		on = FALSE
		charge = 0
		update_icon()
		var/mob/user = loc
		if(istype(user))
			if(user.a_intent)
				var/datum/intent/I = user.a_intent
				if(istype(I))
					I.afterchange()
		playsound(src, pick('sound/items/stunmace_toggle (1).ogg','sound/items/stunmace_toggle (2).ogg','sound/items/stunmace_toggle (3).ogg'), 100, TRUE)

/obj/item/weapon/mace/stunmace/extinguish()
	if(on)
		var/mob/living/user = loc
		if(istype(user))
			user.electrocute_act(5, src)
		on = FALSE
		charge = 0
		update_icon()
		playsound(src, pick('sound/items/stunmace_toggle (1).ogg','sound/items/stunmace_toggle (2).ogg','sound/items/stunmace_toggle (3).ogg'), 100, TRUE)
