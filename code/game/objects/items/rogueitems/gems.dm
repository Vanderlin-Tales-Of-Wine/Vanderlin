
/obj/item/roguegem
	name = "random gem"
	desc = "If you find this, yell at coderbus"
	icon_state = "aros"
	icon = 'icons/roguetown/items/gems.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	///I am leaving this here as a note. If you leave the price null on subtypes, you're eating the infinite recursion pill.
	///I dont care if its negative just DONT LEAVE IT 0
	sellprice = 0
	static_price = FALSE
	experimental_inhand = FALSE
	///For Mappers; gem_path = weight
	var/list/valid_gems = list()

/obj/item/roguegem/Initialize()
	. = ..()
	if(sellprice == 0)
		var/new_gem
		if(length(valid_gems))
			new_gem = pickweight(valid_gems)
		else
			new_gem = pick(subtypesof(/obj/item/roguegem))
		var/obj/item/roguegem/spawned = new new_gem(get_turf(src))
		spawned.update_icon_state()
		return INITIALIZE_HINT_QDEL
	update_icon_state()

///This is a switch incase anyone would like to add more...
/obj/item/roguegem/update_icon_state()
	if(icon_state == "aros")
		switch(rand(1,2))
			if(1)
				icon_state = "d_cut"
			if(2)
				icon_state = "e_cut"
	return
/obj/item/roguegem/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -1,"sy" = 0,"nx" = 11,"ny" = 1,"wx" = 0,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = 0,"wturn" = 0,"eturn" = 39,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/roguegem/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(loc, pick('sound/items/gems (1).ogg','sound/items/gems (2).ogg'), 100, TRUE, -2)
	..()

/obj/item/roguegem/green
	name = "gemerald"
	desc = "Glints with verdant brilliance."
	//color = "#15af158c"
	icon_state = "emerald_cut"
	sellprice = 44

/obj/item/roguegem/blue
	name = "blortz"
	desc = "Pale blue, like a frozen tear."
	//color = "#1ca5aa8c"
	icon_state = "quartz_cut"
	sellprice = 88

/obj/item/roguegem/yellow
	name = "toper"
	desc = "Its amber hues remind you of the sunset."
	//color = "#e6a0088c"
	icon_state = "topaz_cut"
	sellprice = 25

/obj/item/roguegem/violet
	name = "saffira"
	desc = "This gem is admired by many wizards."
	//color = "#1733b38c"
	icon_state = "sapphire_cut"
	sellprice = 56

/obj/item/roguegem/diamond
	name = "dorpel"
	desc = "Beautifully pure, it demands respect."
	//color = "#ffffff8c"
	icon_state = "diamond_cut"
	sellprice = 121

/obj/item/roguegem/red
	name = "rubor"
	desc = "Glistening with unkempt rage."
	//color = "#ff00008c"
	icon_state = "ruby_cut"
	sellprice = 100

/obj/item/roguegem/black
	name = "onyxa"
	desc = "Dark as nite."
	color = "#2000138c"
	sellprice = 76

/// riddle


/obj/item/riddleofsteel
	name = "riddle of steel"
	icon_state = "ros"
	icon = 'icons/roguetown/items/gems.dmi'
	desc = "Flesh, mind."
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.4
	drop_sound = 'sound/items/gem.ogg'
	sellprice = 554

/obj/item/riddleofsteel/Initialize()
	. = ..()
	set_light(2, 2, 1, l_color = "#ff0d0d")
