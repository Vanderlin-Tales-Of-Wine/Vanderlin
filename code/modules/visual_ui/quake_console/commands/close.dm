/datum/console_command/close
	command_key = "close"
	notify_admins = FALSE

/datum/console_command/close/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("close - Close the console")

/datum/console_command/close/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	output.parent:close_console()
