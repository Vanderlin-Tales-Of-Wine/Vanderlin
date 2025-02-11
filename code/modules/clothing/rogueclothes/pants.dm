/obj/item/clothing/under/roguetown
	slot_flags = ITEM_SLOT_PANTS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	body_parts_covered = GROIN|LEGS
	resistance_flags = FLAMMABLE // Most made of cloth
	prevent_crits = list(BCLASS_LASHING)
	icon = 'icons/roguetown/clothing/pants.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_pants.dmi'
	sleevetype = "leg"
	equip_delay_self = 30
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	anvilrepair = null
	r_sleeve_zone = BODY_ZONE_R_LEG
	l_sleeve_zone = BODY_ZONE_L_LEG
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	dropshrink = 0.8
	max_integrity = INTEGRITY_WORST

/obj/item/clothing/under/roguetown/AdjustClothes(mob/user)
#ifdef MATURESERVER
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_t"
			body_parts_covered = null
			slowdown += 2
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_pants()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_pants()
#else
	return
#endif

/obj/item/clothing/under/roguetown/tights
	name = "tights"
	desc = "Comfortable loose pants."
	gender = PLURAL
	icon_state = "tights"
	item_state = "tights"
//	adjustable = CAN_CADJUST

/obj/item/clothing/under/roguetown/tights/random/Initialize()
	color = RANDOM_PEASANT_DYES
	..()

/obj/item/clothing/under/roguetown/tights/uncolored
	color = CLOTHING_LINEN

/obj/item/clothing/under/roguetown/tights/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/under/roguetown/tights/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/under/roguetown/tights/purple
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/under/roguetown/tights/green
	color = CLOTHING_FOREST_GREEN

/obj/item/clothing/under/roguetown/tights/jester
	desc = "Funny tights!"
	color = CLOTHING_SALMON

/obj/item/clothing/under/roguetown/tights/lord
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/under/roguetown/tights/vagrant
	r_sleeve_status = SLEEVE_TORN
	body_parts_covered = GROIN|LEG_LEFT
	torn_sleeve_number = 1

/obj/item/clothing/under/roguetown/tights/vagrant/l
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_TORN
	body_parts_covered = GROIN|LEG_RIGHT

/obj/item/clothing/under/roguetown/tights/vagrant/Initialize()
	color = pick(CLOTHING_MUD_BROWN, CLOTHING_OLD_LEATHER, CLOTHING_SPRING_GREEN, CLOTHING_BARK_BROWN, CLOTHING_CANVAS	)
	..()

/obj/item/clothing/under/roguetown/tights/sailor
	name = "pants"
	icon_state = "sailorpants"

/obj/item/clothing/under/roguetown/webs
	name = "webbing"
	desc = "A fine webbing made from spidersilk, popular fashion within the underdark."
	gender = PLURAL
	icon_state = "webs"
	item_state = "webs"
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/under/roguetown/trou/leather/mourning
	name = "mourning trousers"
	desc = "Dark trousers worn by morticians while performing burial rites."
	icon_state = "leathertrou"
	color = "#151615"

/obj/item/clothing/under/roguetown/trou/shadowpants
	name = "silk tights"
	desc = "Form-fitting legwear. Almost too form-fitting."
	mob_overlay_icon = 'icons/roguetown/clothing/newclothes/onmob/onmobsilkpants.dmi'
	sleeved = 'icons/roguetown/clothing/newclothes/onmob/sleeves_pants.dmi'
	icon_state = "shadowpants"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	salvage_amount = 1
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/under/roguetown/trou/apothecary
	name = "apothecary trousers"
	desc = "Heavily padded trousers. They're stained by countless herbs."
	icon_state = "apothpants"
	item_state = "apothpants"

/obj/item/clothing/under/roguetown/trou/artipants
	name = "artificer trousers"
	desc = "Thick leather trousers to protect from sparks or stray gear projectiles. Judging by the wear, its had plenty of use."
	icon_state = "artipants"
	item_state = "artipants"

/obj/item/clothing/under/roguetown/trou/leathertights
	name = "leather tights"
	desc = "Classy leather tights, form-fitting but tasteful."
	icon_state = "leathertights"
	item_state = "leathertights"

/obj/item/clothing/under/roguetown/trou/beltpants
	name = "belt-buckled trousers"
	desc = "Dark leather trousers adorned with far too many buckles to be pragmatic."
	icon_state = "beltpants"
	item_state = "beltpants"

/obj/item/clothing/under/roguetown/loincloth
	name = "loincloth"
	desc = "Protects your modesty, but not much else."
	icon_state = "loincloth"
	item_state = "loincloth"
//	adjustable = CAN_CADJUST
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	fiber_salvage = FALSE
	salvage_amount = 1

/obj/item/clothing/under/roguetown/loincloth/brown
	color = CLOTHING_BARK_BROWN

/obj/item/clothing/under/roguetown/loincloth/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/under/roguetown/loincloth/pink
	color = "#b98ae3"

/obj/item/clothing/under/roguetown/skirt
	name = "skirt"
	desc = "Long, flowing, and modest."
	icon_state = "skirt"
	item_state = "skirt"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'

