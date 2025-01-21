#define LOCKPICK_MOUSEUP 0
#define LOCKPICK_MOUSEDOWN 1

//base element, tells thing it can be lockpicked
/obj
	//check if object is being picked if can be picked
	var/being_picked = FALSE
	//check if lock can be picked
	var/can_be_picked = TRUE
	//check if obj has lock and can be picked
	var/lock_tampered = FALSE //for doors this gets reset

/datum/element/lockpickable
	///Difficulty of the lock. Smaller is harder.
	var/difficulty
	///picks able to be used
	var/list/lockpicks = list(/obj/item/lockpick)
	///wedges able to be used
	var/list/wedges = list(/obj/item/rogueweapon/knife/dagger, /obj/item/lockpick) //whem we add more thieves tools check this
	///shows the lock difficulty level on examine, like fallout
	var/shown_difficulty

/datum/element/lockpickable/Attach(datum/target, list/lockpicks, list/wedges, difficulty, shown_difficulty)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	switch(difficulty)
		if(1 to 3)
			shown_difficulty = "LEGENDARY"
		if(4 to 6)
			shown_difficulty = "MASTER"
		if(7 to 9)
			shown_difficulty = "EXPERT"
		if(10 to 15)
			shown_difficulty = "SKILLED"
		if(16 to 20)
			shown_difficulty = "NOVICE"
		if(20 to 100)
			shown_difficulty = "BASIC"

	if(!src.lockpicks)
		src.lockpicks = lockpicks.Copy()
	if(!src.wedges)
		src.wedges = wedges.Copy()
	src.difficulty = difficulty
	src.shown_difficulty = shown_difficulty

	RegisterSignal(target, COMSIG_PARENT_ATTACKBY, PROC_REF(check_pick))
	RegisterSignal(target, COMSIG_PARENT_EXAMINE, PROC_REF(examine))


/datum/element/lockpickable/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, list(COMSIG_PARENT_ATTACKBY, COMSIG_PARENT_EXAMINE))

