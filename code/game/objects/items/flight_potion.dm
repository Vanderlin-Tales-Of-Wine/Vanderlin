/obj/item/reagent_containers/glass/bottle/potion
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "potionflask"

/obj/item/reagent_containers/glass/bottle/potion/flight
	name = "strange elixir"
	desc = ""
	list_reagents = list(/datum/reagent/flightpotion = 5)

/obj/item/reagent_containers/glass/bottle/potion/update_icon()
	if(reagents.total_volume)
		icon_state = "potionflask"
	else
		icon_state = "potionflask_empty"

/datum/reagent/flightpotion
	name = "Flight Potion"
	description = "Strange mutagenic compound of unknown origins."
	reagent_state = LIQUID
	color = "#FFEBEB"

/datum/reagent/flightpotion/reaction_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		var/mob/living/carbon/C = M
		var/holycheck = ishumanbasic(C)
		if(!(holycheck || reac_volume < 5))// implying xenohumans are holy //as with all things,
			if(method == INGEST && show_message)
				to_chat(C, "<span class='notice'><i>I feel nothing but a terrible aftertaste.</i></span>")
			return ..()

		to_chat(C, "<span class='danger'>A terrible pain travels down my back as wings burst out!</span>")
		C.dna.species.GiveSpeciesFlight(C)
		if(holycheck)
			to_chat(C, "<span class='notice'>I feel blessed!</span>")
			ADD_TRAIT(C, TRAIT_HOLY, SPECIES_TRAIT)
		playsound(C.loc, 'sound/blank.ogg', 50, TRUE, -1)
		C.adjustBruteLoss(20)
		C.emote("scream")
	..()
