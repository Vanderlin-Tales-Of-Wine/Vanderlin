//PORT OF https://github.com/BeeStation/BeeStation-Hornet/pull/11210
/*
 *	[What does this do?]
 * 		It supports to make adjustment for each map
 *
 * 	[Why don't you just make this with map json file?]
 * 		Some stuff is easy to mistake.
 * 		Being a part of DM files can make a failsafe.
 *
*/
/datum/map_adjustment
	/// key of map_adjustment. It is used to check if '/datum/map_config/var/map_file' is matched
	var/map_file_name = "some_station_map.dmm" // change yourself
	/// Jobs that this station map won't use
	var/list/blacklisted_jobs

/// called on map config is loaded.
/// You need to change things manually here.
/datum/map_adjustment/proc/on_mapping_init()
	return

/// called upon job datum creation. Override this proc to change.
/datum/map_adjustment/proc/job_change()
	for(var/title in blacklisted_jobs)
		change_job_position(title, 0)
		var/datum/job/job = SSjob.GetJob(title)
		job.job_flags &= ~(JOB_NEW_PLAYER_JOINABLE)
	return

/// * job_name<datum/job/J>: 			Datum of the job that's being adjusted
/// * spawn_positions<number>: 			Sets the number of roundstart positions of this job, when spawning at roundstart
/// * total_positions<number, null>: 	Sets the number of total positions of this job, including roundstart and latejoin
/datum/map_adjustment/proc/change_job_position(datum/job/J, spawn_positions, total_positions = null)
	SHOULD_NOT_OVERRIDE(TRUE) // no reason to override for a new behaviour
	PROTECTED_PROC(TRUE) // no reason to call this outside of /map_adjustment datum. (I didn't add _underbar_ to the proc name because you use this frequently)
	if(!J)
		CRASH("Failed to adjust a job position: [J.title]")
	J.spawn_positions = spawn_positions
	J.total_positions = total_positions || spawn_positions
