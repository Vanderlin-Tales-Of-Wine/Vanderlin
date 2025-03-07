/datum/job/orphan
	title = "Orphan"
	flag = ORPHAN
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 12
	spawn_positions = 12

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	allowed_ages = list(AGE_CHILD)

	tutorial = "Your parents are dead and you have no home. Will you make something of yourself or will you die in the streets as a nobody."

	outfit = /datum/outfit/job/orphan
	display_order = JDO_ORPHAN
	show_in_credits = FALSE
	min_pq = -30
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'
	can_have_apprentices = FALSE
	bypass_lastclass = TRUE

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
