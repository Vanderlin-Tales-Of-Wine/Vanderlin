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
	var/mob/living/carbon/human/H = src
	if(stat < UNCONSCIOUS)
		COOLDOWN_START(src, stress_indicator, 8 SECONDS)

		var/list/offsets

		if(public)
			var/use_female_sprites = MALE_SPRITES
			if(species)
				if(species.sexes)
					if(H.gender == FEMALE && !species.swap_female_clothes || H.gender == MALE && species.swap_male_clothes)
						use_female_sprites = FEMALE_SPRITES

				if(use_female_sprites)
					offsets = (H.age == AGE_CHILD) ? species.offset_features_child : species.offset_features_f
				else
					offsets = (H.age == AGE_CHILD) ? species.offset_features_child : species.offset_features_m

			var/mutable_appearance/appearance = mutable_appearance(icon_path, overlay_name, overlay_layer)
			if(LAZYACCESS(offsets, OFFSET_HEAD))
				appearance.pixel_x += offsets[OFFSET_HEAD][1]
				appearance.pixel_y += offsets[OFFSET_HEAD][2] + 12
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

			vis_contents += new /obj/effect/temp_visual/stress_event(null, can_see, icon_path, overlay_name, offsets)

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
	if(LAZYACCESS(offsets, OFFSET_HEAD))
		I.pixel_x += offsets[OFFSET_HEAD][1]
		I.pixel_y += offsets[OFFSET_HEAD][2] + 12
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/People, iname, I, seers)

/mob/living/carbon/proc/play_stress_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "stress", 20, OBJ_LAYER, soundin = 'sound/ddstress.ogg')

/mob/living/carbon/proc/play_relief_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "relief", 20, OBJ_LAYER, soundin = 'sound/ddrelief.ogg')

/mob/living/carbon/proc/play_mental_break_indicator()
	play_overhead_indicator('icons/mob/overhead_effects.dmi', "mentalbreak", 30, OBJ_LAYER, soundin = 'sound/stressaffliction.ogg')
