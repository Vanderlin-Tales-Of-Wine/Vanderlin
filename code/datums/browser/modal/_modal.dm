/datum/browser/modal
	window_options = "can_close=1;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1;"
	/// If this modal has been closed.
	var/final/closed = FALSE
	/// This modal's selected choice.
	var/final/choice = null
	/// The time in deciseconds before this modal is cancelled.
	var/timeout = 0
	/// If the modal will continuously regrab focus.
	var/final/autofocus = FALSE

/datum/browser/modal/New(user, window_id, title = "", width = 0, nheight = 0, atom/owner = null, autofocus = TRUE, timeout = 0)
	. = ..()
	src.autofocus = autofocus
	if(!autofocus)
		window_options += "focus=[FALSE];"
	src.timeout = timeout

/datum/browser/modal/open()
	. = ..()
	if(isnull(window_id))
		closed = TRUE
		return

/datum/browser/modal/close()
	. = ..()
	closed = TRUE

/datum/browser/modal/open(use_onclose)
	set waitfor = 0

	if(autofocus)
		. = ..()
	else
		var/focusedwindow = winget(user, null, "focus")
		. = ..()

		//waits for the window to show up client side before attempting to un-focus it
		//winexists sleeps until it gets a reply from the client, so we don't need to bother sleeping
		for (var/i in 1 to 10)
			if (user && winexists(user, window_id))
				if (focusedwindow)
					winset(user, focusedwindow, "focus=true")
				else
					winset(user, "mapwindow", "focus=true")
				break
	if(timeout)
		addtimer(CALLBACK(src, PROC_REF(close)), timeout)

/datum/browser/modal/proc/wait()
	while (!choice && !closed && !QDELETED(src)) //(opentime && selectedbutton <= 0 && (!timeout || opentime+timeout > world.time))
		stoplag(1)

/datum/browser/modal/proc/set_choice(choice)
	src.choice = choice
