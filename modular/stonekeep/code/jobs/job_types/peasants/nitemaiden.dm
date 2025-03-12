/* Comments: Has the soap that gives unique mood boost & removes tired when used by Nitemaiden on person in a bath tile
It´s pretty good. Also extra good mood boost for sex, but still a bit barebones. Expand a little cooking/serving? */


/obj/item/bath/soap // replaced by fixing /obj/item/soap nuke ROGTODO

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
		"Tiefling",
		"Dark Elf"
	)
	allowed_sexes = list(FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "You are a woman of low status in your community, but while your work has little honor, it serves keep the population cleaner and the unmarried men less unruly. \
	Your work requires a valid certificate from the Feldsher that you are not carrying any diseases that might bring ruin. \
	Working for the Nitemaster, you are supposed to give them half of your earnings at least, and is expected to seek the help of the Feldsher should the various homebrewed contraceptives fail."
	display_order = BATHMAID_ORDER
	whitelist_req = FALSE
	bypass_lastclass = TRUE

	outfit = /datum/outfit/job/stonekeep/nitemaiden	//Default outfit.
	advclass_cat_rolls = list(CTAG_CONSORT= 20)	//Handles class selection.
	give_bank_account = 25
	min_pq = -25

	cmode_music = 'modular/stonekeep/kaizoku/sound/combat/combat_stormwarrior.ogg'

/datum/job/stonekeep/nitemaiden/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

//Universal stuff for all nitemaidens
/datum/outfit/job/stonekeep/nitemaiden
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/key/bathhouse
	beltl = /obj/item/storage/belt/pouch/coins/poor
	shoes = /obj/item/clothing/shoes/shortboots
	r_hand = /obj/item/paper/feldsher_certificate/maybe
	l_hand = /obj/item/soap


/datum/outfit/job/stonekeep/nitemaiden/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	if(H.dna.species?.id == "abyssariad")
		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch || /obj/item/clothing/face/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/kaizoku/facemask/dishonor
		mask = /obj/item/clothing/face/kaizoku/facemask/dishonor
		H.burakumin = TRUE
		to_chat(H, "<span class='userdanger'>In pursuit of hedonism and vices, I forfeited my honor and values of the Abyssal Tide. My soul can no longer claim the essence of an Abyssariad.</span>")
		if(H.patron == /datum/patron/divine/abyssor)
			H.patron = GLOB.patronlist[/datum/patron/divine/eora]
			to_chat(H, "<span class='warning'>The waters I once revered now scorn me - the rivers blistering my impure skin. I've failed Abyssor as his champion, and now I've bonded with [H.patron].")

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) // To wrestle people out of the baths
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)

	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_LCK, 1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 1)

/* ! ! ! Class Selection Section Below ! ! !
Design philosphy:
- Bathmaid, more rogue flavored, less classy
- Serving girl, works in the inn, got keys, little cooking skill
*/

/datum/advclass/stonekeep/nitemaid/bathmaid
	name = "Bathmaid"
	tutorial = "You work mostly in the Bath-house, cleaning guests, playing music, doing whatever is required to earn your keep."
	outfit = /datum/outfit/job/stonekeep/nitemaid/bathmaid
	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/stonekeep/nitemaid/bathmaid/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>You need to keep your boss, the Nitemaster, happy, or next stop is beggar.")
	shirt = /obj/item/clothing/shirt/dress/gen/sexy
	cloak = /obj/item/clothing/cloak/raincloak/red
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick(1,2), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)

/datum/advclass/stonekeep/nitemaid/servinggirl
	name = "Serving girl"
	tutorial = "You work mostly in the Inn, helping to keep it clean and the guest feel welcome, while earning some coin on the side by plying your less respectable trade. "
	outfit = /datum/outfit/job/stonekeep/nitemaid/servinggirl
	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/stonekeep/nitemaid/servinggirl/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>The Innkeep is your boss, the Cook your superior, and the Nitemaster your side-income.")
	shirt = /obj/item/clothing/shirt/dress/valorian
	armor = /obj/item/clothing/armor/corset
	beltr = /obj/item/storage/keyring/servinggirl
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
