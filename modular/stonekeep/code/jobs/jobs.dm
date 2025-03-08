#define SK_LORD			(1<<0)
#define SK_CONSORT		(1<<1)
#define SK_HAND			(1<<2)
#define SK_STEWARD		(1<<3)
#define SK_WIZARD		(1<<4)
#define SK_ARCHIVIST	(1<<5)
#define SK_SERVANT		(1<<6)
#define SK_JESTER		(1<<7)

#define SK_SHERIFF		(1<<0)
#define SK_VETERAN		(1<<1)
#define SK_GUARD		(1<<2)
#define SK_SQUIRE		(1<<3)

#define SK_PRIEST		(1<<0)
#define SK_ACOLYTE		(1<<1)
#define SK_GRAVETENDER	(1<<2)
#define SK_TEMPLAR		(1<<3)
#define SK_INQUISITOR	(1<<4)
#define SK_ADEPT		(1<<5)

#define SK_MERCHANT		(1<<0)
#define SK_INNKEEP		(1<<1)
#define SK_FELDSHER		(1<<2)
#define SK_BLACKSMITH	(1<<3)
#define SK_MASON		(1<<4)
#define SK_NITEMAN		(1<<5)

#define SK_ELDER		(1<<0)
#define SK_SOILSON		(1<<1)
#define SK_COOK			(1<<2)
#define SK_WEAVER		(1<<3)
#define SK_WOODSMAN		(1<<4)
#define SK_STEVEDORE	(1<<5)
#define SK_BATHMAID		(1<<6)
#define SK_BEGGAR		(1<<7)

#define SK_MERCENARY	(1<<0)
#define SK_ADVENTURER	(1<<1)
#define SK_PILGRIM		(1<<2)
#define SK_BANDIT		(1<<3)

#define LORD_ORDER			1
#define CONSORT_ORDER		2
#define HAND_ORDER			3
#define STEWARD_ORDER		4
#define COURTWIZARD_ORDER	6
#define ARCHIVIST_ORDER		7
#define SERVANT_ORDER		8
#define JESTER_ORDER		9

#define SHERIFF_ORDER		11
#define VETERAN_ORDER		12
#define GARRISON_ORDER		13
#define SQUIRE_ORDER		15

#define PRIEST_ORDER		21
#define ACOLYTE_ORDER		22
#define GRAVEKEEPER_ORDER	23
#define TEMPLAR_ORDER		24
#define INQUISITOR_ORDER	27
#define ADEPT_ORDER			28

#define MERCHANT_ORDER		31
#define INNKEEP_ORDER		33
#define FELDSHER_ORDER		34
#define BLACKSMITH_ORDER	35
#define MASON_ORDER			36
#define NITEMAN_ORDER		38

#define ELDER_ORDER			41
#define SOILSON_ORDER		43
#define COOK_ORDER			44
#define WEAVER_ORDER		45
#define WOODSMAN_ORDER		46
#define STEVEDORE_ORDER		47
#define BATHMAID_ORDER		48
#define BEGGAR_ORDER		49

#define MERCENARY_ORDER		51
#define PILGRIM_ORDER		53
#define ADVENTURER_ORDER	55


GLOBAL_LIST_INIT(noble_positions, list(
	"Monarch",
	"Hand",
	"Captain",
	"Steward",
	"Court Magician",
	"Archivist",
	"Servant",
	"Jester",
	"Noble"
	))

GLOBAL_LIST_INIT(garrison_positions, list(
	"Sheriff",
	"Royal Knight",
	"Veteran",
	"Garrison Guard",
	"Men-at-arms",
	"Town Elder",
	"Squire",
	))

GLOBAL_LIST_INIT(church_positions, list(
	"Priest",
	"Acolyte",
	"Gravekeeper",
	"Gravetender",
	"Confessor",
	"Templar",
	"Inquisitor",
	"Adept"
	))

GLOBAL_LIST_INIT(serf_positions, list(
	"Merchant",
	"Innkeep",
	"Feldsher",
	"Blacksmith",
	"Weaver",
	"Niteman",
	))

GLOBAL_LIST_INIT(peasant_positions, list(
	"Village Elder",
	"Soilson",
	"Stevedore",
	"Cook",
	"Woodsman",
	"Prisoner",
	"Beggar"
	))

GLOBAL_LIST_INIT(apprentices_positions, list(
	"Mercenary",
	"Adventurer",
	"Pilgrim",
	))



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
/datum/job/hunter/config_check()
	return FALSE
/datum/job/miner/config_check()
	return FALSE
/datum/job/bapprentice/config_check()
	return FALSE
/datum/job/squire/config_check()
	return FALSE
/datum/job/servant/config_check()
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
/datum/advclass/pilgrim/bard
	maximum_possible_slots = 0
/datum/advclass/pilgrim/blacksmith
	maximum_possible_slots = 0
/datum/advclass/pilgrim/briar
	maximum_possible_slots = 0
/datum/advclass/pilgrim/cheesemaker
	maximum_possible_slots = 0
/datum/advclass/pilgrim/fisher
	maximum_possible_slots = 0
/datum/advclass/pilgrim/hunter
	maximum_possible_slots = 0
/datum/advclass/pilgrim/huntress
	maximum_possible_slots = 0
/datum/advclass/pilgrim/noble
	maximum_possible_slots = 0
/datum/advclass/pilgrim/peasant
	maximum_possible_slots = 0
/datum/advclass/pilgrim/physicker
	maximum_possible_slots = 0
/datum/advclass/pilgrim/weaver
	maximum_possible_slots = 0
/datum/advclass/pilgrim/woodcutter
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/grenzelhoft
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/mastercarpenter
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/masterchef
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/fishermaster
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/grandmastermason
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/minermaster
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/farmermaster
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/masterblacksmith
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/zybantine
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/preacher
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/merchant
	maximum_possible_slots = 0
/datum/advclass/pilgrim/rare/crusader
	maximum_possible_slots = 0
/datum/advclass/combat/heartfelthand
	maximum_possible_slots = 0
/datum/advclass/combat/heartfeltlord
	maximum_possible_slots = 0
/datum/advclass/sk_carpenter
	maximum_possible_slots = 0
/datum/job/roguetown/servant
	total_positions = 0
	spawn_positions = 0

/datum/job/adventurer
	allowed_races = ALL_STONEKEEP_PLAYER_RACES
	display_order = ADVENTURER_ORDER
	flag = SK_ADVENTURER
	department_flag = APPRENTICES
	total_positions = 8
	spawn_positions = 8
/datum/job/pilgrim
	allowed_races = ALL_STONEKEEP_PLAYER_RACES
	display_order = PILGRIM_ORDER
	flag = SK_PILGRIM
	department_flag = APPRENTICES
	total_positions = 10
	spawn_positions = 10
