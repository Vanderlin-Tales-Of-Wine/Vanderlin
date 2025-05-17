/// A lock that is not key controlled
/datum/lock
	/// Our holder /obj
	var/obj/holder = null
	/// Are we currently locked?
	var/locked = FALSE
	/// Have we been broken?
	var/lock_broken = FALSE
	/// Do we use a key?
	var/uses_key = FALSE
	/// Have we been lockpicked open, reset when the lock is toggled
	var/tampered = FALSE

/datum/lock/New(obj/holder)
	if(!holder)
		CRASH("[type] created without a parent object.")
	src.holder = holder
	src.holder.on_lock_add()

/datum/lock/Destroy()
	src.holder = null
	return ..()

/datum/lock/proc/toggle(mob/user, silent = FALSE)
	if(!silent && user)
		silent = user?.m_intent == MOVE_INTENT_SNEAK
	if(locked)
		unlock(user, silent)
	else
		lock(user, silent)

/datum/lock/proc/lock(user, silent = FALSE)
	tampered = FALSE
	locked = TRUE
	if(user)
		holder?.on_lock(user, silent)

/datum/lock/proc/unlock(user, silent = FALSE)
	tampered = FALSE
	locked = FALSE
	if(user)
		holder?.on_unlock(user, silent)

/// A keylock
/datum/lock/key
	uses_key = TRUE
	/// Lockids to use for access
	var/list/lockid_list
	/// If the master key can open this lock regardless of access
	var/master_unlockable = TRUE

	///// Lockpicking
	/// Difficulty of the lock, smaller is harder
	var/difficulty = 5
	/// Picks able to be used
	var/list/lockpicks = list(/obj/item/lockpick)
	/// Wedges able to be used
	var/list/wedges = list(/obj/item/weapon/knife/dagger, /obj/item/lockpick) //when we add more thieves tools check this
	/// Can we be picked
	var/pickable = TRUE
	/// Requires left/right inputs for key turning
	var/requires_turning = TRUE

/datum/lock/key/New(obj/holder, list/lockids)
	. = ..()
	if(lockids && islist(lockids))
		lockid_list = lockids
	RegisterSignal(src.holder, COMSIG_PARENT_EXAMINE, PROC_REF(examine))
	RegisterSignal(src.holder, COMSIG_PARENT_ATTACKBY, PROC_REF(attack_by))
	if(requires_turning)
		RegisterSignal(src.holder, COMSIG_ATOM_ATTACK_RIGHT, PROC_REF(attack_right))

/datum/lock/key/Destroy()
	UnregisterSignal(src.holder, list(COMSIG_PARENT_ATTACKBY, COMSIG_PARENT_EXAMINE))
	if(requires_turning)
		UnregisterSignal(src.holder, COMSIG_ATOM_ATTACK_RIGHT)
	return ..()

/datum/lock/key/proc/examine(obj/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(tampered)
		examine_list += span_notice("[source] has been tampered with.")

/datum/lock/key/proc/attack_by(obj/source, obj/item/I, mob/living/user)
	SIGNAL_HANDLER
	return attack_wrap(source, I, user)

/datum/lock/key/proc/attack_right(obj/source, mob/living/user)
	SIGNAL_HANDLER
	var/obj/item/I = user.get_active_held_item()
	if(QDELETED(I))
		return FALSE
	return attack_wrap(source, I, user, FALSE)

/datum/lock/key/proc/attack_wrap(obj/source, obj/item/I, mob/living/user, is_left = TRUE)
	if(I.has_access() && source.pre_lock_interact(user))
		try_toggle(I, user, is_left)
		return TRUE
	if(is_type_in_list(I, lockpicks))
		if(source.pre_lock_interact(user) && user.try_pick(source, I, lockpicks, wedges, difficulty))
			return TRUE

/// Try to toggle the lock with I
/datum/lock/key/proc/try_toggle(obj/item/I, mob/user, is_left)
	var/silent = user?.m_intent == MOVE_INTENT_SNEAK
	if(!check_access(I))
		holder?.lock_failed(user, silent)
		return
	if(requires_turning)
		if(locked && !is_left)
			holder?.lock_failed(user, silent, "It won't turn this way, try turning it to the left.")
			return
		if(!locked && is_left)
			holder?.lock_failed(user, silent, "It won't turn this way, try turning it to the right.")
			return
	toggle(user, silent)

/datum/lock/key/proc/set_pick_difficulty(difficulty)
	src.difficulty = CLAMP(difficulty, 1, 6)

/datum/lock/key/proc/get_string_difficulty()
	switch(difficulty)
		if(1)
			return "LEGENDARY"
		if(2)
			return "MASTER"
		if(3)
			return "EXPERT"
		if(4)
			return "SKILLED"
		if(5)
			return "NOVICE"
		if(6)
			return "BASIC"

/// Check if an item has access to this lock
/datum/lock/key/proc/check_access(obj/item/I)
	return check_access_list(I ? I.get_access() : null)

/// Check a list of accesses for one of the required accesses
/datum/lock/key/proc/check_access_list(list/access_list)
	if(!LAZYLEN(lockid_list) || !islist(lockid_list))
		return FALSE
	if(!LAZYLEN(access_list) || !islist(access_list))
		return FALSE
	if(master_unlockable && (ACCESS_LORD in access_list))
		return TRUE
	for(var/id as anything in lockid_list)
		if(id in access_list)
			return TRUE
	return FALSE

/datum/lock/key/proc/set_access(list/access)
	if(!LAZYLEN(access) || !islist(access))
		return
	lockid_list = access
