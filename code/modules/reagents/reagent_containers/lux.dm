/obj/item/reagent_containers/lux
	name = "lux"
	desc = "The stuff of life and souls, retrieved from within a hopefully-willing donor. It's a bit clammy and squishy, like a half-fried egg."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "lux"
	item_state = "lux"
	possible_transfer_amounts = list()
	volume = 15
	list_reagents = list(/datum/reagent/lux = 5)
	grind_results = list(/datum/reagent/lux = 5)
	sellprice = 500

/datum/reagent/lux
	name = "Lux"
	description = "The extracted and processed essence of life."
	color = "#7d8e98" // rgb: 96, 165, 132
	overdose_threshold = 10
	metabolization_rate = 0.1

/datum/reagent/lux/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, 0.25*REM)
	M.adjustFireLoss(0.25*REM, 0)
	..()
	. = 1

/datum/reagent/lux/on_mob_life(mob/living/carbon/M)
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction()
	if(M.has_status_effect(/datum/status_effect/buff/lux_drained))
		M.remove_status_effect(/datum/status_effect/buff/lux_drained)
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, apply_status_effect), /datum/status_effect/buff/lux_drained), 5 MINUTES)
		to_chat(M, span_green("I can feel my soul again, albeit temporarily!"))
	M.apply_status_effect(/datum/status_effect/buff/lux_drank)
	..()
