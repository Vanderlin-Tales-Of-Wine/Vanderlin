/datum/component/uses_essence
	var/datum/callback/get_essence_callback
	var/datum/callback/activate_check_failure_callback
	var/datum/callback/get_user_callback
	var/datum/callback/get_essence_required_callback

	var/list/datum/attunement/attunements
	var/essence_required

	var/pre_use_check_with_feedback_comsig
	var/pre_use_check_comsig
	var/post_use_comsig

/datum/component/uses_essence/Initialize(
	datum/callback/activate_check_failure_callback,
	datum/callback/get_user_callback,
	pre_use_check_with_feedback_comsig,
	pre_use_check_comsig,
	post_use_comsig,
	datum/callback/essence_required,
	list/datum/attunement/attunements,
)
	. = ..()

	if (isnull(pre_use_check_with_feedback_comsig))
		stack_trace("pre_use with feedback null")
		return COMPONENT_INCOMPATIBLE
	if (isnull(post_use_comsig))
		stack_trace("post_use comsig null")
		return COMPONENT_INCOMPATIBLE

	src.activate_check_failure_callback = activate_check_failure_callback
	src.get_user_callback = get_user_callback

	if (istype(essence_required))
		src.get_essence_required_callback = essence_required
	else if (isnum(essence_required))
		src.essence_required = essence_required

	src.attunements = attunements
	src.pre_use_check_with_feedback_comsig = pre_use_check_with_feedback_comsig
	src.pre_use_check_comsig = pre_use_check_comsig
	src.post_use_comsig = post_use_comsig

/datum/component/uses_essence/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, pre_use_check_with_feedback_comsig, PROC_REF(can_activate_with_feedback))
	RegisterSignal(parent, post_use_comsig, PROC_REF(react_to_successful_use))

/datum/component/uses_essence/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, pre_use_check_with_feedback_comsig)
	UnregisterSignal(parent, post_use_comsig)

/datum/component/uses_essence/proc/get_essence_required(atom/caster, ...)
	if (!isnull(get_essence_required_callback))
		return get_essence_required_callback?.Invoke(arglist(args))

	var/required = 0
	if (!isnull(essence_required))
		required = essence_required
	else
		return stack_trace("Both the Callback and value for essence required is null!")
	return required

/datum/component/uses_essence/proc/get_essence_gauntlet()
	var/atom/movable/caster = get_parent_user()
	if(!iscarbon(caster))
		return null

	var/mob/living/carbon/carbon_caster = caster
	var/obj/item/clothing/gloves/essence_gauntlet/gauntlet = carbon_caster.gloves

	if(!istype(gauntlet))
		return null

	return gauntlet

/datum/component/uses_essence/proc/is_essence_sufficient(atom/movable/user, ...)
	var/obj/item/clothing/gloves/essence_gauntlet/gauntlet = get_essence_gauntlet()
	if(!gauntlet)
		return FALSE

	var/required_essence = get_essence_required(arglist(args))
	return gauntlet.can_consume_essence(required_essence, attunements)

/datum/component/uses_essence/proc/drain_essence(...)
	var/obj/item/clothing/gloves/essence_gauntlet/gauntlet = get_essence_gauntlet()
	if(!gauntlet)
		return

	var/essence_consumed = get_essence_required(arglist(args))
	gauntlet.consume_essence(essence_consumed, attunements)

/datum/component/uses_essence/proc/can_activate(...)
	return is_essence_sufficient(arglist(list(get_parent_user()) + args))

/datum/component/uses_essence/proc/can_activate_with_feedback(...)
	var/can_activate
	var/list/argss = args.Copy(1)
	can_activate = can_activate(arglist(argss))

	if (!can_activate)
		return can_activate_check_failure(arglist(args.Copy()))
	return NONE

/datum/component/uses_essence/proc/can_activate_check_failure(...)
	return !activate_check_failure_callback?.Invoke(arglist(args))

/datum/component/uses_essence/proc/react_to_successful_use(...)
	drain_essence(arglist(list(get_parent_user()) + args))
	return

/datum/component/uses_essence/proc/get_parent_user()
	return get_user_callback?.Invoke()
