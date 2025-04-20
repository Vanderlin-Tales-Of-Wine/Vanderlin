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
	for(var/jobType in blacklisted_jobs)
		change_job_position(jobType, 0)
		var/datum/job/J = SSjob.GetJobType(jobType)
		J?.job_flags &= ~(JOB_NEW_PLAYER_JOINABLE)
	return

/**
 * job_type`</datum/job/J>`: Type of the job that's being adjusted \
 * spawn_positions`<number, null>`: Roundstart positions, if null will not be adjusted \
 * total_positions`<number, null>`: Latejoin positions, if null will use spawn_positions
 **/
/datum/map_adjustment/proc/change_job_position(job_type, spawn_positions = null, total_positions = null)
	SHOULD_NOT_OVERRIDE(TRUE) // no reason to override for a new behaviour
	PROTECTED_PROC(TRUE) // no reason to call this outside of /map_adjustment datum. (I didn't add _underbar_ to the proc name because you use this frequently)
	var/datum/job/adjusting_job = SSjob.GetJobType(job_type)
	if(!adjusting_job)
		CRASH("Failed to adjust a job position: [job_type]")
	if(isnull(spawn_positions) && isnull(total_positions))
		CRASH("called without any positions to set")

	if(isnum(spawn_positions))
		adjusting_job.spawn_positions = spawn_positions

	if(isnull(total_positions)) //we can have spawn slots but no total slots, see lord
		total_positions = spawn_positions
	if(isnum(total_positions))
		adjusting_job.total_positions = total_positions
