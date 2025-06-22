/datum/objective/wise_trees
	name = "Create Wise Trees"
	triumph_count = 0
	var/trees_transformed = 0
	var/trees_required = 3

/datum/objective/wise_trees/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_TREE_TRANSFORMED, PROC_REF(on_tree_transformed))
	update_explanation_text()

/datum/objective/wise_trees/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_TREE_TRANSFORMED)
	return ..()

/datum/objective/wise_trees/proc/on_tree_transformed(datum/source)
	SIGNAL_HANDLER
	if(completed)
		return

	trees_transformed++
	to_chat(owner.current, span_green("Tree transformed! [trees_required - trees_transformed] more tree\s needed."))

	if(trees_transformed >= trees_required)
		complete_objective()

/datum/objective/wise_trees/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have created enough wise trees to satisfy Dendor!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Dendor", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_TREE_TRANSFORMED)

/datum/objective/wise_trees/update_explanation_text()
	explanation_text = "Transform [trees_required] common trees into guardian wise trees using Dendor's blessing."
