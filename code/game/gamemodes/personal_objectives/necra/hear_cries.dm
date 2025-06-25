/datum/objective/listen_whispers
	name = "Listen to Whispers"
	triumph_count = 0
	var/time_required = 5 MINUTES
	var/time_spent = 0
	var/last_check = 0
	var/check_interval = 10 SECONDS
	var/area/church_area = /area/rogue/indoors/town/church
	var/list/heard_messages = list()

/datum/objective/listen_whispers/on_creation()
	. = ..()
	START_PROCESSING(SSprocessing, src)
	update_explanation_text()

/datum/objective/listen_whispers/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/objective/listen_whispers/process()
	if(world.time < last_check + check_interval || completed || !owner?.current)
		return

	last_check = world.time
	check_location()

/datum/objective/listen_whispers/proc/check_location()
	var/mob/living/user = owner.current
	if(!istype(user) || user.stat == DEAD)
		return

	if(!istype(get_area(user), church_area))
		return // Not in church area

	time_spent += check_interval

	// Occasionally play a whisper from the dead
	if(prob(10) && GLOB.last_messages.len)
		var/message = pick(GLOB.last_messages)
		to_chat(user, span_warning("[message]"))
		heard_messages += message
		user.playsound_local(user, 'sound/effects/ghost.ogg', 25)

	if(time_spent >= time_required && !completed)
		complete_objective()

/datum/objective/listen_whispers/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have listened to the whispers of the dead long enough to satisfy Necra!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Necra", 15)
	escalate_objective()
	STOP_PROCESSING(SSprocessing, src)

/datum/objective/listen_whispers/update_explanation_text()
	explanation_text = "Spend at least [time_required / (1 MINUTES)] minutes in the church area to listen to the whispers of the dead and commune with Necra."
