/obj/item/canvas
	name = "canvas"
	desc = "A perfect place to paint"

	icon = 'icons/paint_supplies/canvas_32.dmi'
	icon_state = "canvas"

	var/easel_offset = 9
	var/canvas_size_x = 32
	var/canvas_size_y = 32

	var/atom/movable/screen/canvas/used_canvas
	var/list/showers = list()

	var/icon/draw
	var/icon/base

	var/title
	var/author
	var/author_ckey
	var/canvas_size = "32x32"
	var/reject = FALSE

	var/canvas_icon = 'icons/paint_supplies/canvas/canvas_32x32.dmi'
	var/canvas_icon_state = "canvas"
	var/canvas_screen_loc = "6,6"
	var/canvas_divider_x = 5
	var/canvas_divider_y = 5
	var/pixel_size_x = 4
	var/pixel_size_y = 4

	var/list/overlay_to_index = list()
	var/current_overlays = 0

	var/loads_painting = FALSE

/obj/item/canvas/Initialize()
	. = ..()
	used_canvas = new
	used_canvas.host = src
	used_canvas.base_icon = icon(icon, icon_state)
	used_canvas.icon = canvas_icon
	used_canvas.screen_loc = canvas_screen_loc
	used_canvas.icon_state = canvas_icon_state
	draw = icon(icon, icon_state)
	base = icon(icon, icon_state)
	underlays += base
	icon = draw
	RegisterSignal(src, COMSIG_MOVABLE_TURF_ENTERED, PROC_REF(remove_showers))

/obj/item/canvas/Destroy()
	. = ..()
	for(var/mob/mob in showers)
		remove_shower(mob)

/obj/item/canvas/attack_hand(mob/user)
	. = ..()
	if(user.cmode)
		if(anchored)
			to_chat(user, "I start unmounting [src]...")
			if(!do_after(user, 3 SECONDS, src))
				return
			anchored = FALSE
			to_chat(user, "I unmount [src].")

/obj/item/canvas/attack_right(mob/user)
	. = ..()
	if(user.get_active_held_item())
		return
	if(user in showers)
		return
	user?.client.screen += used_canvas
	showers |= user
	RegisterSignal(user, COMSIG_MOVABLE_TURF_ENTERED, PROC_REF(remove_shower))

/obj/item/canvas/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/natural/feather))
		author = input("Who's the author of this painting?")
		author_ckey = user.ckey
		title = input("What's the title of this painting.")
		if(title)
			name = title
		if(author)
			desc = "Painted by: [author]."

		return

	if(!istype(I, /obj/item/paint_brush))
		return
	if(user in showers)
		return
	user?.client.screen += used_canvas
	showers |= user
	RegisterSignal(user, COMSIG_MOVABLE_TURF_ENTERED, PROC_REF(remove_shower))

/obj/item/canvas/proc/remove_showers()
	for(var/mob/mob in showers)
		remove_shower(mob)

/obj/item/canvas/attack_turf(turf/T, mob/living/user)
	. = ..()
	to_chat(user, "I start mounting [src] to [T]...")
	if(!do_after(user, 3 SECONDS, T))
		return
	user.dropItemToGround(src)
	forceMove(T)
	pixel_x = 0
	pixel_y = 0
	anchored = TRUE
	to_chat(user, "I mount [src] to [T].")

/obj/item/canvas/proc/remove_shower(mob/source)
	showers -= source
	source.client?.screen -= used_canvas
	UnregisterSignal(source, COMSIG_MOVABLE_TURF_ENTERED)

/obj/item/canvas/proc/update_drawing(x, y, current_color)
	if("[x][y]" in overlay_to_index)
		cut_overlay(overlay_to_index["[x][y]"])
		overlay_to_index -= "[x][y]"
	var/mutable_appearance/MA = mutable_appearance('icons/paint_supplies/pixel.dmi', "pixel")
	MA.color = current_color
	MA.pixel_x = x
	MA.pixel_y = y
	add_overlay(MA)
	overlay_to_index |= "[x][y]"
	overlay_to_index["[x][y]"] = MA
	current_overlays++
	if(current_overlays > 150)
		icon = usr.client.RenderIcon(src)
		current_overlays = 0
		cut_overlays()
		overlay_to_index = list()

/obj/item/canvas/proc/upload_painting()
	if(!author || !title)
		return
	var/icon/rendered = usr.client.RenderIcon(src)
	cut_overlays()
	if(rendered)
		icon = rendered
		SSpaintings.playerpainting2file(icon, title, author, author_ckey, canvas_size, src)
		SSpaintings.update_paintings()

/atom/movable/screen/canvas
	icon = 'icons/paint_supplies/canvas/canvas_32x32.dmi'
	icon_state = "canvas"
	screen_loc = "6,6"

	var/obj/item/canvas/host
	var/list/modified_areas = list()
	var/icon/base_icon
	var/icon/draw
	var/icon/base

	var/list/overlay_to_index = list()
	var/current_overlays = 0


/atom/movable/screen/canvas/Initialize(mapload, ...)
	. = ..()
	draw = icon(icon, icon_state)
	base = icon(icon, icon_state)
	icon = draw
	underlays += base

/atom/movable/screen/canvas/Click(location, control, params)
	. = ..()
	if(host.item_flags & IN_STORAGE)
		return
	var/obj/item/paint_brush/brush = usr.get_active_held_item()
	if(!istype(brush))
		return
	var/current_color = brush.current_color
	if(!current_color)
		return
	var/list/param_list = params2list(params)

	var/x = text2num(param_list["icon-x"])
	var/y = text2num(param_list["icon-y"])

	y = min(FLOOR(y / host.canvas_divider_y, 1), host.canvas_size_y-1)
	x = min(FLOOR(x / host.canvas_divider_x, 1), host.canvas_size_x-1)

	if(param_list["right"])
		var/original_color = base_icon.GetPixel(x, y)
		current_color = original_color
		modified_areas -= "[x][y]"
		if("[x][y]" in overlay_to_index)
			cut_overlay(overlay_to_index["[x][y]"])
	else

		if("[x][y]" in modified_areas)
			var/pre_merge = draw.GetPixel(x+1, y+1)
			if(pre_merge != current_color)
				current_color = BlendRGB(current_color, pre_merge, 0.5)
		modified_areas |= "[x][y]"
		if("[x][y]" in overlay_to_index)
			cut_overlay(overlay_to_index["[x][y]"])

	var/mutable_appearance/MA = mutable_appearance(host.canvas_icon, "pixel")
	MA.color = current_color
	MA.pixel_x = (x) * host.canvas_divider_y
	MA.pixel_y = (y) * host.canvas_divider_x
	MA.layer = layer +1
	MA.plane = plane
	add_overlay(MA)
	current_overlays++
	overlay_to_index |= "[x][y]"
	overlay_to_index["[x][y]"] = MA
	if(current_overlays > 150)
		icon = usr.client.RenderIcon(src)
		current_overlays = 0
		cut_overlays()
		overlay_to_index = list()

	host.update_drawing(x, y, current_color)

/obj/item/canvas/random_painting
	loads_painting = TRUE

/obj/item/canvas/random_painting/Initialize()
	. = ..()
	icon = SSpaintings.get_random_painting("32x32")
	var/icon/new_icon = getFlatIcon(src)
	new_icon.Scale(160, 160)
	used_canvas.draw.Blend(new_icon, ICON_OVERLAY)
	used_canvas.icon = used_canvas.draw
