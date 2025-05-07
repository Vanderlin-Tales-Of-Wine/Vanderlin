/datum/objective/craft_shrine
	name = "Craft Shrine"
	triumph_count = 0
	var/target_type = /obj/structure/fluff/psycross/crafted

/datum/objective/craft_shrine/New(text, datum/mind/owner, obj/target_path)
	if(target_path)
		target_type = target_path
	. = ..()

/datum/objective/craft_shrine/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ITEM_CRAFTED, PROC_REF(on_item_crafted))
	update_explanation_text()

/datum/objective/craft_shrine/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)
	return ..()

/datum/objective/craft_shrine/proc/on_item_crafted(datum/source, mob/user, craft_path)
	SIGNAL_HANDLER
	if(completed || !ispath(craft_path, target_type))
		return

	to_chat(owner.current, span_greentext("You have built the sacred cross, completing Malum's objective!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Malum", 10)
	UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)

/datum/objective/craft_shrine/update_explanation_text()
	explanation_text = "Build a wooden pantheon cross to demonstrate your devotion to Malum."
