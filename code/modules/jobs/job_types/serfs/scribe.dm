/datum/job/scribe
	title = "Scribe"
	flag = SCRIBE
	department_flag = SERFS
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/scribe
	outfit_female = /datum/outfit/job/scribe/female
	display_order = 6


/datum/outfit/job/scribe
	name = "Scribe"
	jobtype = /datum/job/scribe

	pants = /obj/item/clothing/pants/tights
	shirt = /obj/item/clothing/shirt/undershirt
	armor = /obj/item/clothing/shirt/rags
	shoes = /obj/item/clothing/shoes/boots

/datum/outfit/job/scribe/female
	name = "Scribe"
	jobtype = /datum/job/scribe

	pants = null
