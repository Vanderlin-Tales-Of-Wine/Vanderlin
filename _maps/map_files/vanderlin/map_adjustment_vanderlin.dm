/datum/map_adjustment/template
	map_file_name = "vanderlin.dmm"

/datum/map_adjustment/template/job_change()
	. = ..()
	var/datum/job/consort = SSjob.GetJob("Consort")
	consort?.allowed_races = ALL_PLAYER_RACES_BY_NAME
