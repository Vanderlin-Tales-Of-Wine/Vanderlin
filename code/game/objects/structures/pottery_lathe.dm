/obj/item/natural/clay
	name = "clay"
	icon_state = "clay"
	main_material = /datum/material/clay

/obj/item/natural/clay/New(loc, ...)
	main_material = pick(typesof(/datum/material/clay))

	. = ..()
/obj/item/natural/clay/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] clay lump"

/obj/structure/pottery_lathe
	name = "potter's lathe"
	icon = 'icons/obj/pottery_wheel.dmi'
	icon_state = "wheel"

	density = TRUE
	anchored = TRUE

	rotation_structure = TRUE
	stress_use = 64

	var/obj/item/natural/clay/stored_clay
	var/datum/pottery_recipe/in_progress

	var/static/list/recipes = list()


/obj/structure/pottery_lathe/update_overlays()
	. = ..()
	if(length(overlays))
		overlays.Cut()

	if(!stored_clay)
		return
	var/mutable_appearance/MA = mutable_appearance(icon, "wheel-clay")
	MA.color = initial(stored_clay.main_material.color)
	overlays += MA

/obj/structure/pottery_lathe/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(!stored_clay)
		if(istype(I, /obj/item/natural/clay))
			if(!choose_recipe(user))
				return
			stored_clay = I
			I.forceMove(src)
			start_spinning_pottery(user)
			return

	if(!in_progress?.next_step(I))
		return
	I.forceMove(src)
	start_spinning_pottery(user)

/obj/structure/pottery_lathe/attack_hand(mob/user)
	. = ..()
	start_spinning_pottery(user)

/obj/structure/pottery_lathe/proc/start_spinning_pottery(mob/user)
	update_overlays()
	if(!stored_clay)
		return

	visible_message("[user] starts shaping some clay.", "You start shaping some clay.")
	if(!do_after(user, in_progress.get_delay(user, rotations_per_minute), src))
		return

	if(in_progress.update_step(user, rotations_per_minute))
		finish_item(user)

/obj/structure/pottery_lathe/proc/finish_item(mob/user)
	var/obj/obj = new in_progress.created_item (get_turf(src))
	obj.set_main_material(stored_clay.main_material)

	in_progress.finish(user)

	QDEL_NULL(in_progress)
	QDEL_NULL(stored_clay)

/obj/structure/pottery_lathe/proc/choose_recipe(mob/user)
	if(!length(recipes))
		for(var/datum/pottery_recipe/recipe as anything in typesof(/datum/pottery_recipe))
			if(is_abstract(recipe))
				continue
			recipes |= new recipe

	var/datum/pottery_recipe/choice = input(user, "Choose a recipe to start", src) as anything in recipes
	if(!choice)
		return FALSE
	in_progress = new choice.type
	return TRUE

