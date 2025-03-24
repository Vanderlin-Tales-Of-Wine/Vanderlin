
/// Check if an item (not object because this is only relevant for players) has access to this object
/obj/proc/check_access(obj/item/I)
	return src.check_access_list(I ? I.get_access() : null)

/// Check a list of accesses for one of the required accesses
/obj/proc/check_access_list(list/access_list)
	if(!length(src.lockids))
		return FALSE
	if(!length(access_list) || !islist(access_list))
		return FALSE
	if(src.master_unlockable && (ACCESS_LORD in access_list))
		return TRUE
	for(var/id as anything in src.lockids)
		if(id in access_list)
			return TRUE
		return FALSE
	return FALSE

/// Copy obj access to another obj returns success
/obj/proc/copy_access(obj/O)
	if(!O.has_access())
		return FALSE
	src.lockids = O.get_access()
	return TRUE

/// Returns obj access list copy or null
/obj/proc/get_access()
	if(!length(src.lockids))
		return null
	return src.lockids.Copy()

/**
 * Check if obj has access set
 * This intentionally doesn't check var/keylock
 */
/obj/proc/has_access()
	if(!islist(src.get_access()) || !length(src.get_access()))
		return FALSE
	return TRUE

/// Access to english string
/obj/proc/access2string()
	var/list/access = src.get_access()
	if(!islist(access) || !length(access))
		return
	if(length(access) == 1)
		return "[access[0]]"
	var/list/strings = list()
	for(var/string as anything in access)
		strings += string
	return jointext(strings, ", ")
