
/obj/item/clothing/wrists/wrappings
	name = "solar wrappings"
	desc = "Common Astratan vestments for the forearms."
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "wrappings"
	item_state = "wrappings"

/obj/item/clothing/wrists/nocwrappings
	name = "moon wrappings"
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "nocwrappings"
	item_state = "nocwrappings"

//Aasimar hoplite bracers
/obj/item/clothing/wrists/bracers/hoplite
	name = "ancient bracers"
	desc = "Stalwart bronze bracers, from an age long past."
	icon_state = "aasimarwrist"
	item_state = "aasimarwrist"
	armor = list("blunt" = 70, "slash" = 70, "stab" = 70,  "piercing" = 50, "fire" = 0, "acid" = 0) // Less protection than steel
	smeltresult = /obj/item/ingot/bronze

//copper bracers

/obj/item/clothing/wrists/bracers/copper
	name = "copper bracers"
	desc = "Copper forearm guards that offer some protection while looking rather stylish."
	body_parts_covered = ARMS
	icon_state = "copperarm"
	item_state = "copperarm"
	armor = list("blunt" = 50, "slash" = 50, "stab" = 50,  "piercing" = 60, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	smeltresult = /obj/item/ingot/copper
	blocksound = PLATEHIT
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE

//Queensleeves
/obj/item/clothing/wrists/royalsleeves
	name = "royal sleeves"
	desc = "Sleeves befitting an elaborate gown."
	slot_flags = ITEM_SLOT_WRISTS
	icon_state = "royalsleeves"
	item_state = "royalsleeves"
	detail_tag = "_detail"
	detail_color = CLOTHING_SOOT_BLACK

/obj/item/clothing/wrists/royalsleeves/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/wrists/royalsleeves/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/wrists/royalsleeves/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/wrists/royalsleeves/Destroy()
	GLOB.lordcolor -= src
	return ..()
