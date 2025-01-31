/**
 * # area
 *
 * A grouping of tiles into a logical space, mostly used by map editors
 */
/area
	level = null
	name = "unknown"
	icon = 'icons/turf/areas.dmi'
	icon_state = "unknown"
	layer = AREA_LAYER
	//Keeping this on the default plane, GAME_PLANE, will make area overlays fail to render on FLOOR_PLANE.
	plane = BLACKNESS_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	invisibility = INVISIBILITY_LIGHTING

	var/map_name // Set in New(); preserves the name set by the map maker, even if renamed by the Blueprints.

	var/valid_territory = TRUE // If it's a valid territory for cult summoning or the CRAB-17 phone to spawn

	var/totalbeauty = 0 //All beauty in this area combined, only includes indoor area.
	var/beauty = 0 // Beauty average per open turf in the area
	var/beauty_threshold = 150 //If a room is too big it doesn't have beauty.

	var/outdoors = FALSE //For space, the asteroid, lavaland, etc. Used with blueprints to determine if we are adding a new area (vs editing a station room)

	var/areasize = 0 //Size of the area in open turfs, only calculated for indoors areas.

	/// Bonus mood for being in this area
	var/mood_bonus = 0
	/// Mood message for being here, only shows up if mood_bonus != 0
	var/mood_message = "<span class='nicegreen'>This area is pretty nice!\n</span>"

	var/has_gravity = 0
	///Are you forbidden from teleporting to the area? (centcom, mobs, wizard, hand teleporter)
	var/noteleport = FALSE
	///Hides area from player Teleport function.
	var/hidden = FALSE
	///Is the area teleport-safe: no space / radiation / aggresive mobs / other dangers
	var/safe = FALSE
	/// If false, loading multiple maps with this area type will create multiple instances.
	var/unique = TRUE

//	var/no_air = null

	var/parallax_movedir = 0

	var/list/ambientsounds = GENERIC
	var/list/ambientrain = null
	var/list/ambientnight = null

	var/min_ambience_cooldown = 70 SECONDS
	var/max_ambience_cooldown = 120 SECONDS

	var/droningniqqa = TRUE
	var/loopniqqa = TRUE

	var/droning_sound_current = null
	var/droning_sound_dawn = null
	var/droning_sound = null
	var/droning_sound_dusk = null
	var/droning_sound_night = null
	var/droning_vary = 0
	var/droning_repeat = TRUE
	var/droning_wait = 0
	var/droning_volume = 90 // From 100, part of soundscape polishing THIS VAR DOES NOTHING
	var/droning_channel = CHANNEL_BUZZ
	var/droning_frequency = 0

	var/list/spookysounds = null
	var/list/spookynight = null

	flags_1 = CAN_BE_DIRTY_1 | CULT_PERMITTED_1
	var/soundenv = 0

	var/first_time_text = null
	var/custom_area_sound = null

	/// typecache to limit the areas that atoms in this area can smooth with, used for shuttles IIRC
	var/list/canSmoothWithAreas

	var/list/ambush_types
	var/list/ambush_mobs
	var/list/ambush_times

	var/converted_type


/**
 * A list of teleport locations
 *
 * Adding a wizard area teleport list because motherfucking lag -- Urist
 * I am far too lazy to make it a proper list of areas so I'll just make it run the usual telepot routine at the start of the game
 */
GLOBAL_LIST_EMPTY(teleportlocs)

/**
 * Generate a list of turfs you can teleport to from the areas list
 *
 * Includes areas if they're not a shuttle or not not teleport or have no contents
 *
 * The chosen turf is the first item in the areas contents that is a station level
 *
 * The returned list of turfs is sorted by name
 */
/proc/process_teleport_locs()
	for(var/V in GLOB.sortedAreas)
		var/area/AR = V
		if(AR.noteleport)
			continue
		if(GLOB.teleportlocs[AR.name])
			continue
		if (!AR.contents.len)
			continue
		var/turf/picked = AR.contents[1]
		if (picked && is_station_level(picked.z))
			GLOB.teleportlocs[AR.name] = AR

	sortTim(GLOB.teleportlocs, GLOBAL_PROC_REF(cmp_text_asc))

/**
 * Called when an area loads
 *
 *  Adds the item to the GLOB.areas_by_type list based on area type
 */
/area/New()
	// This interacts with the map loader, so it needs to be set immediately
	// rather than waiting for atoms to initialize.
	if (unique)
		GLOB.areas_by_type[type] = src
	return ..()

