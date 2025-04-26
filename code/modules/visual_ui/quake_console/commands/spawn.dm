/datum/console_command/spawn
	command_key = "spawn"
	required_args = 1

/datum/console_command/spawn/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("spawn {PATH or partial path} - spawns a mob at your feet")

/datum/console_command/spawn/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	var/mob/user = output.get_user()
	var/datum/admins/admin = user.client.holder
	if(!admin)
		output.add_line("ERROR: Lacks Permission")
		return
	var/name = admin.spawn_atom(arg_list[1])
	output.add_line("Successfully spawned [name] at feet")
