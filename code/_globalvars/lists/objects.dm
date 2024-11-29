GLOBAL_LIST_EMPTY(portals)					        //list of all /obj/effect/portal
GLOBAL_LIST_EMPTY(shuttle_caller_list)  		    //list of all communication consoles and AIs, for automatic shuttle calls when there are none.
GLOBAL_LIST_EMPTY(machines)					        //NOTE: this is a list of ALL machines now. The processing machines list is SSmachine.processing !
GLOBAL_LIST_EMPTY(navigation_computers)				//list of all /obj/machinery/computer/camera_advanced/shuttle_docker
GLOBAL_LIST_EMPTY(syndicate_shuttle_boards)	        //important to keep track of for managing nukeops war declarations.
GLOBAL_LIST_EMPTY(navbeacons)					    //list of all bot nagivation beacons, used for patrolling.


GLOBAL_LIST(chemical_reactions_list)				//list of all /datum/chemical_reaction datums. Used during chemical reactions
GLOBAL_LIST(chemical_reagents_list)				//list of all /datum/reagent datums indexed by reagent id. Used by chemistry stuff
GLOBAL_LIST_EMPTY(crafting_recipes)				//list of all table craft recipes
GLOBAL_LIST_EMPTY(anvil_recipes)				//list of all anvil crafted recipes
GLOBAL_LIST_EMPTY(artificer_recipes)			//list of all artificer recipes
GLOBAL_LIST_EMPTY(alch_grind_recipes)			//list of all alchemy grinding recipes
GLOBAL_LIST_EMPTY(alch_cauldron_recipes)		//list of all alchemy cauldron recipes
GLOBAL_LIST_EMPTY(poi_list)					//list of points of interest for observe/follow
GLOBAL_LIST_EMPTY(pinpointer_list)			//list of all pinpointers. Used to change stuff they are pointing to all at once.
GLOBAL_LIST_EMPTY(zombie_infection_list) 		// A list of all zombie_infection organs, for any mass "animation"
GLOBAL_LIST_EMPTY(ladders)
GLOBAL_LIST_EMPTY(trophy_cases)
GLOBAL_LIST_EMPTY(bard_buffs)               // List of buffs by bard songs


GLOBAL_LIST_EMPTY(mob_spawners) 		    // All mob_spawn objects

GLOBAL_LIST_INIT(rod_jobs, list(
	"Garrison Guard",
	"Captain",
	"Dungeoneer",
	"Royal Guard",
	"Veteran",
	"Squire",
	"Mayor",
	"Servant",
	"Steward",
	"Queen",
	"King",
	"Prince",
	"Hand",
	"Court Magician",
	"Butler",
	"Archivist",
	"Stevedore",
	"Jester",
	"Prisoner",
	"Feldsher",
	"Niteman",
	"Champion of Rockhill",
	"Warden of the Terrorbog",
	"Huntmaster of the Murderwoods",
	"Hetman of Mount Decapitation",
))
