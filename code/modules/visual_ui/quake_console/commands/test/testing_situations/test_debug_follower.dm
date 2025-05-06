/datum/test_situation/debug_follower
	start = "debug_follower"

/datum/test_situation/debug_follower/execute_test(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	var/mob/living/starter = output.get_user()
	if(!isliving(starter))
		output.add_line("ERROR: No host to bind to.")
		return

	var/obj/effect/proc_holder/spell/invoked/findfamiliar/spell = new /obj/effect/proc_holder/spell/invoked/findfamiliar
	starter.mind.AddSpell(spell)
	spell.cast(list(starter), starter)
	var/mob/living/simple_animal/hostile/retaliate/wolf/familiar/pet = locate(/mob/living/simple_animal/hostile/retaliate/wolf/familiar) in get_turf(starter)
	if(!pet)
		output.add_line("ERROR: Failed to find pet.")
		return
	starter.client.mark_datum(pet)

	for(var/datum/console_command/listed_command in GLOB.console_commands)
		if(!istype(listed_command, /datum/console_command/debug_ai))
			continue
		listed_command.execute(output)

	starter.say("Follow")
