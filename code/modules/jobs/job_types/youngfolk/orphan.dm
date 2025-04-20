/datum/job/orphan
	title = "Orphan"
	tutorial = "Before you could even form words, you were abandoned, or perhaps lost. \
	Ever since, you have lived in the Orphanage under the Matron's care. \
	Will you make something of yourself, or will you die in the streets as a nobody?"
	flag = ORPHAN
	department_flag = YOUNGFOLK
	job_flags = (JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_ORPHAN
	faction = FACTION_STATION
	total_positions = 12
	spawn_positions = 12
	min_pq = 2
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL
	allowed_ages = list(AGE_CHILD)

	outfit = /datum/outfit/job/orphan
	can_have_apprentices = FALSE
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

/datum/job/orphan/New()
	. = ..()
	peopleknowme = list()

/datum/outfit/job/orphan/pre_equip(mob/living/carbon/human/H)
	..()
	// The guaranteed clothing they wear.
	if(prob(50))
		if(prob(50))
			shirt = /obj/item/clothing/shirt/undershirt/vagrant/l
		else
			shirt = /obj/item/clothing/shirt/undershirt/vagrant
		if(prob(50))
			pants = /obj/item/clothing/pants/tights/vagrant/l
		else
			pants = /obj/item/clothing/pants/tights/vagrant
	else
		armor = /obj/item/clothing/shirt/rags
	// Flair
	if(prob(35))
		cloak = pick(/obj/item/clothing/cloak/half, /obj/item/clothing/cloak/half/brown)
	if(prob(30))
		head = pick(/obj/item/clothing/head/knitcap, /obj/item/clothing/head/bardhat, /obj/item/clothing/head/courtierhat, /obj/item/clothing/head/fancyhat)
	if(prob(15))
		r_hand = pick(/obj/item/instrument/lute, /obj/item/instrument/accord, /obj/item/instrument/guitar, /obj/item/instrument/flute, /obj/item/instrument/hurdygurdy, /obj/item/instrument/viola)
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/misc/music, pick(2,3,4), TRUE)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.STALUC = rand(1, 20)
	H.change_stat(STATKEY_INT, round(rand(-4,4)))
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_END, -1)
