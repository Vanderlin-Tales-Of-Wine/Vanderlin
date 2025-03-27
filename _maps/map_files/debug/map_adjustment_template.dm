/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/template
	map_file_name = "roguetest.dmm"
	blacklisted_jobs = list(
		/datum/job/forestguard,
		/datum/job/vagrant
		)

/datum/map_adjustment/template/job_change()
	. = ..()
	change_job_position(/datum/job/consort, 2)
