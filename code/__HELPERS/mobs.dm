/proc/random_human_blood_type()
	var/static/list/human_blood_type_weights = list(
		/datum/blood_type/human/o_minus = 4,
		/datum/blood_type/human/o_plus = 36,
		/datum/blood_type/human/a_minus = 28,
		/datum/blood_type/human/a_plus = 3,
		/datum/blood_type/human/b_minus = 20,
		/datum/blood_type/human/b_plus = 1,
		/datum/blood_type/human/ab_minus = 5,
		/datum/blood_type/human/ab_plus = 1
	)

	return pickweight(human_blood_type_weights)

/proc/random_eye_color()
	switch(pick(20;"brown",20;"hazel",20;"grey",15;"blue",15;"green",1;"amber",1;"albino"))
		if("brown")
			return "630"
		if("hazel")
			return "542"
		if("grey")
			return pick("666","777","888","999","aaa","bbb","ccc")
		if("blue")
			return "36c"
		if("green")
			return "060"
		if("amber")
			return "fc0"
		if("albino")
			return pick("c","d","e","f") + pick("0","1","2","3","4","5","6","7","8","9") + pick("0","1","2","3","4","5","6","7","8","9")
		else
			return "000"

/proc/random_underwear(gender)
	if(!GLOB.underwear_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear, GLOB.underwear_list, GLOB.underwear_m, GLOB.underwear_f)
	switch(gender)
		if(MALE)
			return pick(GLOB.underwear_m)
		if(FEMALE)
			return pick(GLOB.underwear_f)
		else
			return pick(GLOB.underwear_list)

/proc/random_undershirt(gender)
	if(!GLOB.undershirt_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/undershirt, GLOB.undershirt_list, GLOB.undershirt_m, GLOB.undershirt_f)
	switch(gender)
		if(MALE)
			return pick(GLOB.undershirt_m)
		if(FEMALE)
			return pick(GLOB.undershirt_f)
		else
			return pick(GLOB.undershirt_list)

/proc/random_socks()
	if(!GLOB.socks_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/socks, GLOB.socks_list)
	return pick(GLOB.socks_list)

/proc/random_backpack()
	return pick(GLOB.backpacklist)

