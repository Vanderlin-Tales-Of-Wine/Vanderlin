
/obj/item/clothing/gloves/roguetown
	slot_flags = ITEM_SLOT_GLOVES
	body_parts_covered = HANDS
	sleeved = 'icons/roguetown/clothing/onmob/gloves.dmi'
	icon = 'icons/roguetown/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/gloves.dmi'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	bloody_icon_state = "bloodyhands"
	sleevetype = "shirt"
	max_heat_protection_temperature = 361
	resistance_flags = FIRE_PROOF
	sewrepair = TRUE
	anvilrepair = null
	smeltresult = /obj/item/ash
	max_integrity = INTEGRITY_WORST
	sewrepair = TRUE
	fiber_salvage = FALSE
	salvage_amount = 1


//..................................................................................................................................
/*---------------\
|			 	 |
|  Light Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/gloves/roguetown/leather
	name = "leather gloves"
	desc = "Gloves made out of sturdy leather. Warm, and offer very small protection against melee attacks."
	icon_state = "leather_gloves"
	resistance_flags = null
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	resistance_flags = FLAMMABLE // Made of leather

	armor = ARMOR_PADDED_BAD
	prevent_crits = CUT_AND_MINOR_CRITS
	max_integrity = INTEGRITY_POOR
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/gloves/roguetown/leather/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/gloves/roguetown/leather/advanced
	name = "hardened leather gloves"
	desc = "Sturdy, durable, flexible. A marvel of the dark ages that exists solely to protect your fingers."
	max_integrity = 200
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 50, "slash" = 40, "stab" = 20, "piercing" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/gloves/roguetown/leather/masterwork
	name = "masterwork leather gloves"
	desc = "These gloves are a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	max_integrity = 300
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP) //we're adding chop here!
	armor = list("blunt" = 80, "slash" = 60, "stab" = 40, "piercing" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/gloves/roguetown/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

/obj/item/clothing/gloves/roguetown/leather/feld
	name = "feldsher's gloves"
	desc = "Improved grip for wielding the tools of the trade."
	icon_state = "feldgloves"

/obj/item/clothing/gloves/roguetown/leather/phys
	name = "physicker's gloves"
	desc = "Improved grip for wielding disembowled organs."
	icon_state = "surggloves"

/obj/item/clothing/gloves/roguetown/leather/apothecary
	name = "apothecary gloves"
	desc = "Thick leather gloves for pulling thorny plants... or cracking skulls."
	icon_state = "apothgloves"


/obj/item/clothing/gloves/roguetown/fingerless
	name = "fingerless gloves"
	desc = "Gloves made out of sturdy leather with the fingers cut off for extra dexterity. They offer almost no protection whatsoever."
	icon_state = "fingerless_gloves"
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	resistance_flags = FLAMMABLE // Made of leather

	armor = ARMOR_MINIMAL
	max_integrity = INTEGRITY_POOR

/obj/item/clothing/gloves/roguetown/fingerless/shadowgloves
	name = "silk gloves"
	desc = "Silk gloves to absorb palm sweat while leaving the fingers free for fine manipulation."
	mob_overlay_icon = 'icons/roguetown/clothing/newclothes/onmob/onmobgloves.dmi'
	sleeved = 'icons/roguetown/clothing/newclothes/onmob/onmobgloves.dmi'
	icon_state = "shadowgloves"
	salvage_result = /obj/item/natural/silk


/obj/item/clothing/gloves/roguetown/angle
	name = "heavy leather gloves"
	desc = "A heavier pair of leather gloves with extra padding. These look like they can take some beating. Fair melee protection and decent durability."
	icon_state = "angle"
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	resistance_flags = FLAMMABLE // Made of leather

	armor = ARMOR_LEATHER
	prevent_crits = ALL_EXCEPT_CHOP_AND_STAB
	max_integrity = INTEGRITY_STANDARD
	salvage_result = /obj/item/natural/fur

/obj/item/clothing/gloves/roguetown/angle/grenzel
	name = "grenzelhoft gloves"
	desc = "Regal gloves of Grenzelhoftian design, more a fashion statement than actual protection."
	icon_state = "grenzelgloves"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'



//..................................................................................................................................
/*---------------\
|			 	 |
|  Medium Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/gloves/roguetown/chain
	name = "chain gauntlets"
	desc = "Gauntlets made out of interwoven steel chains. Average melee protection, though better used to stop arrows from being lethal."
	icon_state = "cgloves"
	resistance_flags = null
	blocksound = CHAINHIT
	blade_dulling = DULLING_BASHCHOP
	equip_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	pickup_sound = "rustle"
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = null
	sewrepair = FALSE

	armor_class = AC_MEDIUM
	armor = ARMOR_MAILLE
	prevent_crits = ALL_EXCEPT_BLUNT
	max_integrity = INTEGRITY_STRONGEST
	sewrepair = FALSE

/obj/item/clothing/gloves/roguetown/chain/iron
	name = "iron chain gauntlets"
	icon_state = "icgloves"
	desc = "Gauntlets made out of interwoven iron chains. Decent melee protection, but are better suited to stop arrows than blades."
	armor = ARMOR_MAILLE_IRON
	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/gloves/roguetown/chain/iron/shadowgauntlets
	name = "darkplate gauntlets"
	desc = "Gauntlets with gilded fingers fashioned into talons. The tips are all too dull to be of harm."
	icon_state = "shadowgauntlets"
	allowed_race = list("elf", "dark elf")


//..................................................................................................................................
/*---------------\
|			 	 |
|  Heavy Armor	 |
|			 	 |
\---------------*/

