/**
 * Component that can be used to clean things.
 * Takes care of duration, cleaning skill and special cleaning interactions.
 * A callback can be set by the datum holding the cleaner to add custom functionality.
 * Soap uses a callback to decrease the amount of uses it has left after cleaning for example.
 */
/datum/component/cleaner
	/// The time it takes to clean something, without reductions from the cleaning skill modifier.
	var/base_cleaning_duration
	/// Determines what this cleaner can wash off, [the available options are found here](code/__DEFINES/cleaning.html).
	var/cleaning_strength
	/// Gets called before you start cleaning, returns TRUE/FALSE whether the clean should actually wash tiles, or DO_NOT_CLEAN to not clean at all.
	var/datum/callback/pre_clean_callback
	/// Gets called when something is successfully cleaned.
	var/datum/callback/on_cleaned_callback

/datum/component/cleaner/Initialize(
	base_cleaning_duration = 3 SECONDS,
	cleaning_strength = CLEAN_MEDIUM,
	datum/callback/pre_clean_callback = null,
	datum/callback/on_cleaned_callback = null,
)
	src.base_cleaning_duration = base_cleaning_duration
	src.cleaning_strength = cleaning_strength
	src.pre_clean_callback = pre_clean_callback
	src.on_cleaned_callback = on_cleaned_callback

/datum/component/cleaner/Destroy(force)
	pre_clean_callback = null
	on_cleaned_callback = null
	return ..()

/datum/component/cleaner/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_afterattack))

/datum/component/cleaner/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_AFTERATTACK)

/**
 * Handles the COMSIG_ITEM_AFTERATTACK signal by calling the clean proc.
 *
 * Arguments
 * * source the datum that sent the signal to start cleaning
 * * target the thing being cleaned
 * * user the person doing the cleaning
 * * clean_target set this to false if the target should not be washed and if experience should not be awarded to the user
 */
/datum/component/cleaner/proc/on_afterattack(datum/source, atom/target, mob/user, proximity_flag)
	SIGNAL_HANDLER
	if(!proximity_flag)
		return
	var/clean_target
	if(pre_clean_callback)
		clean_target = pre_clean_callback?.InvokeAsync(source, target, user)
		if(clean_target == DO_NOT_CLEAN)
			return .
	INVOKE_ASYNC(src, PROC_REF(clean), source, target, user, clean_target) //signal handlers can't have do_afters inside of them
	return COMPONENT_NO_AFTERATTACK

/**
 * Cleans something using this cleaner.
 * The cleaning duration is modified by the cleaning skill of the user.
 * Successfully cleaning gives cleaning experience to the user and invokes the on_cleaned_callback.
 *
 * Arguments
 * * source the datum that sent the signal to start cleaning
 * * target the thing being cleaned
 * * user the person doing the cleaning
 * * clean_target set this to false if the target should not be washed and if experience should not be awarded to the user
 */
/datum/component/cleaner/proc/clean(datum/source, atom/target, mob/living/user, clean_target = TRUE)
	//do the cleaning
	user.changeNext_move(base_cleaning_duration)
	user.visible_message(span_small("[user] starts to clean [target]!"), span_small("You start to clean [target]..."))
	var/clean_succeeded = FALSE
	if(do_after(user, base_cleaning_duration, target = target))
		clean_succeeded = TRUE
		user.visible_message(span_small("[user] finishes cleaning [target]!"), span_small("You finish cleaning [target]."))
		if(clean_target)
			wash_atom(target, cleaning_strength)

	on_cleaned_callback?.Invoke(source, target, user, clean_succeeded)
