/*----------\
|  Hammers  |
\----------*/

/obj/item/rogueweapon/hammer
	force = 10
	possible_item_intents = list(/datum/intent/mace/strike,/datum/intent/mace/smash)
	name = "hammer"
	desc = ""
	icon_state = "hammer"
	icon = 'icons/roguetown/weapons/tools.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	sharpness = IS_BLUNT
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	associated_skill = /datum/skill/combat/axesmaces
	smeltresult = /obj/item/ingot/iron

	grid_width = 32
	grid_height = 64
	var/can_smith = TRUE

/obj/proc/unbreak()
	return

/atom/proc/onanvil()
	if(!isturf(src.loc))
		return FALSE
	for(var/obj/machinery/anvil/T in src.loc)
		return TRUE
	return FALSE

/obj/structure
	var/hammer_repair

/obj/item/rogueweapon/hammer/attack_obj(obj/O, mob/living/user)
	if(isitem(O))
		var/obj/item/I = O
		if(I.anvilrepair && I.max_integrity && !I.obj_broken)
//			if(!I.onanvil())
//				return ..()
			if(!isturf(I.loc))
				return
			var/repair_percent = 0.05
			if(user.mind)
				if(user.mind.get_skill_level(I.anvilrepair) <= 0)
					if(prob(30))
						repair_percent = 0.01
					else
						repair_percent = 0
				else
					repair_percent = max(user.mind.get_skill_level(I.anvilrepair) * 0.03, 0.01)

			if(I.obj_integrity < I.max_integrity) // Gain experience only if you effectively repair the item
				if(repair_percent)
					repair_percent = repair_percent * I.max_integrity
					I.obj_integrity = min(I.obj_integrity+repair_percent, I.max_integrity)
					var/mob/living/L = user
					var/amt2raise = floor(L.STAINT * 0.25)
					user.mind.adjust_experience(I.anvilrepair, amt2raise, FALSE) // Some exp from repairs
					user.visible_message("<span class='info'>[user] repairs [I]!</span>")
					playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
				else
					user.visible_message("<span class='warning'>[user] damages [I]!</span>")
					playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
					I.take_damage(5, BRUTE, "blunt")
				return
			else // Stop iiit, he's already... fixed?
				to_chat(user, "\The [I] is already fully repaired!")
				playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
				return

	if(isstructure(O))
		var/obj/structure/I = O
		if(I.hammer_repair && I.max_integrity && !I.obj_broken)
			var/repair_percent = 0.05
			if(user.mind)
				if(user.mind.get_skill_level(I.hammer_repair) <= 0)
					to_chat(user, "<span class='warning'>I don't know how to repair this..</span>")
					return
				repair_percent = max(user.mind.get_skill_level(I.hammer_repair) * 0.05, 0.05)
			repair_percent = repair_percent * I.max_integrity
			I.obj_integrity = min(obj_integrity+repair_percent, I.max_integrity)
			playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
			user.visible_message("<span class='info'>[user] repairs [I]!</span>")
			return
	. = ..()

/obj/item/rogueweapon/hammer/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -8,"wy" = 1,"ex" = 6,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

// --------- IRON HAMMER -----------
/obj/item/rogueweapon/hammer/iron
	icon_state = "hammer"
	experimental_onhip = FALSE
	experimental_onback = FALSE

// --------- STEEL HAMMER -----------
/obj/item/rogueweapon/hammer/steel
	name = "claw hammer"
	icon_state = "hammer_s"
	experimental_onhip = FALSE
	experimental_onback = FALSE

// --------- MALLET -----------
/obj/item/rogueweapon/hammer/wood
	name = "wooden mallet"
	desc = "A wooden mallet is an artificers second best friend! But it may also come in handy to a smith..."
	icon_state = "hammer_w"
	dropshrink = 0.9
	experimental_onhip = FALSE
	experimental_onback = FALSE
	force = 4
	smeltresult = null
	can_smith = FALSE
/obj/item/rogueweapon/hammer/wood/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -8,"wy" = 1,"ex" = 6,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/hammer/copper
	force = 8
	possible_item_intents = list(/datum/intent/mace/strike,/datum/intent/mace/smash)
	name = "copper hammer"
	desc = "A simple and rough copper hammer."
	icon_state = "chammer"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_NORMAL
	associated_skill = /datum/skill/combat/axesmaces
	smeltresult = /obj/item/ingot/copper

