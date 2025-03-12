/obj/item/soap
	name = "soap"
	desc = ""
	gender = PLURAL
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "soap"
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	throwforce = 0
	throw_speed = 1
	throw_range = 7
	var/cleanspeed = 35 //slower than mop
	force_string = "robust... against germs"
	var/uses = 50

/obj/item/soap/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 80)

/obj/item/soap/examine(mob/user)
	. = ..()
	var/max_uses = initial(uses)
	var/msg = "It looks like it was just made."
	if(uses != max_uses)
		var/percentage_left = uses / max_uses
		switch(percentage_left)
			if(0 to 0.15)
				msg = "There's just a tiny bit left of what it used to be, you're not sure it'll last much longer."
			if(0.15 to 0.30)
				msg = "It's dissolved quite a bit, but there's still some life to it."
			if(0.30 to 0.50)
				msg = "It's past its prime, but it's definitely still good."
			if(0.50 to 0.75)
				msg = "It's started to get a little smaller than it used to be, but it'll definitely still last for a while."
			else
				msg = "It's seen some light use, but it's still pretty fresh."
	. += "<span class='notice'>[msg]</span>"

/obj/item/soap/attack(mob/living/carbon/human/target, mob/living/carbon/user)
	user.changeNext_move(CLICK_CD_MELEE)
	//how much reagent we're using on each use

	if(ishuman(target) && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(target.is_mouth_covered())
			to_chat(user, span_warning("Their mouth is blocked!"))
			return FALSE

		if(user != target)
			var/obj/item/grabbing/I = user.get_inactive_held_item()
			if(!(ishuman(I?.grabbed) && I?.grabbed == target)) // gotta have the target in your offhand
				to_chat(user, span_warning("I can't hold them still if I don't grab them!"))
				return FALSE
		user.visible_message("<span class='warning'>\the [user] starts to wash \the [target]'s mouth out with [src.name]...</span>", "<span class='notice'>I start to wash \the [target]'s mouth out with [src.name]...</span>") //washes mouth out with soap sounds better than 'the soap' here			if(user.zone_selected == "mouth")
		// how this looks vvv https://www.desmos.com/calculator/55fpadxol5
		if(do_after(user, (20 / user.STASPD + 2) SECONDS, target))
			user.visible_message("<span class='warning'>\the [user] washes \the [target]'s mouth out with [src.name]!</span>", "<span class='notice'>I wash \the [target]'s mouth out with [src.name]!</span>") //washes mouth out with soap sounds better than 'the soap' here			if(user.zone_selected == "mouth")
			target.emote("drown")
			target.adjustOxyLoss(user.STASTR * 2) // double because it takes much longer than a strangle
			var/datum/reagents/reagents = new()
			reagents.add_reagent(/datum/reagent/soap, 5)
			reagents.trans_to(target, reagents.total_volume, transfered_by = user, method = INGEST)
			log_combat(user, target, "fed", /datum/reagent/soap)
			uses -= 5
			target.lip_style = null //removes lipstick
			target.update_body()
			return TRUE

	var/turf/bathspot = get_turf(target)				// Checks for being in a bath and being undressed
	if(!istype(bathspot, /turf/open/water/bath))
		to_chat(user, span_warning("They must be in the bath water!"))
		return FALSE
	if(!ishuman(target))
		to_chat(user, span_warning("They don't want to be soaped..."))
		return FALSE

	if(istype(target.head, /obj/item/clothing) || istype(target.wear_armor, /obj/item/clothing) || istype(target.wear_shirt, /obj/item/clothing) || istype(target.wear_neck) || istype(target.wear_pants, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with clothing on."))
		return FALSE
	if(istype(target.gloves, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with gloves on."))
		return FALSE
	if(istype(target.wear_pants, /obj/item/clothing) && !istype(target.wear_pants, /obj/item/clothing/pants/loincloth)) // you can bathe in a loincloth
		to_chat(user, span_warning("Can't get a proper bath with pants on."))
		return FALSE
	if(istype(target.shoes, /obj/item/clothing))
		to_chat(user, span_warning("Can't get a proper bath with shoes on."))
		return FALSE

	user.visible_message("<span class='info'>[user] begins scrubbing [target] with the [src].</span>")
	playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
	if(do_after(user, 5 SECONDS, target))
		scrub_scrub(target, user)
		return TRUE
	return FALSE

/obj/item/soap/attack_obj(obj/O, mob/living/user)
	var/datum/reagents/r = O.reagents
	if(!r)
		return
	if(!O.is_open_container())
		to_chat(user, span_warning("It's not open."))
		return
	if(r.total_volume >= r.maximum_volume)
		to_chat(user, span_warning("There's no room to add soap."))
		return
	var/datum/reagent/wawa = r.get_reagent_amount(/datum/reagent/water)
	if(!wawa)
		to_chat(user, span_warning("The soap needs clean water to dissolve."))
		return
	var/amt2Add = min(10, wawa, r.maximum_volume - r.total_volume)
	if(do_after(user, 2 SECONDS, O))
		var/datum/reagents/reagents = new()
		reagents.add_reagent(/datum/reagent/soap, amt2Add)
		reagents.trans_to(O, reagents.total_volume, transfered_by = user, method = TOUCH)
		to_chat(user, span_info("I dissolve some of the soap in the water."))

/obj/item/soap/proc/scrub_scrub(mob/living/carbon/human/target, mob/living/carbon/user)
	wash_atom(target, CLEAN_STRONG)
	user.visible_message(span_info("[user] scrubs [target] with the [src]."))
	uses -= 5
	if(uses == 0)
		qdel(src)

/obj/item/soap/bath
	name = "herbal soap"
	desc = "A soap made from various herbs."
	uses = 25

//Only get the buff if you use the good stuff
/obj/item/soap/bath/scrub_scrub(mob/living/carbon/human/target, mob/living/carbon/user)
	. = ..()
	to_chat(target, span_green("I feel so relaxed and clean!"))
	target.apply_status_effect(/datum/status_effect/buff/clean_plus)
