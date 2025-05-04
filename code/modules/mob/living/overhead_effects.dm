//By DREAMKEEP, Vide Noir https://github.com/EaglePhntm.
//GRAPHICS & SOUNDS INCLUDED:
//DARKEST DUNGEON (STRESS, RELIEF, AFFLICTION)
/mob/living/carbon/proc/play_overhead_indicator(icon_path, overlay_name, clear_time, overlay_layer, public = FALSE, soundin = null)
	if(!ishuman(src))
		return
	if(!client)
		return
	if(!COOLDOWN_FINISHED(src, stress_indicator))
		return
	var/datum/species/species =	dna?.species
	if(!species)
		return
	if(stat < UNCONSCIOUS)
		COOLDOWN_START(src, stress_indicator, 8 SECONDS)
		var/list/offset_list
		if(gender == FEMALE)
			offset_list = species.offset_features[OFFSET_HEAD_F]
		else
			offset_list = species.offset_features[OFFSET_HEAD]
		if(public)
			var/mutable_appearance/appearance = mutable_appearance(icon_path, overlay_name, overlay_layer)
			if(offset_list)
				appearance.pixel_x += (offset_list[1])
				appearance.pixel_y += (offset_list[2]+12)
			appearance.appearance_flags = RESET_COLOR
			overlays_standing[OBJ_LAYER] = appearance
			apply_overlay(OBJ_LAYER)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, cut_overlay), appearance), clear_time)
			playsound(src, soundin, 15, FALSE, extrarange = -1, ignore_walls = FALSE)
		else
			var/list/can_see = list()
			for(var/mob/M in viewers(src))
				if(HAS_TRAIT(M, TRAIT_EMPATH))
					can_see += M
					if(soundin)
						M.playsound_local(get_turf(src), soundin, 15, FALSE)

			vis_contents += new /obj/effect/temp_visual/stress_event(null, can_see, icon_path, overlay_name, offset_list)

/obj/effect/temp_visual/stress_event
	icon = 'icons/mob/overhead_effects.dmi'
	icon_state = null
	duration = 25
	layer = BELOW_MOB_LAYER
	vis_flags = VIS_INHERIT_PLANE|VIS_INHERIT_ID

/obj/effect/temp_visual/stress_event/Initialize(mapload, list/seers, path, iname, list/offsets)
	. = ..()
	var/image/I = image(icon = path, icon_state = iname, layer = ABOVE_MOB_LAYER, loc = src)
	I.alpha = 255
	I.appearance_flags = RESET_ALPHA
	if(offsets)
		I.pixel_x += (offsets[1])
		I.pixel_y += (offsets[2]+12)
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/People, iname, I, seers)

/mob/living/carbon/proc/play_stress_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "stress", 20, OBJ_LAYER, soundin = 'sound/ddstress.ogg')

/mob/living/carbon/proc/play_relief_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "relief", 20, OBJ_LAYER, soundin = 'sound/ddrelief.ogg')

/mob/living/carbon/proc/play_mental_break_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "mentalbreak", 30, OBJ_LAYER, soundin = 'sound/stressaffliction.ogg')
