GLOBAL_LIST_INIT(noble_positions, list(
	"Monarch",
	"Consort",
	"Hand",
	"Prince",
	"Captain",
	"Steward",
	"Court Magician",
	"Archivist",
	"Merchant",
	"Feldsher",
	"Apothecary",
	"Noble"
	))

GLOBAL_LIST_INIT(garrison_positions, list(
	"Royal Knight",
	"Veteran",
	"Garrison Guard",
	"Men-at-arms",
	"Jailor",
	"Dungeoneer",
	"Town Elder",
	"Forest Warden",
	"Forest Guard"
	))

GLOBAL_LIST_INIT(church_positions, list(
	"Priest",
	"Acolyte",
	"Gravetender",
	"Inquisitor",
	"Confessor",
	"Templar",
	"Adept"
	))

GLOBAL_LIST_INIT(serf_positions, list(
	"Innkeep",
	"Armorer",
	"Weaponsmith",
	"Tailor",
	"Alchemist",
	"Artificier",
	"Matron",
	"Physicker",
	"Scribe",
	))

GLOBAL_LIST_INIT(peasant_positions, list(
	"Soilson",
	"Miner",
	"Stevedore",
	"Butcher",
	"Cook",
	"Carpenter",
	"Jester",
	"Hunter",
	"Fisher",
	"Cheesemaker",
	"Butler",
	"Mercenary",
	"Bard",
	"Prisoner",
	"Beggar",
	"Adventurer",
	"Pilgrim",
	"Bandit",
))

GLOBAL_LIST_INIT(apprentices_positions, list(
	"Squire",
	"Smithy Apprentice",
	"Magician's Apprentice",
	"Servant",
	"Orphan"
	))

GLOBAL_LIST_INIT(youngfolk_positions, list(
	"Innkeepers Son",
	"Orphan",
	"Churchling",
))

GLOBAL_LIST_INIT(allmig_positions, list(
	"Adventurer",
	"Pilgrim"
	))

GLOBAL_LIST_INIT(roguewar_positions, list(
	"Adventurer"
	))

GLOBAL_LIST_INIT(roguefight_positions, list(
	"Red Captain",
	"Red Caster",
	"Red Ranger",
	"Red Fighter",
	"Green Captain",
	"Green Caster",
	"Green Ranger",
	"Green Fighter"
	))

GLOBAL_LIST_INIT(test_positions, list(
	"Tester"
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
	EXP_TYPE_GHOST = list() // dead people, observers
))
GLOBAL_PROTECT(exp_jobsmap)
GLOBAL_PROTECT(exp_specialmap)


//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(job_title)
	if(!job_title)
		return list()

	for(var/datum/job/J in SSjob.occupations)
		if(J.title == job_title)
			return J.department_head //this is a list
