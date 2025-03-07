/obj/item/reagent_containers/glass/carafe
	name = "glass carafe"
	desc = "A slightly grimey glass container with a flared lip, most often used for serving water and wine"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "glass_carafe"
	w_class = WEIGHT_CLASS_SMALL
	amount_per_transfer_from_this = 12 // Half a cup
	possible_transfer_amounts = list(12)
	volume = 96 // Four full cups
	fill_icon_thresholds = list(0, 25, 50, 75, 100)
	dropshrink = 0.7
	obj_flags = CAN_BE_HIT
	spillable = TRUE
	var/closed = FALSE
	reagent_flags = OPENCONTAINER
	w_class = WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	sellprice = 5
	gripped_intents = list(INTENT_POUR)

/obj/item/reagent_containers/glass/carafe/update_icon(dont_fill=FALSE)
	if(!fill_icon_thresholds || dont_fill)
		return

	cut_overlays()
	underlays.Cut()

	if(reagents.total_volume)
		var/fill_name = fill_icon_state? fill_icon_state : icon_state
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[fill_name][fill_icon_thresholds[1]]")

		var/percent = round((reagents.total_volume / volume) * 100)
		for(var/i in 1 to fill_icon_thresholds.len)
			var/threshold = fill_icon_thresholds[i]
			var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
			if(threshold <= percent && percent < threshold_end)
				filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		underlays += filling

	if(closed)
		add_overlay("[icon_state]cork")

/obj/item/reagent_containers/glass/carafe/silver
	name = "silver carafe"
	desc = "A shining silver container with a flared lip, most often used for serving water and wine"
	icon_state = "silver_carafe"
	dropshrink = 0.8
	sellprice = 45
	last_used = 0
	is_silver = TRUE

/obj/item/reagent_containers/glass/carafe/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.dna && H.dna.species)
			if(istype(H.dna.species, /datum/species/werewolf))
				return FALSE
	if(M.mind && M.mind.has_antag_datum(/datum/antagonist/vampirelord))
		return FALSE

/obj/item/reagent_containers/glass/carafe/gold
	name = "golden carafe"
	desc = "An opulent golden container with a flared lip, most often used for serving water and wine"
	icon_state = "gold_carafe"
	dropshrink = 0.8
	sellprice = 65

/* Spawning full */

/obj/item/reagent_containers/glass/carafe/water
	list_reagents = list(/datum/reagent/water = 96)

/obj/item/reagent_containers/glass/carafe/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/redwine = 96)

/obj/item/reagent_containers/glass/carafe/silver/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/redwine = 96)

/obj/item/reagent_containers/glass/carafe/gold/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/redwine = 96)
