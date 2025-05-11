/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/rosewood
	map_file_name = "rosewood.dmm"
	var/list/knifeEars = list(
		/datum/job/lord,
		/datum/job/prince,
		/datum/job/hand,
		/datum/job/captain
	)

/datum/map_adjustment/rosewood/job_change()
	. = ..()
	for(var/jobType in knifeEars)
		var/datum/job/J = SSjob.GetJobType(jobType)
		J?.allowed_races = list(
			"Elf",
			"Half-Elf"
		)
