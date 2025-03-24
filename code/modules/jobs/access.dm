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

/// Returns a list of access or null if no access is set
/obj/item/proc/get_access()
	return null

/// Check if something has access at all
/obj/item/proc/has_access()
	if(!islist(src.get_access()) || !length(src.get_access()))
		return FALSE
	return TRUE