/datum/element/lockpickable/proc/examine(obj/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(source.lock_tampered)
		examine_list += span_notice("[source] has been tampered with.")

/datum/element/lockpickable/proc/pick_info(datum/source, list/mutable_lockpicks, list/mutable_wedges, mutable_difficulty)
	SIGNAL_HANDLER

	mutable_lockpicks += list(lockpicks)
	mutable_wedges += list(wedges)
	mutable_difficulty += difficulty

/datum/element/lockpickable/proc/check_pick(obj/source, obj/item/L, mob/living/user)
	SIGNAL_HANDLER
	if(!source.can_be_picked)
		return NONE
	if(user.try_pick(source, L, lockpicks, wedges, user, difficulty, shown_difficulty))
		return COMPONENT_NO_AFTERATTACK
	return NONE
//user is told its picking

/mob/living/proc/try_pick(obj/P, obj/item/L, list/obj/lockpicks, list/obj/wedges, mob/living/user, difficulty, shown_difficulty)

	if(isobj(P))
		if(P.being_picked)
			return

	var/obj/item/the_wedge = user.get_inactive_held_item()

	if(!is_type_in_list(L, lockpicks))
		return
	if(!is_type_in_list(the_wedge, wedges))
		to_chat(user, "<span class='notice'>You need a wedge in order to lockpick the [P]!</span>")
		return

	user.client.spawn_lockpicking_UI(P, user, L, the_wedge, difficulty, shown_difficulty, user.mind.get_skill_level(/datum/skill/misc/lockpicking))
	to_chat(P, span_notice("[user.name] starts picking the [P.name]'s lock..."))
	user.visible_message(span_notice("[user.name] starts picking the [name]s lock."))
	return TRUE

//ui is spawned, users screen is updated

/client/proc/spawn_lockpicking_UI(obj/lock, mob/living/user, obj/lockpick, obj/wedge, difficulty, shown_d, skill_level) //potentially different sprites for locks and picks, put here
	switch(shown_d) //for UI capitilsation
		if("master")
			shown_d = "MASTER"
		if("expert")
			shown_d = "EXPERT"
		if("standard")
			shown_d = "STANDARD"
		if("novice")
			shown_d = "NOVICE"
		if("beginner")
			shown_d = "BEGINNER"

	var/atom/movable/screen/movable/snap/lockpicking/imagery = new
	imagery.picking_object = lock
	imagery.picker = user
	imagery.sweet_spot = rand(1,179)
	imagery.clicker = src
	imagery.difficulty = difficulty
	imagery.maptext += "<br><div align='center'><font color='#f0dd5f'> [shown_d] LOCK<br></div>"
	imagery.maptext += "<br><div align='center'><font color='#f0dd5f'>       \[R Click) Exit\]</font></div><br>"
	imagery.maptext_width = 100
	imagery.maptext_x = 253
	imagery.maptext_y = 150
	imagery.the_lockpick = lockpick
	imagery.the_wedge = wedge
	imagery.skill_level = skill_level
	lock.being_picked = TRUE


	playsound(user, 'sound/items/LPstart.ogg', 100 - (15 * skill_level))

	screen += imagery
	imagery.autofire_on(imagery.clicker)

//the lockpicking UI, everything contained on this

/atom/movable/screen/movable/snap/lockpicking
	name = "lock"
	icon = 'icons/hud/lockpicking.dmi'
	icon_state = "base"
	screen_loc = "1,1"
	locked = TRUE
	plane = HUD_PLANE
	layer = 1

	///Angle of the lock itself. Determined by holding down mouse1.
	var/lock_angle = 0
	///Angle of the wedge. Determined by the lock.
	var/wedge_angle = 0
	///Angle of the lockpick. Determined by mouse coordinates.
	var/pick_angle = 0
	///The angle of the sweet spot.
	var/sweet_spot = 0
	//How far are we, in angular units, are we from the sweet spot?
	var/angle_distance
	///Difficulty of the lock. Smaller is harder.
	var/difficulty
	///the mobs skill level at the start
	var/skill_level = 1
	///client clicking
	var/client/clicker
	//state of the mouse
	var/mouse_status = LOCKPICK_MOUSEUP

	//the lockpick being used
	var/the_lockpick
	//the wedge being used
	var/the_wedge

	var/obj/picking_object

	///Person picking the lock
	var/mob/picker

	///used for completed lock
	var/frozen = FALSE

	var/playing_lock_sound = FALSE

	///the cooldown for break checking
	var/break_checking_cooldown = 0

	///sprite tomfoolery
	var/image/linked_background
	var/obj/linked_lock
	var/obj/linked_pick
	var/obj/linked_wedge

/atom/movable/screen/movable/snap/lockpicking/Initialize()
	. = ..()
	QDEL_NULL(linked_lock)
	QDEL_NULL(linked_pick)
	QDEL_NULL(linked_wedge)

	if(!linked_background)
		linked_background = new /image()
		linked_background.icon_state = "dim"
		linked_background.layer = 0.9
		add_overlay(linked_background)

	linked_lock = new(src)
	linked_lock.icon = initial(icon)
	linked_lock.icon_state = "lock"
	linked_lock.plane = FLOAT_PLANE
	linked_lock.layer = 2
	linked_lock.mouse_opacity = 0
	vis_contents += linked_lock

	linked_wedge = new(src)
	linked_wedge.icon = initial(icon)
	linked_wedge.icon_state = "wedge"
	linked_wedge.plane = FLOAT_PLANE + 2
	linked_wedge.layer = 4
	linked_wedge.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_contents += linked_wedge

	linked_pick = new(src)
	linked_pick.icon = initial(icon)
	linked_pick.icon_state = "pick"
	linked_pick.plane = FLOAT_PLANE + 1
	linked_pick.layer = 3
	linked_pick.pixel_y = 6
	linked_pick.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_contents += linked_pick

/atom/movable/screen/movable/snap/lockpicking/MouseMove(location, control, params)

	. = ..()

	if(!frozen && linked_pick)
		var/list/new_params = params2list(params)

		var/icon_x = text2num(new_params["icon-x"]) - 240
		var/icon_y = text2num(new_params["icon-y"]) - 240

		icon_y = max(1,icon_y)

		pick_angle = ATAN2(icon_x,icon_y)

		pick_angle = clamp(pick_angle,1,179)

		var/matrix/M = matrix()
		M.Turn(90 - pick_angle)
		linked_pick.transform = M

/atom/movable/screen/movable/snap/lockpicking/proc/autofire_on(client/usercli)
	SIGNAL_HANDLER

	clicker = usercli
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(on_mouse_down))
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEUP, PROC_REF(on_mouse_up))
	RegisterSignal(picker,COMSIG_MOVABLE_MOVED, PROC_REF(close_lockpick))
	RegisterSignal(picker, COMSIG_PARENT_EXAMINE, PROC_REF(mob_detection))

	//checks both for each just incase they switch hands for no reason mid lockpick
	var/obj/item/held_lockmain = picker.get_active_held_item()

	var/obj/item/held_wedgemain = picker.get_inactive_held_item()

	if(istype(held_lockmain, the_lockpick))
		RegisterSignal(the_lockpick, COMSIG_ITEM_DROPPED, PROC_REF(close_lockpick))
	if(istype(held_wedgemain, the_wedge))
		RegisterSignal(the_wedge, COMSIG_ITEM_DROPPED, PROC_REF(close_lockpick))

	START_PROCESSING(SSfastprocess, src)

