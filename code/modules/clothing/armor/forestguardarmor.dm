/obj/item/clothing/armor/forrester
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "forrester armour"
	desc = "Armour worn by the Veterans of the Goblin War, who presently serve in the Forest Guard of Vanderlin."
	icon_state = "foresthide"
	blocksound = CHAINHIT
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sellprice = VALUE_LEATHER_ARMOR

	armor_class = AC_MEDIUM
	armor = ARMOR_FORESTGUARD
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/cloak/forrestercloak
	name = "forrester cloak"
	desc = "A makeshift cloak constructed with mud, sticks and fibers."
	icon_state = "forestcloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE


/obj/item/clothing/cloak/wardencloak
	name = "warden cloak"
	desc = "A makeshift cloak constructed with mud, sticks and fibers."
	icon_state = "wardencloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE

/obj/item/clothing/head/helmet/visored/warden
	name = "wardens's helmet"
	desc = "An elegant barbute, fitted with the gold trim and polished metal of nobility."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	icon_state = "wardenhelm"

/obj/item/clothing/head/helmet/medium/decorated	// template
	name = "a template"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
	bloody_icon = 'icons/effects/blood.dmi'
	bloody_icon_state = "helmetblood"
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	sellprice = VALUE_IRON_HELMET
	var/picked = FALSE

	prevent_crits = ALL_EXCEPT_STAB

/obj/item/clothing/head/helmet/medium/decorated/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/helmet/medium/decorated/skullmet
	name = "skullmet"
	desc = "A lavish knights helmet which allows a crest to be mounted on top."
	icon_state = "skullmet_volf"

/obj/item/clothing/head/helmet/medium/decorated/skullmet/attack_right(mob/user)
	..()
	if(!picked)
		var/list/icons = SKULLMET_ICONS
		var/choice = input(user, "Choose a helmet design.", "Helmet designs") as anything in icons
		var/playerchoice = icons[choice]
		picked = TRUE
		icon_state = playerchoice
		item_state = playerchoice
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()
