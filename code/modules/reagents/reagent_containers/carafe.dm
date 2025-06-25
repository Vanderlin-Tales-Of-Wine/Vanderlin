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
	reagent_flags = OPENCONTAINER
	w_class = WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	sellprice = 5
	gripped_intents = list(INTENT_POUR)

/obj/item/reagent_containers/glass/carafe/silver
	name = "silver carafe"
	desc = "A shining silver container with a flared lip, most often used for serving water and wine"
	icon_state = "silver_carafe"
	fill_icon_thresholds = null
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
	if(M.mind && M.mind.has_antag_datum(/datum/antagonist/vampire))
		return FALSE

/obj/item/reagent_containers/glass/carafe/gold
	name = "golden carafe"
	desc = "An opulent golden container with a flared lip, most often used for serving water and wine"
	icon_state = "gold_carafe"
	fill_icon_thresholds = null
	dropshrink = 0.8
	sellprice = 65

/* Spawning full */

/obj/item/reagent_containers/glass/carafe/water
	list_reagents = list(/datum/reagent/water = 96)

/obj/item/reagent_containers/glass/carafe/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 96)

/obj/item/reagent_containers/glass/carafe/silver/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 96)

/obj/item/reagent_containers/glass/carafe/gold/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 96)
