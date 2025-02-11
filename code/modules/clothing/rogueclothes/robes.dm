/obj/item/clothing/suit/roguetown/shirt/robe
	slot_flags = ITEM_SLOT_ARMOR
	name = "robe"
	desc = "A common robe, worn mostly by religious adepts."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	icon_state = "white_robe"
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	flags_inv = HIDEBOOB
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	resistance_flags = FLAMMABLE
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP

	armor = ARMOR_MINIMAL
	prevent_crits = list(BCLASS_TWIST)
	max_integrity = INTEGRITY_POOR

/obj/item/clothing/suit/roguetown/shirt/robe/plain
	color = CLOTHING_LINEN

/obj/item/clothing/suit/roguetown/shirt/robe/black
	color = CLOTHING_DARK_INK

/obj/item/clothing/suit/roguetown/shirt/robe/white


//................ Temple Robes ............... //
/obj/item/clothing/suit/roguetown/shirt/robe/astrata
	name = "sun robe"
	desc = "The cloth of a follower of Astrata."
	icon_state = "astratarobe"
	sleeved = null

/obj/item/clothing/suit/roguetown/shirt/robe/noc
	name = "moon robe"
	desc = "The cloth of a follower of Noc."
	icon_state = "nocrobe"
	sleeved = null

/obj/item/clothing/suit/roguetown/shirt/robe/necromancer
	name = "necromancer robes"
	desc = "Eerie black garb of death."
	icon_state = "warlock"
	sleeved = null

/obj/item/clothing/suit/roguetown/shirt/robe/dendor
	name = "briar robe"
	desc = "Nature nurtures us and we, in turn, will nurture it back in the end."
	icon_state = "dendorrobe"

/obj/item/clothing/suit/roguetown/shirt/robe/eora
	name = "eoran robe"
	desc = "Holy robes, intended for use by followers of Eora"
	icon_state = "eorarobes"

/obj/item/clothing/suit/roguetown/shirt/robe/eora/alt
	name = "eoran straps"
	desc = "Sanctified, form fitting straps. Used by more radical followers of the Eoran Church"
	icon_state = "eorastraps"

/obj/item/clothing/suit/roguetown/shirt/robe/necra
	name = "mourning robe"
	desc = "Black robes which cover the body not unlike those in depictions of the Carriageman himself."
	icon_state = "necrarobe"

/obj/item/clothing/suit/roguetown/shirt/robe/priest
	name = "solar vestments"
	desc = "Holy vestments sanctified by divine hands. Caution is advised if not a faithful."
	icon_state = "priestrobe"
	dropshrink = 0.8

/obj/item/clothing/suit/roguetown/shirt/robe/priest/pickup(mob/living/user)
	if((user.job != "Priest") && (user.job != "Priestess"))
		user.visible_message(span_reallybig("UNWORTHY HANDS TOUCH MY VISAGE, CEASE OR BE PUNISHED"))
		playsound(user, 'sound/misc/astratascream.ogg', 80,  falloff = 0.2)
		spawn(30)
			if(loc == user)
				user.adjust_divine_fire_stacks(5)
				user.IgniteMob()
	..()



//................ Wizard Robes ............... //
/obj/item/clothing/suit/roguetown/shirt/robe/courtmage
	color = CLOTHING_ASH_GREY

/obj/item/clothing/suit/roguetown/shirt/robe/mage/Initialize()
	color = pick( CLOTHING_PEASANT_BROWN, CLOTHING_SPRING_GREEN, CLOTHING_CHESTNUT, CLOTHING_YELLOW_OCHRE)
	. = ..()

/obj/item/clothing/suit/roguetown/shirt/robe/wizard
	name = "wizard's robe"
	desc = "What wizard's ensemble would be complete without robes?"
	icon_state = "wizardrobes"
	allowed_sex = list(MALE)
	allowed_race = list("human", "tiefling", "aasimar")
	sellprice = 100

/obj/item/clothing/suit/roguetown/shirt/robe/magus
	name = "magus's robe"
	desc = "A dark padded robe worn by only the most mysterious of mages, the magi."
	icon_state = "warlock"
	allowed_sex = list(MALE)
	allowed_race = list("human", "tiefling", "aasimar")
	sellprice = 150

	armor = list("blunt" = 40, "slash" = 40, "stab" = 40,  "piercing" = 15, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_TWIST)
	max_integrity = 200



/obj/item/clothing/suit/roguetown/shirt/robe/merchant
	name = "guilder jacket"
	desc = "A fancy jacket common with members of the Mercator Guild."
	icon_state = "merrobe"
	sellprice = 30

/obj/item/clothing/suit/roguetown/shirt/robe/nun
	icon_state = "nun"
	item_state = "nun"
	allowed_race = list("human", "tiefling", "dark elf", "elf", "half-elf", "dwarf", "aasimar")
	allowed_sex = list(FEMALE)

/obj/item/clothing/suit/roguetown/shirt/robe/feld
	name = "feldsher's robe"
	desc = "Red to hide the blood."
	icon_state = "feldrobe"
	item_state = "feldrobe"

/obj/item/clothing/suit/roguetown/shirt/robe/phys
	name = "physicker's robe"
	desc = "Part robe, part butcher's apron."
	icon_state = "surgrobe"
	item_state = "surgrobe"