/area/proc/can_craft_here()
	return TRUE

/**
 * Initalize this area
 *
 * intializes the dynamic area lighting and also registers the area with the z level via
 * reg_in_areas_in_z
 *
 * returns INITIALIZE_HINT_LATELOAD
 */
/area/Initialize()
	if(!outdoors)
		plane = INDOOR_PLANE
		icon_state = "mask"
	else
		icon_state = ""
	layer = AREA_LAYER
	map_name = name // Save the initial (the name set in the map) name of the area.
	canSmoothWithAreas = typecacheof(canSmoothWithAreas)
	first_time_text = uppertext(first_time_text) // Standardization


	if(dynamic_lighting == DYNAMIC_LIGHTING_FORCED)
		dynamic_lighting = DYNAMIC_LIGHTING_ENABLED
		luminosity = 0
	else if(dynamic_lighting != DYNAMIC_LIGHTING_IFSTARLIGHT)
		dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	if(dynamic_lighting == DYNAMIC_LIGHTING_IFSTARLIGHT)
		dynamic_lighting = CONFIG_GET(flag/starlight) ? DYNAMIC_LIGHTING_ENABLED : DYNAMIC_LIGHTING_DISABLED

	. = ..()

//	blend_mode = BLEND_MULTIPLY // Putting this in the constructor so that it stops the icons being screwed up in the map editor.

	if(!IS_DYNAMIC_LIGHTING(src))
		add_overlay(/obj/effect/fullbright)

	reg_in_areas_in_z()

	return INITIALIZE_HINT_LATELOAD

/**
 * Sets machine power levels in the area
 */
/area/LateInitialize()
	update_beauty()

/**
 * Register this area as belonging to a z level
 *
 * Ensures the item is added to the SSmapping.areas_in_z list for this z
 *
 * It also goes through every item in this areas contents and sets the area level z to it
 * breaking the exat first time it does this, this seems crazy but what would I know, maybe
 * areas don't have a valid z themself or something
 */
/area/proc/reg_in_areas_in_z()
	if(contents.len)
		var/list/areas_in_z = SSmapping.areas_in_z
		var/z
		update_areasize()
		for(var/i in 1 to contents.len)
			var/atom/thing = contents[i]
			if(!thing)
				continue
			z = thing.z
			break
		if(!z)
			WARNING("No z found for [src]")
			return
		if(!areas_in_z["[z]"])
			areas_in_z["[z]"] = list()
		areas_in_z["[z]"] += src

/**
 * Destroy an area and clean it up
 *
 * Removes the area from GLOB.areas_by_type and also stops it processing on SSobj
 *
 * This is despite the fact that no code appears to put it on SSobj, but
 * who am I to argue with old coders
 */
/area/Destroy()
	if(GLOB.areas_by_type[type] == src)
		GLOB.areas_by_type[type] = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/**
 * Update the icon state of the area
 *
 * Im not sure what the heck this does, somethign to do with weather being able to set icon
 * states on areas?? where the heck would that even display?
 */
/area/update_icon_state()
//	var/weather_icon
///	for(var/V in SSweather.curweathers)
//	/	var/datum/weather/W = V
//		if(W.stage != END_STAGE && (src in W.impacted_areas))
//			W.update_areas()
//			weather_icon = TRUE
//	if(!weather_icon)
//		icon_state = null
	return

/**
 * Update the icon of the area (overridden to always be null for space
 */
/area/space/update_icon_state()
	icon_state = null

/**
 * Call back when an atom enters an area
 *
 * Sends signals COMSIG_AREA_ENTERED and COMSIG_ENTER_AREA (to the atom)
 *
 * If the area has ambience, then it plays some ambience music to the ambience channel
 */
/area/Entered(atom/movable/M, atom/OldLoc)
	set waitfor = FALSE
	SEND_SIGNAL(src, COMSIG_AREA_ENTERED, M)
	SEND_SIGNAL(M, COMSIG_ENTER_AREA, src) //The atom that enters the area
	if(!isliving(M))
		return

	var/mob/living/L = M
	if(!L.ckey || L.stat == DEAD)
		return

	// Ambience goes down here -- make sure to list each area separately for ease of adding things in later, thanks! Note: areas adjacent to each other should have the same sounds to prevent cutoff when possible.- LastyScratch
