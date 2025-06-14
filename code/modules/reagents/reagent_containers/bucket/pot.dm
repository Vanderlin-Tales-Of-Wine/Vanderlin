/obj/item/reagent_containers/glass/bucket/pot
	name = "pot"
	desc = "The peasants friend, when filled with boiling water it will turn the driest oats to filling oatmeal."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "pote"
	fill_icon_state = null
	force = 10
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
