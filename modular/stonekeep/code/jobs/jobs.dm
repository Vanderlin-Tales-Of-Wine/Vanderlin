#define ALL_STONEKEEP_PLAYER_RACES		list("Humen", "Half-Elf", "Dark Elf", "Elf", "Dwarf","Tiefling", "Aasimar", "Changeling","Skylancer","Ogrun","Undine")

GLOBAL_LIST_INIT(noble_positions, list(
	"Monarch",
	"Hand",
	"Captain",
	"Steward",
	"Court Magician",
	"Archivist",
	"Merchant",
	"Feldsher",
	"Noble"
	))

GLOBAL_LIST_INIT(garrison_positions, list(
	"Royal Knight",
	"Veteran",
	"Garrison Guard",
	"Men-at-arms",
	"Town Elder",
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
	"Blacksmith",
	"Tailor",
	))

GLOBAL_LIST_INIT(peasant_positions, list(
	"Village Elder",
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
	))

GLOBAL_LIST_INIT(youngfolk_positions, list(
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
