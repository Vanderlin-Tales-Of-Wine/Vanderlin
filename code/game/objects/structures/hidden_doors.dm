GLOBAL_LIST_EMPTY(keep_doors)
GLOBAL_LIST_EMPTY(thieves_guild_doors)

/obj/structure/mineral_door/secret
	hover_color = "#607d65"

	name = "wall"
	desc = ""
	icon_state = "woodhandle" //change me
	openSound = 'sound/foley/doors/creak.ogg'
	closeSound = 'sound/foley/doors/shut.ogg'
	resistance_flags = FLAMMABLE
	max_integrity = 9999
	damage_deflection = 30
	layer = ABOVE_MOB_LAYER
	keylock = FALSE
	locked = TRUE
	icon = 'icons/roguetown/misc/doors.dmi'
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')

	can_add_lock = FALSE
	can_knock = FALSE
	redstone_structure = TRUE

	var/open_phrase = "open sesame"

	var/speaking_distance = 2
	var/lang = /datum/language/common
	var/list/vip
	var/vipmessage

/obj/structure/mineral_door/secret/redstone_triggered(mob/user)
	if(!door_opened)
		force_open()
	else
		force_closed()

/obj/structure/mineral_door/secret/update_icon()

///// DOOR TYPES //////
/obj/structure/mineral_door/secret/vault
	vip = list(
	/datum/job/lord,
	/datum/job/consort,
	/datum/job/steward,
	/datum/job/hand,
	)

/obj/structure/mineral_door/secret/merchant
	vip = list(
		/datum/job/merchant,
	)

/obj/structure/mineral_door/secret/wizard //for wizard tower
	vip = list(
		/datum/job/magician,
		/datum/job/wapprentice,
		/datum/job/archivist,
	)
	//make me look like an arcane door
	//icon = 'icons/turf/walls/stonebrick.dmi'
	//icon_state = "stonebrick" //change me


/obj/structure/mineral_door/secret/Initialize()
	become_hearing_sensitive()
	open_phrase = open_word() + " " + magic_word()
	. = ..()

/obj/structure/mineral_door/secret/door_rattle()
	return

//can't kick it open, but you can kick it closed
/obj/structure/mineral_door/secret/onkick(mob/user)
	if(locked)
		return
	else
		..()

/obj/structure/mineral_door/secret/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	var/mob/living/carbon/human/H = speaker
	if(speaker == src) //door speaking to itself
		return FALSE
	var/distance = get_dist(speaker, src)
	if(distance > speaking_distance)
		return FALSE
	if(obj_broken) //door is broken
		return FALSE
	if(!ishuman(speaker))
		return FALSE

	var/message2recognize = sanitize_hear_message(original_message)
	var/isvip = FALSE
	if(H?.mind.assigned_role in vip)
		isvip = TRUE

	if(isvip)
		if(findtext(message2recognize, "help"))
			send_speech(span_purple("'say phrase'... 'set phrase'..."), 2, src, message_language = lang)
			return TRUE
		if(findtext(message2recognize, "say phrase"))
			send_speech(span_purple("[open_phrase]..."), 2, src, message_language = lang)
			return TRUE
		if(findtext(message2recognize, "set phrase"))
			var/new_pass = stripped_input(H, "What should the new close phrase be?")
			open_phrase = new_pass
			send_speech(span_purple("It is done, [flavor_name()]..."), 2, src, message_language = lang)
			return TRUE

	if(findtext(message2recognize, open_phrase) && locked)
		locked = FALSE
		force_open()
		return TRUE
	else if(findtext(message2recognize, open_phrase) && !locked)
		force_closed()
		locked = TRUE
		return TRUE


/obj/structure/mineral_door/secret/Open(silent = FALSE)
	isSwitchingStates = TRUE
	if(!silent)
		playsound(src, openSound, 90)
	if(!windowed)
		set_opacity(FALSE)
	animate(src, pixel_x = -22, alpha = 50, time = animate_time)
	sleep(animate_time)
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(1)
	update_icon()
	isSwitchingStates = FALSE

	if(close_delay >= 0)
		addtimer(CALLBACK(src, PROC_REF(Close), silent), close_delay)

