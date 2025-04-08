/obj
	/**
	 * A list of lockids for keys or custom keys and custom locks
	 * Should not be used on things with a /datum/lock
	 */
	var/list/lockids
	/// A lock datum that handles access and lockpicking
	var/datum/lock/lock
	/// If we don't have a lock datum, can we add one?
	var/can_add_lock = FALSE
	/// If we have a lock datum, can we remove it?
	var/can_remove_lock = FALSE

	var/lock_sound = 'sound/foley/lock.ogg'
	var/unlock_sound = 'sound/foley/unlock.ogg'
	/// Sound we play when a key fails to unlock
	var/rattle_sound = 'sound/foley/lockrattle.ogg'

/**
 * Handle lock actions like keys and lockpicking
 * Returns TRUE if the lock was interacted with
 */
/obj/proc/handle_keylock(obj/item/I, mob/user)
	var/datum/lock/key/KL = lock
	if(I.has_access() && pre_lock_interact(user))
		if(!KL.check_access(I))
			lock_failed(user)
			return TRUE
		var/silent = user.m_intent == MOVE_INTENT_SNEAK
		if(lock.toggle())
			on_lock(user, silent)
		else
			on_unlock(user, silent)
		return TRUE
	if(isliving(user))
		var/mob/living/L = user
		if(pre_lock_interact(user) && L.try_pick(src, I, KL.lockpicks, KL.wedges, KL.difficulty))
			return TRUE
	return FALSE

/// Check if obj has a lock datum and optionally if it uses a key
/obj/proc/lock_check(key = FALSE)
	if(!lock || !istype(lock, /datum/lock))
		return FALSE
	if(key && !lock.uses_key)
		return FALSE
	return TRUE

/// Query lock datum if we are locked or return false if no lock datum
/obj/proc/locked()
	if(!lock_check())
		return FALSE
	return lock.locked

/obj/proc/lock()
	if(!lock_check())
		return FALSE
	lock.lock()

/obj/proc/unlock()
	if(!lock_check())
		return FALSE
	lock.unlock()

/// Override for interaction blocking and feedback
/obj/proc/pre_lock_interact(mob/user)
	return TRUE

/// Called when our key fails to toggle the lock
/obj/proc/lock_failed(mob/user)
	to_chat(user, span_notice("This isn't the right key for [src]."))
	rattle()

/// Shake a bit make a noise
/obj/proc/rattle()
	playsound(get_turf(src), rattle_sound, 100)
	var/oldx = pixel_x
	animate(src, pixel_x = oldx + 1, time = 0.5)
	animate(pixel_x = oldx - 1, time = 0.5)
	animate(pixel_x = oldx, time = 0.5)

/// Called when locked
/obj/proc/on_lock(mob/user, silent = FALSE)
	if(!silent)
		playsound(get_turf(src), lock_sound, 100)
		user.visible_message(span_notice("[user] locks [src]."))
	to_chat(user, span_notice("I lock [src]."))

/// Called when unlocked
/obj/proc/on_unlock(mob/user, silent = FALSE)
	if(!silent)
		playsound(get_turf(src), unlock_sound, 100)
		user.visible_message(span_notice("[user] unlocks [src]."))
	to_chat(user, span_notice("I unlock [src]."))

/// Copy obj access to another obj returns success
/obj/proc/copy_access(obj/O)
	if(!O.has_access())
		return FALSE
	lockids = O.get_access()
	return TRUE

/// Returns obj access list copy or null
/obj/proc/get_access()
	if(lock != null)
		return lock.get_access()
	if(!length(lockids))
		return null
	return lockids.Copy()

/// Check if obj has access set
/obj/proc/has_access()
	if(!islist(get_access()) || !length(get_access()))
		return FALSE
	return TRUE

/// Access to english string
/obj/proc/access2string()
	var/list/access = get_access()
	if(!islist(access) || !length(access))
		return
	return english_list(access)
