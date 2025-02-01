
#define ENGSEC			(1<<0)

#define CAPTAIN_SS13	(1<<0)
#define HOS				(1<<1)
#define WARDEN			(1<<2)
#define DETECTIVE		(1<<3)
#define OFFICER			(1<<4)
#define CHIEF			(1<<5)
#define ENGINEER		(1<<6)
#define ATMOSTECH		(1<<7)
#define ROBOTICIST		(1<<8)
#define AI_JF			(1<<9)
#define CYBORG			(1<<10)


#define MEDSCI			(1<<1)

#define RD_JF			(1<<0)
#define SCIENTIST		(1<<1)
#define CHEMIST			(1<<2)
#define CMO_JF			(1<<3)
#define DOCTOR			(1<<4)
#define GENETICIST		(1<<5)
#define VIROLOGIST		(1<<6)


#define CIVILIAN		(1<<2)

#define HOP				(1<<0)
#define BARTENDER		(1<<1)
#define BOTANIST		(1<<2)
//#define COOK			(1<<3) //This is redefined below, and is a ss13 leftover.
#define JANITOR			(1<<4)
#define CURATOR			(1<<5)
#define QUARTERMASTER	(1<<6)
#define CARGOTECH		(1<<7)
//#define MINER			(1<<8) //This is redefined below, and is a ss13 leftover.
#define LAWYER			(1<<9)
#define CHAPLAIN		(1<<10)
#define CLOWN			(1<<11)
#define MIME			(1<<12)
#define ASSISTANT		(1<<13)

#define JOB_AVAILABLE 0
#define JOB_UNAVAILABLE_GENERIC 1
#define JOB_UNAVAILABLE_BANNED 2
#define JOB_UNAVAILABLE_PLAYTIME 3
#define JOB_UNAVAILABLE_ACCOUNTAGE 4
#define JOB_UNAVAILABLE_SLOTFULL 5
#define JOB_UNAVAILABLE_RACE 6
#define JOB_UNAVAILABLE_SEX 7
#define JOB_UNAVAILABLE_WTEAM 8
#define JOB_UNAVAILABLE_LASTCLASS 9
#define JOB_UNAVAILABLE_PATRON 10
#define JOB_UNAVAILABLE_JOB_COOLDOWN 11

#define DEFAULT_RELIGION "Christianity"
#define DEFAULT_DEITY "Space Jesus"

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define JOB_DISPLAY_ORDER_ASSISTANT 1
#define JOB_DISPLAY_ORDER_CAPTAIN 2
#define JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL 3
#define JOB_DISPLAY_ORDER_QUARTERMASTER 4
#define JOB_DISPLAY_ORDER_CARGO_TECHNICIAN 5
#define JOB_DISPLAY_ORDER_SHAFT_MINER 6
#define JOB_DISPLAY_ORDER_BARTENDER 7
#define JOB_DISPLAY_ORDER_COOK 8
#define JOB_DISPLAY_ORDER_BOTANIST 9
#define JOB_DISPLAY_ORDER_JANITOR 10
#define JOB_DISPLAY_ORDER_CLOWN 11
#define JOB_DISPLAY_ORDER_MIME 12
#define JOB_DISPLAY_ORDER_CURATOR 13
#define JOB_DISPLAY_ORDER_LAWYER 14
#define JOB_DISPLAY_ORDER_CHAPLAIN 15
#define JOB_DISPLAY_ORDER_CHIEF_ENGINEER 16
#define JOB_DISPLAY_ORDER_STATION_ENGINEER 17
#define JOB_DISPLAY_ORDER_ATMOSPHERIC_TECHNICIAN 18
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 19
#define JOB_DISPLAY_ORDER_MEDICAL_DOCTOR 20
#define JOB_DISPLAY_ORDER_CHEMIST 21
#define JOB_DISPLAY_ORDER_GENETICIST 22
#define JOB_DISPLAY_ORDER_VIROLOGIST 23
#define JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR 24
#define JOB_DISPLAY_ORDER_SCIENTIST 25
#define JOB_DISPLAY_ORDER_ROBOTICIST 26
#define JOB_DISPLAY_ORDER_HEAD_OF_SECURITY 27
#define JOB_DISPLAY_ORDER_WARDEN 28
#define JOB_DISPLAY_ORDER_DETECTIVE 29
#define JOB_DISPLAY_ORDER_SECURITY_OFFICER 30
#define JOB_DISPLAY_ORDER_AI 31
#define JOB_DISPLAY_ORDER_CYBORG 32

#define NOBLEMEN		(1<<0)

#define LORD		(1<<0)
#define CONSORT		(1<<1)
#define HAND		(1<<2)
#define STEWARD		(1<<3)
#define WIZARD		(1<<4)
#define CAPTAIN		(1<<5)
#define ARCHIVIST   (1<<6)
#define MERCHANT	(1<<7)
#define FELDSHER    (1<<8)
#define NIGHTMAN    (1<<9)
#define MINOR_NOBLE	(1<<10)

