/* Notes: the global lists copied to the main files, seems to work better when loaded there.
Adventurer and pilgrim jobs - its either untick in config or comment out. I commented out, to maintain most compatibility with Vanderlin.
The regular jobs disabled via the config lines in this document. That method doesnt work with advclass
The new jobs use the /datum/outfit/job/sk typepath for outfits so they are easy to find in the select equipment drop down admin menu (rclick mob for it)
They also use /stonekeep/ in their datum path to be easily sortable.
Some jobs moved to waves, the more exotic/foreign ones mostly belong there to avoid oversaturation.*/


/*
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
	"Beggar",
	"Mercenary"
	))

GLOBAL_LIST_INIT(apprentices_positions, list(
	))
*/


// ===========		DISABLES VANDERLIN JOBS		=====

// SERFS
/datum/job/matron/config_check()
	return FALSE
/datum/job/scribe/config_check()
	return FALSE
/datum/job/artificer/config_check()
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

/datum/job/roguetown/servant/config_check()
	return FALSE



/datum/job/bandit
	allowed_races = ALL_STONEKEEP_PLAYER_RACES
	min_pq = 0
	cmode_music = 'sound/music/cmode/combat_hellish.ogg'

