/datum/map_adjustment/template
	map_file_name = "vanderlin.dmm"

/datum/map_adjustment/template/job_change()
	. = ..()
	var/datum/job/consort = SSjob.GetJobType(/datum/job/consort)
	consort?.allowed_races = ALL_PLAYER_RACES_BY_NAME
