/datum/console_command/clear
	command_key = "clear"

/datum/console_command/clear/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("clear - Clear console output")

/datum/console_command/clear/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	output.clear()
