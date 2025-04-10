#define ACTION_BUTTON_DEFAULT_BACKGROUND "default"

/atom/movable/screen/movable/action_button
	var/datum/action/linked_action
	var/actiontooltipstyle = ""
	screen_loc = null

	var/button_icon_state
	var/appearance_cache
	locked = TRUE
	var/id
	var/ordered = TRUE //If the button gets placed into the default bar
	nomouseover = FALSE

/atom/movable/screen/movable/action_button/proc/can_use(mob/user)
	if (linked_action)
		return linked_action.owner == user
	else if (isobserver(user))
		var/mob/dead/observer/O = user
		return !O.observetarget
	else
		return TRUE

/atom/movable/screen/movable/action_button/MouseDrop(over_object)
	if(!can_use(usr))
		return
	if((istype(over_object, /atom/movable/screen/movable/action_button)))
		if(locked)
//			to_chat(usr, "<span class='warning'>Action button \"[name]\" is locked, unlock it first.</span>")
			return
		var/atom/movable/screen/movable/action_button/B = over_object
		var/list/actions = usr.actions
		actions.Swap(actions.Find(src.linked_action), actions.Find(B.linked_action))
		moved = FALSE
		ordered = TRUE
		B.moved = FALSE
		B.ordered = TRUE
		usr.update_action_buttons()
	else
		return ..()

/atom/movable/screen/movable/action_button/Click(location,control,params)
	if (!can_use(usr))
		return

	if(usr.next_click > world.time)
		return
	usr.next_click = world.time + 1
	if(ismob(usr))
		var/mob/M = usr
		M.playsound_local(M, 'sound/misc/click.ogg', 100)
	linked_action.Trigger()
	return TRUE

/atom/movable/screen/movable/action_button/MouseEntered(location,control,params)
	if(!QDELETED(src))
		openToolTip(usr,src,params,title = name,content = desc,theme = actiontooltipstyle)
	..()

/atom/movable/screen/movable/action_button/MouseExited()
	closeToolTip(usr)
	..()

/datum/hud/proc/get_action_buttons_icons()
	. = list()
	.["bg_icon"] = ui_style
	.["bg_state"] = "template"

//see human and alien hud for specific implementations.

/mob/proc/update_action_buttons_icon(status_only = FALSE)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon(status_only)

//This is the proc used to update all the action buttons.
/mob/proc/update_action_buttons(reload_screen)
	if(!hud_used || !client)
		return

	if(hud_used.hud_shown != HUD_STYLE_STANDARD)
		return

	var/button_number = 0

	if(hud_used.action_buttons_hidden)
		for(var/datum/action/A in actions)
			A.button.screen_loc = null
			if(reload_screen)
				client.screen += A.button
	else
		for(var/datum/action/A in actions)
			A.UpdateButtonIcon()
			var/atom/movable/screen/movable/action_button/B = A.button
			if(B.ordered)
				button_number++
			if(B.moved)
				B.screen_loc = B.moved
			else
				B.screen_loc = hud_used.ButtonNumberToScreenCoords(button_number)
			if(reload_screen)
				client.screen += B



#define AB_MAX_COLUMNS 12

/datum/hud/proc/ButtonNumberToScreenCoords(number) // TODO : Make this zero-indexed for readabilty
	var/row = round((number - 1)/AB_MAX_COLUMNS)
	var/col = ((number - 1)%(AB_MAX_COLUMNS)) + 1

	var/coord_col = "+[col-1]"
	var/coord_col_offset = 4 + 2 * col

	var/coord_row = "[row ? "+[row]" : "+0"]"

	return "WEST[coord_col]:[coord_col_offset],SOUTH[coord_row]:3"

/datum/hud/proc/SetButtonCoords(atom/movable/screen/button,number)
	var/row = round((number-1)/AB_MAX_COLUMNS)
	var/col = ((number - 1)%(AB_MAX_COLUMNS)) + 1
	var/x_offset = 32*(col-1) + 4 + 2*col
	var/y_offset = 32*(row+1) + 26

	var/matrix/M = matrix()
	M.Translate(x_offset,y_offset)
	button.transform = M
