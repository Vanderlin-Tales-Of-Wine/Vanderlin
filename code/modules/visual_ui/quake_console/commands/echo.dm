/datum/console_command/echo
	command_key = "echo"
	required_args = 1
	notify_admins = FALSE

/datum/console_command/echo/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("echo {TEXT} - Display text in console")

/datum/console_command/echo/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	output.add_line(arg_list.Join(" "))
