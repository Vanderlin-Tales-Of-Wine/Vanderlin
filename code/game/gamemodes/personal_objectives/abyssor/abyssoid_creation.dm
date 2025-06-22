/datum/objective/create_abyssoids
	name = "Create Abyssoids"
	triumph_count = 0
	var/abyssoids_created = 0
	var/abyssoids_required = 5

/datum/objective/create_abyssoids/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ABYSSOID_CREATED, PROC_REF(on_abyssoid_created))
	update_explanation_text()

/datum/objective/create_abyssoids/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ABYSSOID_CREATED)
	return ..()

/datum/objective/create_abyssoids/proc/on_abyssoid_created(datum/source)
	SIGNAL_HANDLER
	if(completed)
		return

	abyssoids_created++

	if(abyssoids_created >= abyssoids_required)
		complete_objective()
	else
		to_chat(owner.current, span_notice("Abyssoid created! [abyssoids_required - abyssoids_created] more abyssoid\s needed."))

/datum/objective/create_abyssoids/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have created enough abyssoids to satisfy Abyssor!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Abyssor", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_ABYSSOID_CREATED)

/datum/objective/create_abyssoids/update_explanation_text()
	explanation_text = "Create [abyssoids_required] abyssoid\s from the common leeches, and then distribute them among the ingrate population!"
