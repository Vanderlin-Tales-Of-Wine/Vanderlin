/// Checks if potential_weakref is a weakref of thing.
#define IS_WEAKREF_OF(thing, potential_weakref) (isdatum(thing) && !isnull(potential_weakref) && thing.weak_reference == potential_weakref)

//For these two procs refs MUST be ref = TRUE format like typecaches!
/proc/weakref_filter_list(list/things, list/refs)
	if(!islist(things) || !islist(refs))
		return
	if(!length(refs))
		return things
	if(length(things) > length(refs))
		var/list/f = list()
		for(var/datum/weakref/r as anything in refs)
			var/datum/d = r.resolve()
			if(d)
				f |= d
		return things & f

	else
		. = list()
		for(var/i in things)
			if(!refs[WEAKREF(i)])
				continue
			. |= i

/proc/weakref_filter_list_reverse(list/things, list/refs)
	if(!islist(things) || !islist(refs))
		return
	if(!length(refs))
		return things
	if(length(things) > length(refs))
		var/list/f = list()
		for(var/datum/weakref/r as anything in refs)
			var/datum/d = r.resolve()
			if(d)
				f |= d

		return things - f
	else
		. = list()
		for(var/i in things)
			if(refs[WEAKREF(i)])
				continue
			. |= i
