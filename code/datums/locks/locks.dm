// This file should be used for special static locks that always remain the same

///// Locks
/datum/lock/locked
	locked = TRUE

///// Key locks
/datum/lock/key/locked
	locked = TRUE

/datum/lock/key/steward
	lockid = ACCESS_STEWARD
	locked = TRUE

/datum/lock/key/merchant
	lockid = ACCESS_MERCHANT
	locked = TRUE

/datum/lock/key/lord
	lockid = ACCESS_LORD
	locked = TRUE

/datum/lock/key/apothecary
	lockid = ACCESS_APOTHECARY
	locked = TRUE

///// Multiple key locks
/datum/lock/key/multiple/pillory
	lockid_list = list(ACCESS_GARRISON, ACCESS_FOREST, ACCESS_AT_ARMS, ACCESS_DUNGEON)
