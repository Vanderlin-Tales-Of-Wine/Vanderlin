GLOBAL_LIST_INIT(noble_positions, list(
	/datum/job/lord::title,
	/datum/job/consort::title,
	/datum/job/hand::title,
	/datum/job/prince::title,
	/datum/job/captain::title,
	/datum/job/steward::title,
	/datum/job/magician::title,
	/datum/job/archivist::title,
	/datum/job/merchant::title,
	/datum/job/feldsher::title,
	/datum/job/apothecary::title,
	/datum/job/minor_noble::title,
	/datum/job/stonekeep/hand::title,
	/datum/job/stonekeep/steward::title,
	/datum/job/stonekeep/butler::title,
	/datum/job/stonekeep/courtwizard::title,
	/datum/job/stonekeep/jester::title,
))
GLOBAL_PROTECT(noble_positions)

GLOBAL_LIST_INIT(garrison_positions, list(
	/datum/job/royalguard::title,
	/datum/job/veteran::title,
	/datum/job/guardsman::title,
	/datum/job/men_at_arms::title,
	/datum/job/jailor::title,
	/datum/job/dungeoneer::title,
	/datum/job/mayor::title,
	/datum/job/forestwarden::title,
	/datum/job/forestguard::title,
	/datum/job/stonekeep/sheriff::title,
	/datum/job/stonekeep/garrison::title,
	/datum/job/stonekeep/squire::title,
	))
GLOBAL_PROTECT(garrison_positions)

GLOBAL_LIST_INIT(church_positions, list(
	/datum/job/monk::title,
	/datum/job/undertaker::title,
	// "Confessor",
	/datum/job/priest::title,
	/datum/job/stonekeep/acolyte::title,
	/datum/job/stonekeep/gravekeeper::title,
	/datum/job/stonekeep/inquisitor::title,
	/datum/job/stonekeep/templar::title,
	/datum/job/stonekeep/adept::title,
	))
GLOBAL_PROTECT(church_positions)

GLOBAL_LIST_INIT(serf_positions, list(
	/datum/job/innkeep::title,
	/datum/job/armorsmith::title,
	/datum/job/weaponsmith::title,
	/datum/job/tailor::title,
	/datum/job/alchemist::title,
	/datum/job/artificer::title,
	/datum/job/matron::title,
	/datum/job/physicker::title,
	/datum/job/scribe::title,
	/datum/job/stonekeep/guildmaster::title,
	/datum/job/stonekeep/merchant::title,
	/datum/job/stonekeep/innkeep::title,
	/datum/job/stonekeep/blacksmith::title,
	/datum/job/stonekeep/feldsher::title,
	/datum/job/stonekeep/mason::title,
	/datum/job/stonekeep/nitemaster::title,
	))
GLOBAL_PROTECT(serf_positions)

GLOBAL_LIST_INIT(peasant_positions, list(
	/datum/job/farmer::title,
	/datum/job/miner::title,
	/datum/job/grabber::title,
	/datum/job/butcher::title,
	/datum/job/cook::title,
	/datum/job/carpenter::title,
	/datum/job/jester::title,
	/datum/job/hunter::title,
	/datum/job/fisher::title,
	/datum/job/cheesemaker::title,
	/datum/job/butler::title,
	/datum/job/mercenary::title,
	/datum/job/bard::title,
	/datum/job/prisoner::title,
	/datum/job/vagrant::title,
	/datum/job/adventurer::title,
	/datum/job/pilgrim::title,
	/datum/job/bandit::title,
	/datum/job/stonekeep/beggar::title,
	/datum/job/stonekeep/cook::title,
	/datum/job/stonekeep/elder::title,
	/datum/job/stonekeep/mercenary::title,
	/datum/job/stonekeep/nitemaiden::title,
	/datum/job/stonekeep/soilson::title,
	/datum/job/stonekeep/stevedore::title,
	/datum/job/stonekeep/weaver::title,
	/datum/job/stonekeep/woodsman::title,
))
GLOBAL_PROTECT(peasant_positions)

GLOBAL_LIST_INIT(apprentices_positions, list(
	/datum/job/squire::title,
	/datum/job/bapprentice::title,
	/datum/job/wapprentice::title,
	/datum/job/servant::title,
	/datum/job/orphan::title,
	))
GLOBAL_PROTECT(apprentices_positions)

GLOBAL_LIST_INIT(youngfolk_positions, list(
	/datum/job/innkeep_son::title,
	/datum/job/orphan::title,
	/datum/job/churchling::title,
))
GLOBAL_PROTECT(youngfolk_positions)

GLOBAL_LIST_INIT(allmig_positions, list(
	"Adventurer",
	"Pilgrim",
	))

GLOBAL_LIST_INIT(roguewar_positions, list(
	"Adventurer",
	))

GLOBAL_LIST_INIT(test_positions, list(
	"Tester",
	))

GLOBAL_LIST_EMPTY(job_assignment_order)

/proc/get_job_assignment_order()
	var/list/sorting_order = list()
	sorting_order += GLOB.noble_positions
	sorting_order += GLOB.garrison_positions
	sorting_order += GLOB.church_positions
	sorting_order += GLOB.serf_positions
	sorting_order += GLOB.peasant_positions
	sorting_order += GLOB.apprentices_positions
	sorting_order += GLOB.allmig_positions
	sorting_order += GLOB.youngfolk_positions
	return sorting_order

GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_TOWNER = list("titles" = peasant_positions | apprentices_positions | youngfolk_positions | serf_positions),
	EXP_TYPE_NOBLE = list("titles" = noble_positions),
	EXP_TYPE_CHURCH = list("titles" = church_positions),
	EXP_TYPE_GUARDS = list("titles" = garrison_positions),
	EXP_TYPE_ADVENTURER = list("titles" = allmig_positions),
))

GLOBAL_LIST_INIT(exp_specialmap, list(
	EXP_TYPE_LIVING = list(), // all living mobs
	EXP_TYPE_ANTAG = list(),
	EXP_TYPE_GHOST = list(), // dead people, observers
))
GLOBAL_PROTECT(exp_jobsmap)
GLOBAL_PROTECT(exp_specialmap)


//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(job_title)
	if(!job_title)
		return list()

	for(var/datum/job/job as anything in SSjob.joinable_occupations)
		if(job.title == job_title)
			return job.department_head //this is a list
