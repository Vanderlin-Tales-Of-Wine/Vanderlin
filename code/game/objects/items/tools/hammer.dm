/obj/item/weapon/hammer
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
	var/time_multiplier = 1

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

/obj/item/weapon/hammer/attack_obj(obj/O, mob/living/user)
	if(!isliving(user) || !user.mind)
		return
	var/datum/mind/blacksmith_mind = user.mind
	var/repair_percent = 0.025 // 2.5% Repairing per hammer smack
	/// Repairing is MUCH better with an anvil!
	if(locate(/obj/machinery/anvil) in O.loc)
		repair_percent *= 2 // Double the repair amount if we're using an anvil

	if(isbodypart(O) && !user.cmode)
		var/obj/item/bodypart/attacked_prosthetic = O
		if(!attacked_prosthetic.anvilrepair || !isturf(attacked_prosthetic.loc))
			return
		if(attacked_prosthetic.obj_integrity >= attacked_prosthetic.max_integrity && attacked_prosthetic.brute_dam == 0 && attacked_prosthetic.burn_dam == 0 && attacked_prosthetic.wounds == null && attacked_prosthetic.bodypart_disabled == BODYPART_NOT_DISABLED) //A mouthful
			to_chat(user, span_warning("There is nothing to further repair on [attacked_prosthetic]."))
			return

		if(blacksmith_mind.get_skill_level(attacked_prosthetic.anvilrepair) <= 0)
			if(prob(30))
				repair_percent = 0.01
			else
				repair_percent = 0
		else
			repair_percent *= blacksmith_mind.get_skill_level(attacked_prosthetic.anvilrepair)

		playsound(src,'sound/items/bsmith3.ogg', 100, FALSE)
		if(repair_percent)
			repair_percent *= attacked_prosthetic.max_integrity
			var/amt2raise = floor(user.STAINT * 0.25)
			attacked_prosthetic.obj_integrity = min(attacked_prosthetic.obj_integrity + repair_percent, attacked_prosthetic.max_integrity)
			attacked_prosthetic.brute_dam = max(attacked_prosthetic.brute_dam - 10, 0)
			attacked_prosthetic.burn_dam = max(attacked_prosthetic.burn_dam - 10, 0)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [attacked_prosthetic]."))
			else
				user.visible_message(span_info("[user] repairs [attacked_prosthetic]!"))
				attacked_prosthetic.wounds = null //You need actual skill to do this
				attacked_prosthetic.bodypart_disabled = BODYPART_NOT_DISABLED
			blacksmith_mind.add_sleep_experience(attacked_prosthetic.anvilrepair, amt2raise)
		else
			user.visible_message(span_warning("[user] fumbles trying to repair [attacked_prosthetic]!"))
			attacked_prosthetic.take_damage(attacked_prosthetic.max_integrity * 0.1, BRUTE, "blunt")
		attacked_prosthetic.update_icon()
		return

	if(isitem(O) && !user.cmode)
		var/obj/item/attacked_item = O
		if(!attacked_item.anvilrepair || !attacked_item.max_integrity || attacked_item.obj_broken || (attacked_item.obj_integrity >= attacked_item.max_integrity) || !isturf(attacked_item.loc))
			to_chat(user, span_warning("[attacked_item] cannot be repaired any further."))
			return

		if(blacksmith_mind.get_skill_level(attacked_item.anvilrepair) <= 0)
			if(prob(30))
				repair_percent = 0.01
			else
				repair_percent = 0
		else
			repair_percent *= blacksmith_mind.get_skill_level(attacked_item.anvilrepair)

		playsound(src,'sound/items/bsmithfail.ogg', 40, FALSE)
		if(repair_percent)
			repair_percent *= attacked_item.max_integrity
			var/amt2raise = floor(user.STAINT * 0.25)
			attacked_item.obj_integrity = min(attacked_item.obj_integrity + repair_percent, attacked_item.max_integrity)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [attacked_item]."))
			else
				user.visible_message(span_info("[user] repairs [attacked_item]!"))
			blacksmith_mind.add_sleep_experience(attacked_item.anvilrepair, amt2raise)
		else
			user.visible_message("<span class='warning'>[user] damages [attacked_item]!</span>")
			attacked_item.take_damage(attacked_item.max_integrity * 0.1, BRUTE, "blunt")
		attacked_item.update_icon()
		return

	if(isstructure(O) && !user.cmode)
		var/obj/structure/attacked_structure = O
		if(!attacked_structure.hammer_repair || !attacked_structure.max_integrity || attacked_structure.obj_broken)
			to_chat(user, span_warning("[attacked_structure] cannot be repaired any further."))
			return
		if(blacksmith_mind.get_skill_level(attacked_structure.hammer_repair) <= 0)
			to_chat(user, span_warning("I don't know how to repair this.."))
			return
		var/amt2raise = floor(user.STAINT * 0.25)
		repair_percent *= blacksmith_mind.get_skill_level(attacked_structure.hammer_repair) * attacked_structure.max_integrity
		attacked_structure.obj_integrity = min(attacked_structure.obj_integrity + repair_percent, attacked_structure.max_integrity)
		blacksmith_mind.add_sleep_experience(attacked_structure.hammer_repair, amt2raise)
		playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
		user.visible_message(span_info("[user] repairs [attacked_structure]!"))
		attacked_structure.update_icon()
		return

	. = ..()

/obj/item/weapon/hammer/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -8,"wy" = 1,"ex" = 6,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

// --------- IRON HAMMER -----------
/obj/item/weapon/hammer/iron
	icon_state = "hammer"
	experimental_onhip = FALSE
	experimental_onback = FALSE

// --------- STEEL HAMMER -----------
/obj/item/weapon/hammer/steel
	name = "claw hammer"
	icon_state = "hammer_s"
	experimental_onhip = FALSE
	experimental_onback = FALSE
	time_multiplier = 0.8

// --------- MALLET -----------
/obj/item/weapon/hammer/wood
	name = "wooden mallet"
	desc = "A wooden mallet is an artificers second best friend! But it may also come in handy to a smith..."
	icon_state = "hammer_w"
	dropshrink = 0.9
	experimental_onhip = FALSE
	experimental_onback = FALSE
	force = 4
	smeltresult = null
	can_smith = FALSE
	time_multiplier = 1.2

/obj/item/weapon/hammer/wood/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -8,"wy" = 1,"ex" = 6,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/hammer/copper
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
	time_multiplier = 1.1

/obj/item/weapon/hammer/sledgehammer
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
	grid_width = null
	grid_height = null

/obj/item/weapon/hammer/sledgehammer/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -8,"wy" = 1,"ex" = 6,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/hammer/sledgehammer/war
	force = 15
	force_wielded = 30
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike/heavy, /datum/intent/mace/smash/heavy)
	name = "steel sledgehammer"
	desc = "A heavy steel sledgehammer, a weapon designed to make knights run in fear, the best option for a common soldier against a knight."
	icon_state = "warbonker"
	icon = 'icons/roguetown/weapons/32.dmi'
	max_integrity = 500
	smeltresult = /obj/item/ingot/steel
	time_multiplier = 1.5 //it's for crushing skulls not nails
