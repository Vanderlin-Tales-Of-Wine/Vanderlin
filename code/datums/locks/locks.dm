// This file should be used for special static locks that always remain the same

///// Locks
/datum/lock/locked
	locked = TRUE

///// Key locks
/datum/lock/key/locked
	locked = TRUE

/datum/lock/key/steward
	lockid_list = list(ACCESS_STEWARD)
	locked = TRUE

/datum/lock/key/merchant
	lockid_list = list(ACCESS_MERCHANT)
	locked = TRUE

/datum/lock/key/lord
	lockid_list = list(ACCESS_LORD)
	locked = TRUE

/datum/lock/key/apothecary
	lockid_list = list(ACCESS_APOTHECARY)
	locked = TRUE

/datum/lock/key/manor
	lockid_list = list(ACCESS_MANOR)
	locked = TRUE

/datum/lock/key/inn
	lockid_list = list(ACCESS_INN)
	locked = TRUE

///// Multiple key locks
/datum/lock/key/pillory
	lockid_list = list(ACCESS_GARRISON, ACCESS_FOREST, ACCESS_AT_ARMS, ACCESS_DUNGEON)
