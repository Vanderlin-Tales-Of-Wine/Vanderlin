/atom/movable/screen/plane_master
	screen_loc = "CENTER"
	icon_state = "blank"
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_OVERLAY
	var/show_alpha = 255
	var/hide_alpha = 0

/atom/movable/screen/plane_master/proc/Show(override)
	alpha = override || show_alpha

/atom/movable/screen/plane_master/proc/Hide(override)
	alpha = override || hide_alpha

//Why do plane masters need a backdrop sometimes? Read https://secure.byond.com/forum/?post=2141928
//Trust me, you need one. Period. If you don't think you do, you're doing something extremely wrong.
/atom/movable/screen/plane_master/proc/backdrop(mob/mymob)

/atom/movable/screen/plane_master/openspace
	name = "open space plane master"
	plane = OPENSPACE_BACKDROP_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_MULTIPLY
	alpha = 255

/atom/movable/screen/plane_master/openspace/backdrop(mob/mymob)
	filters = list()
//	filters += GAUSSIAN_BLUR(3)
//	filters += filter(type = "drop_shadow", color = "#04080FAA", size = -10)
//	filters += filter(type = "drop_shadow", color = "#04080FAA", size = -15)
//	filters += filter(type = "drop_shadow", color = "#04080FAA", size = -20)

/atom/movable/screen/plane_master/osreal
	name = "open space plane master real"
	plane = OPENSPACE_PLANE
	appearance_flags = PLANE_MASTER

/atom/movable/screen/plane_master/osreal/backdrop(mob/mymob)
	filters = list()
	filters += GAUSSIAN_BLUR(1)

/atom/movable/screen/plane_master/proc/outline(_size, _color)
	filters += filter(type = "outline", size = _size, color = _color)

/atom/movable/screen/plane_master/proc/shadow(_size, _border, _offset = 0, _x = 0, _y = 0, _color = "#04080FAA")
	filters += filter(type = "drop_shadow", x = _x, y = _y, color = _color, size = _size, offset = _offset)

/atom/movable/screen/plane_master/proc/clear_filters()
	filters = list()

/atom/movable/screen/plane_master/floor
	name = "floor plane master"
//	screen_loc = "CENTER-2"
	plane = FLOOR_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/floor/backdrop(mob/mymob)
	filters = list()
	if(istype(mymob) && mymob.eye_blurry)
		filters += GAUSSIAN_BLUR(CLAMP(mymob.eye_blurry*0.1,0.6,3))

/atom/movable/screen/plane_master/game_world
	name = "game world plane master"
//	screen_loc = "CENTER-2"
	plane = GAME_PLANE
	appearance_flags = PLANE_MASTER //should use client color
	blend_mode = BLEND_OVERLAY
	//render_target = GAME_PLANE_RENDER_TARGET

/atom/movable/screen/plane_master/game_world/backdrop(mob/mymob)
	filters = list()
	if(istype(mymob) && mymob.client && mymob.client.prefs && mymob.client.prefs.ambientocclusion)
		filters += AMBIENT_OCCLUSION
//		filters += filter(type="bloom", size = 4, offset = 0, threshold = "#282828")
	if(istype(mymob) && mymob.eye_blurry)
		filters += GAUSSIAN_BLUR(CLAMP(mymob.eye_blurry*0.1,0.6,3))
	if(istype(mymob))
		if(isliving(mymob))
			var/mob/living/L = mymob
			if(L.has_status_effect(/datum/status_effect/buff/druqks))
				filters += filter(type="ripple",x=80,size=50,radius=0,falloff = 1)
				var/F1 = filters[filters.len]
//				animate(F1, size=50, radius=480, time=4, loop=-1, flags=ANIMATION_PARALLEL)
				filters += filter(type="color", color = list(0,0,1,0, 0,1,0,0, 1,0,0,0, 0,0,0,1, 0,0,0,0))
				F1 = filters[filters.len-1]
				animate(F1, size=50, radius=480, time=10, loop=-1, flags=ANIMATION_PARALLEL)
