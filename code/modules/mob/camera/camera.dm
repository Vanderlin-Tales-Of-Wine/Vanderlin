// Camera mob, used by AI camera and blob.

/mob/camera
	name = "camera mob"
	density = FALSE
	move_force = INFINITY
	move_resist = INFINITY
	status_flags = GODMODE  // You can't damage it.
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	see_in_dark = 7
	invisibility = INVISIBILITY_ABSTRACT // No one can see us
	sight = SEE_SELF
	var/static_visibility_range = 16
	var/list/visibleCameraChunks = list()
	var/use_static = USE_STATIC_OPAQUE
	var/use_visibility = FALSE

/mob/camera/proc/GetViewerClient()
	if(client)
		return client
	return null

/mob/camera/forceMove(atom/destination)
	var/oldloc = loc
	loc = destination
	Moved(oldloc, NONE, TRUE)

/mob/camera/canUseStorage()
	return FALSE

/mob/camera/emote(act, m_type = null, message = null, intentional = FALSE, forced = FALSE, targetted = FALSE, custom_me = FALSE)
	return