/obj/item/rogueweapon/hammer/sledgehammer
	force = 15
	force_wielded = 25
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike/heavy, /datum/intent/mace/smash/heavy)
	name = "sledgehammer"
	desc = "It's almost asking to be put to work."
	icon_state = "sledgehammer"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 10
	wbalance = -1 // Heavy
	gripsprite = TRUE
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	associated_skill = /datum/skill/combat/axesmaces
	smeltresult = /obj/item/ingot/iron

/obj/item/rogueweapon/hammer/sledgehammer/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -8,"wy" = 1,"ex" = 6,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/hammer/sledgehammer/war
	force = 15
	force_wielded = 30
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike/heavy, /datum/intent/mace/smash/heavy)
	name = "steel warhammer"
	desc = "A heavy steel warhammer, a weapon designed to make knights run in fear, the best option for a common soldier against a knight."
	icon_state = "warbonker"
	icon = 'icons/roguetown/weapons/32.dmi'
	max_integrity = 500
	smeltresult = /obj/item/ingot/steel

/*
/obj/item/rogueweapon/hammer/steel/attack_turf(turf/T, mob/living/user)
	if(!user.cmode)
		if(T.hammer_repair && T.max_integrity && !T.obj_broken)
			var/repair_percent = 0.05
			if(user.mind)
				if(user.mind.get_skill_level(I.hammer_repair) <= 0)
					to_chat(user, "<span class='warning'>I don't know how to repair this..</span>")
					return
				repair_percent = max(user.mind.get_skill_level(I.hammer_repair) * 0.05, 0.05)
			repair_percent = repair_percent * I.max_integrity
			I.obj_integrity = min(obj_integrity+repair_percent, I.max_integrity)
			playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
			user.visible_message("<span class='info'>[user] repairs [I]!</span>")
			return
	..()
*/

/*----------\
|  Tongs  |
\----------*/

/obj/item/rogueweapon/tongs
	force = 5
	possible_item_intents = list(/datum/intent/mace/strike)
	name = "tongs"
	desc = ""
	icon_state = "tongs"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	associated_skill = null
	var/obj/item/ingot/hingot = null
	var/hott = 0
	smeltresult = /obj/item/ingot/iron
	grid_width = 32
	grid_height = 96

/obj/item/rogueweapon/tongs/examine(mob/user)
	. = ..()
	if(hott)
		. += "<span class='warning'>The tip is hot to the touch.</span>"

/obj/item/rogueweapon/tongs/get_temperature()
	if(hott)
		return 150+T0C
	return ..()

/obj/item/rogueweapon/tongs/fire_act(added, maxstacks)
	. = ..()
	hott = world.time
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(make_unhot), world.time), 10 SECONDS)

/obj/item/rogueweapon/tongs/update_icon()
	. = ..()
	if(!hingot)
		icon_state = "tongs"
	else
		if(hott)
			icon_state = "tongsi1"
		else
			icon_state = "tongsi0"

/obj/item/rogueweapon/tongs/proc/make_unhot(input)
	if(hott == input)
		hott = 0
	update_icon()

///Places the ingot on the atom, this can be either a turf or a table
/obj/item/rogueweapon/tongs/proc/place_ingot_to_atom(atom/A, mob/user)
	if(hingot && (isturf(A) || istype(A, /obj/structure/table)))
		hingot.forceMove(get_turf(A))
		hingot = null
		hott = 0
		update_icon()
	else if(hingot)
		to_chat(user, "<span class='warning'>Cannot place ingot there!</span>")

/obj/item/rogueweapon/tongs/attack_self(mob/user)
	place_ingot_to_atom(get_turf(user), user)

/obj/item/rogueweapon/tongs/dropped(mob/user)
	. = ..()
	place_ingot_to_atom(get_turf(src), user)

/obj/item/rogueweapon/tongs/pre_attack_right(atom/A, mob/living/user, params)
	. = ..()
	place_ingot_to_atom(get_turf(A), user)

/obj/item/rogueweapon/tongs/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -8,"wy" = 1,"ex" = 6,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/tongs/stone
	name = "stone tongs"
	icon_state = "stonetongs"
	force = 3
	smeltresult = null
	anvilrepair = null
	max_integrity = 20

/obj/item/rogueweapon/tongs/stone/update_icon()
	. = ..()
	if(!hingot)
		icon_state = "stonetongs"
	else
		if(hott)
			icon_state = "stonetongsi1"
		else
			icon_state = "stonetongsi0"
