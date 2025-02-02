/obj/item/reagent_containers/glass/cup
	name = "metal cup"
	desc = "An iron cup, it's rim gnawed upon and grimey."
	icon = 'modular/Neu_Food/icons/cooking.dmi'
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "iron"
	force = 5
	throwforce = 10
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	volume = 24
	obj_flags = CAN_BE_HIT
	sellprice = 1
	drinksounds = list('sound/items/drink_cup (1).ogg','sound/items/drink_cup (2).ogg','sound/items/drink_cup (3).ogg','sound/items/drink_cup (4).ogg','sound/items/drink_cup (5).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	gripped_intents = list(INTENT_POUR)

/obj/item/reagent_containers/glass/cup/update_icon(dont_fill=FALSE)
	testing("cupupdate")

	cut_overlays()

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('modular/Neu_Food/icons/cooking.dmi', "[icon_state]filling")

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		add_overlay(filling)

/obj/item/reagent_containers/glass/cup/wooden
	name = "wooden cup"
	desc = "A wooden cup that has seen it's fair share of use and barfights."
	resistance_flags = FLAMMABLE
	icon_state = "wooden"
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	metalizer_result = /obj/item/reagent_containers/glass/cup

/obj/item/reagent_containers/glass/cup/steel
	name = "goblet"
	desc = "A steel goblet that bears a few dents from previous scuffles."
	icon_state = "steel"
	sellprice = 10

/obj/item/reagent_containers/glass/cup/silver
	name = "silver goblet"
	desc = "A silver goblet, its surface adorned with intricate carvings and runes."
	icon_state = "silver"
	sellprice = 30
	last_used = 0
	is_silver = TRUE

/obj/item/reagent_containers/glass/cup/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.dna && H.dna.species)
			if(istype(H.dna.species, /datum/species/werewolf))
				return FALSE
	if(M.mind && M.mind.has_antag_datum(/datum/antagonist/vampirelord))
		return FALSE

/obj/item/reagent_containers/glass/cup/golden
	name = "golden goblet"
	desc = "A golden gilded goblet which gleams pathetically despite it's illustrious metal."
	icon_state = "golden"
	sellprice = 50

/obj/item/reagent_containers/glass/cup/skull
	name = "skull goblet"
	desc = "The hollow eye sockets tell you of forgotten, dark rituals."
	icon_state = "skull"
