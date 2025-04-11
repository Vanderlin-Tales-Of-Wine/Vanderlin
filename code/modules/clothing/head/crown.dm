/obj/item/clothing/head/crown		// doesn't hide hair
	dynamic_hair_suffix = ""				// this just means hair does not change when item is worn
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/clothing/head/crown/circlet
	name = "golden circlet"
	icon_state = "goldcirclet"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/crown/nyle
	name = "jewel of nyle"
	icon_state = "nile"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/crown/nyle/consortcrown
	name = "jewel of nyle"
	icon_state = "consortcrown"
	sellprice = VALUE_GOLD_ITEM


/obj/item/clothing/head/crown/serpcrown
	name = "crown of Vanderlin"
	desc = "Heavy is the weight of the crown, and even heavier the responsibility it infers to its wearer."
	icon_state = "serpcrown"
	sellprice = VALUE_EXTREME
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF|UNACIDABLE|INDESTRUCTIBLE

/obj/item/clothing/head/crown/serpcrown/Initialize()
	. = ..()
	name = "crown of [SSmapping.config.map_name]"
	if(type == /obj/item/clothing/head/crown/serpcrown && !istype(loc, /mob/living/carbon/human/dummy)) //dummies spawn this in character setup
		SSroguemachine.crown = src

/obj/item/clothing/head/crown/serpcrown/proc/anti_stall()
	src.visible_message(span_warning("[src] crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	SSroguemachine.crown = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/clothing/head/crown/serpcrown/surplus
	name = "crown"
	desc = "A replacement for the Crown of Vanderlin, every bit as valid as proof of sovereignity as the original."
	icon_state = "serpcrowno"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/crown/sparrowcrown
	name = "champions circlet"
	desc = "Winner of tournaments, bask in Ravox's glory."
	icon_state = "sparrowcrown"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/crown/circlet/vision
	name = "mystical circlet"
	desc = "A shining gold circlet, with a mysterious purple insert. You feel like you have a third eye while near it..."
	icon_state = "visioncirclet"
	item_state = "visioncirclet"
	sellprice = VALUE_MAGIC_ITEM_STRONG

/obj/item/clothing/head/crown/circlet/vision/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_HEAD && istype(user))
		ADD_TRAIT(user, TRAIT_THERMAL_VISION,"thermal_vision")
	else
		REMOVE_TRAIT(user, TRAIT_THERMAL_VISION,"thermal_vision")

//............... Nosleep Circlet ............... //
/obj/item/clothing/head/crown/circlet/sleepless
	name = "clouded circlet"
	desc = "A shining gold circlet, with a mysterious blue insert. You feel more energetic while near it..."
	icon_state = "sleepcirclet"
	item_state = "sleepcirclet"
	sellprice = VALUE_MAGIC_ITEM_WEAK

/obj/item/clothing/head/crown/circlet/sleepless/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_HEAD && istype(user))
		ADD_TRAIT(user, TRAIT_NOSLEEP,"Fatal Insomnia")
	else
		REMOVE_TRAIT(user, TRAIT_NOSLEEP,"Fatal Insomnia")

//............... Stink Immunity Circlet ............... //
/obj/item/clothing/head/crown/circlet/stink
	name = "numbing circlet"
	desc = "A shining gold circlet, with a mysterious green insert. You feel your sense of smell numb while near it..."
	icon_state = "stinkcirclet"
	item_state = "stinkcirclet"
	sellprice = VALUE_MAGIC_ITEM_WEAK

/obj/item/clothing/head/crown/circlet/stink/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_HEAD && istype(user))
		ADD_TRAIT(user, TRAIT_NOSTINK,"Dead Nose")
	else
		REMOVE_TRAIT(user, TRAIT_NOSTINK,"Dead Nose")
