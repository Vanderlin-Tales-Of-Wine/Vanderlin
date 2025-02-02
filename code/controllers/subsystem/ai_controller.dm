/// The subsystem used to tick [/datum/ai_controllers] instances. Handling the re-checking of plans.
SUBSYSTEM_DEF(ai_controllers)
	name = "AI Controller Ticker"
	flags = SS_POST_FIRE_TIMING|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	init_order = INIT_ORDER_AI_CONTROLLERS
	wait = 0.5 SECONDS //Plan every half second if required, not great not terrible.
	///List of all ai_subtree singletons, key is the typepath while assigned value is a newly created instance of the typepath. See setup_subtrees()
	var/list/ai_subtrees = list()
	///List of all ai controllers currently running
	var/list/active_ai_controllers = list()
	///List of all AI controllers that are not running
	var/list/inactive_ai_controllers = list()

#define AI_STATUS_OFF_MAX_TIME 5 SECONDS

/datum/controller/subsystem/ai_controllers/Initialize(timeofday)
	setup_subtrees()
	return ..()

/datum/controller/subsystem/ai_controllers/proc/setup_subtrees()
	ai_subtrees = list()
	for(var/subtree_type in subtypesof(/datum/ai_planning_subtree))
		var/datum/ai_planning_subtree/subtree = new subtree_type
		ai_subtrees[subtree_type] = subtree

/datum/controller/subsystem/ai_controllers/fire(resumed)
	for(var/datum/ai_controller/ai_controller as anything in active_ai_controllers)
		if(!COOLDOWN_FINISHED(ai_controller, failed_planning_cooldown))
			continue
		if(!ai_controller.able_to_plan())
			continue
		ai_controller.SelectBehaviors(wait * 0.1)
		if(!LAZYLEN(ai_controller.current_behaviors)) //Still no plan
			COOLDOWN_START(ai_controller, failed_planning_cooldown, AI_FAILED_PLANNING_COOLDOWN)
	for(var/datum/ai_controller/ai_controller as anything in inactive_ai_controllers)
		if(isnull(ai_controller.pawn))
			inactive_ai_controllers -= ai_controller
			continue
		if(ai_controller.inactive_timestamp + AI_STATUS_OFF_MAX_TIME < world.time)
			var/mob/living/mob_pawn = ai_controller.pawn
			if(mob_pawn.stat != DEAD) // We don't remove it from the inactive controller in the case it's revived yada yada.
				mob_pawn.ai_controller.set_ai_status(AI_STATUS_ON) // Adds it back to the active AI controllers on next fire.
				continue
			ai_controller.inactive_timestamp = world.time // Acts as a cooldown.

#undef AI_STATUS_OFF_MAX_TIME
