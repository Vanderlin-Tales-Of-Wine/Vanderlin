/obj/item/clothing/head/helmet/heavy
	name = "helmet template"
	icon_state = "barbute"
	flags_inv = HIDEEARS|HIDEFACE
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_RIGHT|FOV_LEFT
	equip_delay_self = 3 SECONDS
	unequip_delay_self = 3 SECONDS
	emote_environment = 3		// Unknown if this actually works and what it does
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_STEEL_HELMET

	armor = ARMOR_PLATE
	body_parts_covered = FULL_HEAD
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONGEST // no moving parts, steel

/obj/item/clothing/head/helmet/heavy/necked		// includes a coif or gorget part to cover neck. Why? So templars can wear their cross on their neck basically, also special thing for Temple
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD_NECK
	prevent_crits = ALL_EXCEPT_BLUNT


//................ Iron Plate Helmet ............... //
/obj/item/clothing/head/helmet/heavy/ironplate
	name = "iron plate helmet"
	desc = "An iron masked helmet usually worn by armed men, it is a solid design yet antiquated and cheap."
	icon_state = "ironplate"
	flags_inv = HIDEEARS
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_CHEAP_IRON_HELMET

	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STRONG //isn't the same as a steel helmet but is better than a skullcap, costs 2 bars and protects the mouth

//............... Rusted Barbute ............... //
/obj/item/clothing/head/helmet/heavy/rust
	name = "rusted barbute"
	desc = "A rusted barbute. Relatively fragile, and might turn your hair brown, but offers good protection."
	icon = 'icons/roguetown/clothing/special/rust_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	icon_state = "rusthelm"
	item_state = "rusthelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR/2
	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STANDARD

//............... Great Helm ............... //
/obj/item/clothing/head/helmet/heavy/bucket
	name = "great helm"
	desc = "An immovable bulkwark of protection for the head of the faithful. Antiquated and impractical, but offering incredible defense."
	icon_state = "topfhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

	armor = ARMOR_PLATE
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/helmet/heavy/bucket/gold
	icon_state = "topfhelm_gold"


// Vampire Lord is no longer as OP, but the armor should protect against dreaded stabs or it makes the vitae spent on it pointless.
/obj/item/clothing/head/helmet/heavy/savoyard
	name = "savoyard"
	desc = "A terrifying yet crude iron helmet shaped like a humen skull. Commands the inspiring terror of inhumen tyrants from yils past."
	icon_state = "savoyard"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_HELMET+BONUS_VALUE_MODEST

	armor = ARMOR_PLATE
	prevent_crits = ALL_CRITICAL_HITS_VAMP
	max_integrity = INTEGRITY_STRONG


//............... Frog Helmet ............... //
/obj/item/clothing/head/helmet/heavy/frog
	name = "frog helmet"
	desc = "A thick, heavy helmet that severely obscures the wearer's vision. Still rather protective."
	icon_state = "froghelm"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

	armor = ARMOR_PLATE_GOOD
	prevent_crits = ALL_CRITICAL_HITS

//............... Temple heavy helmets ......................//
//............... Astrata Helmet ............... //
/obj/item/clothing/head/helmet/heavy/necked/astrata
	name = "astrata helmet"
	desc = "A great helmet decorated with a golden sigil of the solar order and a maille neck cover. The dependable companion of many holy warriors of Astrata."
	icon_state = "astratahelm"

//............... Noc Helmet ............... //
/obj/item/clothing/head/helmet/heavy/necked/noc
	name = "noc helmet"
	desc = "A sleek and rounded heavy helmet with a maille neck cover. Its unique craft is said to allow holy warriors of Noc additional insight before battle."
	icon_state = "nochelm"

//............... Necra Helmet ............... //
/obj/item/clothing/head/helmet/heavy/necked/necra
	name = "necra helmet"
	desc = "A reinforced helmet shaped into the visage of a skull with a maille neck cover under the cloth. A symbol of authority for the battle servants of the Undermaiden."
	icon_state = "necrahelm"

//............... Dendor Helmet ............... //	This one seems a bit out of place
/obj/item/clothing/head/helmet/heavy/necked/dendorhelm
	name = "dendor helmet"
	desc = "A great helmet with twisted metalwork that imitates the twisting of bark, or the horns of a beast."
	icon_state = "dendorhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	prevent_crits = ALL_EXCEPT_BLUNT

