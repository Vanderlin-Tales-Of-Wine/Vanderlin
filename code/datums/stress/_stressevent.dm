/datum/stressevent
	var/timer
	var/stressadd
	var/desc
	var/time_added
	var/stacks = 0
	var/max_stacks = 1
	var/stressadd_per_extra_stack = 0

/datum/stressevent/proc/get_desc(mob/living/user)
	return desc

/datum/stressevent/proc/can_apply(mob/living/user)
	return TRUE

/datum/stressevent/proc/on_apply(mob/living/user)
	return TRUE

/datum/stressevent/proc/get_stress(mob/living/user)
	return stressadd + ((stacks - 1) * stressadd_per_extra_stack)

/datum/stressevent/test
	timer = 5 SECONDS
	stressadd = 3
	desc = "<span class='red'>This is a positive test event.</span>"

/datum/stressevent/testr
	timer = 5 SECONDS
	stressadd = -3
	desc = "<span class='green'>This is a negative test event.</span>"
