
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
	"Blacksmith",
	"Tailor",
	"Alchemist",
	"Artificier",
	"Matron",
	"Physicker",
	"Scribe",
	))

GLOBAL_LIST_INIT(peasant_positions, list(
	"Soilson",
	"Hammerite",
	"Stevedore",
	"Butcher",
	"Cook",
	"Carpenter",
	"Jester",
	"Jaegward",
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



// ===========		DISABLES VANDERLIN JOBS		=====

// SERFS
/datum/job/matron/config_check()
	return FALSE
/datum/job/scribe/config_check()
	return FALSE
/datum/job/artificer/config_check()
	return FALSE
/datum/job/roguetown/alchemist/config_check()
	return FALSE
/datum/job/physicker/config_check()
	return FALSE
/datum/job/armorsmith/config_check()
	return FALSE
/datum/job/weaponsmith/config_check()
	return FALSE
/datum/job/innkeep/config_check()
	return FALSE
/datum/job/tailor/config_check()
	return FALSE
/datum/advclass/pilgrim/blacksmith/config_check()
	return FALSE

// TEMPLE
/datum/job/priest/config_check()
	return FALSE
/datum/job/monk/config_check()
	return FALSE
/datum/job/undertaker/config_check()
	return FALSE
/datum/job/inquisitor/config_check()
	return FALSE
/datum/job/templar/config_check()
	return FALSE
/datum/job/adept/config_check()
	return FALSE

// YOUNG
/datum/job/innkeep_son/config_check()
	return FALSE
/datum/job/orphan/config_check()
	return FALSE
/datum/job/churchling/config_check()
	return FALSE

// GARRISON
/datum/job/royalguard/config_check()
	return FALSE
/datum/job/veteran/config_check()
	return FALSE
/datum/job/guardsman/config_check()
	return FALSE
/datum/job/men_at_arms/config_check()
	return FALSE
/datum/job/jailor/config_check()
	return FALSE
/datum/job/dungeoneer/config_check()
	return FALSE
/datum/job/mayor/config_check()
	return FALSE
/datum/job/forestwarden/config_check()
	return FALSE
/datum/job/forestguard/config_check()
	return FALSE
// PEASANT
/datum/job/farmer/config_check()
	return FALSE
/datum/job/grabber/config_check()
	return FALSE
/datum/job/butcher/config_check()
	return FALSE
/datum/job/cook/config_check()
	return FALSE
/datum/job/carpenter/config_check()
	return FALSE
/datum/job/jester/config_check()
	return FALSE
/datum/job/fisher/config_check()
	return FALSE
/datum/job/cheesemaker/config_check()
	return FALSE
/datum/job/butler/config_check()
	return FALSE
/datum/job/mercenary/config_check()
	return FALSE
/datum/job/bard/config_check()
	return FALSE
/datum/job/prisoner/config_check()
	return FALSE
/datum/job/vagrant/config_check()
	return FALSE
/datum/job/adventurer/config_check()
	return FALSE
/datum/job/pilgrim/config_check()
	return FALSE
/datum/job/bandit/config_check()
	return FALSE

// NOBLE
/datum/job/lord/config_check()
	return FALSE
/datum/job/consort/config_check()
	return FALSE
/datum/job/hand/config_check()
	return FALSE
/datum/job/prince/config_check()
	return FALSE
/datum/job/captain/config_check()
	return FALSE
/datum/job/steward/config_check()
	return FALSE
/datum/job/magician/config_check()
	return FALSE
/datum/job/archivist/config_check()
	return FALSE
/datum/job/merchant/config_check()
	return FALSE
/datum/job/feldsher/config_check()
	return FALSE
/datum/job/apothecary/config_check()
	return FALSE
/datum/job/minor_noble/config_check()
	return FALSE
