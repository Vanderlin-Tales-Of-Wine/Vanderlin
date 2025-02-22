/* FLAILS - Zero wdefense, can´t parry, best AP
==========================================================*/
/obj/item/rogueweapon/flail
	force = DAMAGE_NORMAL_FLAIL
	possible_item_intents = list(/datum/intent/flail/strike, /datum/intent/flail/strike/smash)
	name = "military flail"
	desc = "A sturdy handle afixed to a cruel spiked ball with a harrowing metal chain."
	icon_state = "iflail"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	associated_skill = /datum/skill/combat/whipsflails
	smeltresult = /obj/item/ingot/iron
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	swingsound = BLUNTWOOSH_MED
	can_parry = FALSE // You can't parry with this, it'd be awkward to tangle chains, use a shield
	wdefense = TERRIBLE_PARRY
	max_integrity = 300
	throwforce = 5
	minstr = 6
	sellprice = 20
	grid_width = 32
	grid_height = 96

/obj/item/rogueweapon/flail/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/*--------------\
| Strike intent |	small AP
\--------------*/
/datum/intent/flail/strike
	name = "strike"
	icon_state = "instrike"
	blade_class = BCLASS_BLUNT
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	swingdelay = 5
	misscost = 5
	attack_verb = list("strikes", "hits")
	penfactor = AP_FLAIL_STRIKE
	item_damage_type = "slash"

/datum/intent/flail/strike/long
	reach = 2
	misscost = 8


/*--------------\
| Smash intent |	20% force increase and huge AP, requires charging and has higher penalties
\--------------*/
/datum/intent/flail/strike/smash
	name = "smash"
	icon_state = "insmash"
	blade_class = BCLASS_SMASH
	no_early_release = TRUE
	chargetime = 5
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	recovery = 10
	misscost = 10
	attack_verb = list("smashes")
	damfactor = 1.2
	penfactor = AP_FLAIL_SMASH
	item_damage_type = "slash"

/datum/intent/flail/strike/smash/long
	reach = 2
	recovery = 12
	misscost = 12


//................ Militia Flail ............... //
/obj/item/rogueweapon/flail/militia
	name = "militia flail"
	desc = "A lucky hit from such a flail can squash a cheap helmet along with the wearer's skull."
	icon_state = "militiaflail"

//................ Wooden Flail ............... // Obsolete by the thresher? No smash so its bad
/obj/item/rogueweapon/flail/towner
	force = DAMAGE_WEAK_FLAIL
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/flailthresh, /datum/intent/mace/strike/wood)
	name = "wooden flail"
	desc = "During peacetime these flails are used to thresh wheat. During wartime - to chase off marauders."
	icon_state = "peasantflail"
	smeltresult = /obj/item/rogueore/coal //is mostly wood
	max_integrity = 200
	minstr = 5
	sellprice = 10


//................ Steel Flail ............... //
/obj/item/rogueweapon/flail/sflail
	force = DAMAGE_GOOD_FLAIL
	name = "steel flail"
	desc = "A knightly flail made of worked steel, with a flanged head. An effective and brutal design."
	icon_state = "flail"
	smeltresult = /obj/item/ingot/steel
	minstr = 4
	max_integrity = 500
	sellprice = 35

//................ Peasant Flail ............... // A little confusing still
/obj/item/rogueweapon/flail/peasant
	force = DAMAGE_NORMAL_FLAIL
	force_wielded = DAMAGE_GOOD_FLAIL
	name = "peasant flail"
	desc = "What used to be a humble thresher by design, has become a deadly flail with extended range and punch. Favored by the peasantry militia or knight errants."
	icon = 'icons/roguetown/weapons/64.dmi'
	icon_state = "bigflail"
	possible_item_intents = list(/datum/intent/flail/strike/long)
	gripped_intents = list(/datum/intent/flail/strike/long, /datum/intent/flail/strike/smash/long)
	bigboy = TRUE
	gripsprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	wbalance = 0
	wlength = WLENGTH_LONG
	slot_flags = ITEM_SLOT_BACK
	max_integrity = 500
	sellprice = 20
	minstr = 8

/obj/item/rogueweapon/flail/peasant/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)




