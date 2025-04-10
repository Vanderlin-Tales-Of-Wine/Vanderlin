

//Values for antag preferences, event roles, etc. unified here



//These are synced with the Database, if you change the values of the defines
//then you MUST update the database!

// Main villains
#define ROLE_MANIAC "Maniac"
#define ROLE_WEREWOLF "Werewolf"
#define ROLE_VAMPIRE "Vampire"
#define ROLE_NBEAST "Vampire Lord"
#define ROLE_ZIZO_ELF "Dark Elf"
#define ROLE_BANDIT "Bandit"
#define ROLE_PREBEL "Peasant Rebel"
#define ROLE_ZIZOIDCULTIST "Zizoid Cultist"
#define ROLE_LICH "Lich"
#define ROLE_ASPIRANT "Aspirant"

// Midround/Side Villains
#define ROLE_BOUND_BEAST "Bound Beast"
#define ROLE_SKELETON "Skeleton"
#define ROLE_GOBLIN "Goblin"
#define ROLE_DEATHKNIGHT "Death Knight"
#define ROLE_RATMAN "Rousman"
#define ROLE_NECRO_SKELETON	"Necromancer Skeleton"


GLOBAL_LIST_INIT(special_roles_rogue, list(
	ROLE_MANIAC = /datum/antagonist/maniac,
	ROLE_PREBEL = /datum/antagonist/prebel,
	ROLE_BANDIT = /datum/antagonist/bandit,
	ROLE_ZIZOIDCULTIST = /datum/antagonist/zizocultist,
	ROLE_WEREWOLF = /datum/antagonist/werewolf,
	ROLE_NBEAST = /datum/antagonist/vampire,
	ROLE_ASPIRANT = /datum/antagonist/aspirant,
	ROLE_LICH = /datum/antagonist/lich
))

//Job defines for what happens when you fail to qualify for any job during job selection
#define BERANDOMJOB "Be Random Role"
#define RETURNTOLOBBY 	"Return to Lobby"
