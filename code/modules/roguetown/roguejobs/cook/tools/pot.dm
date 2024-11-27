/obj/item/reagent_containers/glass/bucket/pot
	force = 10
	name = "pot"
	desc = "The peasants friend, when filled with boiling water it will turn the driest oats to filling oatmeal."

	icon = 'modular/Neu_Food/icons/cooking.dmi'
	icon_state = "pote"

	sharpness = IS_BLUNT
	slot_flags = null
	w_class = WEIGHT_CLASS_BULKY
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'

	// Sorry Melbert for butchering your code
	var/list/obj/item/added_ingredients


/obj/item/reagent_containers/glass/bucket/pot/attackby(obj/item/reagent_containers/food/snacks/attacking_item, mob/user, params)
	. = ..()
	if(.)
		return

	if(isnull(attacking_item.stew_reagent))
		to_chat(user, "<span class='notice'>Cooking this wouldn't make any stew!</span>")
		return

	// Not enough room
	if(LAZYLEN(added_ingredients) >= FLOOR((reagents.get_reagent_amount(/datum/reagent/water) / 33), 1))
		to_chat(user, "<span class='notice'>There's not enough room for another ingredient!</span>")
		return

	to_chat(user, "DEBUG MESSAGE. ROOM CHECK AND REAGENT CHECK PASSED.")
	LAZYADD(added_ingredients, attacking_item)
	to_chat(user, "ITEM SHOULD BE ADDED. CHECK added_ingredients VARIABLE.")
	qdel(attacking_item)
	return


/obj/item/reagent_containers/glass/bucket/pot/update_icon()
	cut_overlays()
	if(reagents.total_volume > 0)
		if(reagents.total_volume <= 50)
			var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "pote_half")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)

		if(reagents.total_volume > 50)
			var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "pote_full")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)


/obj/item/reagent_containers/glass/bucket/pot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass/bowl))
		to_chat(user, "<span class='notice'>Filling the bowl...</span>")
		playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 70, FALSE)
		if(do_after(user,2 SECONDS, target = src))
			reagents.trans_to(I, reagents.total_volume)
	return TRUE

/obj/item/reagent_containers/glass/bucket/pot/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(reagents.total_volume > 5)
		new /obj/effect/decal/cleanable/food/mess/soup(get_turf(src))
	..()

/obj/item/reagent_containers/glass/bucket/pot/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -5,"sy" = -8,"nx" = 7,"ny" = -9,"wx" = -1,"wy" = -8,"ex" = -1,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)