/obj/structure/mineral_door/secret/force_open()
	isSwitchingStates = TRUE
	if(!windowed)
		set_opacity(FALSE)
	animate(src, pixel_x = -22, alpha = 50, time = animate_time)
	sleep(animate_time)
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(1)
	update_icon()
	isSwitchingStates = FALSE

	if(close_delay >= 0)
		addtimer(CALLBACK(src, PROC_REF(Close)), close_delay)


/obj/structure/mineral_door/secret/force_closed()
	isSwitchingStates = TRUE
	if(!windowed)
		set_opacity(TRUE)
	animate(src, pixel_x = 0, alpha = 255, time = animate_time)
	sleep(animate_time)
	density = TRUE
	door_opened = FALSE
	layer = CLOSED_DOOR_LAYER
	air_update_turf(1)
	update_icon()
	isSwitchingStates = FALSE

/obj/structure/mineral_door/secret/Close(silent = FALSE)
	if(isSwitchingStates || !door_opened)
		return
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T)
		return
	isSwitchingStates = TRUE
	if(!silent)
		playsound(src, closeSound, 90)
	animate(src, pixel_x = 0, alpha = 255, time = animate_time)
	sleep(animate_time)
	density = TRUE
	if(!windowed)
		set_opacity(TRUE)
	door_opened = FALSE
	layer = initial(layer)
	air_update_turf(1)
	update_icon()
	isSwitchingStates = FALSE
	locked = TRUE

/proc/open_word()
	var/list/open_word = list(
		"open",
		"pass",
		"part",
		"break",
		"reveal",
		"unbar",
		"gape", //You wanted this.
		"extend",
		"widen",
		"unfold",
		"rise"
		)
	return pick(open_word)

/proc/close_word()
	var/list/close_word = list(
		"close",
		"seal",
		"still",
		"fade",
		"retreat",
		"consume",
		"envelope",
		"hide",
		"halt",
		"cease",
		"vanish",
		"end"
		)
	return pick(close_word)


/proc/magic_word()
	var/list/magic_word = list(
		"sesame",
		"abyss",
		"fire",
		"wind",
		"earth",
		"shadow",
		"night",
		"oblivion",
		"void",
		"time",
		"dead",
		"decay",
		"gods",
		"ancient",
		"twisted",
		"corrupt",
		"secrets",
		"lore",
		"text",
		"ritual",
		"sacrifice",
		"deal",
		"pact",
		"bargain",
		"ritual",
		"dream",
		"nightmare",
		"vision",
		"hunger",
		"lust",
		"necra",
		"noc",
		"psydon"
		)
	return pick(magic_word)

/proc/flavor_name()
	var/list/flavor_name = list(
		"my friend",
		"love",
		"my love",
		"honey",
		"darling",
		"stranger",
		"companion",
		"mate",
		"you harlot",
		"comrade",
		"fellow",
		"chum",
		"bafoon"
		)
	return pick(flavor_name)

/obj/structure/mineral_door/secret/proc/set_phrase(new_phrase)
	open_phrase = new_phrase

///// KEEP DOORS /////
/obj/structure/mineral_door/secret/keep
	vip = list(
		/datum/job/lord,
		/datum/job/consort,
		/datum/job/prince,
		/datum/job/hand,
		/datum/job/butler,
	)
	icon = 'icons/turf/walls/stonebrick.dmi'
	icon_state = "stonebrick"

/obj/structure/mineral_door/secret/keep/Initialize()
	. = ..()
	if(GLOB.keep_doors.len > 0)
		var/obj/structure/mineral_door/secret/D = GLOB.keep_doors[1]
		open_phrase = D.open_phrase
	GLOB.keep_doors += src

/obj/structure/mineral_door/secret/keep/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	if(!..())
		return FALSE
	var/mob/living/carbon/human/H = speaker

	var/message2recognize = sanitize_hear_message(raw_message)
	if(vip.Find(H?.mind.assigned_role) && findtext(message2recognize, "set phrase"))
		for(var/obj/structure/mineral_door/secret/D in GLOB.keep_doors)
			D.set_phrase(open_phrase)
	return TRUE

/obj/structure/mineral_door/secret/keep/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_KNOWKEEPPLANS))
		. += span_purple("There's a hidden wall here...")

