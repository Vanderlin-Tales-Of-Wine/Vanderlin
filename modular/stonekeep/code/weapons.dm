/* * * * * **
 *			*
 *	Weapons	*
 *			*
 * * * * * **/

// =================================================================================
// -------------- POLEARMS -----------------
/obj/item/weapon/polearm
	icon = 'modular/stonekeep/icons/weapons_64.dmi'
	slot_flags = null

/obj/item/weapon/polearm/eaglebeak
	slot_flags = null

/obj/item/weapon/polearm/eaglebeak/lucerne/poleaxe
	name = "poleaxe"
	desc = "A poleaxe of simple iron, fracture bone and dissent with simple brute force."
	icon_state = "poleaxe"
/obj/item/weapon/polearm/eaglebeak/lucerne/poleaxe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -8,"sy" = 3,"nx" = 8,"ny" = 6,"wx" = -5,"wy" = 6,"ex" = 0,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -32,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -2,"ex" = 5,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/weapon/polearm/halberd/bardiche/woodcutter
	icon = 'modular/stonekeep/icons/weapons_64.dmi'
	dropshrink = 0.9
/obj/item/weapon/polearm/halberd/bardiche/woodcutter/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -4,"nx" = 7,"ny" = -3,"wx" = -2,"wy" = -3 ,"ex" = 1,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -2,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = -2,"sy" = -2,"nx" = -2,"ny" = -2,"wx" = -4,"wy" = -2,"ex" = -2,"ey" = -3,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)


/obj/item/weapon/polearm/halberd/bardiche/warcutter
	name = "war axe"
	desc = "Favored by common folk looking to cut a noble whoreson down to size."
	smeltresult = /obj/item/ingot/iron

/obj/item/weapon/mace/goden
	icon = 'modular/stonekeep/icons/weapons_64.dmi'

/obj/item/weapon/polearm/woodstaff
	slot_flags = null

/obj/item/weapon/polearm/woodstaff/aries/noc // for noc priest
	name = "staff of lunar epiphany"
	icon_state = "naledistaff"

/obj/item/weapon/polearm/spear/bonespear
	icon_state = "bonespear"

/obj/item/weapon/polearm/spear/hoplite
	desc = "A humble spear with a bronze head, a rare survivor from the battles long past that nearly destroyed Grimoria."

/obj/item/weapon/polearm/spear/hoplite/winged
	desc = "A humble spear with a bronze head, a rare survivor from the battles long past that nearly destroyed Grimoria."

/obj/item/weapon/flail/peasant
	name = "crusher"
	desc = "To break, smash and chastise thy foes."
	icon = 'modular/stonekeep/icons/weapons_64.dmi'
	icon_state = "crusher"

/obj/item/weapon/polearm/spear/stone/copper	// ROGTODO check it works
	icon = 'icons/roguetown/weapons/64.dmi'

//................ Onehanders ............... //
/obj/item/weapon/mace/steel
	icon = 'modular/stonekeep/icons/weapons.dmi'
/obj/item/weapon/mace/steel/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.5,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -6,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()



/obj/item/weapon/knife/hunting
	icon = 'modular/stonekeep/icons/weapons.dmi'

/obj/item/weapon/mace/cudgel
	icon = 'modular/stonekeep/icons/weapons.dmi'

/obj/item/weapon/knife/cleaver
	icon = 'modular/stonekeep/icons/weapons.dmi'

/obj/item/weapon/knife/villager
	icon = 'modular/stonekeep/icons/weapons.dmi'

/obj/item/weapon/pick/paxe
	icon = 'modular/stonekeep/icons/weapons.dmi'

/obj/item/weapon/hammer/sledgehammer
	icon = 'modular/stonekeep/icons/weapons.dmi'

/obj/item/weapon/flail/sflail
	icon = 'modular/stonekeep/icons/weapons.dmi'
	icon_state = "sflail"

/obj/item/weapon/knife/cleaver/combat
	icon = 'icons/roguetown/weapons/32.dmi'
	force = DAMAGE_DAGGER+2

/obj/item/weapon/mace/copperbludgeon
	name = "studded club"
	desc = "A simple wooden club reinforced with some metal bits."
	icon = 'modular/stonekeep/icons/weapons.dmi'
	icon_state = "bludgeon"

/obj/item/weapon/mace/copperbludgeon/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -12,"sy" = -6,"nx" = 12,"ny" = -4,"wx" = -7,"wy" = -4,"ex" = 5,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -6,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()


/obj/item/weapon/mace/cudgel/carpenter
	name = "studded club"
	desc = "A simple wooden club reinforced with some metal bits."
	icon = 'modular/stonekeep/icons/weapons.dmi'
	icon_state = "bludgeon"

/obj/item/weapon/flail/militia
	desc = "A lucky hit from such a flail can squash a cheap helmet along with the wearer's skull."
	icon_state = "iflail_old"

/obj/item/weapon/flail/towner
	desc = "A lucky hit from such a flail can squash a cheap helmet along with the wearer's skull."
	icon_state = "iflail_old"

/obj/item/weapon/axe/iron/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()


//................ Rapiers ............... //
/obj/item/weapon/sword/rapier
	dropshrink = 0.7

/obj/item/weapon/sword/rapier/dec
	icon_state = "decrapier"
	desc = "A rapier decorated with gold inlaid on its hilt. A fine weapon, fit for nobility."
	sellprice = 80

/obj/item/weapon/sword/rapier/dec/lord
	sellprice = 160



/obj/item/weapon/sword/khopesh/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -8,"nx" = 13,"ny" = -8,"wx" = -8,"wy" = -7,"ex" = 7,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -80,"eturn" = 81,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = 4,"nx" = -1,"ny" = 4,"wx" = -8,"wy" = 3,"ex" = 7,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 15,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -4,"sy" = -6,"nx" = 5,"ny" = -6,"wx" = 0,"wy" = -6,"ex" = -1,"ey" = -6,"nturn" = 100,"sturn" = 156,"wturn" = 90,"eturn" = 180,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)



/obj/item/weapon/whip/antique
	name = "war whip"