//	if(L.client && !L.client.ambience_playing && L.client.prefs.toggles & SOUND_SHIP_AMBIENCE)
//		L.client.ambience_playing = 1
//		SEND_SOUND(L, sound('sound/blank.ogg', repeat = 1, wait = 0, volume = 35, channel = CHANNEL_BUZZ))

	if(first_time_text)
		L.intro_area(src)

	var/mob/living/living_arrived = M

	if(istype(living_arrived) && living_arrived.client && !living_arrived.cmode)
		//Ambience if combat mode is off
		SSdroning.area_entered(src, living_arrived.client)
		SSdroning.play_loop(src, living_arrived.client)

//	L.play_ambience(src)

/client
	var/musicfading = 0

/mob/living/proc/intro_area(area/A)
	if(!mind)
		return
	if(A.first_time_text in mind.areas_entered)
		return
	if(!client)
		return
	mind.areas_entered += A.first_time_text
	var/atom/movable/screen/area_text/T = new()
	client.screen += T
	T.maptext = {"<span style='vertical-align:top; text-align:center;
				color: #820000; font-size: 300%;
				text-shadow: 1px 1px 2px black, 0 0 1em black, 0 0 0.2em black;
				font-family: "Blackmoor LET", "Pterra";'>[A.first_time_text]</span>"}
	T.maptext_width = 205
	T.maptext_height = 209
	T.maptext_x = 12
	T.maptext_y = 64
	if(A.custom_area_sound)
		playsound_local(src, A.custom_area_sound, 125, FALSE)
	else
		playsound_local(src, 'sound/misc/area.ogg', 100, FALSE)

	animate(T, alpha = 255, time = 10, easing = EASE_IN)
	addtimer(CALLBACK(src, PROC_REF(clear_area_text), T), 35)

/mob/living/proc/clear_area_text(atom/movable/screen/A)
	if(!A)
		return
	if(!client)
		return
	animate(A, alpha = 0, time = 10, easing = EASE_OUT)
	sleep(11)
	if(client)
		if(client.screen && A)
			client.screen -= A
			qdel(A)

/mob/living/proc/clear_time_icon(atom/movable/screen/A)
	if(!A)
		return
	if(!client)
		return
	animate(A, alpha = 0, time = 20, easing = EASE_OUT)
	sleep(21)
	if(client)
		if(client.screen && A)
			client.screen -= A
			qdel(A)

///Divides total beauty in the room by roomsize to allow us to get an average beauty per tile.
/area/proc/update_beauty()
	if(!areasize)
		beauty = 0
		return FALSE
	if(areasize >= beauty_threshold)
		beauty = 0
		return FALSE //Too big
	beauty = totalbeauty / areasize


/**
 * Called when an atom exits an area
 *
 * Sends signals COMSIG_AREA_EXITED and COMSIG_EXIT_AREA (to the atom)
 */
/area/Exited(atom/movable/M)
	SEND_SIGNAL(src, COMSIG_AREA_EXITED, M)
	SEND_SIGNAL(M, COMSIG_EXIT_AREA, src) //The atom that exits the area

/**
 * Reset the played var to false on the client
 */

/**
 * Setup an area (with the given name)
 *
 * Sets the area name, sets all status var's to false and adds the area to the sorted area list
 */
/area/proc/setup(a_name)
	name = a_name
	valid_territory = FALSE
	addSorted()
/**
 * Set the area size of the area
 *
 * This is the number of open turfs in the area contents, or FALSE if the outdoors var is set
 *
 */
/area/proc/update_areasize()
	if(outdoors)
		return FALSE
	areasize = 0
	for(var/turf/open/T in contents)
		areasize++

/**
 * Causes a runtime error
 */
/area/AllowDrop()
	CRASH("Bad op: area/AllowDrop() called")

/**
 * Causes a runtime error
 */
/area/drop_location()
	CRASH("Bad op: area/drop_location() called")

/// A hook so areas can modify the incoming args (of what??)
/area/proc/PlaceOnTopReact(list/new_baseturfs, turf/fake_turf_type, flags)
	return flags

/area/proc/on_joining_game(mob/living/boarder)
	return

/area/proc/reconnect_game(mob/living/boarder)
	return

/area/on_joining_game(mob/living/boarder)
	. = ..()
	if(istype(boarder) && boarder.client)
		SSdroning.area_entered(src, boarder.client)
		boarder.client.update_ambience_pref()
		SSdroning.play_loop(src, boarder.client)

/area/reconnect_game(mob/living/boarder)
	. = ..()
	if(istype(boarder) && boarder.client)
		SSdroning.area_entered(src, boarder.client)
		SSdroning.play_loop(src, boarder.client)
