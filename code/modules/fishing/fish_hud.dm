/atom/movable/fishingoverlay //all of the code is handled in the fishing rod item, this is just for the ui elements
	name = null
	icon = 'icons/roguetown/hud/fishingmeme.dmi'
	screen_loc = "CENTER:-16,CENTER:-16"
	appearance_flags = PIXEL_SCALE
	plane = HUD_PLANE
	nomouseover = TRUE

/atom/movable/fishingoverlay/base
	icon_state = "fishingbase"
	var/pointdir = 180
	var/client/owner = null

/atom/movable/fishingoverlay/base/MouseMove(location,control,params)
	var/list/new_params = params2list(params)
	new_params["icon-x"] = text2num(new_params["icon-x"])
	new_params["icon-y"] = text2num(new_params["icon-y"])
	var/icon_x = new_params["icon-x"] - 32
	var/icon_y = new_params["icon-y"] - 32
	pointdir = SIMPLIFY_DEGREES(ATAN2(icon_y, icon_x))

/atom/movable/fishingoverlay/pointer1
	icon_state = "reelstate"

/atom/movable/fishingoverlay/pointer2
	icon_state = "fishstate"

/atom/movable/fishingoverlay/face
	icon = 'icons/mob/roguehud.dmi'
	icon_state = "stress1"
	screen_loc = "CENTER,CENTER:-64"

/atom/movable/fishingoverlay/face/frame
	icon = 'icons/roguetown/items/fishing.dmi'
	icon_state = "faceframe"
