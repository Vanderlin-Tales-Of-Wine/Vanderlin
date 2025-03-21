/* Notes: the global lists copied to the main files, seems to work better when loaded there.

Adventurer and pilgrim jobs - Vanderlin ones commented out in their files. Its either that, untick them, or make new duplicate adv job branches.
This causes some conflicts when updated, but its easy to solve. Just accept both changes if it happens, make sure file is still commented out, done.
Migrant waves : same as above

The regular jobs disabled via the config lines in this document. That method doesnt work with advclasss or migrant waves.
The new jobs use the /datum/outfit/job/sk typepath for outfits so they are easy to find in the select euipment drop down admin menu (rclick mob for it)
They also use /stonekeep/ in their datum path to be easily sortable.

Some jobs moved to waves, the more exotic/foreign ones mostly belong there to avoid oversaturation.

Logic of social groupings: The job groupings are consistently by social grouping now, as in the social unit the role belongs to. A butler might not be a noble but they will belong
to the Court social group in all respects and thats the only useful grouping. Only drawback is one has to keep an eye on mechanics relating to these groupings, should they be added by someone else.
Thus the jobs in the noble_positions are labeeld as court and will primarily listen to the Monarch and then the Hand. The garrison boss is the Sheriff. The Temple boss is the Priest.
The word serf means something completely different than what the original maker of this list thought, its used for the burghers now, the "middle-class", the tradesmen, the guilds members.
*/

/*
GLOBAL_LIST_INIT(noble_positions, list(
	"Monarch",
	"Hand",
	"Captain",
	"Steward",
	"Court Magician",
	"Archivist",
	"Butler",
	"Jester",
	"Noble",
	"Court Wizard"
	))

GLOBAL_LIST_INIT(garrison_positions, list(
	"Sheriff",
	"Royal Knight",
	"Veteran",
	"Garrison Guard",
	"Man-at-arms",
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
 	"Mason",
	"Weaver",
	"Nitemaster",
	))

GLOBAL_LIST_INIT(peasant_positions, list(
	"Village Elder",
	"Soilson",
	"Stevedore",
	"Cook",
	"Woodsman",
	"Nitemaiden",
	"Prisoner",
	"Mercenary",
	"Beggar"
	))

GLOBAL_LIST_INIT(apprentices_positions, list(
	"Servant"
	))

GLOBAL_LIST_INIT(youngfolk_positions, list(
	"Prisoner",
))

GLOBAL_LIST_INIT(allmig_positions, list(
	"Adventurer",
	"Pilgrim"
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

/datum/job/adventurer
	flag = SK_ADVENTURER	// STONEKEEP EDIT
	department_flag = OUTSIDERS	// STONEKEEP EDIT
	allowed_races = ALL_STONEKEEP_PLAYER_RACES	// STONEKEEP EDIT
	display_order = ADVENTURER_ORDER	// STONEKEEP EDIT
	min_pq = 0	// STONEKEEP EDIT
	selection_color = "#d7d8df"		// STONEKEEP EDIT

	department_flag = OUTSIDERS	// STONEKEEP EDIT
	allowed_races = ALL_STONEKEEP_PLAYER_RACES	// STONEKEEP EDIT
	tutorial = "Hero of nothing, adventurer by trade. \
	Whatever led you to this fate is up to the wind to decide, \
	and you've never fancied yourself for much other than the thrill. \
	Someday your pride is going to catch up to you, \
	and you're going to find out why most men don't end up in the annals of history."

	display_order = ADVENTURER_ORDER	// STONEKEEP EDIT
	min_pq = 0	// STONEKEEP EDIT

/datum/job/bandit
	allowed_races = ALL_STONEKEEP_PLAYER_RACES
	min_pq = 0
	cmode_music = 'sound/music/cmode/combat_hellish.ogg'

/datum/job/pilgrim
	flag = SK_PILGRIM	// STONEKEEP EDIT
	department_flag = OUTSIDERS	// STONEKEEP EDIT
	allowed_races = ALL_STONEKEEP_PLAYER_RACES	// STONEKEEP EDIT
	tutorial = "Pilgrims begin far outside of the town and must reach it in order to ply their various trades. Sometimes, they build their own settlements and enjoy the terrible nature."
	display_order = PILGRIM_ORDER	// STONEKEEP EDIT

/datum/job/stonekeep
	min_pq = 0
	faction = FACTION_STATION
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	bypass_lastclass = TRUE
	whitelist_req = FALSE
	can_have_apprentices = FALSE
	allowed_sexes = list(MALE, FEMALE)