/obj/structure/lever/hidden/keep/feel_button(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_KNOWKEEPPLANS))
		..()

/proc/know_keep_door_password(mob/living/carbon/human/H)
	var/obj/structure/mineral_door/secret/D = GLOB.keep_doors[1]
	to_chat(H, span_notice("The keep's secret doors answer to: '[D.open_phrase]'"))

///// THIEVES GUILD DOORS /////
/obj/structure/mineral_door/secret/thieves_guild
	vip = list(
		///datum/job/thief,
		/datum/job/matron,
	)
	lang = /datum/language/thievescant
	icon = 'icons/turf/walls/stonebrick.dmi'
	icon_state = "stonebrick"

/obj/structure/mineral_door/secret/thieves_guild/Initialize()
	. = ..()
	if(GLOB.thieves_guild_doors.len > 0)
		var/obj/structure/mineral_door/secret/D = GLOB.thieves_guild_doors[1]
		open_phrase = D.open_phrase
	GLOB.thieves_guild_doors += src

/obj/structure/mineral_door/secret/thieves_guild/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	if(!..())
		return FALSE
	var/mob/living/carbon/human/H = speaker

	var/message2recognize = sanitize_hear_message(raw_message)
	if((vip.Find(H?.mind.assigned_role)) && findtext(message2recognize, "set phrase"))
		for(var/obj/structure/mineral_door/secret/D in GLOB.keep_doors)
			D.set_phrase(open_phrase)
	return TRUE


///// MAPPERS /////
/obj/effect/mapping_helpers/secret_door_creator
	name = "Secret door creator: Turns the given wall into a hidden door with a random password."
	icon = 'icons/effects/hidden_door.dmi'
	icon_state = "hidden_door"

	var/redstone_id

	var/obj/structure/mineral_door/secret/door_type = /obj/structure/mineral_door/secret
	var/datum/language/given_lang = /datum/language/thievescant //DEPRECATED
	var/list/vips = list("Thief", "Matron") //DEPRECATED
	var/vip_message = "Thief and Matron" //DEPRECATED

	var/override_floor = TRUE //Will only use the below as the floor tile if true. Source turf have at least 1 baseturf to use false
	var/turf/open/floor_turf = /turf/open/floor/blocks

/obj/effect/mapping_helpers/secret_door_creator/Initialize()
	if(!isclosedturf(get_turf(src)))
		return ..()
	var/turf/closed/source_turf = get_turf(src)
	var/obj/structure/mineral_door/secret/new_door = new door_type(source_turf)

	new_door.icon = source_turf.icon
	new_door.icon_state = source_turf.icon_state
	new_door.smooth = source_turf.smooth
	new_door.canSmoothWith = source_turf.canSmoothWith
	new_door.name = source_turf.name
	new_door.desc = source_turf.desc

	//assigns local smoothing to neighboring walls
	//i can see this causing an issue under very specific door configuration.
	for(var/dir in GLOB.cardinals)
		var/turf/T = get_step(src, dir)
		var/canDoorSmooth = FALSE
		for(var/smoothType in new_door.canSmoothWith)
			if(istype(T, smoothType))
				canDoorSmooth = TRUE
				break
		if(!canDoorSmooth)
			continue
		var/smoothCompatible = FALSE
		var/alreadyAdded = FALSE
		for(var/smoothType in T.canSmoothWith)
			if(istype(source_turf, smoothType))
				smoothCompatible = TRUE
			if(ispath(smoothType, /obj/structure/mineral_door/secret))
				alreadyAdded = TRUE
				break
		if(smoothCompatible && !alreadyAdded)
			T.canSmoothWith += /obj/structure/mineral_door/secret

	if(redstone_id)
		new_door.redstone_id = redstone_id
		GLOB.redstone_objs += new_door
		new_door.LateInitialize()

	if(override_floor || length(source_turf.baseturfs) < 1)
		source_turf.ChangeTurf(floor_turf)
	else
		source_turf.ChangeTurf(source_turf.baseturfs[1])

	. = ..()


/obj/effect/mapping_helpers/secret_door_creator/keep
	name = "Keep Secret Door Creator"
	door_type = /obj/structure/mineral_door/secret/keep
	override_floor = FALSE
