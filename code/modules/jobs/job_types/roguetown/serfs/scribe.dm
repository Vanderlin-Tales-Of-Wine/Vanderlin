/// Seemingly unused, could be the proto-archivist?
/datum/job/roguetown/scribe
	title = "Scribe"
	flag = SCRIBE
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = 6
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/roguetown/scribe
	outfit_female = /datum/outfit/job/roguetown/scribe/female


/datum/outfit/job/roguetown/scribe
	name = "Scribe"
	jobtype = /datum/job/roguetown/scribe

	pants = /obj/item/clothing/under/roguetown/tights
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	armor = /obj/item/clothing/suit/roguetown/shirt/rags
	shoes = /obj/item/clothing/shoes/roguetown/boots

/datum/outfit/job/roguetown/scribe/female
	pants = null //???
