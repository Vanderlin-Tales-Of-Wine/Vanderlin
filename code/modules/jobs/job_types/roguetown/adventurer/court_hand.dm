/datum/job/roguetown/adventurer/courtagent
	title = "Court Agent"
	total_positions = 2
	spawn_positions = 2
	tutorial = "Whether acquired by merit, shrewd negotiation or fulfilled bounties, you have found yourself under the underhanded employ of the Hand. Fulfill desires and whims of the court that they would rather not be publicly known. Your position is anything but secure, and any mistake can leave you disowned and charged like the petty criminal are. Garrison and Court members know who you are."
	min_pq = 8
	always_show_on_latechoices = FALSE
	job_reopens_slots_on_death = FALSE
	shows_in_list = FALSE
	can_have_apprentices = FALSE


//Hooking in here does not mess with their equipment procs
/datum/job/roguetown/adventurer/courtagent/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	if(L)
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			GLOB.roundstart_court_agents += H.real_name
			..()
