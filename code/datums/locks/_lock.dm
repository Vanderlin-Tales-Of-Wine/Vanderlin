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

/// Toggle locked and return value
/datum/lock/proc/toggle()
	if(tampered)
		tampered = FALSE
	locked = !locked
	return locked

/datum/lock/proc/lock()
	if(tampered)
		tampered = FALSE
	locked = TRUE

/datum/lock/proc/unlock()
	if(tampered)
		tampered = FALSE
	locked = FALSE

/// A keylock
/datum/lock/key
	uses_key = TRUE
	/// Lockid to use for access requirements
	var/lockid = null
	/// If the master key can open this lock regardless of access
	var/master_unlockable = TRUE

	///// Lockpicking
	/// Difficulty of the lock, smaller is harder
	var/difficulty = 20
	/// Picks able to be used
	var/list/lockpicks = list(/obj/item/lockpick)
	/// Wedges able to be used
	var/list/wedges = list(/obj/item/weapon/knife/dagger, /obj/item/lockpick) //when we add more thieves tools check this
	/// Can we be picked
	var/pickable = TRUE

/datum/lock/key/proc/set_pick_difficulty(difficulty)
	src.difficulty = CLAMP(difficulty, 1, 100)

/datum/lock/key/proc/get_string_difficulty()
	switch(difficulty)
		if(1 to 3)
			return "LEGENDARY"
		if(4 to 6)
			return "MASTER"
		if(7 to 9)
			return "EXPERT"
		if(10 to 15)
			return "SKILLED"
		if(16 to 20)
			return "NOVICE"
		if(21 to 100)
			return "BASIC"

/// Check if an item has access to this lock
/datum/lock/key/proc/check_access(obj/item/I)
	return check_access_list(I ? I.get_access() : null)

/// Check a list of accesses for one of the required accesses
/datum/lock/key/proc/check_access_list(list/access_list)
	if(lockid == null)
		return FALSE
	if(!length(access_list) || !islist(access_list))
		return FALSE
	if(master_unlockable && (ACCESS_LORD in access_list))
		return TRUE
	if(lockid in access_list)
		return TRUE
	return FALSE

/datum/lock/key/proc/set_access(var/access)

/// A keylock that accepts a list of keys
/datum/lock/key/multiple
	/// Lockids to use for access requirements
	var/list/lockid_list = null

/datum/lock/key/multiple/check_access_list(list/access_list)
	if(!length(lockid_list))
		return FALSE
	if(!length(access_list) || !islist(access_list))
		return FALSE
	if(master_unlockable && (ACCESS_LORD in access_list))
		return TRUE
	for(var/id as anything in lockid_list)
		if(id in access_list)
			return TRUE
	return FALSE
