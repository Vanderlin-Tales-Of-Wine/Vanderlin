/datum/console_command/update
	command_key = "update"
	required_args = 1

/datum/console_command/update/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("update {VAR} value - checks and sets the var specified")
	output.add_line("    Keywords: src = sender")
	output.add_line("    usr = sender")
	output.add_line("    here = senders turf")
	output.add_line("    marked = marked datum")
	output.add_line("    loc = senders loc")

/datum/console_command/update/get_secondary_args(mob/user)
	var/datum/marked_datum = user.client.holder?.marked_datum
	if(!marked_datum)
		marked_datum = user
	return marked_datum.vars


/datum/console_command/update/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	var/variable = arg_list[1]
	var/mob/user = output.parent.get_user()
	var/value = output.parent:convert_arg_type(arg_list[2], user, user.client.holder?.marked_datum)
	var/datum/marked_datum = user.client.holder?.marked_datum
	if(marked_datum)
		user = marked_datum

	if(!(variable in user.vars))
		output.add_line("ERROR: variable not in list")
		return

	user.vars[variable] = value
	output.add_line("[variable] set to [value]")
	return TRUE
