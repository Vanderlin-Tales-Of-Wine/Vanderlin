/* Comments: Has the soap that gives unique mood boost & removes tired when used by Nitemaiden on person in a bath tile
It´s pretty good. Also extra good mood boost for sex, but still a bit barebones. Expand a little cooking/serving? */


/datum/job/stonekeep/nitemaiden
	title = "Nitemaiden"
	flag = SK_BATHMAID
	department_flag = PEASANTS
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

	outfit = /datum/outfit/job/stonekeep/nitemaiden	//Default outfit.
	advclass_cat_rolls = list(CTAG_NITEMAIDEN= 20)	//Handles class selection.
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
	beltl = /obj/item/storage/belt/pouch/nitemaiden
	shoes = /obj/item/clothing/shoes/shortboots

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
	category_tags = list(CTAG_NITEMAIDEN)

/datum/outfit/job/stonekeep/nitemaid/bathmaid/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>You need to keep your boss, the Nitemaster, happy, or next stop is beggar.")
	armor = /obj/item/clothing/shirt/dress/gen/sexy
	cloak = /obj/item/clothing/cloak/raincloak/red
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick(1,2), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)

/datum/advclass/stonekeep/nitemaid/servinggirl
	name = "Serving girl"
	tutorial = "You work mostly in the Inn, helping to keep it clean and the guest feel welcome, while earning some coin on the side by plying your less respectable trade. "
	outfit = /datum/outfit/job/stonekeep/nitemaid/servinggirl
	category_tags = list(CTAG_NITEMAIDEN)

/datum/outfit/job/stonekeep/nitemaid/servinggirl/pre_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, "<span class='warning'>The Innkeep is your boss, the Cook your superior, and the Nitemaster your side-income.")
	armor = /obj/item/clothing/shirt/dress/valorian
	beltr = /obj/item/storage/keyring/servinggirl
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)


// Herbal soap
/obj/item/bath/soap
	name = "herbal soap"
	desc = "A soap made from various herbs."
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "soap_herbal"
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	throwforce = 0
	throw_speed = 1
	throw_range = 7
	var/cleanspeed = 35 //slower than mop
	uses = 10

/obj/item/bath/soap/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 80)

/obj/item/bath/soap/examine(mob/user)
	. = ..()
	var/max_uses = initial(uses)
	var/msg = "It looks like it was freshly made."
	if(uses != max_uses)
		var/percentage_left = uses / max_uses
		switch(percentage_left)
			if(0 to 0.2)
				msg = "There's just a tiny bit left of what it used to be, you're not sure it'll last much longer."
			if(0.21 to 0.4)
				msg = "It's dissolved quite a bit, but there's still some life to it."
			if(0.41 to 0.6)
				msg = "It's past its prime, but it's definitely still good."
			if(0.61 to 0.85)
				msg = "It's started to get a little smaller than it used to be, but it'll definitely still last for a while."
			else
				msg = "It's seen some light use, but it's still pretty fresh."
	. += "<span class='notice'>[msg]</span>"

/obj/item/bath/soap/attack(mob/living/carbon/human/target, mob/living/carbon/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/turf/bathspot = get_turf(target)				// Checks for being in a bath and being undressed
	if(!istype(bathspot, /turf/open/water/bath))
		if((!locate(/obj/structure/table/wood/bathtub) in target.loc))
			to_chat(user, span_warning("They must be in the bath water!"))
			return
	if(!ishuman(target))
		to_chat(user, span_warning("They don't want to be soaped..."))
		return

	if(istype(target.wear_armor, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with armor on."))
		return

	if(istype(target.wear_shirt, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with clothing on."))
		return

	if(istype(target.cloak, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with clothing on."))
		return

	if(istype(target.wear_pants, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with pants on."))
		return

	if(istype(target.shoes, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with shoes on."))
		return

	user.visible_message("<span class='info'>[user] begins scrubbing [target] with the [src].</span>")	// Applies the special bonus only if Nitemaiden using the soap
	playsound(src.loc, pick('sound/items/soaping.ogg'), 100)
	if(do_after(user, 5 SECONDS, target = target))
		if((user.job == "Nitemaiden"))
			user.visible_message(span_info("[user] expertly scrubs and soothes [target] with the [src]."))
			to_chat(target, span_warning("I feel so relaxed and clean!"))
			target.apply_status_effect(/datum/status_effect/buff/clean_plus)
	//		target.tiredness = 0
			target.remove_status_effect(/datum/status_effect/debuff/sleepytime)
		else
			user.visible_message(span_info("[user] tries their best to scrub [target] with the [src]."))
			to_chat(target, span_warning("Its worth a little soap in my eyes to get clean."))
		wash_atom(target, CLEAN_STRONG)
		uses -= 1
		if(uses == 0)
			qdel(src)


/obj/item/storage/belt/pouch/nitemaiden
	populate_contents = list(
		/obj/item/paper/feldsher_certificate/maybe,
		/obj/item/natural/cloth,
	)
