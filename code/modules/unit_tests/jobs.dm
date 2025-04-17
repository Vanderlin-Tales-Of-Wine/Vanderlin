/datum/unit_test/job_sanity/Run()
	if(!length(SSjob.all_occupations))
		SSjob.SetupOccupations()
	for(var/datum/job/this_job as anything in SSjob.all_occupations)
		if( \
			(this_job.job_flags & JOB_NEW_PLAYER_JOINABLE) || \
			(this_job.spawn_positions) || \
			((this_job.total_positions > 0) || (this_job.total_positions != -1)) \
		)
			// Spawnable jobs must have a unique, valid ID //
			if(!this_job.id)
				TEST_FAIL("job [this_job.type] can be joined as but has no id")
				continue
			if(SSjob.id_occupations[this_job.id] != this_job)
				TEST_FAIL("job [this_job.type] is using an id that is already taken by [SSjob.id_occupations[this_job.id].type]")
				continue
			var/static/regex/forbidden_sql_characters = regex("\[\\\\\\'\\\"\\;\]", "")
			if(forbidden_sql_characters.Find(this_job.id))
				TEST_FAIL("job [this_job.type] has invalid characters for SQL")
				continue
