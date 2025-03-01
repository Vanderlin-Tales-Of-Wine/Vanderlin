/proc/getviewsize(view)
	var/viewX
	var/viewY
	if(isnum(view))
		var/totalviewrange = 1 + 2 * view
		viewX = totalviewrange
		viewY = totalviewrange
	else
		var/list/viewrangelist = splittext(view,"x")
		viewX = text2num(viewrangelist[1])
		viewY = text2num(viewrangelist[2])
	return list(viewX, viewY)

/proc/in_view_range(mob/user, atom/A)
	var/list/view_range = getviewsize(user.client.view)
	var/turf/source = get_turf(user)
	var/turf/target = get_turf(A)
	return ISINRANGE(target.x, source.x - view_range[1], source.x + view_range[1]) && ISINRANGE(target.y, source.y - view_range[1], source.y + view_range[1])

/// Takes a string or num view, and converts it to pixel width/height in a list(pixel_width, pixel_height)
/proc/view_to_pixels(view)
	if(!view)
		return list(0, 0)
	var/list/view_info = getviewsize(view)
	view_info[1] *= world.icon_size
	view_info[2] *= world.icon_size
	return view_info

/// Takes a screen_loc string and cut out any directions like NORTH or SOUTH
/proc/cut_relative_direction(fragment)
	var/static/regex/regex = regex(@"([A-Z])\w+", "g")
	return regex.Replace(fragment, "")

/// Takes a screen loc string in the format
/// "+-left-offset:+-pixel,+-bottom-offset:+-pixel"
/// Where the :pixel is optional, and returns
/// A list in the format (x_offset, y_offset)
/// We require context to get info out of screen locs that contain relative info, so NORTH, SOUTH, etc
/proc/screen_loc_to_offset(screen_loc, view)
	if(!screen_loc)
		return list(64, 64)
	var/list/view_size = view_to_pixels(view)
	var/x = 0
	var/y = 0
	// Time to parse for directional relative offsets
	if(findtext(screen_loc, "EAST")) // If you're starting from the east, we start from the east too
		x += view_size[1]
	if(findtext(screen_loc, "WEST")) // HHHHHHHHHHHHHHHHHHHHHH WEST is technically a 1 tile offset from the start. Shoot me please
		x += world.icon_size
	if(findtext(screen_loc, "NORTH"))
		y += view_size[2]
	if(findtext(screen_loc, "SOUTH"))
		y += world.icon_size

	var/list/x_and_y = splittext(screen_loc, ",")

	var/list/x_pack = splittext(x_and_y[1], ":")
	var/list/y_pack = splittext(x_and_y[2], ":")

	var/x_coord = x_pack[1]
	var/y_coord = y_pack[1]

	if (findtext(x_coord, "CENTER"))
		x += view_size[1] / 2

	if (findtext(y_coord, "CENTER"))
		y += view_size[2] / 2

	x_coord = text2num(cut_relative_direction(x_coord))
	y_coord = text2num(cut_relative_direction(y_coord))

	x += x_coord * world.icon_size
	y += y_coord * world.icon_size

	if(length(x_pack) > 1)
		x += text2num(x_pack[2])
	if(length(y_pack) > 1)
		y += text2num(y_pack[2])
	return list(x, y)
