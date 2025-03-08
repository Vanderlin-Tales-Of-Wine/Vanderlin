/datum/job/stonekeep/jester
	title = "Jester"
	flag = SK_JESTER
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Undine"
	)

	tutorial = "The Grenzelhofts were known for their Jesters, wisemen with a tongue just as sharp as their wit. \
		You command a position of a fool, envious of the position your superiors have upon you. \
		Your cheap tricks and illusions of intelligence will only work for so long, \
		and someday you'll find yourself at the end of something sharper than you."

	spells = list(/obj/effect/proc_holder/spell/self/telljoke,/obj/effect/proc_holder/spell/self/telltragedy,/obj/effect/proc_holder/spell/self/fart)
	outfit = /datum/outfit/job/stonekeep/jester
	display_order = 10
	bypass_lastclass = TRUE
	min_pq = -20
	give_bank_account = TRUE

/datum/outfit/job/stonekeep/jester/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/jester
	pants = /obj/item/clothing/pants/tights
	armor = /obj/item/clothing/shirt/jester
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/keyring/jester
	beltl = /obj/item/storage/belt/pouch
	head = /obj/item/clothing/head/jester
	neck = /obj/item/clothing/neck/coif
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, pick(1,2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,3,4,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, pick(1,2,3,4,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/bombs, pick(1,2,3,4,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/fishing, pick(1,2,3,4,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, pick(1,2,3,4,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, pick(1,2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(1,2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick(1,2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, pick(4,5), TRUE) // Pirouette, but falling and hurting yourself IS pretty funny.
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, pick(4,4,4,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(1,2,3,4,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, pick(1,2,3,4,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, pick(1,2,3,4,5,6), TRUE)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery) // Mock people to your heart's content!
		H.TOTALINT = rand(1, 20)
		H.TOTALLUC = rand(1, 20)
		H.TOTALSTR = rand(1, 20)
		H.TOTALCON = rand(1, 20)
		H.TOTALPER = rand(1, 20)
		H.TOTALSPD = rand(1, 20)

		if(H.STASTR > 16)
			H.cmode_music = 'sound/music/cmode/nobility/CombatJesterSTR.ogg'
		else
			H.cmode_music = pick("sound/music/cmode/nobility/CombatJester1.ogg","sound/music/cmode/nobility/CombatJester2.ogg")

/*		if(H.gender == MALE)
			if(H.dna?.species)
				if(H.dna.species.id == "human")
					H.dna.species.soundpack_m = new /datum/voicepack/male/jester()
				if(H.dna.species.id == "dwarf")
					H.dna.species.soundpack_m = new /datum/voicepack/male/dwarf/jester()
				if(H.dna.species.id == "elf")
					H.dna.species.soundpack_m = new /datum/voicepack/male/elf/jester()*/
//		H.hair_color = "cd65cb"
//		H.facial_hair_color = "cd65cb"
//		H.update_body_parts_head_only()
	H.verbs |= /mob/living/carbon/human/proc/ventriloquate
	H.verbs |= /mob/living/carbon/human/proc/ear_trick
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)

