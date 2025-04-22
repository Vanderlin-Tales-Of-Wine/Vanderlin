/datum/round_event_control/eora_marriage_call
	name = "Eora's Marriage Call"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/eora_marriage_call
	weight = 4
	earliest_start = 15 MINUTES
	max_occurrences = 1
	min_players = 30
	allowed_storytellers = list(/datum/storyteller/eora)

/datum/round_event/eora_marriage_call/start()
	var/list/eligible_males = list()
	var/list/eligible_females = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		// Must worship the Ten and be unmarried, clergy is excluded
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine) || (human_mob.mind?.assigned_role.title in GLOB.church_positions) || human_mob.spouse_mob)
			continue

		if(human_mob.gender == MALE)
			eligible_males += human_mob
		else if(human_mob.gender == FEMALE)
			eligible_females += human_mob

	// Select up to 3 people of each gender
	eligible_males = shuffle(eligible_males)
	eligible_females = shuffle(eligible_females)
	if(!length(eligible_males) || !length(eligible_females))
		return

	var/num_pairs = min(3, eligible_males.len, eligible_females.len)

	for(var/i in 1 to num_pairs)
		var/mob/living/carbon/human/male = eligible_males[i]
		var/mob/living/carbon/human/female = eligible_females[i]

		male.add_stress(/datum/stressevent/eora_marriage_call)
		female.add_stress(/datum/stressevent/eora_marriage_call)

		to_chat(male, span_love("Eora's voice whispers in your heart - you feel an irresistible urge to finally get married..."))
		to_chat(male, span_love("The name of [female.real_name] seems to get your heart racing for some reason..."))

		to_chat(female, span_love("Eora's voice whispers in your heart - you feel an irresistible urge to finally get married..."))
		to_chat(female, span_love("The name of [male.real_name] seems to get your heart racing for some reason..."))

		SEND_SOUND(male, 'sound/vo/female/gen/giggle (1).ogg')
		SEND_SOUND(female, 'sound/vo/female/gen/giggle (1).ogg')
