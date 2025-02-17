/* POLEARMS
==========================================================*/

/obj/item/rogueweapon/polearm
	throwforce = DAMAGE_STAFF
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	max_blade_int = 100
	max_integrity = INTEGRITY_STANDARD
	minstr = 8
	smeltresult = /obj/item/ash
	associated_skill = /datum/skill/combat/polearms
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	dropshrink = 0.8
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = GREAT_PARRY
	thrown_bclass = BCLASS_STAB
	sellprice = 20

/obj/item/rogueweapon/polearm/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

/*--------------\
| Thrust intent |
\--------------*/
/datum/intent/polearm/thrust
	name = "thrust"
	blade_class = BCLASS_STAB
	attack_verb = list("stabs")
	animname = "stab"
	icon_state = "instab"
	reach = 2
	chargetime = 1
	warnie = "mobwarning"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = AP_POLEARM_THRUST
	swingdelay = 1
	misscost = 10
	item_damage_type = "stab"

/datum/intent/polearm/thrust/spear
	penfactor = AP_SPEAR_THRUST

/*------------\
| Bash intent |
\------------*/
/datum/intent/polearm/bash
	name = "bash"
	blade_class = BCLASS_BLUNT
	icon_state = "inbash"
	attack_verb = list("bashes", "strikes")
	hitsound = list('sound/combat/hits/blunt/woodblunt (1).ogg', 'sound/combat/hits/blunt/woodblunt (2).ogg')
	penfactor = AP_POLEARM_BASH
	damfactor = 0.8
	swingdelay = 1
	misscost = 5
	item_damage_type = "blunt"

/*-------------\
| Swing intent |
\-------------*/
/datum/intent/polearm/bash/swing//AYAYAYAYA BONK BONK BONK
	name = "swing"
	attack_verb = list("bashes", "strikes", "swings")
	reach = 2
	chargetime = 1
	item_damage_type = "slash"

/*-----------\
| Cut intent |
\-----------*/
/datum/intent/polearm/cut
	name = "cut"
	blade_class = BCLASS_CUT
	attack_verb = list("cuts", "slashes")
	icon_state = "incut"
	animname = "cut"
	damfactor = 0.8
	hitsound = list('sound/combat/hits/bladed/genslash (1).ogg', 'sound/combat/hits/bladed/genslash (2).ogg', 'sound/combat/hits/bladed/genslash (3).ogg')
	reach = 2
	swingdelay = 1
	misscost = 10
	item_damage_type = "slash"

/*------------\
| Chop intent |
\------------*/
/datum/intent/polearm/chop
	name = "chop"
	icon_state = "inchop"
	attack_verb = list("chops", "hacks")
	animname = "chop"
	blade_class = BCLASS_CHOP
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	penfactor = AP_POLEARM_CHOP
	chargetime = 1.5
	damfactor = 1.2
	swingdelay = 2
	misscost = 20
	warnie = "mobwarning"
	item_damage_type = "slash"


//................ Wooden Staff ............... //
/obj/item/rogueweapon/polearm/woodstaff
	force =  DAMAGE_STAFF
	force_wielded =  DAMAGE_STAFF_WIELD-1
	possible_item_intents = list(POLEARM_BASH)
	gripped_intents = list(POLEARM_BASH,/datum/intent/mace/smash/wood)
	name = "wooden staff"
	desc = "The ultimate tool of travel for weary wanderers, support your weight or crack the heads that don't support you."
	icon_state = "woodstaff"
	wlength = WLENGTH_LONG
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_BLUNT
	max_integrity = 200
	wdefense = ULTMATE_PARRY
	minstr = 6
	sellprice = 5

/obj/item/rogueweapon/polearm/woodstaff/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -6,"sy" = -1,"nx" = 8,"ny" = 0,"wx" = -4,"wy" = 0,"ex" = 2,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -23,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 4,"sy" = -2,"nx" = -3,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//................ Quarterstaff ............... //!
/obj/item/rogueweapon/polearm/woodstaff/quarterstaff
	force_wielded =  DAMAGE_STAFF_WIELD
	name = "wooden quarterstaff"
	desc = "A staff that makes any journey easier. Durable and swift, capable of bludgeoning stray volves and ruffians alike."
	icon_state = "quarterstaff"
	max_integrity = INTEGRITY_STRONG
	sellprice = 10

//................ Iron-shod Staff ............... //
/obj/item/rogueweapon/polearm/woodstaff/quarterstaff/iron
	force_wielded =  DAMAGE_STAFF_WIELD
	gripped_intents = list(POLEARM_BASH,/datum/intent/mace/smash)
	name = "iron quarterstaff"
	desc = "A perfect tool for bounty hunters who prefer their prisoners broken and bruised but not slain. This reinforced staff is capable of clubbing even an armed opponent into submission with some carefully placed strikes."
	icon_state = "ironstaff"
	minstr = 7
	max_integrity = INTEGRITY_STRONG

