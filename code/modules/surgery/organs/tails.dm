// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

/obj/item/organ/tail
	name = "tail"
	desc = ""
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	visible_organ = TRUE
	var/tail_type = "None"

/obj/item/organ/tail/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(H && H.dna && H.dna.species)
		H.dna.species.stop_wagging_tail(H)

/obj/item/organ/tail/cat
	name = "cat tail"
	desc = ""
	tail_type = "Cat"

/obj/item/organ/tail/lizard
	name = "lizard tail"
	desc = ""
	color = "#116611"
	tail_type = "Smooth"
	var/spines = "None"