/obj/item/clothing/gloves/roguetown/plate
	name = "plate gauntlets"
	desc = "Plated gauntlets made out of steel. Offers the best protection against melee attacks."
	icon_state = "gauntlets"
	blocksound = PLATEHIT
	equip_delay_self = 25
	unequip_delay_self = 25
	body_parts_covered = ARMS|HANDS
	blade_dulling = DULLING_BASH
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	pickup_sound = "rustle"
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/iron //no 1 to 1 conversion

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONGEST

	grid_width = 64
	grid_height = 32

/obj/item/clothing/gloves/roguetown/rare
	icon = 'icons/roguetown/clothing/Racial_Armour.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/onmob_racial.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/onmob_racial.dmi'
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	pickup_sound = "rustle"
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	sleevetype = null
	blocksound = PLATEHIT
	body_parts_covered = HANDS
	blade_dulling = DULLING_BASH
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE_GOOD
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/gloves/roguetown/rare/elfplate
	name = "dark elf plate gauntlets"
	desc = "Plate gauntlets of mystic dark elven alloy, lightweight yet incredibly protective. Typically worn by elite bladesingers."
	icon_state = "elfhand"
	allowed_race = list("elf", "half-elf", "dark elf")

/obj/item/clothing/gloves/roguetown/rare/elfplate/welfplate
	name = "elvish plate gauntlets"
	desc = "Plate gauntlets of mystic elven alloy, lightweight yet incredibly protective. Typically worn by elite bladesingers."
	icon_state = "welfhand"

/obj/item/clothing/gloves/roguetown/rare/dwarfplate
	name = "dwarvish plate gauntlets"
	desc = "Plated gauntlets of masterwork dwarven smithing, the pinnacle of protection for one's hands."
	icon_state = "dwarfhand"
	allowed_race = list("dwarf")
	allowed_sex = list(MALE, FEMALE)

/obj/item/clothing/gloves/roguetown/rare/grenzelplate
	name = "grenzelhoftian plate gauntlets"
	desc = "Battling the Zybantus led to the exchange of military ideas. The Grenzelhoft adopted refined chain and plate armaments to better allow their knights unmatchable resilience against the enemies of their Empire."
	icon_state = "human_swordhand"
	allowed_race = list("human")
	allowed_sex = list(MALE)

/obj/item/clothing/gloves/roguetown/rare/zybanplate
	name = "kataphractoe claw gauntlets"
	desc = "Interwoven beautifully with layers of silk, chain and plate, these gauntlets grant unmatched coverage while allowing maximum mobility. Both useful to the Zybantu's ever-growing slave-empire."
	icon_state = "human_spearhand"
	allowed_race = list("human")
	allowed_sex = list(MALE)
