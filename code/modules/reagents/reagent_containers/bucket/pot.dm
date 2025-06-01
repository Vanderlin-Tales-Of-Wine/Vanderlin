/obj/item/reagent_containers/glass/bucket/pot
	force = 10
	name = "pot"
	desc = "The peasants friend, when filled with boiling water it will turn the driest oats to filling oatmeal."

	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "pote"

	sharpness = IS_BLUNT
	slot_flags = null
	w_class = WEIGHT_CLASS_BULKY
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	var/processing_amount = 0 ///we use this to "reserve" reagents
	var/static/list/recipe_list = list()

/obj/item/reagent_containers/glass/bucket/pot/Initialize(mapload, vol)
	. = ..()
	if(!length(recipe_list))
		recipe_list = subtypesof(/datum/container_craft/cooking)
		recipe_list -= /datum/container_craft/cooking/generic_meat_stew
		recipe_list += /datum/container_craft/cooking/generic_meat_stew

	AddComponent(/datum/component/storage/concrete/grid/food/cooking/pot)
	AddComponent(/datum/component/container_craft, recipe_list, TRUE)

/obj/item/reagent_containers/glass/bucket/pot/copper
	icon_state = "pote_copper"

/obj/item/reagent_containers/glass/bucket/pot/update_icon()
	cut_overlays()
	if(reagents.total_volume > 0)
		if(reagents.total_volume <= 50)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/cooking.dmi', "pote_half")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			for(var/datum/reagent/reagent as anything in reagents.reagent_list)
				if(reagent.glows)
					var/mutable_appearance/emissive = mutable_appearance('icons/roguetown/items/cooking.dmi', "pote_half")
					emissive.plane = EMISSIVE_PLANE
					overlays += emissive
					break
			add_overlay(filling)

		if(reagents.total_volume > 50)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/cooking.dmi', "pote_full")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			for(var/datum/reagent/reagent as anything in reagents.reagent_list)
				if(reagent.glows)
					var/mutable_appearance/emissive = mutable_appearance('icons/roguetown/items/cooking.dmi', "pote_full")
					emissive.plane = EMISSIVE_PLANE
					overlays += emissive
					break
			add_overlay(filling)


/obj/item/reagent_containers/glass/bucket/pot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass/bowl))
		to_chat(user, "<span class='notice'>Filling the bowl...</span>")
		playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 70, FALSE)
		if(do_after(user, 2 SECONDS, src))
			reagents.trans_to(I, reagents.total_volume)
		return TRUE
	return ..()

/obj/item/reagent_containers/glass/bucket/pot/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(reagents.total_volume > 5)
		new /obj/effect/decal/cleanable/food/mess/soup(get_turf(src))
	. = ..()

/obj/item/reagent_containers/glass/bucket/pot/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -5,"sy" = -8,"nx" = 7,"ny" = -9,"wx" = -1,"wy" = -8,"ex" = -1,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