/obj/item/rogueweapon/polearm/woodstaff/quarterstaff/steel
	force_wielded =  DAMAGE_STAFF_WIELD+1
	gripped_intents = list(POLEARM_BASH,/datum/intent/mace/smash)
	name = "steel quarterstaff"
	desc = "An unusual sight, a knightly combat staff made out of worked steel and reinforced wood. It is a heavy and powerful weapon, more than capable of beating the living daylights out of any brigand."
	icon_state = "steelstaff"
	minstr = 7
	max_integrity = INTEGRITY_STRONGEST

//................ Staff of the Testimonium ............... //
/obj/item/rogueweapon/polearm/woodstaff/aries
	force_wielded =  DAMAGE_STAFF_WIELD+1
	name = "staff of the testimonium"
	desc = "A symbolic staff, granted to enlightened acolytes who have achieved and bear witnessed to the miracles of the Gods."
	icon_state = "aries"
	resistance_flags = FIRE_PROOF // Leniency for unique items
	dropshrink = 0.6
	sellprice = 100


//................ Spear ............... //
/obj/item/rogueweapon/polearm/spear
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEAR_WIELD
	throwforce = DAMAGE_SPEAR
	possible_item_intents = list(SPEAR_THRUST, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEARM_THRUST, SPEAR_CUT, POLEARM_BASH)
	name = "spear"
	desc = "The humble spear, use the pointy end."
	icon_state = "spear"
	slot_flags = ITEM_SLOT_BACK
	max_blade_int = 100
	smeltresult = /obj/item/ingot/iron
	dropshrink = 0.8
	thrown_bclass = BCLASS_STAB
	sellprice = 22

/obj/item/rogueweapon/polearm/spear/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)

//................ Billhook ............... //
/obj/item/rogueweapon/polearm/spear/billhook
	name = "billhook"
	desc = "A polearm with a curved krag, a Valorian design for dismounting mounted warriors and to strike down monstrous beasts."
	icon_state = "billhook"
	possible_item_intents = list(POLEARM_THRUST, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEARM_THRUST, SPEAR_CUT, /datum/intent/polearm/chop, POLEARM_BASH)
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	max_blade_int = 100
	smeltresult = /obj/item/ingot/steel
	max_integrity = INTEGRITY_STRONG
	wdefense = ULTMATE_PARRY
	wbalance = EASY_TO_DODGE
	sellprice = 60


//................ Stone Short Spear ............... //		- Short spears got shorter reach and worse wield effect, made for one handed and throwing
/obj/item/rogueweapon/polearm/spear/stone
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEAR+2
	throwforce = DAMAGE_SPEAR
	name = "simple spear"
	desc = "With this weapon, the tribes of humenity became the chosen people of Psydon."
	icon_state = "stonespear"
	minstr = 6
	max_blade_int = 50
	smeltresult = /obj/item/ash
	dropshrink = 0.7
	wlength = WLENGTH_LONG
	wdefense = AVERAGE_PARRY
	max_integrity = INTEGRITY_WORST
	sellprice = 5

//................ Javelin ............... //
/obj/item/rogueweapon/polearm/spear/stone/copper
	throwforce = DAMAGE_SPEAR_WIELD
	name = "javelin"
	desc = "Made for throwing, long out of favor and using inferior metals, it still can kill when the aim is true."
	icon_state = "cspear"
	max_blade_int = 70
	max_integrity = INTEGRITY_POOR
	minstr = 7
	smeltresult = /obj/item/ingot/copper
	dropshrink = 0.9
	sellprice = 15
	throw_speed = 3
	embedding = list("embedded_pain_multiplier" = 4, "embed_chance" = 50, "embedded_fall_chance" = 0, "embedded_ignore_throwspeed_threshold" = 1)

/obj/item/rogueweapon/polearm/spear/stone/copper/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)


//................ Halberd ............... //
/obj/item/rogueweapon/polearm/halberd
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_HALBERD_WIELD
	slowdown = 1
	possible_item_intents = list(POLEARM_THRUST, POLEARM_BASH) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEARM_THRUST, SPEAR_CUT, /datum/intent/polearm/chop, POLEARM_BASH)
	name = "halberd"
	desc = "A reinforced polearm for clobbering ordained with a crested ax head, pick and sharp point, a royal arm for defence and aggression."
	icon_state = "halberd"
	slot_flags = ITEM_SLOT_BACK
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	smeltresult = /obj/item/ingot/steel
	dropshrink = 0.8
	wdefense = ULTMATE_PARRY
	wbalance = EASY_TO_DODGE
	sellprice = 90

/obj/item/rogueweapon/polearm/halberd/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