#define GARRISON		(1<<1)

#define GUARDSMAN	(1<<0)
#define WATCHMAN	(1<<1)
#define JAILOR	    (1<<2)
#define DUNGEONEER	(1<<3)
#define MAYOR       (1<<4)
#define FORWARDEN   (1<<5)
#define FORGUARD    (1<<6)

#define CHURCHMEN		(1<<2)

#define PRIEST		(1<<0)
#define CLERIC		(1<<1)
#define PURITAN		(1<<2)
#define MONK		(1<<3)
#define GRAVETENDER	(1<<4)

#define SERFS			(1<<3)

#define INNKEEP		(1<<0)
#define BLACKSMITH	(1<<1)
#define ALCHEMIST	(1<<2)
#define MASON		(1<<3)
#define TAILOR		(1<<4)
#define ARTIFICER	(1<<5)
#define MATRON 		(1<<6)
#define PHYSICKER	(1<<7)
#define SCRIBE		(1<<8)

#define PEASANTS		(1<<4)

#define HUNTER		(1<<0)
#define FARMER		(1<<1)
#define BEASTMASTER	(1<<2)
#define FISHER		(1<<4)
#define LUMBERJACK	(1<<5)
#define MINER		(1<<6)
#define BUTLER		(1<<7)
#define JESTER		(1<<8)
#define ADVENTURER	(1<<9)
#define COOK		(1<<10)
#define GRABBER		(1<<11)
#define BARD		(1<<12)
#define CHEESEMAKER (1<<13)
#define MIGRANT		(1<<16)
#define BANDIT		(1<<17)

#define APPRENTICES		(1<<5)

#define APPRENTICE	(1<<0)
#define SQUIRE		(1<<1)
#define SERVANT		(1<<2)
#define PRINCE		(1<<3)

#define YOUNGFOLK           (1<<6)
#define INNKEEPCHILD    (1<<1)
#define CHURCHLING      (1<<2)
#define ORPHAN		    (1<<3)

#define UNDEAD		(1<<10)

#define DEATHKNIGHT (1<<0)
#define SKELETON	(1<<1)

#define JCOLOR_NOBLE "#9c40bf"
#define JCOLOR_MERCHANT "#c2b449"
#define JCOLOR_SOLDIER "#b64949"
#define JCOLOR_SERF "#669968"
#define JCOLOR_PEASANT "#936d6c"


// job display orders //

#define JDO_LORD 1
#define JDO_CONSORT 1.1
#define JDO_PRINCE 1.2
#define JDO_HAND 2
#define JDO_STEWARD 3
#define JDO_MINOR_NOBLE 3.5

#define JDO_MAGICIAN 4
#define JDO_WAPP 5

#define JDO_FELDSHER 6
#define JDO_PHYSICKER 6.1

#define JDO_CAPTAIN 7
#define JDO_ROYALGUARD 7.1
#define JDO_GARRISONGUARD 7.5
#define JDO_WATCHMAN 8
#define JDO_JAILOR 8.5
#define JDO_DUNGEONEER 9
#define JDO_SQUIRE 9.5
#define JDO_VET 10
#define JDO_FORWARDEN 11
#define JDO_FORGUARD 11.5

#define JDO_PRIEST 12
#define JDO_CLERIC 13
#define JDO_MONK 14
#define JDO_GRAVETENDER 15
#define JDO_CHURCHLING 15.1

#define JDO_PURITAN 16
#define JDO_SHEPHERD 17
#define JDO_TEMPLAR 17.1

#define JDO_MERCHANT 18
#define JDO_TAILOR 18.1
#define JDO_GRABBER 19

#define JDO_ARMORER 20
#define JDO_WSMITH 21
#define JDO_BAPP 22
#define JDO_ARTIFICER 23

#define JDO_MASON 24

#define JDO_BUTLER 25
#define JDO_SERVANT 26

#define JDO_INNKEEP 27
#define JDO_INNKEEP_CHILD 27.5
#define JDO_COOK 28

#define JDO_BUTCHER 28.1
#define JDO_SOILSON 28.2
#define JDO_FISHER 28.3
#define JDO_HUNTER 28.4
#define JDO_CARPENTER 28.6
#define JDO_CHEESEMAKER 28.7
#define JDO_MINER 28.8
#define JDO_MATRON 28.9
#define JDO_GRAVEMAN 29

#define JDO_APOTHECARY 29.1

#define JDO_JESTER 30
#define JDO_BARD 30.1
#define JDO_PRISONER 31

#define JDO_CHIEF 32

#define JDO_ADVENTURER 33
#define JDO_PILGRIM 34.2
#define JDO_MIGRANT  34.3
#define JDO_BANDIT 34.3

#define JDO_MERCENARY 35

#define JDO_VAGRANT 36
#define JDO_ORPHAN 37
