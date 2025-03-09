/// This should match the interface of /client wherever necessary.
/datum/client_interface
	/// Player preferences datum for the client
	var/datum/preferences/prefs

	/// The view of the client, similar to /client/var/view.
	var/view = "15x15"

	/// View data of the client, similar to /client/var/view_size.
	var/datum/view_data/view_size

	/// Objects on the screen of the client
	var/list/screen = list()

	/// The mob the client controls
	var/mob/mob

	/// The ckey for this mock interface
	var/ckey = "mockclient"

	/// The key for this mock interface
	var/key = "mockclient"

	/// client prefs
	var/fps
	var/hotkeys
	var/tgui_say
	var/typing_indicators
	var/datum/interaction_mode/imode
	var/context_menu_requires_shift = FALSE

	///these persist between logins/logouts during the same round.
	var/datum/player_details/player_details
	var/reconnecting = FALSE

/datum/client_interface/proc/IsByondMember()
	return FALSE

/datum/client_interface/New(key)
	..()
	if(key)
		src.key = key
		ckey = ckey(key)
		if(GLOB.player_details[ckey])
			reconnecting = TRUE
			player_details = GLOB.player_details[ckey]
		else
			player_details = new(ckey)
			player_details.byond_version = world.byond_version
			player_details.byond_build = world.byond_build
			GLOB.player_details[ckey] = player_details

/datum/client_interface/proc/set_macros()
	return

/datum/client_interface/proc/set_right_click_menu_mode()
	return

/datum/client_interface/proc/is_afk(duration)
	return FALSE

/datum/client_interface/proc/punish_log(whom, punishment)
	var/msg = "[key_name_admin(src)] punished [key_name_admin(whom)] with [punishment]."
	message_admins(msg)
	admin_ticket_log(whom, msg)
	log_admin("[key_name(src)] punished [key_name(whom)] with [punishment].")

/datum/client_interface/proc/get_exp_living(pure_numeric = FALSE)
	if(!prefs?.exp?[EXP_TYPE_LIVING])
		return pure_numeric ? 0 : "No data"
	var/exp_living = text2num(prefs.exp[EXP_TYPE_LIVING])
	return pure_numeric ? exp_living : get_exp_format(exp_living)

/datum/client_interface/proc/operator""()
	return "[key]"
