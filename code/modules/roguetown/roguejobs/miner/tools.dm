/obj/item/rogueweapon/pick
	force = 10
	possible_item_intents = list(/datum/intent/pick)
	name = "pick"
	desc = ""
	icon_state = "pick"
	icon = 'icons/roguetown/weapons/tools.dmi'
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	experimental_onhip = FALSE
	experimental_onback = FALSE
	sharpness = IS_BLUNT
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	toolspeed = 2
	associated_skill = /datum/skill/labor/mining
	smeltresult = /obj/item/ingot/iron
	var/pickmult = 1 // Multiplier of how much extra picking force we do to rocks.

/obj/item/rogueweapon/pick/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -10,"sy" = 0,"nx" = 11,"ny" = 0,"wx" = -8,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/pick/copper
	force = 7
	possible_item_intents = list(/datum/intent/pick)
	name = "copper pick"
	desc = ""
	icon_state = "cpick"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	toolspeed = 3
	pickmult = 0.8 // Worse pick
	associated_skill = /datum/skill/combat/axesmaces
	smeltresult = /obj/item/ingot/copper

