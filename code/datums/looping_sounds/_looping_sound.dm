GLOBAL_LIST_EMPTY(created_sound_groups)
/datum/sound_group
	var/list/reserved_channels = list()
	var/channel_count = 1
	var/last_iter = 1

/datum/sound_group/New()
	. = ..()
	for(var/channel = 1 to channel_count)
		reserved_channels |= SSsounds.reserve_sound_channel(src)

// /datum/sound_group/torches
// 	channel_count = 150

/datum/sound_group/fire_loop
	channel_count = 150

/datum/sound_group/instruments
	channel_count = 20 // definitely more than enough

/*
	parent	(the source of the sound)			The source the sound comes from

	mid_sounds		(list or soundfile)		Since this can be either a list or a single soundfile you can have random sounds. May contain further lists but must contain a soundfile at the end.
	mid_length		(num)					The length to wait between playing mid_sounds

	start_sound		(soundfile)				Played before starting the mid_sounds loop
	start_length	(num)					How long to wait before starting the main loop after playing start_sound

	end_sound		(soundfile)				The sound played after the main loop has concluded

	chance			(num)					Chance per loop to play a mid_sound
	volume			(num)					Sound output volume
	max_loops		(num)					The max amount of loops to run for.
	direct			(bool)					If true plays directly to provided atoms instead of from them
*/
/datum/looping_sound
	var/atom/parent
	var/mid_sounds
	var/mid_length = 1
	var/start_sound
	var/start_length
	var/end_sound = 'sound/blank.ogg'
	var/chance
	var/volume = 100
	var/vary = FALSE
	var/max_loops = 0
	var/cur_num_loops = 0
	var/direct
	var/extra_range = 0
	var/falloff
	var/frequency
	var/stopped = TRUE
	var/persistent_loop = FALSE //we stay in the client's played_loops so we keep updating volume even when out of range
	var/cursound
	var/list/thingshearing = list()
	var/ignore_walls = TRUE
	var/timerid
	/// Has the looping started yet?
	var/loop_started = FALSE
	///our sound channel
	var/channel
	var/datum/sound_group/sound_group
	var/starttime // A world.time snapshot of when the loop was started.

/datum/looping_sound/New(_parent, start_immediately=FALSE, _direct=FALSE, _channel = 0)
	if(islist(_parent))
		WARNING("A looping sound datum was created using a list, this is no longer allowed please change to a parent")
		return

	var/datum/sound_group/group
	if(sound_group)
		for(var/datum/sound_group/listed in GLOB.created_sound_groups)
			if(listed.type != sound_group)
				continue
			group = listed
		if(!group)
			group = new sound_group
			GLOB.created_sound_groups |= group
		if(group.last_iter == group.channel_count)
			group.last_iter = 1

		var/picked_channel = group.reserved_channels[group.last_iter]
		group.last_iter++
		channel = picked_channel

	parent = _parent
	direct = _direct

	if(_channel)
		channel = _channel
	if(!channel)
		channel = SSsounds.reserve_sound_channel(src)

	if(start_immediately)
		start()

/datum/looping_sound/Destroy()
	stop()
	parent = null
	thingshearing.Cut()
	return ..()

/datum/looping_sound/proc/start(atom/on_behalf_of)
	stopped = FALSE
	if(on_behalf_of)
		set_parent(on_behalf_of)
	loop_started = TRUE
//	if(timerid)
//		return
	on_start()

/datum/looping_sound/proc/stop(null_parent)
	if(!stopped)
		stopped = TRUE
		if(null_parent)
			set_parent(null)
		on_stop()
		loop_started = FALSE
//		if(!timerid)
//			return
//		deltimer(timerid)
//		timerid = null

/datum/looping_sound/proc/sound_loop()
//	START_PROCESSING(SSsoundloopers, src)
	if(!cursound)
		cursound = get_sound(starttime)

	if(max_loops && cur_num_loops >= max_loops)
		cur_num_loops = 0
		stop()
		return 1
	else if(max_loops)
		cur_num_loops++

	if(stopped)
		stop()
		return 1
	if(!chance || prob(chance))
		play(cursound)