//................ Bardiche ............... //
/obj/item/rogueweapon/polearm/halberd/bardiche
	force = DAMAGE_AXE
	force_wielded = DAMAGE_AXE_WIELD
	possible_item_intents = list(/datum/intent/axe/cut)
	gripped_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop/great, /datum/intent/axe/thrust)
	name = "bardiche"
	desc = "A grand axe of northernly design, renowned for easily chopping off limbs clean with brutal strength."
	icon_state = "bardiche"
	smeltresult = /obj/item/ingot/iron
	swingsound = BLADEWOOSH_MED
	wbalance = VERY_EASY_TO_DODGE
	max_blade_int = 200
	max_integrity = INTEGRITY_STRONG
	dropshrink = 0.95
	minstr = 10
	wdefense = AVERAGE_PARRY
	axe_cut = 10
	sellprice = 30

//................ Eagle Beak ............... //
/obj/item/rogueweapon/polearm/eaglebeak
	force = DAMAGE_SPEAR
	force_wielded = DAMAGE_SPEAR_WIELD
	slowdown = 1
	possible_item_intents = list(POLEARM_BASH, /datum/intent/polearm/chop) //bash is for nonlethal takedowns, only targets limbs
	gripped_intents = list(POLEARM_BASH, POLEARM_THRUST, /datum/intent/mace/smash/heavy,/datum/intent/polearm/chop)
	name = "eagle's beak"
	desc = "A reinforced pole affixed with an ornate steel eagle's head, of which it's beak is intended to pierce with great harm."
	icon_state = "eaglebeak"
	slot_flags = ITEM_SLOT_BACK
	minstr = 11
	smeltresult = /obj/item/ingot/steel
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONGEST
	dropshrink = 0.8
	wbalance = EASY_TO_DODGE
	sellprice = 60

/obj/item/rogueweapon/polearm/eaglebeak/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -8,"sy" = 6,"nx" = 8,"ny" = 6,"wx" = -5,"wy" = 6,"ex" = 0,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 32,"eturn" = -32,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -2,"ex" = 5,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

//................ Lucerne Hammer ............... //
/obj/item/rogueweapon/polearm/eaglebeak/lucerne
	name = "lucerne"
	desc = "A polehammer of simple iron, fracture bone and dissent with simple brute force."
	icon_state = "polehammer"
	smeltresult = /obj/item/ingot/iron
	max_integrity = INTEGRITY_STRONG
	sellprice = 40
	wbalance = VERY_EASY_TO_DODGE
	wdefense = AVERAGE_PARRY

//................ Hoplite Spear ............... //
/obj/item/rogueweapon/polearm/spear/hoplite
	force = DAMAGE_SPEARPLUS
	name = "ancient spear"
	desc = "A humble spear with a bronze head, a rare survivor from the battles long past that nearly destroyed Psydonia."
	icon_state = "bronzespear"
	max_blade_int = 300
	max_integrity = INTEGRITY_STRONG
	smeltresult = /obj/item/ash
	sellprice = 120 // A noble collector would love to get his/her hands on one of these spears

/obj/item/rogueweapon/polearm/spear/hoplite/winged // Winged version has +1 weapon defence and sells for a bit more, but is identical otherwise
	name = "ancient winged spear"
	desc = "A spear with a winged bronze head, a rare survivor from the battles long past that nearly destroyed Psydonia."
	icon_state = "bronzespear_winged"
	wdefense = ULTMATE_PARRY
	sellprice = 150 // A noble collector would love to get his/her hands on one of these spears


/obj/item/rogueweapon/polearm/spear/bronze
	name = "Bronze Spear"
	desc = "A spear forged of bronze. Expensive but more durable than a regular iron one."
	icon_state = "bronzespear"
	max_blade_int = 200
	smeltresult = /obj/item/ingot/bronze
	force = 20
	force_wielded = 25


//scythe
/obj/item/rogueweapon/sickle/scythe
	force = 10
	force_wielded = 20
	possible_item_intents = list(SPEAR_CUT) //truly just a long knife
	gripped_intents = list(SPEAR_CUT)
	name = "scythe"
	desc = "A humble farming tool with long reach, traditionally used to cut grass or wheat."
	icon_state = "scythe"
	icon = 'icons/roguetown/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	max_blade_int = 100
	max_integrity = 300
	minstr = 5
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/polearms
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	dropshrink = 0.75
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = 2
	thrown_bclass = BCLASS_CUT
	throwforce = 25
	sellprice = 10

/obj/item/rogueweapon/polearm/spear/bonespear
	force = 18
	force_wielded = 22
	name = "bone spear"
	desc = "A spear made of bones."
	// icon_state = "bonespear"
	icon_state = "stonespear_sk"
	// pixel_y = -16
	// pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	minstr = 6
	max_blade_int = 70
	smeltresult = null
	associated_skill = /datum/skill/combat/polearms
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wdefense = 4
	max_integrity = 60
	throwforce = 20
