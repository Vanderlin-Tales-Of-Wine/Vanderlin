//..................................................................................................................................
/*---------------\
|			 	 |
|  Light Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/neck/coif
	name = "leather coif"
	desc = "A simple coif made of boiled leather, not that good as armor itself but mostly useful as padding for proper helmets."
	icon_state = "coif"
	item_state = "coif"
	flags_inv = HIDEEARS|HIDEHAIR
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	blocksound = SOFTHIT
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	sewrepair = TRUE
	anvilrepair = null
	resistance_flags = FLAMMABLE // Made of leather
	smeltresult = /obj/item/ash

	armor = ARMOR_LEATHER
	body_parts_covered = NECK|HAIR|EARS|HEAD
	max_integrity = INTEGRITY_POOR
	prevent_crits = CUT_AND_MINOR_CRITS


/obj/item/clothing/neck/coif/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEEARS|HIDEHAIR
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_neck()
					H.update_inv_head()

/obj/item/clothing/neck/coif/cloth
	name = "padded coif"
	desc = "A simple coif made of cloth. Not very effective armor, but may soften weak blows and keeps the head and neck warm."
	icon_state = "ccoif"
	flags_inv = HIDEEARS|HIDEHAIR
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	blocksound = SOFTHIT
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE

	armor = ARMOR_PADDED
	body_parts_covered = NECK|HAIR|EARS|HEAD
	prevent_crits = MINOR_CRITICALS


//..................................................................................................................................
/*---------------\
|			 	 |
|  Medium Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/neck/chaincoif
	name = "chain coif"
	desc = "A coif made of interwoven steel rings, made to protect against arrows and blades. \
			Generally used as padding, but serviceable enough on its own."
	icon_state = "chaincoif"
	flags_inv = HIDEEARS|HIDEHAIR
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_HEAD
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	break_sound = 'sound/foley/breaksound.ogg'
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	blocksound = CHAINHIT
	smeltresult = null
	clothing_flags = CANT_SLEEP_IN

	armor = ARMOR_MAILLE
	body_parts_covered = NECK|HAIR|EARS|HEAD
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_BLUNT


/obj/item/clothing/neck/chaincoif/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEEARS|HIDEHAIR
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_neck()
					H.update_inv_head()


/obj/item/clothing/neck/chaincoif/iron
	icon_state = "ichaincoif"
	name = "iron chain coif"
	desc = "A chain coif made of interwoven iron rings. Affordable protection against arrows and blades, \
			but should be used as padding rather than relied upon as armor."
	smeltresult = null

	armor = ARMOR_MAILLE_IRON
	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/neck/gorget/copper
	name = "neck protector"
	icon_state = "copperneck"
	desc = "An antique and simple protection for the neck, used more as an accessory by the common folk. But poor protection is still better than nothing."
	smeltresult = /obj/item/ingot/copper

	armor = ARMOR_LEATHER_GOOD
	max_integrity = INTEGRITY_POOR


//..................................................................................................................................
/*---------------\
|			 	 |
|  Heavy Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/neck/bevor
	name = "bevor"
	desc = "A piece of plate armor meant to protect the throat and neck of its wearer against decapitation, extending the protection of armor plates."
	icon_state = "bervor"
	flags_inv = HIDEFACIALHAIR
	smeltresult = /obj/item/ingot/steel
	equip_sound = 'sound/foley/equip/equip_armor.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	break_sound = 'sound/foley/breaksound.ogg'
	slot_flags = ITEM_SLOT_NECK
	blocksound = PLATEHIT
	clothing_flags = CANT_SLEEP_IN

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE
	body_parts_covered = NECK|EARS|MOUTH|NOSE
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_STAB

/obj/item/clothing/neck/gorget
	name = "gorget"
	icon_state = "gorget"
	desc = "An affordable piece of iron armor meant to protect one's neck against chopping. \
			Fits comfortably beneath chest armor, despite its weight."
	flags_inv = HIDEFACIALHAIR
	resistance_flags = FIRE_PROOF
	slot_flags = ITEM_SLOT_NECK
	blocksound = PLATEHIT
	equip_sound = 'sound/foley/equip/equip_armor.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	break_sound = 'sound/foley/breaksound.ogg'
	smeltresult = /obj/item/ingot/iron
	clothing_flags = CANT_SLEEP_IN

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE_BAD
	body_parts_covered = NECK
	max_integrity = INTEGRITY_STRONG
	prevent_crits = ALL_EXCEPT_STAB

/obj/item/clothing/neck/gorget/hoplite // Better than an iron gorget, not quite as good as a steel bevor
	name = "bronze gorget"
	desc = "A heavy collar of great age, meant to protect the neck."
	icon_state = "aasimarneck"
	smeltresult = /obj/item/ingot/bronze
	armor = ARMOR_MAILLE_GOOD

/obj/item/clothing/neck/highcollier
	name = "high collier"
	desc = "A more durable, thicker, piece of chain neck protection, though, this one only covers the neck, ears and mouth when pulled up."
	icon_state = "high_collier"
	icon = 'icons/roguetown/clothing/special/coif.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/coif.dmi'
	body_parts_covered = NECK|MOUTH|EARS
	slot_flags = ITEM_SLOT_NECK
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	armor = ARMOR_MAILLE_GOOD
	resistance_flags = FIRE_PROOF
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	break_sound = 'sound/foley/breaksound.ogg'
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	blocksound = CHAINHIT
	smeltresult = null
	clothing_flags = CANT_SLEEP_IN
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_BLUNT

/obj/item/clothing/neck/highcollier/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			body_parts_covered = NECK
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_neck()
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEFACE|HIDEFACIALHAIR
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_neck()

/obj/item/clothing/neck/highcollier/iron
	name = "iron high collier"
	desc = "A thicker piece of chain neck protection made from iron, though, this one only covers the neck and mouth when pulled up."
	icon_state = "ihigh_collier"
	armor = ARMOR_MAILLE
	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/neck/talkstone
	name = "talkstone"
	desc = "A bizarre, enchanted necklace. Allows you to bridge the gap between languages."
	icon_state = "talkstone"
	item_state = "talkstone"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 98

/obj/item/clothing/neck/horus
	name = "eye of horuz"
	desc = ""
	icon_state = "horus"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 30

/obj/item/clothing/neck/shalal
	name = "desert rider medal"
	desc = ""
	icon_state = "shalal"
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 15

/obj/item/clothing/neck/shalal/emir
	name = "desert noble medal"

/obj/item/clothing/neck/feld
	name = "feldsher's collar"
	desc = "Fits snug."
	icon_state = "feldcollar"
	item_state = "feldcollar"
	sellprice = 15

/obj/item/clothing/neck/phys
	name = "physicker's collar"
	desc = "Fits snug."
	icon_state = "surgcollar"
	item_state = "surgcollar"
	sellprice = 15

/obj/item/clothing/neck/bogcowl
	name = "bogcowl"
	desc = "An odd cowl made using mud, sticks, and fibers."
	icon_state = "bogcowl"

/obj/item/clothing/neck/elfears
	name = "elfear necklace"
	desc = "A grim necklace made to show off the wearer's macabre collection of cut off elf ears."
	icon_state = "elfears"

/obj/item/clothing/neck/menears
	name = "menear necklace"
	desc = "A grim necklace made to show off the wearer's macabre collection of cut off humen ears."
	icon_state = "menears"
