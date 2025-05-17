/datum/round_event_control/retainer_recruitment
	name = "Retainer Recruitment"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/retainer_recruitment
	weight = 7
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20
	tags = list(TAG_BOON)

/datum/round_event_control/retainer_recruitment/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/astrata))
			continue
		if(!H.is_noble())
			continue
		return TRUE

	return FALSE

/datum/round_event/retainer_recruitment/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.is_noble())
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/noble = pick(valid_targets)
	noble.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/retainer)

	var/datum/objective/retainer/new_objective = new(owner = noble.mind)
	noble.mind.add_personal_objective(new_objective)

	to_chat(noble, span_userdanger("A HOUSE NEEDS SERVANTS!"))
	to_chat(noble, span_notice("Recruit at least one retainer to serve your household!"))
	SEND_SOUND(noble, 'sound/magic/bless.ogg')

	noble.mind.announce_personal_objectives()
