/obj/effect/proc_holder/spell/aoe_turf/knock
	name = "Knock"
	desc = ""
	base_icon_state = ""
	action_icon_state = "knock"
	overlay_state = "knock"
	school = "transmutation"
	recharge_time = 100
	invocation = "AULIE OXIN FIERA"
	invocation_type = "whisper"
	range = 3
	cooldown_min = 300 //20 deciseconds reduction per rank
	attunements = list(
		/datum/attunement/aeromancy = 0.2,
	)

/obj/effect/proc_holder/spell/aoe_turf/knock/cast(list/targets,mob/user = usr)
//	SEND_SOUND(user, sound('sound/blank.ogg'))
	playsound(get_turf(user), 'sound/misc/chestopen.ogg', 100, TRUE, -1)
	for(var/turf/T in targets)
		for(var/obj/structure/door/door in T.contents)
			INVOKE_ASYNC(src, PROC_REF(open_door), door)
		for(var/obj/structure/closet/C in T.contents)
			INVOKE_ASYNC(src, PROC_REF(open_closet), C)

/obj/effect/proc_holder/spell/aoe_turf/knock/proc/open_door(obj/structure/door/door)
	if(istype(door))
		door.force_open()
		door.locked = FALSE

/* Assuming force_open is a correct method for both wooden and other doors.
Check your door implementation to ensure this method exists and is appropriate.*/

/obj/effect/proc_holder/spell/aoe_turf/knock/proc/open_closet(obj/structure/closet/C)
	C.locked = FALSE
	C.open()