//	if(!timerid)
//		timerid = addtimer(CALLBACK(src, PROC_REF(sound_loop), world.time), mid_length, TIMER_CLIENT_TIME | TIMER_STOPPABLE | TIMER_LOOP)

/datum/looping_sound/proc/play(soundfile)
	var/sound/S = soundfile
	if(!istype(S))
		S = sound(soundfile)
	if(direct)
		S.channel = channel
		S.volume = volume
	var/atom/thing = parent

	starttime = world.time

	if(direct)
		if(ismob(thing))
			var/mob/mob = thing
			mob.playsound_local(mob, S, volume, vary, frequency, falloff, repeat = src, channel = channel)
	else
		var/list/R = playsound(thing, S, volume, vary, extra_range, falloff, frequency, channel, ignore_walls = ignore_walls, repeat = src)
		if(!R || !R.len)
			R = list()
		for(var/mob/M as anything in thingshearing)
			if(!M.client)
				thingshearing -= M
				continue
			if(!(M in R) || M.IsSleeping())// they are out of range
				var/list/L = M.client.played_loops[src]
				if(L)
					var/sound/SD = L["SOUND"]
					if(SD)
						if(persistent_loop)
							L["MUTESTATUS"] = TRUE
							L["VOL"] = 0
							M.mute_sound(SD)
							//M.play_ambience()
						else
							M.client.played_loops -= src
							thingshearing -= M
							M.stop_sound_channel(SD.channel)
			else
				on_hear_sound(M)

/datum/looping_sound/proc/on_hear_sound(mob/M)
	return

/datum/looping_sound/proc/get_sound(starttime, _mid_sounds)
	. = _mid_sounds || mid_sounds
	while(!isfile(.) && !isnull(.))
		. = pickweight(.)

/datum/looping_sound/proc/on_start()
	var/start_wait = 0
	if(start_sound)
		play(start_sound)
		start_wait = start_length
	addtimer(CALLBACK(src, PROC_REF(begin_loop)), start_wait, TIMER_CLIENT_TIME)
	if(persistent_loop && !(src in GLOB.persistent_sound_loops))
		GLOB.persistent_sound_loops |= src

/datum/looping_sound/proc/begin_loop()
	sound_loop()
	START_PROCESSING(SSsoundloopers, src)

/datum/looping_sound/proc/on_stop()
//	play(end_sound)
	STOP_PROCESSING(SSsoundloopers, src)
	if(persistent_loop)
		GLOB.persistent_sound_loops -= src
	if(!direct)
		for(var/mob/M as anything in thingshearing)
			if(M.client)
				var/list/L = M.client.played_loops[src]
				if(L)
					var/sound/SD = L["SOUND"]
					if(SD)
						M.stop_sound_channel(SD.channel)
					M.client.played_loops -= src
					thingshearing -= M
	else
		var/mob/P = parent
		if(P && P.client)
			P.stop_sound_channel(channel) //This is mostly used for weather
/*
/mob/proc/stop_all_loops()
	if(client)
		for(var/datum/looping_sound/X in client.played_loops)
			var/list/L = client.played_loops[X]
			var/sound/SD = L["SOUND"]
			if(SD)
				stop_sound_channel(SD.channel)
			client.played_loops -= X
			X.thingshearing -= src
*/

/datum/looping_sound/proc/set_parent(new_parent)
	if(parent)
		UnregisterSignal(parent, COMSIG_PARENT_QDELETING)
	parent = new_parent
	if(parent)
		RegisterSignal(parent, COMSIG_PARENT_QDELETING, PROC_REF(handle_parent_del))

/datum/looping_sound/proc/handle_parent_del(datum/source)
	SIGNAL_HANDLER
	set_parent(null)
