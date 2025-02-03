/obj/item/clothing/head/roguetown/helmet/rousman
	name = "stomachgutter helmet"
	icon_state = "stomachgutter_helm_item"
	item_state = "stomachgutter_helm"
	smeltresult = /obj/item/ingot/iron
	icon = 'icons/roguetown/mob/monster/rousman.dmi'
	allowed_race = list("rousman")
	armor = list("blunt" = 80, "slash" = 80, "stab" = 80,  "piercing" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = HEAD|EARS|HAIR|EYES
	sellprice = 0

/obj/item/clothing/suit/roguetown/armor/cuirass/iron/rousman
	name = "stomachgutter plate armor"
	icon_state = "stomachgutter_armor_item"
	item_state = "stomachgutter_armor"
	icon = 'icons/roguetown/mob/monster/rousman.dmi'
	smeltresult = /obj/item/ingot/iron
	armor = list("blunt" = 80, "slash" = 80, "stab" = 80,  "piercing" = 0, "fire" = 0, "acid" = 0)
	allowed_race = list("rousman")
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	anvilrepair = /datum/skill/craft/armorsmithing
	max_integrity = 60
	armor_class = AC_LIGHT
	sellprice = 0

/obj/item/clothing/suit/roguetown/armor/leather/hide/rousman
	name = "rousman loincloth"
	icon_state = "rousman_loincloth_item"
	item_state = "rousman_loincloth"
	icon = 'icons/roguetown/mob/monster/rousman.dmi'
	allowed_race = list("rousman")
	armor = list("blunt" = 30, "slash" = 30, "stab" = 30,  "piercing" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN
	sellprice = 0
	smeltresult = /obj/item/ash