//............... Eora Helmet ............... //
/obj/item/clothing/head/helmet/sallet/eoran
	name = "eora helmet"
	desc = "A standard helmet forged in the style typical of Eoran worshippers, a simple yet practical protective piece of equipment. Upon it lays several laurels of flowers and other colorful ornaments, followed by several symbols and standards of the user's chapter, accomplishments or even punishment"
	icon_state = "eorahelm"
	item_state = "eorahelm"


//............... Pestra Helmet ............... //
/obj/item/clothing/head/helmet/heavy/necked/pestrahelm
	name = "pestran helmet"
	desc = "A great helmet made of coarse, tainted steel. It is modeled after a plagued carrion, a blessed abomination of Pestra."
	icon_state = "pestrahelm"
	item_state = "pestrahelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

//................ Malum Helmet ............. //
/obj/item/clothing/head/helmet/heavy/necked/malumhelm
	name = "malumite helmet"
	desc = "A great helmet of sturdy dark steel. Its chiseled countenance reminds the viewer of Malum's stern gaze."
	icon_state = "malumhelm"
	item_state = "malumhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

/obj/item/clothing/head/helmet/heavy/necked/ravox
	name = "ravoxian helmet"
	desc = "Headwear commonly worn by Templars in service to Ravox. It resembles an heavily adorned visored sallet."
	icon_state = "ravoxhelm"
	item_state = "ravoxhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

//............... Sinistar (Graggar) Helmet ............... //
/obj/item/clothing/head/helmet/heavy/sinistar
	name = "sinistar helmet"
	desc = "Glorious star, smeared in guts and greeted with a chorus of howls."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	icon_state = "sinistarhelm"
	dropshrink = 0.9
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/helmet/heavy/decorated	// template
	name = "a template"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	sellprice = VALUE_STEEL_HELMET+BONUS_VALUE_TINY
	var/picked = FALSE

	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/helmet/heavy/decorated/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)


//............... Decorated Knight Helmet ............... //
/obj/item/clothing/head/helmet/heavy/decorated/knight
	name = "knights helmet"
	desc = "A lavish knights helmet which allows a crest to be mounted on top."
	icon_state = "decorated_knight"

/obj/item/clothing/head/helmet/heavy/decorated/knight/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = HELMET_KNIGHT_DECORATIONS
		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

//............... Decorated Hounskull ............... //
/obj/item/clothing/head/helmet/heavy/decorated/hounskull
	name = "hounskull"
	desc = "A lavish hounskull which allows a crest to be mounted on top."
	icon_state = "decorated_hounskull"
	armor = ARMOR_PLATE_GOOD
	max_integrity = INTEGRITY_STRONG
	prevent_crits = ALL_CRITICAL_HITS


/obj/item/clothing/head/helmet/heavy/decorated/hounskull/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = HELMET_HOUNSKULL_DECORATIONS
		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

//............... Decorated Great Helm ............... //
/obj/item/clothing/head/helmet/heavy/decorated/bucket
	name = "great helm"
	desc = "A lavish great helm which allows a crest to be mounted on top."
	icon_state = "decorated_bucket"
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/helmet/heavy/decorated/bucket/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = HELMET_BUCKET_DECORATIONS
		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

//............... Decorated Gold Helm ............... //
/obj/item/clothing/head/helmet/heavy/decorated/golden
	name = "gold helm"
	desc = "A lavish gold-trimmed greathelm which allows a crest to be mounted on top."
	icon_state = "decorated_gbucket"
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/helmet/heavy/decorated/golden/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = HELMET_GOLD_DECORATIONS
		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/helmet/heavy/decorated/bascinet
	name = "bascinet"
	desc = "A simple steel helmet that can be decorated with a crest. Somewhat basic, but you'll be the envy of those who cannot afford such a fancy helmet."
	icon_state = "decorated_bascinet"
	flags_inv = HIDEEARS
	sellprice = VALUE_STEEL_HELMET
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 2 SECONDS
	block2add = null

	body_parts_covered = HEAD|HAIR|EARS

/obj/item/clothing/head/helmet/heavy/decorated/bascinet/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = BASCINET_DECORATIONS
		var/choice = input(user, "Choose a crest.", "Knightly crests") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
