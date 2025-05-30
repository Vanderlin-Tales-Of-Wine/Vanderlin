GLOBAL_LIST_INIT(unlinked_dungeon_entries, list())
GLOBAL_LIST_INIT(dungeon_entries, list())
GLOBAL_LIST_INIT(dungeon_exits, list())

/obj/structure/dungeon_entry/center
	dungeon_id = "center"

/obj/structure/dungeon_entry
	name = "The Tomb of Matthios"
	desc = ""

	icon = 'icons/roguetown/misc/portal.dmi'
	icon_state = "portal"
	density = TRUE
	anchored = TRUE
	pixel_x = -48
	max_integrity = 0
	bound_width = 128
	appearance_flags = NONE
	opacity = TRUE
	obj_flags = INDESTRUCTIBLE

	var/dungeon_id
	var/list/dungeon_exits = list()
	var/can_enter = TRUE

/obj/structure/dungeon_entry/Initialize()
	. = ..()
	GLOB.dungeon_entries |= src
	if(dungeon_id)
		for(var/obj/structure/dungeon_exit/exit as anything in GLOB.dungeon_exits)
			if(exit.dungeon_id != dungeon_id)
				continue
			dungeon_exits |= exit
			exit.entry = src
			GLOB.unlinked_dungeon_entries -= src
		return
	GLOB.unlinked_dungeon_entries |= src
	shuffle_inplace(GLOB.dungeon_exits)
	for(var/obj/structure/dungeon_exit/exit as anything in GLOB.dungeon_exits)
		if(exit.dungeon_id)
			continue
		dungeon_exits |= exit
		exit.entry = src
		GLOB.unlinked_dungeon_entries -= src
		break

/obj/structure/dungeon_entry/Destroy()
	for(var/obj/structure/dungeon_exit/exit as anything in dungeon_exits)
		exit.entry = null
	dungeon_exits.Cut()
	GLOB.dungeon_entries -= src
	GLOB.unlinked_dungeon_entries -= src
	return ..()

/obj/structure/dungeon_entry/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	use(user)

/obj/structure/dungeon_entry/attackby(obj/item/W, mob/user, params)
	return use(user)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/dungeon_entry/attack_ghost(mob/dead/observer/user)
	use(user, TRUE)
	return ..()

/obj/structure/dungeon_entry/proc/use(mob/user, is_ghost)
	if(!is_ghost && !can_enter)
		return
	if(!length(dungeon_exits))
		return
	var/atom/exit = pick(dungeon_exits)

	if(!is_ghost)
		playsound(src, 'sound/foley/ladder.ogg', 100, FALSE)
		if(!do_after(user, 3 SECONDS, src))
			return
	movable_travel_z_level(user, get_turf(exit))

/obj/structure/dungeon_exit
	name = "dungeon exit"
	desc = ""

	obj_flags = INDESTRUCTIBLE

	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "ladder10"

	var/dungeon_id
	var/obj/structure/dungeon_entry/entry

/obj/structure/dungeon_exit/Initialize()
	. = ..()
	GLOB.dungeon_exits |= src

	if(dungeon_id)
		for(var/obj/structure/dungeon_entry/exit as anything in GLOB.dungeon_entries)
			if(exit.dungeon_id != dungeon_id)
				continue
			exit.dungeon_exits |= src
			entry = exit
			GLOB.unlinked_dungeon_entries -= exit
		return
	shuffle_inplace(GLOB.unlinked_dungeon_entries)
	for(var/obj/structure/dungeon_entry/exit as anything in GLOB.unlinked_dungeon_entries)
		if(exit.dungeon_id)
			continue
		exit.dungeon_exits |= src
		entry = exit
		GLOB.unlinked_dungeon_entries -= exit
		break

/obj/structure/dungeon_exit/Destroy()
	entry = null
	GLOB.dungeon_exits -= src
	return ..()

/obj/structure/dungeon_exit/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	use(user)

/obj/structure/dungeon_exit/attackby(obj/item/W, mob/user, params)
	return use(user)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/dungeon_exit/attack_ghost(mob/dead/observer/user)
	use(user, TRUE)
	return ..()

/obj/structure/dungeon_exit/proc/use(mob/user, is_ghost)
	if(!entry)
		return
	if(!is_ghost)
		playsound(src, 'sound/foley/ladder.ogg', 100, FALSE)
		if(!do_after(user, 3 SECONDS, src))
			return
	movable_travel_z_level(user, get_turf(entry))
