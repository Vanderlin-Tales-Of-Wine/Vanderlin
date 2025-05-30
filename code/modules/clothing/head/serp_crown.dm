/obj/item/clothing/head/crown/serpcrown
	name = "crown of Vanderlin"
	desc = "Heavy is the weight of the crown, and even heavier the responsibility it infers to its wearer."
	icon_state = "serpcrown"
	sellprice = VALUE_EXTREME
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF|UNACIDABLE|INDESTRUCTIBLE
	/// the trapped spirit inside
	var/mob/camera/primogenitor/possessor
	var/obj/structure/fake_machine/camera/builtInCamera = null
	/// portable camera camerachunk update
	var/updating = FALSE

/obj/item/clothing/head/crown/serpcrown/Destroy()
	. = ..()
	QDEL_NULL(builtInCamera)

/obj/item/clothing/head/crown/serpcrown/Initialize()
	. = ..()
	name = "crown of [SSmapping.config.map_name]"
	if(type == /obj/item/clothing/head/crown/serpcrown && !istype(loc, /mob/living/carbon/human/dummy)) //dummies spawn this in character setup
		SSroguemachine.crown = src
	become_hearing_sensitive()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	#ifdef LOWMEMORYMODE
	create_ancestral_spirit() // TESTING PROC, DON'T LEAVE THIS IN FOR LIVE
	#endif

/obj/item/clothing/head/crown/serpcrown/proc/create_ancestral_spirit()
	if(possessor)
		return

	name = "primogenitor " + name
	possessor = new (loc, src)
	builtInCamera = new (src)
	update_camera_location(loc, TRUE)

#define SERPCROWN_CAMERA_BUFFER 5

/obj/item/clothing/head/crown/serpcrown/proc/on_equip(datum/source)
	if(ismob(loc))
		RegisterSignal(loc, COMSIG_MOVABLE_MOVED, PROC_REF(on_wearer_move))
		RegisterSignal(loc, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(on_wearer_unequip))

/obj/item/clothing/head/crown/serpcrown/proc/on_wearer_unequip(datum/source)
	if(ismob(source))
		UnregisterSignal(source, list(COMSIG_MOVABLE_MOVED, COMSIG_MOB_UNEQUIPPED_ITEM))

/obj/item/clothing/head/crown/serpcrown/proc/on_wearer_move(datum/source)
	update_camera_location(loc)

/obj/item/clothing/head/crown/serpcrown/Moved(oldLoc, dir)
	. = ..()
	update_camera_location(oldLoc)

/obj/item/clothing/head/crown/serpcrown/forceMove(atom/destination)
	. = ..()
	//Only bother updating the camera if we actually managed to move
	if(.)
		update_camera_location(destination)

/obj/item/clothing/head/crown/serpcrown/proc/do_camera_update(oldLoc)
	if(!QDELETED(builtInCamera) && oldLoc != get_turf(src))
		GLOB.cameranet.updatePortableCamera(builtInCamera)
	updating = FALSE

/obj/item/clothing/head/crown/serpcrown/proc/update_camera_location(oldLoc, instant = FALSE)
	oldLoc = get_turf(oldLoc)
	if(!QDELETED(builtInCamera) && !updating && oldLoc != get_turf(src))
		if(instant)
			do_camera_update(oldLoc)
		else
			updating = TRUE
			addtimer(CALLBACK(src, PROC_REF(do_camera_update), oldLoc), SERPCROWN_CAMERA_BUFFER)

#undef SERPCROWN_CAMERA_BUFFER

/obj/item/clothing/head/crown/serpcrown/proc/anti_stall()
	src.visible_message(span_warning("[src] crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	if(SSroguemachine.crown == src)
		SSroguemachine.crown = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/clothing/head/crown/serpcrown/surplus
	name = "crown"
	desc = "A replacement for the Crown of Vanderlin, every bit as valid as proof of sovereignity as the original."
	icon_state = "serpcrowno"
	sellprice = VALUE_GOLD_ITEM
