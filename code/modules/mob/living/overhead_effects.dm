//By DREAMKEEP, Vide Noir https://github.com/EaglePhntm.
//GRAPHICS & SOUNDS INCLUDED:
//DARKEST DUNGEON (STRESS, RELIEF, AFFLICTION)
/mob/living/proc/play_overhead_indicator(icon_path, overlay_name, clear_time, overlay_layer, private = FALSE, soundin = null)
	if(!ishuman(src))
		return
	if(!client)
		return
	if(!MOBTIMER_FINISHED(src, MT_STRESS, 10 SECONDS))
		return
	if(stat < UNCONSCIOUS)
		MOBTIMER_SET(src, MT_STRESS)
		var/mob/living/carbon/human/humie = src
		var/datum/species/species =	humie.dna.species
		var/list/offset_list
		if(humie.gender == FEMALE)
			offset_list = species.offset_features[OFFSET_HEAD_F]
		else
			offset_list = species.offset_features[OFFSET_HEAD]
		if(!private)
			var/mutable_appearance/appearance = mutable_appearance(icon_path, overlay_name, overlay_layer)
			if(offset_list)
				appearance.pixel_x += (offset_list[1])
				appearance.pixel_y += (offset_list[2]+12)
			appearance.appearance_flags = RESET_COLOR
			overlays_standing[OBJ_LAYER] = appearance
			apply_overlay(OBJ_LAYER)
			addtimer(CALLBACK(humie, PROC_REF(clear_overhead_indicator), appearance), clear_time)
			playsound(src, soundin, 15, FALSE, extrarange = -1, ignore_walls = FALSE)
		else
			var/list/can_see = list()
			for(var/mob/M in viewers(world.view, src))
				if(HAS_TRAIT(M, TRAIT_EMPATH))
					can_see += M
					if(soundin)
						M.playsound_local(get_turf(src), soundin, 15, FALSE)

			vis_contents += new /obj/effect/temp_visual/stress_event/invisible(null, can_see, icon_path, overlay_name, offset_list)

/obj/effect/temp_visual/stress_event
	icon = 'icons/mob/overhead_effects.dmi'
	duration = 25
	layer = BELOW_MOB_LAYER
	vis_flags = VIS_INHERIT_PLANE

/obj/effect/temp_visual/stress_event/invisible
	icon_state = null

/obj/effect/temp_visual/stress_event/invisible/Initialize(mapload, list/seers, path, iname, list/offsets)
	. = ..()
	var/image/I = image(icon = path, icon_state = iname, layer = ABOVE_MOB_LAYER, loc = src)
	I.alpha = 255
	I.appearance_flags = RESET_ALPHA
	if(offsets)
		I.pixel_x += (offsets[1])
		I.pixel_y += (offsets[2]+12)
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/People, iname, I, seers)

/mob/living/proc/clear_overhead_indicator(appearance)
	cut_overlay(appearance)
	qdel(appearance)
	update_icon()
	return

/mob/living/proc/play_stress_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "stress", 15, OBJ_LAYER, private = TRUE, soundin = 'sound/ddstress.ogg')

/mob/living/proc/play_relief_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "relief", 15, OBJ_LAYER, private = TRUE, soundin = 'sound/ddrelief.ogg')

/mob/living/proc/play_mental_break_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "mentalbreak", 25, OBJ_LAYER, private = TRUE, soundin = 'sound/stressaffliction.ogg')
