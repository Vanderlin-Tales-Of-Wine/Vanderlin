/atom/movable/screen/strategy_ui
	icon = 'icons/hud/rts_mob_hud.dmi'

/atom/movable/screen/strategy_ui/controller_ui
	screen_loc = "WEST,SOUTH"
	icon = null

	var/atom/movable/screen/strategy_ui/action/actions
	var/atom/movable/screen/strategy_ui/stat_pane/stat
	var/atom/movable/screen/strategy_ui/units_preview/units
	var/atom/movable/screen/strategy_ui/ability_bar/ability

	var/atom/movable/screen/strategy_ui/controller_button/one/button_one
	var/atom/movable/screen/strategy_ui/controller_button/two/button_two
	var/atom/movable/screen/strategy_ui/controller_button/three/button_three

/atom/movable/screen/strategy_ui/controller_ui/vv_edit_var(var_name, var_value)
	switch (var_name)
		if ("screen_loc")
			update_screen_loc(var_value)
			return TRUE

	return ..()

/atom/movable/screen/strategy_ui/controller_ui/New()
	. = ..()
	create_and_position_buttons()

/atom/movable/screen/strategy_ui/controller_ui/proc/add_ui(client/client)
	if(!client)
		return
	update_all()
	client.screen += actions

/atom/movable/screen/strategy_ui/controller_ui/proc/add_ui_buttons(client/client)
	if(!client)
		return
	update_all()
	client.screen += stat
	client.screen += units
	client.screen += ability
	client.screen += button_one
	client.screen += button_two
	client.screen += button_three

/atom/movable/screen/strategy_ui/controller_ui/proc/remove_ui(client/client)
	if(!client)
		return
	update_all()
	client.screen -= stat
	client.screen -= units
	client.screen -= ability
	client.screen -= button_one
	client.screen -= button_two
	client.screen -= button_three

/atom/movable/screen/strategy_ui/controller_ui/proc/create_and_position_buttons()
	actions = new
	units = new
	ability = new
	stat = new
	button_one = new
	button_two = new
	button_three = new

	update_screen_loc()
	update_all()

/atom/movable/screen/strategy_ui/controller_ui/proc/update_screen_loc(new_loc)
	if(new_loc)
		screen_loc = new_loc

	actions.screen_loc = screen_loc
	units.screen_loc = screen_loc
	ability.screen_loc = screen_loc
	stat.screen_loc = screen_loc
	button_one.screen_loc = screen_loc
	button_two.screen_loc = screen_loc
	button_three.screen_loc = screen_loc

/atom/movable/screen/strategy_ui/controller_ui/proc/update_all()


/atom/movable/screen/strategy_ui/controller_ui/proc/update_text()

/atom/movable/screen/strategy_ui/action
	icon_state = "action"

/atom/movable/screen/strategy_ui/stat_pane
	icon_state = "stats"
	maptext_x = 346
	maptext_y = 62
	maptext_width = 128
	maptext_height = 32

/atom/movable/screen/strategy_ui/units_preview
	icon_state = "units_preview"

/atom/movable/screen/strategy_ui/ability_bar
	icon_state = "ability_bar"

/atom/movable/screen/strategy_ui/controller_button
	icon_state = "button_1"

	var/list/buildings


/atom/movable/screen/strategy_ui/controller_button/one
	icon_state = "button_1"

/atom/movable/screen/strategy_ui/controller_button/two
	icon_state = "button_2"

	buildings = list(
		/datum/building_datum/core,
		/datum/building_datum/farm,
		/datum/building_datum/bar,
		/datum/building_datum/kitchen,
		/datum/building_datum/stockpile,
		/datum/building_datum/lumber_yard,
		/datum/building_datum/blacksmith,
		/datum/building_datum/mines,
		/datum/building_datum/spawning_grounds,

	)

/atom/movable/screen/strategy_ui/controller_button/three
	icon_state = "button_3"

	buildings = list(
		/datum/building_datum/simple/flame,
		/datum/building_datum/simple/poison,
		/datum/building_datum/simple/chill,
		/datum/building_datum/simple/wall_fire,
		/datum/building_datum/simple/wall_arrow,
		/datum/building_datum/simple/saw,
		/datum/building_datum/simple/bomb,
		/datum/building_datum/simple/spike,
	)

/atom/movable/screen/strategy_ui/controller_button/Click(location, control, params)
	. = ..()
	if(length(buildings))
		var/mob/camera/strategy_controller/controller = usr
		controller.building_icon.open_ui(controller, buildings)
