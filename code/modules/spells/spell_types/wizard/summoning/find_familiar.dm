/obj/effect/proc_holder/spell/invoked/findfamiliar
	name = "Find Familiar"
	desc = "Summons a temporary spectral volf to aid you. Prioritizes your target and is hostile to all but yourself. Summon with care."
	school = "transmutation"
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	recharge_time = 240 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	sound = 'sound/blank.ogg'
	overlay_state = "forcewall"
	range = -1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 3
	attunements = list(
		/datum/attunement/arcyne = 0.4,
	)

/obj/effect/proc_holder/spell/invoked/findfamiliar/cast(list/targets,mob/user = usr)
	. = ..()
	var/mob/living/M = new /mob/living/simple_animal/hostile/retaliate/wolf/familiar(get_turf(user), user)
	M.befriend(user)
	var/atom/A = targets[1]
	if(isliving(A))
		M.ai_controller?.set_blackboard_key(BB_BASIC_MOB_PRIORITY_TARGETS, A)
	else
		var/turf/target_turf = get_turf(A)
		var/list/turftargets = list()
		for(var/mob/living/L in target_turf)
			turftargets += L
		M.ai_controller?.set_blackboard_key(BB_BASIC_MOB_PRIORITY_TARGETS, turftargets)
	return TRUE
