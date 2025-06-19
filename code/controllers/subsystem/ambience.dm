// The subsystem used to play ambience to users every now and then, makes them real excited.
SUBSYSTEM_DEF(ambience)
	name = "Ambience"
	flags = SS_BACKGROUND|SS_NO_INIT
	priority = FIRE_PRIORITY_AMBIENCE
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 1 SECONDS
	///Assoc list of listening client - next ambience time
	var/list/ambience_listening_clients = list()
	var/list/client_old_areas = list()
	///Cache for sanic speed :D
	var/list/currentrun = list()

/datum/controller/subsystem/ambience/fire(resumed)
	if(!resumed)
		currentrun = ambience_listening_clients.Copy()
	var/list/cached_clients = currentrun

	while(cached_clients.len)
		var/client/client_iterator = cached_clients[cached_clients.len]
		cached_clients.len--
		//Check to see if the client exists and isn't held by a new player
		var/mob/client_mob = client_iterator?.mob
		if(isnull(client_iterator) || !client_mob ||isnewplayer(client_mob))
			ambience_listening_clients -= client_iterator
			client_old_areas -= client_iterator
			continue

		//Check to see if the client-mob is in a valid area
		var/area/current_area = get_area(client_mob)
		if(!current_area) //Something's gone horribly wrong
			stack_trace("[key_name(client_mob)] has somehow ended up in nullspace. WTF did you do")
			ambience_listening_clients -= client_iterator
			continue

		if(ambience_listening_clients[client_iterator] > world.time)
			if(!(current_area.forced_ambience && (client_old_areas?[client_iterator] != current_area) && prob(5)))
				continue

		//Run play_ambience() on the client-mob, and set it's ambience cooldown relative to the length of the sound played.
		ambience_listening_clients[client_iterator] = world.time + current_area.play_ambience(client_mob)

		//We REALLY don't want runtimes in SSambience
		if(client_iterator)
			client_old_areas[client_iterator] = current_area

		if(MC_TICK_CHECK)
			return

///Attempts to play an ambient sound to a mob, returning the cooldown in deciseconds
/area/proc/play_ambience(mob/M, sound/override_sound, volume)
	var/sound/new_sound
	if(override_sound)
		new_sound = override_sound
	else if(GLOB.tod == "night" && ambientnight)
		new_sound = pick(ambientnight)
	else if(ambientsounds)
		new_sound = pick(ambientsounds)
	else
		return
	var/turf/T = get_turf(M)

	new_sound = sound(new_sound, channel = CHANNEL_AMBIENCE)
	M.playsound_local(T,
		new_sound,
		volume ? volume : 33,
		TRUE,
		channel = CHANNEL_AMBIENCE
	)

	return rand(min_ambience_cooldown, max_ambience_cooldown) + (new_sound.len * 10) //Convert to deciseconds

/datum/controller/subsystem/ambience/proc/remove_ambience_client(client/to_remove)
	ambience_listening_clients -= to_remove
	client_old_areas -= to_remove
	currentrun -= to_remove
