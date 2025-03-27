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
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 20
	spawn_positions = 20
	min_pq = -20
	banned_leprosy = FALSE
	bypass_lastclass = TRUE
	outfit = null
	outfit_female = null
	advclass_cat_rolls = list(CTAG_PILGRIM = 15)

/datum/job/stonekeep
	min_pq = 0
	faction = FACTION_STATION
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	bypass_lastclass = TRUE
	whitelist_req = FALSE
	can_have_apprentices = FALSE
	allowed_sexes = list(MALE, FEMALE)
