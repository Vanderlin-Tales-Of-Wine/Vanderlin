
SUBSYSTEM_DEF(mobs)
	name = "Mobs"
	priority = FIRE_PRIORITY_MOBS
	flags = SS_KEEP_TIMING | SS_NO_INIT
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()
	var/static/list/clients_by_zlevel[][]
	var/static/list/dead_players_by_zlevel[][] = list(list()) // Needs to support zlevel 1 here, MaxZChanged only happens when z2 is created and new_players can login before that.
	var/static/list/cubemonkeys = list()

	var/static/list/matthios_mobs = list()
	var/list/matthios = list()

/datum/controller/subsystem/mobs/stat_entry()
	..("P:[GLOB.mob_living_list.len]")

/datum/controller/subsystem/mobs/proc/MaxZChanged()
	if (!islist(clients_by_zlevel))
		clients_by_zlevel = new /list(world.maxz,0)
		dead_players_by_zlevel = new /list(world.maxz,0)
	while (clients_by_zlevel.len < world.maxz)
		clients_by_zlevel.len++
		clients_by_zlevel[clients_by_zlevel.len] = list()
		dead_players_by_zlevel.len++
		dead_players_by_zlevel[dead_players_by_zlevel.len] = list()

/datum/controller/subsystem/mobs/proc/MaxZDec()
	if (!islist(clients_by_zlevel))
		clients_by_zlevel = new /list(world.maxz,0)
		dead_players_by_zlevel = new /list(world.maxz,0)
	while (clients_by_zlevel.len > world.maxz)
		clients_by_zlevel.len--
		dead_players_by_zlevel.len--


/datum/controller/subsystem/mobs/fire(resumed = 0)
	var/seconds = wait * 0.1
	if (!resumed)
		src.currentrun = GLOB.mob_living_list.Copy()
		src.currentrun -= matthios_mobs

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	var/times_fired = src.times_fired
	while(currentrun.len)
		var/mob/living/L = currentrun[currentrun.len]
		currentrun.len--
		if(!L || QDELETED(L))
			GLOB.mob_living_list.Remove(L)
			continue
		if(L.stat == DEAD)
			L.DeadLife()
		else
			L.Life(seconds, times_fired)
		if (MC_TICK_CHECK)
			return

	if(!length(matthios))
		matthios = matthios_mobs.Copy()

	while(matthios.len)
		var/mob/living/L = matthios[matthios.len]
		matthios.len--
		if(!L || QDELETED(L))
			GLOB.mob_living_list.Remove(L)
			continue
		if(L.stat == DEAD)
			L.DeadLife()
		else
			L.Life(seconds, times_fired)
		if (TICK_CHECK_LOW)
			return