//			if(L.has_status_effect(/datum/status_effect/buff/weed))
//				filters += filter(type="bloom",threshold=rgb(255, 128, 255),size=5,offset=5)
/*
/atom/movable/screen/plane_master/byondlight
	name = "byond lighting master"
//	screen_loc = "CENTER-2"
	plane = BYOND_LIGHTING_PLANE
	appearance_flags = PLANE_MASTER

/atom/movable/screen/plane_master/byondlight/proc/shadowblack()
	filters = list()
	filters += filter(type = "drop_shadow", x = 2, y = 2, color = "#04080FAA", size = 5, offset = 5)
*/

/atom/movable/screen/plane_master/lighting
	name = "lighting plane master"
	plane = LIGHTING_PLANE
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/lighting/Initialize()
	. = ..()
	filters += filter(type="alpha", render_source = EMISSIVE_RENDER_TARGET, flags = MASK_INVERSE)
	filters += filter(type="alpha", render_source = EMISSIVE_UNBLOCKABLE_RENDER_TARGET, flags = MASK_INVERSE)
	filters += filter(type="alpha", render_source = O_LIGHTING_VISUAL_RENDER_TARGET, flags = MASK_INVERSE)

/atom/movable/screen/plane_master/parallax
	name = "parallax plane master"
//	screen_loc = "CENTER-2"
	plane = PLANE_SPACE_PARALLAX
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/plane_master/parallax_white
	name = "parallax whitifier plane master"
//	screen_loc = "CENTER-2"
	plane = PLANE_SPACE

/atom/movable/screen/plane_master/lighting/backdrop(mob/mymob)
	mymob.overlay_fullscreen("lighting_backdrop_lit", /atom/movable/screen/fullscreen/lighting_backdrop/lit)
	mymob.overlay_fullscreen("lighting_backdrop_unlit", /atom/movable/screen/fullscreen/lighting_backdrop/unlit)
	mymob.overlay_fullscreen("sunlight_backdrop",  /atom/movable/screen/fullscreen/lighting_backdrop/sunlight)

/atom/movable/screen/plane_master/camera_static
	name = "camera static plane master"
	plane = CAMERA_STATIC_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/indoor_mask
	plane = INDOOR_PLANE
	mouse_opacity = 0
	render_target = "*rainzone"
	appearance_flags = PLANE_MASTER

/atom/movable/screen/plane_master/weather
	plane = WEATHER_PLANE
	mouse_opacity = 0
	appearance_flags = PLANE_MASTER

/atom/movable/screen/plane_master/game_world_fov_hidden
	name = "game world fov hidden plane master"
	plane = GAME_PLANE_FOV_HIDDEN
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/game_world_fov_hidden/backdrop(mob/mymob)
	filters = list()
	if(istype(mymob) && mymob.client && mymob.client.prefs && mymob.client.prefs.ambientocclusion)
		filters += AMBIENT_OCCLUSION
	if(istype(mymob) && mymob.eye_blurry)
		filters += GAUSSIAN_BLUR(CLAMP(mymob.eye_blurry*0.1,0.6,3))
	if(istype(mymob))
		if(isliving(mymob))
			var/mob/living/L = mymob
			if(L.has_status_effect(/datum/status_effect/buff/druqks))
				filters += filter(type="ripple",x=80,size=50,radius=0,falloff = 1)
				var/F1 = filters[filters.len]
				filters += filter(type="color", color = list(0,0,1,0, 0,1,0,0, 1,0,0,0, 0,0,0,1, 0,0,0,0))
				F1 = filters[filters.len-1]
				animate(F1, size=50, radius=480, time=10, loop=-1, flags=ANIMATION_PARALLEL)
	filters += filter(type = "alpha", render_source = FIELD_OF_VISION_BLOCKER_RENDER_TARGET, flags = MASK_INVERSE)

