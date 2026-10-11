// rmd embeds this integration for the Forced bundled profile setting. To make the profile part of a
// Vanderlin checkout instead, copy it there and `#include` it from `vanderlin.dme` after
// `// END_INCLUDE`, the guard keeps BYOND compiling it to nothing.
//
// Vanderlin needs its globals and overlay subsystem stubbed before anything smooths, and its fluid
// pipes assemble an icon state from a connection list that normally fills in over two init passes.
#ifdef __DEMIR_BAKE__

/datum/controller/subsystem/overlays/demir_preview/New()
	SSoverlays = src
	stats = list()

/datum/controller/global_vars/demir_preview/New()
	GLOB = src
	if(!SSoverlays)
		SSoverlays = new /datum/controller/subsystem/overlays/demir_preview
	bitflag_lists = list()
	gvars_datum_init_order = list()
	InitGlobalcardinals()

/atom/proc/demir_prepare_smoothing()
	SETUP_SMOOTHING()

// MOVABLE_LIGHT uses a pre-baked mask in vis_contents. Emit the same mask as a tagged underlay so
// the editor can composite it after static lighting without starting components or signals.
/proc/demir_vanderlin_overlay_icon(pixel_bounds)
	switch(pixel_bounds)
		if(32)
			return 'icons/effects/light_overlays/light_32.dmi'
		if(64)
			return 'icons/effects/light_overlays/light_64.dmi'
		if(96)
			return 'icons/effects/light_overlays/light_96.dmi'
		if(128)
			return 'icons/effects/light_overlays/light_128.dmi'
		if(160)
			return 'icons/effects/light_overlays/light_160.dmi'
		if(192)
			return 'icons/effects/light_overlays/light_192.dmi'
		if(224)
			return 'icons/effects/light_overlays/light_224.dmi'
		if(256)
			return 'icons/effects/light_overlays/light_256.dmi'
		if(288)
			return 'icons/effects/light_overlays/light_288.dmi'
		if(320)
			return 'icons/effects/light_overlays/light_320.dmi'
		if(352)
			return 'icons/effects/light_overlays/light_352.dmi'
		if(384)
			return 'icons/effects/light_overlays/light_384.dmi'
		if(416)
			return 'icons/effects/light_overlays/light_416.dmi'
		if(448)
			return 'icons/effects/light_overlays/light_448.dmi'
		if(480)
			return 'icons/effects/light_overlays/light_480.dmi'
		if(512)
			return 'icons/effects/light_overlays/light_512.dmi'
		if(544)
			return 'icons/effects/light_overlays/light_544.dmi'
	return null

/atom/movable/proc/demir_add_overlay_light()
	if(light_system != MOVABLE_LIGHT || !light_on || !light_outer_range)
		return
	demir_add_light_mask(light_outer_range, light_color)

/atom/movable/proc/demir_add_light_mask(outer_range, mask_color)
	var/rounded_range = clamp(CEILING(outer_range, 0.5), 1, 9)
	var/pixel_bounds = ((rounded_range - 1) * 64) + 32
	var/image/mask = new
	mask.icon = demir_vanderlin_overlay_icon(pixel_bounds)
	mask.icon_state = "light2"
	mask.dir = dir
	mask.plane = O_LIGHTING_VISUAL_PLANE
	mask.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	mask.alpha = 255
	mask.color = mask_color
	mask.pixel_x = -((pixel_bounds - 32) * 0.5)
	mask.pixel_y = mask.pixel_x
	mask.demir_overlay_light = 1
	underlays += mask

// A sconce sparks the torch it spawns in Initialize(), and the torch's light component hangs its
// mask on the sconce because the torch itself is not on a turf.
/obj/machinery/light/fueled/torchholder/demir_add_overlay_light()
	if(!ispath(torchy))
		return
	var/obj/item/flashlight/flare/torch/torch = torchy
	demir_add_light_mask(initial(torch.light_outer_range), initial(torch.light_color))

// Fixtures are STATIC_LIGHT, but their light vars stay at the type defaults until update() copies
// brightness, bulb_power and bulb_colour over them through set_light().
/obj/machinery/light/demir_prepare_light_state()
	light_on = on
	if(!on)
		return
	light_power = bulb_power
	light_color = color ? color : bulb_colour
	light_outer_range = brightness
	if(light_outer_range > 0 && light_outer_range < MINIMUM_USEFUL_LIGHT_RANGE)
		light_outer_range = MINIMUM_USEFUL_LIGHT_RANGE
	if(light_inner_range >= light_outer_range)
		light_inner_range = light_outer_range / 4
	light_falloff_curve = LIGHTING_DEFAULT_FALLOFF_CURVE

// `seton(TRUE)` from Initialize()
/obj/machinery/light/fueled/demir_prepare_light_state()
	on = status == LIGHT_OK
	..()

/obj/machinery/light/fueled/torchholder/demir_prepare_light_state()
	..()
	if(!torchy)
		on = FALSE
		light_on = FALSE

// `lights_on()` from Initialize()
/obj/machinery/light/fueledstreet/demir_prepare_light_state()
	on = TRUE
	..()

// Flashlights normally derive light_on from their mapped on/icon state during Initialize().
/obj/item/flashlight/demir_prepare_light_state()
	if(icon_state == "[initial(icon_state)]-on")
		on = TRUE
	light_on = on

