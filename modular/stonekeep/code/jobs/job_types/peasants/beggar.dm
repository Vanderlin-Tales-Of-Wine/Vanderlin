
/datum/job/stonekeep/beggar
	title = "Beggar"
	flag = SK_BEGGAR
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 15
	spawn_positions = 15

	allowed_races = list(
		"Humen",
		"Elf",
		"Dwarf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/stonekeep/beggar
	bypass_lastclass = TRUE
	banned_leprosy = FALSE

	tutorial = "The smell of filth and sweat no longer bother you, the glances of disgust or pity others give you familiar  ; the only reason you've not dead in a mud pit already is because you are tough as a old leather sole, hardned by ratbites, sticks and stones."
	display_order = BEGGAR_ORDER
	show_in_credits = FALSE
	can_random = FALSE

	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'
	can_have_apprentices = FALSE

/datum/job/stonekeep/beggar/New()
	. = ..()
	peopleknowme = list()

/datum/outfit/job/stonekeep/beggar/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(5))
		r_hand = /obj/item/natural/worms
	if(prob(20))
		head = /obj/item/clothing/head/knitcap
	if(prob(5))
		r_hand = /obj/item/reagent_containers/powder/moondust
	if(prob(10))
		mouth = /obj/item/clothing/face/cigarette/rollie/cannabis
	if(prob(10))
		cloak = /obj/item/clothing/cloak/raincloak/brown
	if(prob(10))
		gloves = /obj/item/clothing/gloves/fingerless
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/shirt/rags
	else
		pants = /obj/item/clothing/pants/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/pants/tights/vagrant/l
		shirt = /obj/item/clothing/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/shirt/undershirt/vagrant/l
	if(H.dna.species?.id == "abyssariad")
		mask = /obj/item/clothing/face/kaizoku/facemask/dishonor
		to_chat(H, "<span class='userdanger'>In failure I forfeited my honor and values of the Abyssal Tide. If I am to claim the essence of an Abyssariad once more, I must prove myself worthy.</span>")
		H.burakumin = TRUE
		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch || /obj/item/clothing/face/eyepatch/left ))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/kaizoku/facemask/dishonor
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, pick(2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(1,2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick (1,2,3,4,5), TRUE) // thug lyfe
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, pick(2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,3,4), TRUE) // Street-fu
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,3), TRUE)
		H.TOTALLUC = rand(1, 20)
	if(prob(5))
		r_hand = /obj/item/weapon/mace/woodclub
	if(prob(20))
		H.change_stat("constitution", 2)
		H.change_stat("intelligence", -1)
	if(prob(20))
		H.change_stat("endurance", 3)
		H.change_stat("constitution", -1)
	if(prob(20))
		H.change_stat("strength", 2)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)
		H.change_stat("intelligence", -1)
	H.change_stat("intelligence", -2)
	H.change_stat("constitution", -2)
	H.change_stat("endurance", -1)