/atom/movable/screen/plane_master/game_world_above
	name = "above game world plane master"
	plane = GAME_PLANE_UPPER
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/atom/movable/screen/plane_master/game_world_above/backdrop(mob/mymob)
	filters = list()
	if(istype(mymob) && mymob.client && mymob.client.prefs && mymob.client.prefs.ambientocclusion)
		filters += AMBIENT_OCCLUSION
	if(istype(mymob) && mymob.eye_blurry)
		filters += GAUSSIAN_BLUR(CLAMP(mymob.eye_blurry*0.1,0.6,3))
	if(istype(mymob))
		if(isliving(mymob))
			var/mob/living/L = mymob
			if(L.has_status_effect(/datum/status_effect/buff/druqks))
				filters += filter(type="ripple",x=80,size=50,radius=0,falloff = 1)
				var/F1 = filters[filters.len]
				filters += filter(type="color", color = list(0,0,1,0, 0,1,0,0, 1,0,0,0, 0,0,0,1, 0,0,0,0))
				F1 = filters[filters.len-1]
				animate(F1, size=50, radius=480, time=10, loop=-1, flags=ANIMATION_PARALLEL)

/atom/movable/screen/plane_master/field_of_vision_blocker
	name = "field of vision blocker plane master"
	plane = FIELD_OF_VISION_BLOCKER_PLANE
	render_target = FIELD_OF_VISION_BLOCKER_RENDER_TARGET
	mouse_opacity = 0
	appearance_flags = PLANE_MASTER

/atom/movable/screen/plane_master/o_light_visual
	name = "overlight light visual plane master"
	layer = O_LIGHTING_VISUAL_LAYER
	plane = O_LIGHTING_VISUAL_PLANE
	render_target = O_LIGHTING_VISUAL_RENDER_TARGET
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_MULTIPLY


//Contains all weather overlays
/atom/movable/screen/plane_master/weather_overlay
	name = "weather overlay master"
	plane = WEATHER_OVERLAY_PLANE
	layer = WEATHER_OVERLAY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = WEATHER_RENDER_TARGET
	blend_mode = BLEND_MULTIPLY
	//render_relay_plane = null //Used as alpha filter for weather_effect fullscreen

//Contains the weather effect itself
/atom/movable/screen/plane_master/weather_effect
	name = "weather effect plane master"
	plane = WEATHER_EFFECT_PLANE
	blend_mode = BLEND_OVERLAY
	screen_loc = "CENTER-2:-16, CENTER"
	//render_relay_plane = RENDER_PLANE_GAME

/atom/movable/screen/plane_master/weather_effect/Initialize()
	. = ..()
	//filters += filter(type="alpha", render_source=WEATHER_RENDER_TARGET)
	SSoutdoor_effects.weather_planes_need_vis |= src

/atom/movable/screen/plane_master/weather_effect/Destroy()
	. = ..()
	SSoutdoor_effects.weather_planes_need_vis -= src
/* Our sunlight planemaster mashes all of our sunlight overlays together into one             */
/* The fullscreen then grabs the plane_master with a layer filter, and colours it             */
/* We do this so the sunlight fullscreen acts as a big lighting object, in our lighting plane */
/atom/movable/screen/fullscreen/lighting_backdrop/sunlight
	icon_state  = ""
	screen_loc = "CENTER-2:-16, CENTER"
	transform = null
	plane = LIGHTING_PLANE
	blend_mode = BLEND_ADD
	show_when_dead = TRUE

/atom/movable/screen/fullscreen/lighting_backdrop/sunlight/Initialize()
	. = ..()
	filters += filter(type="layer", render_source=SUNLIGHTING_RENDER_TARGET)
	SSoutdoor_effects.sunlighting_planes |= src
	color = SSoutdoor_effects.last_color
	SSoutdoor_effects.transition_sunlight_color(src)

/atom/movable/screen/fullscreen/lighting_backdrop/sunlight/Destroy()
	. = ..()
	SSoutdoor_effects.sunlighting_planes -= src

//Contains all sunlight overlays
/atom/movable/screen/plane_master/sunlight
	name = "sunlight plane master"
	plane = SUNLIGHTING_PLANE
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_target = SUNLIGHTING_RENDER_TARGET
