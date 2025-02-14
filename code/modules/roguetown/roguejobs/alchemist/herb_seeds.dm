/obj/item/herbseed
	name = "herb seeds"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "seeds"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	possible_item_intents = list(/datum/intent/use)
	var/makes_herb = null
	var/seed_identity = "unknown"

/obj/item/herbseed/Initialize()
	. = ..()
	if(icon_state == "seeds")
		icon_state = "seeds[rand(1,3)]"

/obj/item/herbseed/examine(mob/user)
	. = ..()
	var/show_real_identity = FALSE
	if(isliving(user))
		var/mob/living/living = user
		if(HAS_TRAIT(living, TRAIT_SEEDKNOW) || HAS_TRAIT(living,TRAIT_LEGENDARY_ALCHEMIST))
			show_real_identity = TRUE
		// Alchemy seeds, so they would know them
		else if(living.mind.get_skill_level(/datum/skill/craft/alchemy) >= 2 || living.mind.get_skill_level(/datum/skill/labor/farming) >= 2)
			show_real_identity = TRUE
	else
		show_real_identity = TRUE
	if(show_real_identity)
		. += span_info("I can tell these are [seed_identity]")

/obj/item/herbseed/attack_turf(turf/T, mob/living/user)
	var/obj/structure/soil/soil = get_soil_on_turf(T)
	if(soil)
		try_plant_seed(user, soil)
		return
	else if(istype(T, /turf/open/floor/rogue/dirt))
		to_chat(user, span_notice("I begin making a mound for the seeds..."))
		if(do_after(user, get_farming_do_time(user, 10 SECONDS), src))
			apply_farming_fatigue(user, 30)
			soil = get_soil_on_turf(T)
			if(!soil)
				soil = new /obj/structure/soil(T)
		return
	. = ..()

/obj/item/herbseed/proc/try_plant_seed(mob/living/user, obj/structure/soil/soil)
	if(soil.plant)
		to_chat(user, span_warning("There is already something planted in \the [soil]!"))
		return
	to_chat(user, span_notice("I plant \the [src] in \the [soil]. I should check back later when \the [src] has grown."))
	addtimer(CALLBACK(src,TYPE_PROC_REF(/obj/item/herbseed,become_plant),soil,makes_herb),7.5 MINUTES)
	soil.desc += span_info(" Something appears to be planted here, but I cannot descern what.")
	src.forceMove(soil)
	return

/obj/item/herbseed/proc/become_plant(obj/structure/soil/soil,to_make)
	if(QDELETED(src) || QDELETED(soil))
		return
	if(ispath(to_make))
		var/obj/structure/flora/roguegrass/herb/newplant = new to_make
		newplant.forceMove(get_turf(soil))
		newplant.pixel_x += rand(-3,3)
		soil.visible_message(span_info("The [soil] suddenly bursts away to reveal \the [newplant]!"))
	else
		soil.visible_message(span_info("The [soil] suddenly collapses, leaving nothing behind..."))
	qdel(soil)
	return

/obj/item/herbseed/atropa
	makes_herb = /obj/structure/flora/roguegrass/herb/atropa
	seed_identity = "atropa seeds"

/obj/item/herbseed/matricaria
	makes_herb = /obj/structure/flora/roguegrass/herb/matricaria
	seed_identity = "matricaria seeds"

/obj/item/herbseed/symphitum
	makes_herb = /obj/structure/flora/roguegrass/herb/symphitum
	seed_identity = "symphitum seeds"

/obj/item/herbseed/taraxacum
	makes_herb = /obj/structure/flora/roguegrass/herb/taraxacum
	seed_identity = "taraxacum seeds"

/obj/item/herbseed/euphrasia
	makes_herb = /obj/structure/flora/roguegrass/herb/euphrasia
	seed_identity = "euphrasia seeds"

/obj/item/herbseed/paris
	makes_herb = /obj/structure/flora/roguegrass/herb/paris
	seed_identity = "paris seeds"

/obj/item/herbseed/calendula
	makes_herb = /obj/structure/flora/roguegrass/herb/calendula
	seed_identity = "calendula seeds"

/obj/item/herbseed/mentha
	makes_herb = /obj/structure/flora/roguegrass/herb/mentha
	seed_identity = "mentha seeds"

/obj/item/herbseed/urtica
	makes_herb = /obj/structure/flora/roguegrass/herb/urtica
	seed_identity = "urtica seeds"

/obj/item/herbseed/salvia
	makes_herb = /obj/structure/flora/roguegrass/herb/salvia
	seed_identity = "salvia seeds"

/obj/item/herbseed/hypericum
	makes_herb = /obj/structure/flora/roguegrass/herb/hypericum
	seed_identity = "hypericum seeds"

/obj/item/herbseed/benedictus
	makes_herb = /obj/structure/flora/roguegrass/herb/benedictus
	seed_identity = "benedictus seeds"

/obj/item/herbseed/valeriana
	makes_herb = /obj/structure/flora/roguegrass/herb/valeriana
	seed_identity = "valeriana seeds"

/obj/item/herbseed/artemisia
	makes_herb = /obj/structure/flora/roguegrass/herb/artemisia
	seed_identity = "artemisia seeds"