/atom/movable/screen/movable/snap/lockpicking/proc/on_mouse_down(client/source, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, "middle"))
		return
	if(LAZYACCESS(modifiers, "right")) //right click to close
		close_lockpick()
		return
	if(source.mob.in_throw_mode)
		return
	if(!isturf(source.mob.loc))
		return
	if(get_dist(source.mob, _target) < 2) //Adjacent clicking.
		return

	if(SEND_SIGNAL(src, COMSIG_LOCKPICK_ONMOUSEDOWN, source, _target, location, control, params) & COMPONENT_LOCKPICK_ONMOUSEDOWN_BYPASS)
		return

	source.click_intercept_time = world.time //From this point onwards Click() will no longer be triggered

	INVOKE_ASYNC(src, PROC_REF(move_pick_forward))

/atom/movable/screen/movable/snap/lockpicking/proc/mob_detection(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("They are picking the [picking_object]'s lock!")

/atom/movable/screen/movable/snap/lockpicking/proc/close_lockpick(client/source, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	qdel(src)
	picking_object.being_picked = FALSE

	to_chat(picker, "<span class='notice'>You stop picking the [picking_object.name]s lock.</span>")

/atom/movable/screen/movable/snap/lockpicking/proc/on_mouse_up(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	mouse_status = LOCKPICK_MOUSEUP
	lock_angle -= 10
	process()

/atom/movable/screen/movable/snap/lockpicking/proc/move_pick_forward(control, params)
	SIGNAL_HANDLER
	mouse_status = LOCKPICK_MOUSEDOWN
	lock_angle += 10
	process()

//compilcated circle mathematics about rotations and shit, signals and the like
/atom/movable/screen/movable/snap/lockpicking/process()

	if(!linked_lock || !picker)
		lock_angle = 0
		return FALSE

	switch(mouse_status)
		if(LOCKPICK_MOUSEDOWN)
			lock_angle += 10
		if(LOCKPICK_MOUSEUP)
			lock_angle -= 10

	lock_angle = clamp(lock_angle,0,90)

	var/complete_multiplier = lock_angle/90 // 1 means we've unlocked it.
	angle_distance = abs(sweet_spot-pick_angle) //How far are we, in angular units, are we from the sweet spot?
	//The larger the angle distance, the easier it is to fail.

	var/failing = (angle_distance * complete_multiplier) > (difficulty + (skill_level))

	var/matrix/M = matrix()
	M.Turn(lock_angle)
	animate(linked_lock,transform = M,time=1)

	var/wedge_x = -sin(lock_angle)*8
	var/wedge_y = -cos(lock_angle)*8 + 8

	var/matrix/W = matrix()
	W.Turn(wedge_angle)
	animate(linked_wedge,pixel_x = wedge_x, pixel_y = wedge_y,time=1)
	animate(linked_wedge,transform = M,time=1)

	var/pick_x = sin(lock_angle)*6
	var/pick_y = 6 + cos(lock_angle)*6 - 6
	if(failing)
		if(break_checking_cooldown <= world.time)
			if(prob(10 - skill_level))
				to_chat(picker, "<span class='notice'>Your [the_lockpick] broke!</span>")
				playsound(loc, 'sound/items/LPBreak.ogg', 100 - (15 * skill_level))
				qdel(the_lockpick)
			break_checking_cooldown = world.time + 7 SECONDS

		lock_angle -= 20
		playsound(picker.loc, pick('sound/items/LPtry.ogg', 'sound/items/LPtry2.ogg'), 100 - (15 * skill_level))
	if(lock_angle >= 1 && !failing && !playing_lock_sound)
		play_turn_sound()
		playing_lock_sound = TRUE

	animate(linked_pick,pixel_x = pick_x, pixel_y = pick_y,time= failing ? 0.1 : 1)

	if(complete_multiplier <= 0)
		lock_angle = 0
		return FALSE

	if(complete_multiplier >= 1)
		frozen = TRUE
		if(picking_object)
			picking_object.picked(picker, the_lockpick, skill_level, difficulty)
			qdel(src)
		return FALSE

	return TRUE

/atom/movable/screen/movable/snap/lockpicking/proc/play_turn_sound(timerd)
	//playsound(picker.loc, pick('sound/items/LPTurn1.ogg', 'sound/items/LPTurn2.ogg'), (100 - (15 * skill_level)) * 0.5)
	addtimer(CALLBACK(src, PROC_REF(turn_sound_reset)), 0.7 SECONDS) //stops the spam

/atom/movable/screen/movable/snap/lockpicking/proc/turn_sound_reset()
	playing_lock_sound = FALSE

//obj is told its picked, theoretically can be used for any objects

/obj/proc/picked(mob/living/user, obj/lockpick_used, skill_level, difficulty)

	finish_lockpicking(user)

	if(prob(60 - (skill_level * 10)))
		to_chat(user, "<span class='notice'>Your [lockpick_used.name] broke!</span>")
		playsound(loc, 'sound/items/LPBreak.ogg', 100 - (15 * skill_level))
		qdel(lockpick_used)

	//special cases that need telling what to do due to others shartcode
	var/obj/structure/mineral_door/A = src
	if(istype(A))
		A.locked = FALSE
	lock_tampered = TRUE
	playsound(loc, 'sound/items/LPWin.ogg', 150 - (15 * skill_level))

	var/amt2raise = user.STAINT + (50 / difficulty)
	var/boon = user.mind?.get_learning_boon(/datum/skill/misc/lockpicking)
	user.mind?.adjust_experience(/datum/skill/misc/lockpicking, amt2raise * boon)
	return TRUE

/obj/proc/finish_lockpicking(mob/living/user)

	if(!user)
		return FALSE

	to_chat(user, "<span class='notice'>You pick [name]s lock.</span>")
	user.visible_message(span_notice("[user.name] picks [name]s lock."), span_notice("You pick the [name]s lock."))

	being_picked = FALSE

	return TRUE

/obj/proc/can_be_picked()
	return TRUE
