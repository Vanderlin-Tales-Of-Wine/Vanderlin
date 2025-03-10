/*
/datum/job/nitemaiden
	title = "Nitemaiden"
	flag = JESTER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_races =  ALL_PLAYER_RACES_BY_NAME

	tutorial = "You should not see this.."

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	outfit = /datum/outfit/job/nitemaiden
	display_order = JDO_NITEMAIDEN
	give_bank_account = TRUE
	min_pq = -20
	can_random = FALSE
	bypass_lastclass = TRUE

/datum/outfit/job/nitemaiden/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shortboots
	shirt = /obj/item/clothing/shirt/undershirt
	armor = /obj/item/clothing/shirt/dress/gen/sexy
	neck = /obj/item/storage/belt/pouch/nitemaiden
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/key/nitemaiden
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) // To wrestle people out of the baths
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(1,2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/undershirt/puritan
		armor = /obj/item/clothing/armor/leather/jacket/sea
*/
// Washing Implements

/obj/item/bath/soap
	name = "herbal soap"
	desc = "A body soap infused with various herbs to create a floral smell."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "soap"
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	throwforce = 0
	throw_speed = 1
	throw_range = 7
	var/uses = 10
	var/slip_chance = 10

/obj/item/bath/soap/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 8, NONE, null, 0, FALSE, slip_chance)

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
	. += span_notice("[msg]")

/obj/item/bath/soap/attack(mob/living/carbon/human/target, mob/living/carbon/user)
	user.changeNext_move(CLICK_CD_MELEE)
	var/turf/bathspot = get_turf(target)				// Checks for being in a bath and being undressed
	if(!istype(bathspot, /turf/open/water/bath))
		to_chat(user, span_warning("[target] must be in bath water to be cleaned."))
		return
	if(!ishuman(target))
		to_chat(user, span_warning("[target] refuses to be soaped!"))
		return

	if(istype(target.wear_armor, /obj/item/clothing))
		to_chat(user, span_warning("[target] can't be properly bathed with armor on."))
		return

	if(istype(target.wear_shirt, /obj/item/clothing))
		to_chat(user, span_warning("[target] can't be properly bathed with clothing on."))
		return

	if(istype(target.cloak, /obj/item/clothing))
		to_chat(user, span_warning("[target] can't be properly bathed with clothing on."))
		return

	if(istype(target.wear_pants, /obj/item/clothing))
		to_chat(user, span_warning("[target] can't be properly bathed with pants on."))
		return

	if(istype(target.shoes, /obj/item/clothing))
		to_chat(user, span_warning("[target] can't be properly bathed with shoes on."))
		return

	user.visible_message(span_info("[user] begins scrubbing [target] with [src]."))
	playsound(src.loc, pick('sound/items/soaping.ogg'), 100)
	if(do_after(user, 5 SECONDS, target))
		if(user != target)
			user.visible_message(span_info("[user] expertly scrubs and soothes [target] with [src]."))
			to_chat(target, span_warning("I feel so relaxed and clean!"))
			target.apply_status_effect(/datum/status_effect/buff/clean_plus)
		else
			user.add_stress(/datum/stressevent/clean)
			user.visible_message(span_info("[user] cleans [user.p_them()]self with [src]."))
		uses -= 1
		if(uses == 0)
			qdel(src)






