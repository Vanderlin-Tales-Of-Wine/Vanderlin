/datum/objective/build_zizo_shrine
	name = "Construct Profane Shrines"
	var/target_type = /obj/structure/fluff/psycross/zizocross
	var/target_count = 2
	var/current_count = 0

/datum/objective/build_zizo_shrine/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.mind.teach_crafting_recipe(/datum/crafting_recipe/zizo_shrine)
		RegisterSignal(owner.current, COMSIG_ITEM_CRAFTED, PROC_REF(on_item_crafted))
	update_explanation_text()

/datum/objective/build_zizo_shrine/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)
	return ..()

/datum/objective/build_zizo_shrine/proc/on_item_crafted(datum/source, mob/user, craft_path)
	SIGNAL_HANDLER
	if(completed || !ispath(craft_path, target_type))
		return

	current_count++
	if(current_count < target_count)
		to_chat(owner.current, span_notice("You have built [current_count] out of [target_count] profane shrines."))
		return

	to_chat(owner.current, span_greentext("You have built all the required profane shrines, completing Zizo's objective!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Zizo", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_ITEM_CRAFTED)

/datum/objective/build_zizo_shrine/update_explanation_text()
	explanation_text = "Construct [target_count] profane shrine[target_count > 1 ? "s" : ""] to spread Zizo's corruption!"

/datum/crafting_recipe/zizo_shrine
	name = "Profane Shrine"
	always_availible = FALSE
	reqs = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/stone = 2,
		/obj/item/grown/log/tree/stake = 3
	)
	result = /obj/structure/fluff/psycross/zizocross
	craftdiff = 1
	verbage = "construct"
	verbage_tp = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'
