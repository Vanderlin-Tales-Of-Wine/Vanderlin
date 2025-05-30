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
	var/use_static = USE_STATIC_NONE // currently none but later will be different
	var/use_visibility = FALSE
	var/list/visibleCameraChunks = list()

/mob/camera/proc/GetViewerClient()
	if(client)
		return client
	return null

/mob/camera/ancestral_spirit/proc/update_visibility()
	if(use_static != USE_STATIC_NONE)
		GLOB.cameranet.visibility(src, client, use_static = use_static)

/mob/camera/forceMove(atom/destination)
	var/oldloc = loc
	loc = destination
	Moved(oldloc, NONE, TRUE)

/mob/camera/canUseStorage()
	return FALSE

/mob/camera/emote(act, m_type = null, message = null, intentional = FALSE, forced = FALSE, targetted = FALSE, custom_me = FALSE)
	return
