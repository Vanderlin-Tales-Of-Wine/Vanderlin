#define UPDATE_BUFFER_TIME (2.5 SECONDS)

/**
 * A 16x16 grid of the map with a list of turfs that can be seen, are visible and are dimmed. \
 * Allows Camera Eyes to stream these chunks and know what it can and cannot see.
 */

/datum/camerachunk
	///turfs our cameras cant see but are inside our grid. associative list of the form: list(obscured turf = static image on that turf)
	var/list/obscuredTurfs = list()
	///turfs our cameras can see inside our grid
	var/list/visibleTurfs = list()
	///cameras that can see into our grid
	///indexed by the z level of the camera
	var/list/cameras = list()
	///list of all turfs, associative with that turf's static image
	///turf -> /image
	var/list/turfs = list()
	///Camera mobs that can see turfs in our grid
	var/list/seenby = list()
	///images currently in use on obscured turfs.
	var/list/active_static_images = list()

	var/changed = FALSE
	var/x = 0
	var/y = 0
	var/lower_z
	var/upper_z

/// Add a camera eye to the chunk, then update if changed.
/datum/camerachunk/proc/add(mob/camera/eye)
	eye.visibleCameraChunks += src
	seenby += eye
	if(changed)
		update()

	var/client/client = eye.GetViewerClient()
	if(client && eye.use_visibility)
		client.images += active_static_images

/// Remove a camera eye from the chunk
/datum/camerachunk/proc/remove(mob/camera/eye)
	eye.visibleCameraChunks -= src
	seenby -= eye

	var/client/client = eye.GetViewerClient()
	if(client && eye.use_visibility && seenby.len == 0)
		client.images -= active_static_images

/// Called when a chunk has changed. I.E: A wall was deleted.
/datum/camerachunk/proc/visibilityChanged(turf/loc)
	if(!visibleTurfs[loc])
		return
	hasChanged()

/**
 * Updates the chunk, makes sure that it doesn't update too much. If the chunk isn't being watched it will
 * instead be flagged to update the next time an AI Eye moves near it.
 *
 * update_delay_buffer is used for cameras that are moving around, which are cyborg inbuilt cameras and
 * mecha onboard cameras. This buffer should be usually lower than UPDATE_BUFFER_TIME because
 * otherwise a moving camera can run out of its own view before updating static.
 */
/datum/camerachunk/proc/hasChanged(update_now = 0, update_delay_buffer = UPDATE_BUFFER_TIME)
	if(seenby.len || update_now)
		addtimer(CALLBACK(src, PROC_REF(update)), update_delay_buffer, TIMER_UNIQUE)
	else
		changed = TRUE

// The actual updating. It gathers the visible turfs from cameras and puts them into the appropiate lists.

/datum/camerachunk/proc/update()
	var/list/newVisibleTurfs = list()

	for(var/camera in cameras)
		var/obj/machinery/camera/c = camera

		if(!c)
			continue

		if(!c.can_use())
			continue

		var/turf/point = locate(src.x + (CHUNK_SIZE / 2), src.y + (CHUNK_SIZE / 2), src.z)
		if(get_dist(point, c) > CHUNK_SIZE + (CHUNK_SIZE / 2))
			continue

		for(var/turf/t in c.can_see())
			// Possible optimization: if(turfs[t]) here, rather than &= turfs afterwards.
			// List associations use a tree or hashmap of some sort (alongside the list itself)
			//  so are surprisingly fast. (significantly faster than var/thingy/x in list, in testing)
			newVisibleTurfs[t] = t

	// Removes turf that isn't in turfs.
	newVisibleTurfs &= turfs

	var/list/visAdded = newVisibleTurfs - visibleTurfs
	var/list/visRemoved = visibleTurfs - newVisibleTurfs

	visibleTurfs = newVisibleTurfs
	obscuredTurfs = turfs - newVisibleTurfs

	for(var/turf in visAdded)
		var/turf/t = turf
		t.vis_contents -= GLOB.cameranet.vis_contents_objects

	for(var/turf in visRemoved)
		var/turf/t = turf
		if(obscuredTurfs[t] && !istype(t, /turf/open/ai_visible))
			t.vis_contents += GLOB.cameranet.vis_contents_objects

	changed = 0

// Create a new camera chunk, since the chunks are made as they are needed.

/datum/camerachunk/New(x, y, z)
	x &= ~(CHUNK_SIZE - 1)
	y &= ~(CHUNK_SIZE - 1)

	src.x = x
	src.y = y
	src.z = z

	for(var/obj/machinery/camera/c in urange(CHUNK_SIZE, locate(x + (CHUNK_SIZE / 2), y + (CHUNK_SIZE / 2), z)))
		if(c.can_use())
			cameras += c

	for(var/turf/t in block(locate(max(x, 1), max(y, 1), z), locate(min(x + CHUNK_SIZE - 1, world.maxx), min(y + CHUNK_SIZE - 1, world.maxy), z)))
		turfs[t] = t

	for(var/camera in cameras)
		var/obj/machinery/camera/c = camera
		if(!c)
			continue

		if(!c.can_use())
			continue

		for(var/turf/t in c.can_see())
			// Possible optimization: if(turfs[t]) here, rather than &= turfs afterwards.
			// List associations use a tree or hashmap of some sort (alongside the list itself)
			//  so are surprisingly fast. (significantly faster than var/thingy/x in list, in testing)
			visibleTurfs[t] = t

	// Removes turf that isn't in turfs.
	visibleTurfs &= turfs

	obscuredTurfs = turfs - visibleTurfs

	for(var/turf in obscuredTurfs)
		var/turf/t = turf
		t.vis_contents += GLOB.cameranet.vis_contents_objects

#undef UPDATE_BUFFER
#undef CHUNK_SIZE
