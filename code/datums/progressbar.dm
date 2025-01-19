#define PROGRESSBAR_HEIGHT 6
#define PROGRESSBAR_ANIMATION_TIME 5

/datum/progressbar
	var/goal = 1
	var/last_progress = 0
	var/obj/effect/world_progressbar/bar
	var/shown = 0
	var/mob/user
	var/listindex
	var/image/self_bar_image

/datum/progressbar/New(mob/User, goal_number, atom/target)
	. = ..()
	if (!istype(target))
		EXCEPTION("Invalid target given")
	if (goal_number)
		goal = goal_number
	bar = new /obj/effect/world_progressbar(get_turf(User))
	user = User

	user.vis_contents |= bar
	bar.user = user

	self_bar_image = image('icons/effects/progessbar.dmi', null, "prog_bar_0", HUD_LAYER)
	self_bar_image.plane = ABOVE_HUD_PLANE
	self_bar_image.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

	user.client.images += self_bar_image
	LAZYINITLIST(user.progressbars)
	LAZYINITLIST(user.progressbars[bar.loc])
	var/list/bars = user.progressbars[bar.loc]
	bars.Add(src)
	listindex = bars.len
	bar.pixel_y = 0
	bar.alpha = 0
	animate(bar, pixel_y = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1)), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

	self_bar_image.pixel_y = 0
	self_bar_image.alpha = 0
	animate(self_bar_image, pixel_y = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1)), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/proc/update(progress)
	progress = CLAMP(progress, 0, goal)
	last_progress = progress
	bar.icon_state = "prog_bar_[round(((progress / goal) * 100), 5)]"
	self_bar_image.icon_state = "prog_bar_[round(((progress / goal) * 100), 5)]"
	if (!shown)
		shown = TRUE

/datum/progressbar/proc/shiftDown()
	--listindex
	bar.pixel_y = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1))
	var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1)) - PROGRESSBAR_HEIGHT
	animate(bar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/Destroy()
	if(last_progress != goal)
		bar.icon_state = "[bar.icon_state]_fail"
	for(var/I in user.progressbars[bar.loc])
		var/datum/progressbar/P = I
		if(P != src && P.listindex > listindex)
			P.shiftDown()

	var/list/bars = user.progressbars[bar.loc]
	bars.Remove(src)

	if(!bars.len)
		LAZYREMOVE(user.progressbars, bar.loc)
	animate(bar, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)
	QDEL_IN(bar, PROGRESSBAR_ANIMATION_TIME * 2) //for garbage collection safety
	animate(self_bar_image, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)
	QDEL_IN(self_bar_image, PROGRESSBAR_ANIMATION_TIME * 2) //for garbage collection safety
	user.client.images -= self_bar_image
	. = ..()

#undef PROGRESSBAR_ANIMATION_TIME
#undef PROGRESSBAR_HEIGHT

/obj/effect/world_progressbar
	icon = 'icons/effects/progessbar.dmi'
	icon_state = "prog_bar_0"
	plane = SPLASHSCREEN_PLANE
	layer = HUD_LAYER
	appearance_flags = RESET_ALPHA | RESET_COLOR | RESET_TRANSFORM | KEEP_APART
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	var/mob/user

/obj/effect/world_progressbar/Destroy(force)
	. = ..()
	user?.vis_contents -= src
	user = null
