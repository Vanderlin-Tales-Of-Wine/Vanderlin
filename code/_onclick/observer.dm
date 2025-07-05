/mob/dead/observer/DblClickOn(atom/A, params)
	if(check_click_intercept(params, A))
		return

	if(can_reenter_corpse && mind && mind.current)
		if(A == mind.current || (mind.current in A)) // double click your corpse or whatever holds it
			reenter_corpse()						// (cloning scanner, body bag, closet, mech, etc)
			return									// seems legit.

	// Things you might plausibly want to follow
	if(ismovableatom(A))
		ManualFollow(A)

	// Otherwise jump
	else if(A.loc)
		forceMove(get_turf(A))

/mob/dead/observer/profane/DblClickOn(atom/A, params) // Souls trapped by the dagger should not be jumping around.
	return

/mob/dead/observer/rogue/DblClickOn(atom/A, params)
	if(check_click_intercept(params, A))
		return

	if(can_reenter_corpse && mind && mind.current)
		if(A == mind.current || (mind.current in A))
			reenter_corpse()
			return

/mob/dead/observer/ClickOn(atom/A, params)
	if(check_click_intercept(params,A))
		return

	if(SEND_SIGNAL(src, COMSIG_MOB_CLICKON, A, params) & COMSIG_MOB_CANCEL_CLICKON)
		return

	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICKED) && LAZYACCESS(modifiers, MIDDLE_CLICK))
		ShiftMiddleClickOn(A)
		return
	if(LAZYACCESS(modifiers, SHIFT_CLICKED) && LAZYACCESS(modifiers, CTRL_CLICKED))
		CtrlShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		MiddleClickOn(A)
		return
	if(LAZYACCESS(modifiers, SHIFT_CLICKED))
		ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, ALT_CLICKED))
		AltClickNoInteract(src, A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICKED))
		CtrlClickOn(A)
		return

	if(world.time <= next_move)
		return
	// You are responsible for checking config.ghost_interaction when you override this function
	// Not all of them require checking, see below
	A.attack_ghost(src)

// Oh by the way this didn't work with old click code which is why clicking shit didn't spam you
/atom/proc/attack_ghost(mob/dead/observer/user)
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_GHOST, user) & COMPONENT_NO_ATTACK_HAND)
		return TRUE
	if(user.client)
		if(user.client.prefs.inquisitive_ghost)
			user.examinate(src)
	return FALSE

/mob/living/attack_ghost(mob/dead/observer/user)
	return ..()