/obj/item/clothing/under/roguetown/skirt/random
	name = "skirt"

/obj/item/clothing/under/roguetown/skirt/random/Initialize()
	..()
	color = pick(CLOTHING_SALMON, CLOTHING_BERRY_BLUE, CLOTHING_SPRING_GREEN, CLOTHING_PEAR_YELLOW)

/obj/item/clothing/under/roguetown/skirt/blue
	color = CLOTHING_BERRY_BLUE

/obj/item/clothing/under/roguetown/skirt/green
	color = CLOTHING_SPRING_GREEN

/obj/item/clothing/under/roguetown/skirt/red
	color = CLOTHING_RED_OCHRE
//..................................................................................................................................
/*---------------\
|			 	 |
|  Light Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/under/roguetown/trou
	name = "work trousers"
	desc = "Padded pants for hardy workers."
	gender = PLURAL
	icon_state = "trou"
	item_state = "trou"
//	adjustable = CAN_CADJUST
	sewrepair = TRUE
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

	armor = ARMOR_PADDED_BAD
	prevent_crits = MINOR_CRITICALS
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/under/roguetown/trou/leather
	name = "leather trousers"
	desc = "Standard leather pants for hardy workers."
	icon_state = "leathertrou"
	armor = ARMOR_LEATHER
	max_integrity = INTEGRITY_POOR

/obj/item/clothing/under/roguetown/trou/leather/advanced
	name = "hardened leather chausses"
	desc = "Sturdy, durable, flexible. The finest leather to protect your nether regions."
	max_integrity = 200
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 70, "slash" = 60, "stab" = 30, "piercing" = 20,"fire" = 0, "acid" = 0)

/obj/item/clothing/under/roguetown/trou/leather/masterwork
	name = "masterwork leather chausses"
	desc = "These chausses are a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	max_integrity = 250
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP)
	armor = list("blunt" = 100, "slash" = 70, "stab" = 40, "piercing" = 20, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/roguetown/trou/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

/obj/item/clothing/under/roguetown/grenzelpants
	name = "grenzelhoftian paumpers"
	desc = "Padded pants for extra comfort and protection, adorned in vibrant colors."
	icon_state = "grenzelpants"
	item_state = "grenzelpants"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	detail_tag = "_detail"
	colorgrenz = TRUE
	armor = ARMOR_PADDED
	prevent_crits = MINOR_CRITICALS
	max_integrity = INTEGRITY_STANDARD

/obj/item/clothing/under/roguetown/grenzelpants/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)


//..................................................................................................................................
/*---------------\
|			 	 |
|  Medium Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/under/roguetown/chainlegs
	name = "chain chausses"
	desc = "Chain mail chausses made of exquisite steel rings boasting superior protection."
	gender = PLURAL
	icon_state = "chain_legs"
	item_state = "chain_legs"
//	adjustable = CAN_CADJUST
	sewrepair = FALSE
	resistance_flags = FIRE_PROOF
	blocksound = CHAINHIT
	equip_delay_self = 25
	unequip_delay_self = 25
	var/do_sound = FALSE
	equip_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	pickup_sound = "rustle"
	break_sound = 'sound/foley/breaksound.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD

	armor_class = AC_MEDIUM
	armor = ARMOR_MAILLE
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_BLUNT
	do_sound_chain = TRUE


/obj/item/clothing/under/roguetown/chainlegs/iron
	icon_state = "ichain_legs"
	name = "iron chain chausses"
	desc = "Chain mail chausses made of iron rings woven together, offering protection against cuts and stabs."
	smeltresult = /obj/item/ingot/iron
	armor = ARMOR_MAILLE_IRON
	max_integrity = INTEGRITY_STRONG


//..................................................................................................................................
/*---------------\
|			 	 |
|  Heavy Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/under/roguetown/platelegs
	name = "plated chausses"
	desc = "Cuisses made of plated steel, offering additional protection against blunt force."
	gender = PLURAL
	icon_state = "heavyleggies" // Finally a sprite
	item_state = "heavyleggies"
	// adjustable = CAN_CADJUST
	sewrepair = FALSE
	blocksound = PLATEHIT
	equip_delay_self = 30
	unequip_delay_self = 30
	resistance_flags = FIRE_PROOF
	var/do_sound = FALSE
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	pickup_sound = "rustle"
	break_sound = 'sound/foley/breaksound.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	clothing_flags = CANT_SLEEP_IN

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_STAB
	do_sound_plate = TRUE

/obj/item/clothing/under/roguetown/platelegs/captain
	name = "captain's chausses"
	desc = "Cuisses made of plated steel, offering additional protection against blunt force. These are specially fitted for the captain."
	icon_state = "capplateleg"
	item_state = "capplateleg"
	icon = 'icons/roguetown/clothing/special/captain.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/captain.dmi'

/obj/item/clothing/under/roguetown/platelegs/rust
	name = "rusted chausses"
	desc = "Old rusted chausses made of plated iron. They'll still protect your legs quite well."
	icon = 'icons/roguetown/clothing/special/rust_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	icon_state = "rustpants"
	item_state = "rustpants"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR/2
	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STANDARD
