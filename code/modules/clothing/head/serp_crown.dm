/obj/item/clothing/head/crown/serpcrown
	name = "crown of Vanderlin"
	desc = "Heavy is the weight of the crown, and even heavier the responsibility it infers to its wearer."
	icon_state = "serpcrown"
	sellprice = VALUE_EXTREME
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF|UNACIDABLE|INDESTRUCTIBLE
	/// the trapped spirit inside
	var/mob/camera/ancestral_spirit/possessor
	var/obj/structure/fake_machine/camera/builtInCamera = null
	/// portable camera camerachunk update
	var/updating = FALSE

/obj/item/clothing/head/crown/serpcrown/Destroy()
	. = ..()
	QDEL_NULL(builtInCamera)

/obj/item/clothing/head/crown/serpcrown/proc/create_ancestral_spirit()
	if(possessor)
		return

	possessor = new (loc, src)
	builtInCamera = new (src)
	update_camera_location(get_turf(loc))

#define SERPCROWN_CAMERA_BUFFER 5

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

/obj/item/clothing/head/crown/serpcrown/proc/update_camera_location(oldLoc)
	oldLoc = get_turf(oldLoc)
	if(!QDELETED(builtInCamera) && !updating && oldLoc != get_turf(src))
		updating = TRUE
		addtimer(CALLBACK(src, PROC_REF(do_camera_update), oldLoc), SERPCROWN_CAMERA_BUFFER)

#undef SERPCROWN_CAMERA_BUFFER

/obj/item/clothing/head/crown/serpcrown/Initialize()
	. = ..()
	name = "crown of [SSmapping.config.map_name]"
	if(type == /obj/item/clothing/head/crown/serpcrown && !istype(loc, /mob/living/carbon/human/dummy)) //dummies spawn this in character setup
		SSroguemachine.crown = src
	become_hearing_sensitive()
	#ifdef LOWMEMORYMODE
	create_ancestral_spirit() // TESTING PROC, DON'T LEAVE THIS IN FOR LIVE
	#endif

/obj/item/clothing/head/crown/serpcrown/proc/anti_stall()
	src.visible_message(span_warning("[src] crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	SSroguemachine.crown = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/clothing/head/crown/serpcrown/surplus
	name = "crown"
	desc = "A replacement for the Crown of Vanderlin, every bit as valid as proof of sovereignity as the original."
	icon_state = "serpcrowno"
	sellprice = VALUE_GOLD_ITEM
