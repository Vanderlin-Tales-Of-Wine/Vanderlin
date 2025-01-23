//HIDDENDOOR
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
	flags_1 = HEAR_1

	can_add_lock = FALSE
	redstone_structure = TRUE

	var/over_state = "woodover"

	var/speaking_distance = 2
	var/open_phrase = "open sesame"
	var/close_phrase = "close sesame"
	var/lang = /datum/language/common
	var/list/vip
	var/vipmessage
	var/defenses = FALSE

/obj/structure/mineral_door/secret/redstone_triggered(mob/user)
	if(!door_opened)
		force_open()
	else
		force_closed()

/obj/structure/mineral_door/secret/update_icon()

/obj/structure/mineral_door/secret/vault
	vip = list("Monarch", "Consort", "Steward", "Hand")
	vipmessage = "Monarch, Consort, Steward and Hand"

/obj/structure/mineral_door/secret/keep
	vip = list("Monarch", "Consort", "Royal Heir", "Hand")
	vipmessage = "Monarch, Consort, Royal Heir and Hand"

/obj/structure/mineral_door/secret/merchant
	vip = list("Merchant", "Shop Hand")
	vipmessage = "Merchant and Shop Hand"

/obj/structure/mineral_door/secret/wizard //for wizard tower
	vip = list("Court Magician", "Magicians Apprentice", "Archivist")
	vipmessage = "Court Magician, Magicians Apprentice and Archivist"
	//make me look like an arcane door
	//icon = 'icons/turf/walls/stonebrick.dmi'
	//icon_state = "stonebrick" //change me

/obj/structure/mineral_door/secret/rogue //for seedy sewer bar / black market?
	vip = list("Vagabond", "Thug", "Rogue", "Nightmaster", "Nightmistress", "Beggar")
	vipmessage = "Vagabond, Thug, Rogue, Nightmaster, Nightmistress and Beggar"
	lang = /datum/language/thievescant
	icon = 'icons/turf/walls/stonebrick.dmi'
	icon_state = "stonebrick"

/obj/structure/mineral_door/secret/Initialize()
	open_phrase = open_word() + " " + magic_word()
	close_phrase = close_word() + " " + magic_word()
	. = ..()


/obj/structure/mineral_door/secret/door_rattle()
	return

/obj/structure/mineral_door/secret/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	var/mob/living/carbon/human/H = speaker
	if(speaker == src) //door speaking to itself
		return
	var/distance = get_dist(speaker, src)
	if(distance > speaking_distance)
		return
	if(obj_broken) //door is broken
		return
	if(!ishuman(speaker))
		return

	var/message2recognize = sanitize_hear_message(raw_message)
	var/isvip = FALSE
	if (vip.Find(H.job) || vip.Find(H.get_role_title()))
		isvip = TRUE

	if(findtext(message2recognize, "help"))
		say("My commands are: 'help', 'say phrases', 'set open', 'set close', 'set language', 'set defenses'. My masters are: [vipmessage]", )

	if(findtext(message2recognize, "say phrases"))
		if(isvip)
			say("Open: '[open_phrase]', Close: '[close_phrase]'.", language = lang)
		else
			say("I don't know you, "+flavor_name()+".", language = lang)
			triggerdefenses(H, defenses)

	if(findtext(message2recognize, open_phrase))
		if(locked)
			locked = FALSE
			force_open()


	if(findtext(message2recognize, close_phrase))
		if(!locked)
			force_closed()
			locked = TRUE
			say("The way is now closed, "+flavor_name()+".", language = lang)

	if(findtext(message2recognize, "set open"))
		if(isvip || !locked)
			var/new_pass = stripped_input(H, "What should the new open phrase be?")
			open_phrase = new_pass
			say("Open phrase has been set, "+flavor_name()+".", language = lang)
		else
			say("I don't know you, "+flavor_name()+".", language = lang)
			triggerdefenses(H, defenses)


	if(findtext(message2recognize, "set close"))
		if(isvip || !locked)
			var/new_pass = stripped_input(H, "What should the new close phrase be?")
			close_phrase = new_pass
			say("Close phrase has been set, "+flavor_name()+".", language = lang)
		else
			say("I don't know you, "+flavor_name()+".", language = lang)
			triggerdefenses(H, defenses)

	if(findtext(message2recognize, "set language"))
		if(isvip || !locked)
			var/list/langresult = list()
			for(var/ld in GLOB.all_languages)
				if (H.mind.language_holder.has_language(ld))
					langresult.Add(ld)
			if(langresult)
				var/datum/language/language_choice = input("Choose the new language", "Available languages") as anything in langresult
				lang = language_choice
		else
			say("I don't know you, "+flavor_name()+".", language = lang)
			triggerdefenses(H, defenses)

	if(findtext(message2recognize, "set defenses"))
		if(isvip || !locked)
			defenses = !defenses
			if(defenses)
				say("Arcyne defenses activated, "+flavor_name()+".", language = lang)
			else
				say("Arcyne defenses deactivated, "+flavor_name()+".", language = lang)
		else
			say("I don't know you, "+flavor_name()+".", language = lang)
			triggerdefenses(H, defenses)


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


/obj/structure/mineral_door/secret/proc/triggerdefenses(mob/living/carbon/human/H, D)
	if (!D || !H)
		return
	H.electrocute_act(30, src) //just shock
	playsound(src, 'sound/items/stunmace_toggle (3).ogg', 100)

/proc/open_word()
	var/list/open_word = list(
		"open",
		"pass",
		"part",
		"break",
		"reveal",
		"unbar",
		"gape",
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
		"psydon",
		"zizo"
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

/obj/effect/mapping_helpers/secret_door_creator
	name = "Secret door creator: Turns the given wall into a hidden door with a random password. THE VIPS LIST IS THE NAME OF THE JOB OR TITLE!"

	var/turf/open/floor_turf = /turf/open/floor/rogue/wood

	var/redstone_id

	var/datum/language/given_lang = /datum/language/thievescant
	var/list/vips = list("Vagabond", "Thug", "Rogue", "Nightmaster", "Nightmistress", "Beggar")
	var/vip_message = "Vagabond, Thug, Rogue, Nightmaster, Nightmistress and Beggar"

/obj/effect/mapping_helpers/secret_door_creator/Initialize()
	if(!isclosedturf(get_turf(src)))
		return ..()
	var/turf/closed/source_turf = get_turf(src)

	var/obj/structure/mineral_door/secret/new_door = new /obj/structure/mineral_door/secret(source_turf)
	new_door.vip = vips
	new_door.lang = given_lang
	new_door.vipmessage = vip_message

	new_door.icon = source_turf.icon
	new_door.icon_state = source_turf.icon_state
	new_door.name = source_turf.name
	new_door.desc = source_turf.desc
	if(redstone_id)
		new_door.redstone_id = redstone_id
		GLOB.redstone_objs += new_door
		new_door.LateInitialize()

	source_turf.ChangeTurf(floor_turf)
	. = ..()
