/obj/item/reagent_containers/pill
	name = "pill"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = "pill"
	possible_transfer_amounts = list()
	volume = 50
	grind_results = list()
	var/apply_type = INGEST
	var/apply_method = "swallow"
	var/rename_with_volume = FALSE
	var/self_delay = 0 //pills are instant, this is because patches inheret their aplication from pills
	var/dissolvable = TRUE

/obj/item/reagent_containers/pill/Initialize()
	. = ..()
	if(!icon_state)
		icon_state = "pill[rand(1,20)]"
	if(reagents.total_volume && rename_with_volume)
		name += " ([reagents.total_volume]u)"


/obj/item/reagent_containers/pill/attack_self(mob/user)
	return


/obj/item/reagent_containers/pill/attack(mob/M, mob/user, def_zone)
	if(!canconsume(M, user))
		return FALSE

	if(M == user)
		M.visible_message("<span class='notice'>[user] attempts to [apply_method] [src].</span>")
		if(self_delay)
			if(!do_after(user, self_delay, M))
				return FALSE
		to_chat(M, "<span class='notice'>I [apply_method] [src].</span>")

	else
		M.visible_message("<span class='danger'>[user] attempts to force [M] to [apply_method] [src].</span>", \
							"<span class='danger'>[user] attempts to force you to [apply_method] [src].</span>")
		if(!do_after(user, 3 SECONDS, M))
			return FALSE
		M.visible_message("<span class='danger'>[user] forces [M] to [apply_method] [src].</span>", \
							"<span class='danger'>[user] forces you to [apply_method] [src].</span>")

	if(icon_state == "pill4" && prob(5)) //you take the red pill - you stay in Wonderland, and I show you how deep the rabbit hole goes
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), M, "<span class='notice'>[pick(strings(REDPILL_FILE, "redpill_questions"))]</span>"), 50)

	if(reagents.total_volume)
		reagents.trans_to(M, reagents.total_volume, transfered_by = user, method = apply_type)
	qdel(src)
	return TRUE


/obj/item/reagent_containers/pill/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if(!dissolvable || !target.is_refillable())
		return
	if(target.is_drainable() && !target.reagents.total_volume)
		to_chat(user, "<span class='warning'>[target] is empty! There's nothing to dissolve [src] in.</span>")
		return

	if(target.reagents.holder_full())
		to_chat(user, "<span class='warning'>[target] is full.</span>")
		return

	user.visible_message("<span class='warning'>[user] slips something into [target]!</span>", "<span class='notice'>I dissolve [src] in [target].</span>", null, 2)
	reagents.trans_to(target, reagents.total_volume, transfered_by = user)
	qdel(src)

/obj/item/reagent_containers/pill/tox
	name = "toxins pill"
	desc = ""
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/toxin = 50)
	rename_with_volume = TRUE

/obj/item/reagent_containers/pill/cyanide
	name = "cyanide pill"
	desc = ""
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/toxin/cyanide = 50)


/obj/item/reagent_containers/pill/happy
	name = "happy pill"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/sugar = 10, /datum/reagent/drug/space_drugs = 10)
	icon_state = "pill_happy"


/obj/item/reagent_containers/pill/aranesp
	name = "smooth pill"
	desc = ""
	list_reagents = list(/datum/reagent/drug/aranesp = 10)
	icon_state = "pill3"

/obj/item/reagent_containers/pill/happiness
	name = "happiness pill"
	desc = ""
	icon_state = "pill_happy"
	list_reagents = list(/datum/reagent/drug/happiness = 10)

/obj/item/reagent_containers/pill/floorpill
	name = "floorpill"
	desc = ""
	icon_state = "pill21"
	var/static/list/names = list("maintenance pill","floorpill","mystery pill","suspicious pill","strange pill")
	var/static/list/descs = list("Your feeling is telling you no, but...","Drugs are expensive, you can't afford not to eat any pills that you find."\
	, "Surely, there's no way this could go bad.")

/obj/item/reagent_containers/pill/floorpill/Initialize()
	list_reagents = list(get_random_reagent_id() = rand(10,50))
	. = ..()
	name = pick(names)
	if(prob(20))
		desc = pick(descs)

/obj/item/reagent_containers/pill/iron
	name = "iron pill"
	desc = ""
	icon_state = "pill9"
	list_reagents = list(/datum/reagent/iron = 30)
	rename_with_volume = TRUE
