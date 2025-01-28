/obj/item/cooking/pan
	name = "frypan"
	icon_state = "pan"
	experimental_inhand = FALSE

	force = 20
	throwforce = 15
	possible_item_intents = list(/datum/intent/mace/strike/shovel)
	wlength = WLENGTH_SHORT
	sharpness = IS_BLUNT
	slot_flags = ITEM_SLOT_HIP
	can_parry = TRUE
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	wdefense = ULTMATE_PARRY
	ingsize = 3

/obj/item/cooking/pan/examine(mob/user)
	. = ..()
