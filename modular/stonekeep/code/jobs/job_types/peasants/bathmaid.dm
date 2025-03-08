/* Comments: Has the soap that gives unique mood boost & removes tired when used by Nitemaiden on person in a bath tile
It´s pretty good. Also extra good mood boost for sex, but still a bit barebones. Expand a little cooking/serving? */
/datum/job/stonekeep/nitemaiden
	title = "Nitemaiden"
	flag = SK_BATHMAID
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 3
	spawn_positions = 3

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf"
	)

	tutorial = "You should not see this.."
	allowed_sexes = list(FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	outfit = /datum/outfit/job/stonekeep/nitemaiden
	display_order = BATHMAID_ORDER
	give_bank_account = TRUE
	min_pq = -25
	can_random = FALSE
	bypass_lastclass = TRUE

/datum/outfit/job/stonekeep/nitemaiden/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shortboots
	shirt = /obj/item/clothing/shirt/undershirt
	armor = /obj/item/clothing/shirt/dress/gen/sexy
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/key/nitemaiden
	beltl = /obj/item/storage/belt/pouch/coins/poor
	r_hand = /obj/item/paper/feldsher_certificate/maybe
	l_hand = /obj/item/soap
	if(H.dna.species?.id == "abyssariad")
		mask = /obj/item/clothing/face/kaizoku/facemask/dishonor
		H.burakumin = TRUE
		to_chat(H, "<span class='userdanger'>In pursuit of hedonism and vices, I forfeited my honor and values of the Abyssal Tide. My soul can no longer claim the essence of an Abyssariad.</span>")
		if(H.patron == /datum/patron/divine/abyssor)
			H.patron = GLOB.patronlist[/datum/patron/divine/eora]
			to_chat(H, "<span class='warning'>The waters I once revered now scorn me - the rivers blistering my impure skin. I've failed Abyssor as his champion, and now I've bonded with [H.patron].")

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch || /obj/item/clothing/face/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/kaizoku/facemask/dishonor

	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) // To wrestle people out of the baths
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick(1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)


/obj/item/bath/soap // replaced by fixing /obj/item/soap nuke ROGTODO

