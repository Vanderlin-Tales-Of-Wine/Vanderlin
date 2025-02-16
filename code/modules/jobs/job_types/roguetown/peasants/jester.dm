/datum/job/roguetown/jester
	title = "Jester"
	flag = JESTER
	department_flag = PEASANTS
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
		"Aasimar",
		"Half-Orc"
	)

	tutorial = "The Grenzelhofts were known for their Jesters, wisemen with a tongue just as sharp as their wit. \
		You command a position of a fool, envious of the position your superiors have upon you. \
		Your cheap tricks and illusions of intelligence will only work for so long, \
		and someday you'll find yourself at the end of something sharper than you."

	spells = list(/obj/effect/proc_holder/spell/self/telljoke,/obj/effect/proc_holder/spell/self/telltragedy,/obj/effect/proc_holder/spell/self/fart)
	outfit = /datum/outfit/job/roguetown/jester
	display_order = JDO_JESTER
	bypass_lastclass = TRUE
	min_pq = -20
	give_bank_account = TRUE

/datum/outfit/job/roguetown/jester/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/jester
	pants = /obj/item/clothing/under/roguetown/tights
	armor = /obj/item/clothing/suit/roguetown/shirt/jester
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/jester
	beltl = /obj/item/storage/belt/rogue/pouch
	head = /obj/item/clothing/head/roguetown/jester
	neck = /obj/item/clothing/neck/roguetown/coif
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

//Ventriloquism! Make things speak!

/mob/living/carbon/human/proc/ventriloquate()
	set name = "Ventriloquism"
	set category = "Japes"

	var/obj/item/grabbing/I = get_active_held_item()
	if(!I)
		to_chat(src, "<span class='warning'>I need to be holding or grabbing something!</span>")
		return
	var/message = input(usr, "What do you want to ventriloquate?", "Ventriloquism!") as text | null
	if(!message)
		return
	I.say(message)
	log_admin("[key_name(usr)] ventriloquated [I] at [AREACOORD(I)] to say \"[message]\"")

// Ear Trick! Pull objects from behind someone's ear by the will of Xylix!

/mob/living/carbon/human/proc/ear_trick()
	set name = "Ear Trick"
	set category = "Japes"

	var/obj/item/grabbing/I = get_active_held_item()
	var/mob/living/carbon/human/H
	var/obj/item/japery_obj
	japery_obj = get_japery()
	var/obj/item/J = new japery_obj(get_turf(H))


	if(!istype(I) || !ishuman(I.grabbed))
		return
	H = I.grabbed
	if(H == src)
		to_chat(src, "<span class='warning'>I know what's behind my own ears!</span>")
		return
	if(mob_timers["lasttrick"])
		if(world.time < mob_timers["lasttrick"] + 20 SECONDS)
			to_chat(src, "<span class='warning'>I need a moment before I can do another trick!</span>")
			return
	qdel(I)
	src.put_in_hands(J)
	src.visible_message("<span class='notice'>[src] reaches behind [H]'s ear with a grin, shaking their closed hand for a moment before revealing [J] held in it!</span>")
	mob_timers["lasttrick"] = world.time

/mob/living/carbon/human/proc/get_japery()
	var/japery_list = list(
		/obj/item/roguecoin/copper,
		/obj/item/natural/dirtclod,
		/obj/item/natural/worms,
		/obj/item/natural/worms/leech,
		/obj/item/natural/thorn,
		/obj/item/natural/stone,
		/obj/item/natural/poo,
		/obj/item/natural/feather,
		/obj/item/reagent_containers/food/snacks/hardtack
		)

	var/japery = pick(japery_list)
	return japery