/proc/random_features()
	if(!GLOB.tails_list_human.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/human, GLOB.tails_list_human)
	if(!GLOB.tails_list_lizard.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/lizard, GLOB.tails_list_lizard)
	if(!GLOB.snouts_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts, GLOB.snouts_list)
	if(!GLOB.horns_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/horns, GLOB.horns_list)
	if(!GLOB.ears_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, GLOB.ears_list)
	if(!GLOB.frills_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/frills, GLOB.frills_list)
	if(!GLOB.spines_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/spines, GLOB.spines_list)
	if(!GLOB.legs_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/legs, GLOB.legs_list)
	if(!GLOB.body_markings_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/body_markings, GLOB.body_markings_list)
	if(!GLOB.wings_list.len)
		init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, GLOB.wings_list)
	//For now we will always return none for tail_human and ears.
	return(list("mcolor" = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F"),"ethcolor" = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)], "tail_lizard" = pick(GLOB.tails_list_lizard), "tail_human" = "None", "wings" = "None", "snout" = pick(GLOB.snouts_list), "horns" = pick(GLOB.horns_list), "ears" = "None", "frills" = pick(GLOB.frills_list), "spines" = pick(GLOB.spines_list), "body_markings" = pick(GLOB.body_markings_list), "legs" = "Normal Legs", "caps" = pick(GLOB.caps_list)))

/proc/random_hairstyle(gender)
	switch(gender)
		if(MALE)
			return pick(GLOB.hairstyles_male_list)
		if(FEMALE)
			return pick(GLOB.hairstyles_female_list)
		else
			return pick(GLOB.hairstyles_list)

/proc/random_facial_hairstyle(gender)
	switch(gender)
		if(MALE)
			return pick(GLOB.facial_hairstyles_male_list)
		if(FEMALE)
			return "None"
		else
			return pick(GLOB.facial_hairstyles_list)

/proc/random_unique_name(gender, attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		if(gender==FEMALE)
			. = capitalize(pick(GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
		else
			. = capitalize(pick(GLOB.first_names_male)) + " " + capitalize(pick(GLOB.last_names))

		if(!findname(.))
			break

/proc/random_unique_lizard_name(gender, attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(lizard_name(gender))

		if(!findname(.))
			break
/proc/random_unique_ethereal_name(attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(ethereal_name())

		if(!findname(.))
			break


GLOBAL_LIST_INIT(skin_tones, sortList(list(
	"skin1" = "ffe0d1",
	"skin2" = "fcccb3",
	"skin3" = "e8b59b"
	)))

/proc/random_skin_tone()
	return GLOB.skin_tones[pick(GLOB.skin_tones)]

GLOBAL_LIST_INIT(haircolor, sortList(list(
	"black" = "#0a0707",
	"brown" = "#362e25",
	"blonde" = "#dfc999",
	"red" = "#a34332"
	)))


/proc/random_haircolor()
	return GLOB.haircolor[pick(GLOB.haircolor)]

GLOBAL_LIST_INIT(oldhc, sortList(list(
	"pale - golden" = "f0eab6",
	"pale - dust" = "ded0af",
	"gray - decay" = "6a6a6a",
	"gray - silvered" = "687371",
	"gray - elderly" = "9e9e9e",
	"gray - ashen" = "404040",
	"white - ancient" = "c9c9c9",
	"white - mythic" = "f4f4f4"
	)))

/proc/skintone2hex(skin_tone)
	. = 0
	switch(skin_tone)
		if("caucasian1")
			. = "ffe0d1"
		if("caucasian2")
			. = "fcccb3"
		if("caucasian3")
			. = "e8b59b"
		if("latino")
			. = "d9ae96"
		if("mediterranean")
			. = "c79b8b"
		if("asian1")
			. = "ffdeb3"
		if("asian2")
			. = "e3ba84"
		if("arab")
			. = "c4915e"
		if("indian")
			. = "b87840"
		if("african1")
			. = "754523"
		if("african2")
			. = "471c18"
		if("albino")
			. = "fff4e6"
		if("orange")
			. = "ffc905"
		if("skin1")
			. = "ffe0d1"
		if("skin2")
			. = "fcccb3"
		if("skin3")
			. = "e8b59b"

/proc/haircolor2hex(haircolor)
	. = 0
	switch(haircolor)
		if("cave black")
			. = "#0a0707"
		if("mud brown")
			. = "#362e25"
		if("pale blonde")
			. = "#dfc999"
		if("dusk red")
			. = "#a34332"
		if("decay grey")
			. = "#6a6a6a"


GLOBAL_LIST_EMPTY(species_list) //why is this here lmao

//some additional checks as a callback for for do_afters that want to break on losing health or on the mob taking action
/mob/proc/break_do_after_checks(list/checked_health, check_clicks)
	if(check_clicks && next_move > world.time)
		return FALSE
	return TRUE

//pass a list in the format list("health" = mob's health var) to check health during this
/mob/living/break_do_after_checks(list/checked_health, check_clicks)
	if(islist(checked_health))
		if(health < checked_health["health"])
			return FALSE
		checked_health["health"] = health
	return ..()

/**
 * Timed action involving one mob user. Target is optional. \
 * Checks that `user` does not move, change hands, get stunned, etc. for the
 * given `delay`. Returns `TRUE` on success or `FALSE` on failure.
 *
 * @param {mob} user - The mob performing the action. \
 * @param {number} delay - The time in deciseconds. Use the SECONDS define for readability. `1 SECONDS` is 10 deciseconds. \
 * @param {atom} target - The target of the action. This is where the progressbar will display. \
 * @param {flag} timed_action_flags - Flags to control the behavior of the timed action. \
 * @param {boolean} progress - Whether to display a progress bar / cogbar. \
 * @param {datum/callback} extra_checks - Additional checks to perform before the action is executed. \
 *
 * ~~@param {string} interaction_key - The assoc key under which the do_after is capped, with max_interact_count being the cap. Interaction key will default to target if not set.~~ \
 * ~~@param {number} max_interact_count - The maximum amount of interactions allowed.~~
 */
/proc/do_after(mob/user, delay, atom/target = null, timed_action_flags = NONE, progress = TRUE, datum/callback/extra_checks)
	if(!user)
		return FALSE
	if(!isnum(delay))
		CRASH("do_after was passed a non-number delay: [delay || "null"].")
	/* */
	if(user.doing)
		return FALSE
	user.doing = TRUE
	/* */

	var/atom/user_loc = user.loc
	var/atom/target_loc = target?.loc

	var/drifting = FALSE
	if(!user.Process_Spacemove(0) && user.inertia_dir)
		drifting = TRUE

	var/holding = user.get_active_held_item()

	if(!(timed_action_flags & IGNORE_SLOWDOWNS))
		delay *= user.do_after_coefficent()

	var/datum/progressbar/progbar
	if(progress)
		progbar = new(user, delay, target || user)

	SEND_SIGNAL(user, COMSIG_DO_AFTER_BEGAN)

	var/endtime = world.time + delay
	var/starttime = world.time
	. = TRUE
	while(world.time < endtime)
		stoplag(1)

		if(!QDELETED(progbar))
			progbar.update(world.time - starttime)

		if(drifting && !user.inertia_dir)
			drifting = FALSE
			user_loc = user.loc

		if(QDELETED(user) \
			|| (!user.doing) /* V: */ \
			|| (!(timed_action_flags & IGNORE_USER_LOC_CHANGE) && !drifting && user.loc != user_loc) \
			|| (!(timed_action_flags & IGNORE_HELD_ITEM) && user.get_active_held_item() != holding) \
			|| (!(timed_action_flags & IGNORE_INCAPACITATED) && HAS_TRAIT(user, TRAIT_INCAPACITATED)) \
			|| (extra_checks && !extra_checks.Invoke()))
			. = FALSE
			break

		if(target && (user != target) && \
			(QDELETED(target) \
			|| (!(timed_action_flags & IGNORE_TARGET_LOC_CHANGE) && target.loc != target_loc)))
			. = FALSE
			break

	/* */
	user.doing = FALSE
	/* */
	if(!QDELETED(progbar))
		progbar.end_progress()

	SEND_SIGNAL(user, COMSIG_DO_AFTER_ENDED)

/mob/proc/do_after_coefficent() // This gets added to the delay on a do_after, default 1
	. = 1
	return

/proc/is_species(A, species_datum)
	. = FALSE
	if(ishuman(A))
		var/mob/living/carbon/human/H = A
		if(H.dna && istype(H.dna.species, species_datum))
			. = TRUE

/proc/spawn_atom_to_turf(spawn_type, target, amount, admin_spawn=FALSE, list/extra_args)
	var/turf/T = get_turf(target)
	if(!T)
		CRASH("attempt to spawn atom type: [spawn_type] in nullspace")

	var/list/new_args = list(T)
	if(extra_args)
		new_args += extra_args
	var/atom/X
	for(var/j in 1 to amount)
		X = new spawn_type(arglist(new_args))
		if (admin_spawn)
			X.flags_1 |= ADMIN_SPAWNED_1
	return X //return the last mob spawned

/proc/spawn_and_random_walk(spawn_type, target, amount, walk_chance=100, max_walk=3, always_max_walk=FALSE, admin_spawn=FALSE)
	var/turf/T = get_turf(target)
	var/step_count = 0
	if(!T)
		CRASH("attempt to spawn atom type: [spawn_type] in nullspace")

	var/list/spawned_mobs = new(amount)

	for(var/j in 1 to amount)
		var/atom/movable/X

		if (istype(spawn_type, /list))
			var/mob_type = pick(spawn_type)
			X = new mob_type(T)
		else
			X = new spawn_type(T)

		if (admin_spawn)
			X.flags_1 |= ADMIN_SPAWNED_1

		spawned_mobs[j] = X

		if(always_max_walk || prob(walk_chance))
			if(always_max_walk)
				step_count = max_walk
			else
				step_count = rand(1, max_walk)

			for(var/i in 1 to step_count)
				step(X, pick(NORTH, SOUTH, EAST, WEST))

	return spawned_mobs

// Displays a message in deadchat, sent by source. Source is not linkified, message is, to avoid stuff like character names to be linkified.
// Automatically gives the class deadsay to the whole message (message + source)
/proc/deadchat_broadcast(message, source=null, mob/follow_target=null, turf/turf_target=null, speaker_key=null, message_type=DEADCHAT_REGULAR)
	message = "<span class='deadsay'>[source]<span class='linkify'>[message]</span></span>"
	for(var/mob/M in GLOB.player_list)
		var/datum/preferences/prefs
		if(M.client.prefs)
			prefs = M.client.prefs
		else
			prefs = new

		var/override = FALSE
		if(M.client.holder && (prefs.chat_toggles & CHAT_DEAD))
			override = TRUE
		if(HAS_TRAIT(M, TRAIT_SIXTHSENSE))
			override = TRUE
		if(isnewplayer(M) && !override)
			continue
		if(M.stat != DEAD && !override)
			continue
		if(speaker_key && (speaker_key in prefs.ignoring))
			continue

		switch(message_type)
			if(DEADCHAT_DEATHRATTLE)
				if(prefs.toggles & DISABLE_DEATHRATTLE)
					continue
			if(DEADCHAT_ARRIVALRATTLE)
				if(prefs.toggles & DISABLE_ARRIVALRATTLE)
					continue

		if(isobserver(M))
			var/rendered_message = message

			if(follow_target)
//				var/F
//				if(turf_target)
//					F = FOLLOW_OR_TURF_LINK(M, follow_target, turf_target)
//				else
//					F = FOLLOW_LINK(M, follow_target)
//				rendered_message = "[F] [message]"
				rendered_message = "[message]"
			else if(turf_target)
//				var/turf_link = TURF_LINK(M, turf_target)
//				rendered_message = "[turf_link] [message]"
				rendered_message = "[message]"

			to_chat(M, rendered_message)
		else
			to_chat(M, message)

//Used in chemical_mob_spawn. Generates a random mob based on a given gold_core_spawnable value.
/proc/create_random_mob(spawn_location, mob_class = HOSTILE_SPAWN)
	var/static/list/mob_spawn_meancritters = list() // list of possible hostile mobs
	var/static/list/mob_spawn_nicecritters = list() // and possible friendly mobs

	if(mob_spawn_meancritters.len <= 0 || mob_spawn_nicecritters.len <= 0)
		for(var/T in typesof(/mob/living/simple_animal))
			var/mob/living/simple_animal/SA = T
			switch(initial(SA.gold_core_spawnable))
				if(HOSTILE_SPAWN)
					mob_spawn_meancritters += T
				if(FRIENDLY_SPAWN)
					mob_spawn_nicecritters += T

	var/chosen
	if(mob_class == FRIENDLY_SPAWN)
		chosen = pick(mob_spawn_nicecritters)
	else
		chosen = pick(mob_spawn_meancritters)
	var/mob/living/simple_animal/C = new chosen(spawn_location)
	return C

/proc/passtable_on(target, source)
	var/mob/living/L = target
	if (!HAS_TRAIT(L, TRAIT_PASSTABLE) && L.pass_flags & PASSTABLE)
		ADD_TRAIT(L, TRAIT_PASSTABLE, INNATE_TRAIT)
	ADD_TRAIT(L, TRAIT_PASSTABLE, source)
	L.pass_flags |= PASSTABLE

/proc/passtable_off(target, source)
	var/mob/living/L = target
	REMOVE_TRAIT(L, TRAIT_PASSTABLE, source)
	if(!HAS_TRAIT(L, TRAIT_PASSTABLE))
		L.pass_flags &= ~PASSTABLE

/proc/dance_rotate(atom/movable/AM, datum/callback/callperrotate, set_original_dir=FALSE)
	set waitfor = FALSE
	var/originaldir = AM.dir
	for(var/i in list(NORTH,SOUTH,EAST,WEST,EAST,SOUTH,NORTH,SOUTH,EAST,WEST,EAST,SOUTH))
		if(!AM)
			return
		AM.setDir(i)
		callperrotate?.Invoke()
		sleep(1)
	if(set_original_dir)
		AM.setDir(originaldir)
