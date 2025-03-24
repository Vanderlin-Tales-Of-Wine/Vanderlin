
/// Check if an item has access to this object
/obj/proc/check_access(obj/item/I)
	return check_access_list(I ? I.get_access() : null)

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

/// Copy item access to another item if possible returns success
/obj/item/proc/copy_access(obj/item/I)
	if(!I.has_access)
		return FALSE
	src.lockids = I.get_access()
	return TRUE

/// Returns item access list or null
/obj/item/proc/get_access()
	return null

/// Check if item has access set
/obj/item/proc/has_access()
	if(!islist(src.get_access()) || !length(src.get_access()))
		return FALSE
	return TRUE