/obj/item/flashlight/flare/torch/prelit/demir_prepare_light_state()
	on = TRUE
	light_on = TRUE

/obj/item/flashlight/flare/torch/metal/prelit/demir_prepare_light_state()
	on = TRUE
	light_on = TRUE

/obj/item/clothing/head/helmet/leather/shaman_hood/demir_prepare_light_state()
	light_on = on

// Fluid pipes keep an associative list of connected directions keyed by the
// direction number, and assemble their icon state from those keys in list
// order. Each pipe links its neighbors pairwise from Initialize(), and
// adjacent machines link back from setup_water(). Baking every pipe from its
// own point of view reaches the same result without a load order.
/obj/structure/water_pipe/demir_bake_appearance()
	for(var/key in connected)
		connected[key] = 0

	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_turf = get_step(src, direction)
		if(!cardinal_turf)
			continue

		var/connects = (locate(/obj/structure/water_pipe) in cardinal_turf)
		if(!connects)
			for(var/obj/structure/structure in cardinal_turf)
				if(!structure.accepts_water_input)
					continue
				if(!structure.valid_water_connection(direction, src))
					continue
				connects = TRUE
				break

		if(connects)
			connected["[direction]"] = 1

	if(locate(/obj/structure/water_pipe) in demir_vertical_turf(1))
		connected["[UP]"] = 1
	if(locate(/obj/structure/water_pipe) in demir_vertical_turf(-1))
		connected["[DOWN]"] = 1

	update_appearance(UPDATE_OVERLAYS)

// `GET_TURF_ABOVE()` reads the mapping subsystem's z level links, which the
// editor never builds. Adjacent z levels stack instead, the way the viewer
// draws its underlays.
/obj/structure/water_pipe/proc/demir_vertical_turf(offset)
	var/turf/here = get_turf(src)
	if(!here)
		return null

	return locate(here.x, here.y, here.z + offset)

/datum/demir/vanderlin
	default = TRUE
	var/sun_color

	New()
		..()
		if(!GLOB)
			GLOB = new /datum/controller/global_vars/demir_preview
		sun_color = demir_daylight_color()

/atom/proc/demir_prepare_light_state()
	return

/datum/demir/vanderlin/prepare(atom/target)
	target.demir_prepare_smoothing()
	target.demir_prepare_light_state()

/atom/proc/demir_bake_appearance()
	if(smoothing_flags & USES_SMOOTHING)
		smooth_icon()

/atom/proc/demir_finish_appearance()
	return

/atom/movable/demir_finish_appearance()
	demir_add_overlay_light()

// Water pipes bypass both generic smoothing and overlay lighting.
/obj/structure/water_pipe/demir_finish_appearance()
	return

/datum/demir/vanderlin/bake(atom/target)
	target.demir_bake_appearance()
	target.demir_finish_appearance()


// The day cycle picks one of the daytime tints at random. Noon is what a mapper wants to see, and
// a fixed choice keeps the view from shimmering between bakes.
/proc/demir_daylight_color()
	var/datum/time_of_day/daytime/noon = /datum/time_of_day/daytime
	var/tint = initial(noon.color)
	if(islist(tint))
		var/list/tints = tint
		return length(tints) ? tints[1] : COLOR_WHITE
	return tint || COLOR_WHITE

// `is_sky_visible()` walks the z stack through the mapping subsystem's level links and a
// transparency trait, neither of which the editor builds. Adjacent z levels stack instead, the way
// the water pipes above already assume.
/turf/proc/demir_sees_sky()
	if(pseudo_roof)
		return FALSE
	var/turf/above = locate(x, y, z + 1)
	if(above)
		return above.demir_sky_passes()
	var/area/here = get_area(src)
	return here && here.outdoors

/turf/proc/demir_sky_passes()
	return FALSE

/turf/open/openspace/demir_sky_passes()
	for(var/obj/structure/thing in src)
		if(thing.weatherproof)
			return FALSE
	return demir_sees_sky()

/atom/proc/demir_apply_light()
	if(light_system != STATIC_LIGHT || !light_on || !light_outer_range || !light_power)
		return
	demir_light_range = max(light_outer_range, MINIMUM_USEFUL_LIGHT_RANGE)
	demir_light_inner_range = light_inner_range
	demir_light_curve = light_falloff_curve
	// APPLY_CORNER squares the power and puts the sign back afterwards.
	demir_light_power = (light_power ** 2) * (light_power < 0 ? -1 : 1)
	demir_light_color = light_color
	// LUM_FALLOFF measures flat distance, with no pseudo z term under the root.
	demir_light_height = 0

// Sunlight spreads GLOBAL_LIGHT_RANGE tiles from every turf that can see the sky, and HARD_SUN is
// the -0.5 under the root. Corners keep the closest source rather than the sum, so this is a peak
// source. A lit turf reaches its own corners at full strength, which is what makes the outdoors
// read as daylight without an explicit border pass.
/turf/demir_apply_light()
	if(!demir_sees_sky())
		return ..()
	demir_light_range = 3
	demir_light_power = 1
	demir_light_height = -0.5
	var/datum/demir/vanderlin/profile = demir_profile()
	demir_light_color = profile.sun_color
	demir_light_peak = 1

/area/demir_apply_light()
	demir_fullbright = !dynamic_lighting

/datum/demir/vanderlin/light(atom/target)
	target.demir_apply_light()

#endif
