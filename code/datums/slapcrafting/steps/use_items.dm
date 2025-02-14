/datum/slapcraft_step/use_item/sewing/needle
	desc =  "Using a needle sew the seams."
	item_types = list(/obj/item/needle)

/datum/slapcraft_step/use_item/carpentry/hammer
	desc = "Hammer the wooden joints together"
	item_types = list(/obj/item/rogueweapon/hammer)

/datum/slapcraft_step/use_item/carpentry/hammer/second

/datum/slapcraft_step/use_item/carpentry/hammer/get_speed_multiplier(mob/living/user, obj/item/item, obj/item/slapcraft_assembly/assembly)
	. = ..()
	var/obj/item/rogueweapon/hammer/hammer = item
	. *= hammer.time_multiplier

/datum/slapcraft_step/use_item/masonry/hammer
	desc = "Hammer the stones in place."
	start_verb = "for"
	item_types = list(/obj/item/rogueweapon/hammer)

/datum/slapcraft_step/use_item/masonry/hammer/second

/datum/slapcraft_step/use_item/masonry/hammer/get_speed_multiplier(mob/living/user, obj/item/item, obj/item/slapcraft_assembly/assembly)
	. = ..()
	var/obj/item/rogueweapon/hammer/hammer = item
	. *= hammer.time_multiplier

/datum/slapcraft_step/use_item/engineering/hammer
	desc = "Hammer the mechanical parts together"
	item_types = list(/obj/item/rogueweapon/hammer)

/datum/slapcraft_step/use_item/engineering/hammer/second

/datum/slapcraft_step/use_item/engineering/hammer/get_speed_multiplier(mob/living/user, obj/item/item, obj/item/slapcraft_assembly/assembly)
	. = ..()
	var/obj/item/rogueweapon/hammer/hammer = item
	. *= hammer.time_multiplier
