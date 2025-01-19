
/obj/item/clothing/proc/step_action() //this was made to rewrite clown shoes squeaking
	SEND_SIGNAL(src, COMSIG_CLOTHING_STEP_ACTION)

/obj/item/clothing
	var/do_sound_chain = FALSE
	var/do_sound_plate = FALSE

/obj/item/clothing/Initialize()
	. = ..()
	if(do_sound_chain)
		AddComponent(/datum/component/squeak, list('sound/foley/footsteps/armor/chain (1).ogg',\
													'sound/foley/footsteps/armor/chain (2).ogg',\
													'sound/foley/footsteps/armor/chain (3).ogg'), 100)
	else if(do_sound_plate)
		AddComponent(/datum/component/squeak, list('sound/foley/footsteps/armor/plate (1).ogg',\
													'sound/foley/footsteps/armor/plate (2).ogg',\
													'sound/foley/footsteps/armor/plate (3).ogg'), 100)

/obj/item/clothing/suit/roguetown/armor
	slot_flags = ITEM_SLOT_ARMOR
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	sleevetype = "shirt"
	bloody_icon_state = "bodyblood"
	boobed = TRUE
	edelay_type = 1
	equip_delay_self = 3 SECONDS
	unequip_delay_self = 2 SECONDS
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	blade_dulling = DULLING_BASHCHOP
	nodismemsleeves = TRUE
	equip_sound = 'sound/foley/equip/equip_armor.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	pickup_sound =  'sound/blank.ogg'
	break_sound = 'sound/foley/breaksound.ogg'
	experimental_onhip = TRUE // does this do anything on armor I wonder?
//	blocking_behavior		use to block gloves when armor includes them etc
	sellprice = VALUE_COMMON_GOODS
	armor = ARMOR_MINIMAL
	body_parts_covered = CHEST
	grid_width = 64
	grid_height = 96

/obj/item/clothing/suit/roguetown/armor/medium	// Template, not for use
	name = "Medium armor template"
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 3 SECONDS
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = AC_MEDIUM
	armor = ARMOR_SCALE
	max_integrity = INTEGRITY_STANDARD
	clothing_flags = CANT_SLEEP_IN
	prevent_crits = ALL_EXCEPT_STAB


//..................................................................................................................................
/*---------------\
|			 	 |
|  Light Armor	 |
|			 	 |
\---------------*/

/*-------------\
| Padded Armor |	- Cloth based
\-------------*/
//................ Corset.................... //
/obj/item/clothing/suit/roguetown/armor/corset
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "corset"
	desc = "A leather binding to constrict one's figure... and lungs."
	icon_state = "corset"
	armor = ARMOR_PADDED
	body_parts_covered = COVERAGE_VEST

//................ Gambesson ............... //
/obj/item/clothing/suit/roguetown/armor/gambeson
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "gambeson"
	desc = "Thick quilted cloth in layers, good on its own or worn below metal as padding."
	icon_state = "gambeson"
	resistance_flags = FLAMMABLE
	blocksound = SOFTUNDERHIT
	blade_dulling = DULLING_BASHCHOP
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
//	nodismemsleeves = FALSE gambesson being ripped by hand to bandages makes no sense. OTOH it can go into shirt slot asnd its kinda fun so maybe?
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	sellprice = VALUE_GAMBESSON

	armor_class = AC_LIGHT
	armor = ARMOR_PADDED
	body_parts_covered = COVERAGE_FULL
	prevent_crits = ALL_EXCEPT_CHOP_AND_STAB

/obj/item/clothing/suit/roguetown/armor/gambeson/light
	name = "light gambeson"
	desc = "Thin and the maker skimped on the padding, typically worn by the peasantry to give some protection against cold for the whole body."
	icon_state = "gambesonl"
	color = CLOTHING_LINEN
	sellprice = VALUE_LIGHT_GAMBESSON

	armor = ARMOR_PADDED_BAD
	prevent_crits = MINOR_CRITICALS

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	name = "padded gambeson"
	desc = "Thick, padded, this will help a little even against arrows. A wise man carried steel as well, but it will do in a pinch."
	icon_state = "gambesonp"
	sellprice = VALUE_HEAVY_GAMBESSON

	armor = ARMOR_PADDED_GOOD


/obj/item/clothing/suit/roguetown/armor/gambeson/apothecary
	name = "apothecary overcoat"
	desc = "An armoured overcoat that can take a few hits. Men have lost their lives for less."
	icon_state = "apothover"
	item_state = "apothover"

	armor = ARMOR_PADDED_GOOD

/obj/item/clothing/suit/roguetown/armor/gambeson/steward
	name = "steward tailcoat"
	desc = "A thick, pristine leather tailcoat adorned with polished bronze buttons."
	sleeved = 'icons/roguetown/clothing/special/onmob/steward.dmi'
	icon_state = "stewardtailcoat"
	item_state = "stewardtailcoat"
	armor = ARMOR_PADDED_GOOD
	icon = 'icons/roguetown/clothing/special/steward.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/steward.dmi'

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dark
	color = CLOTHING_DARK_INK


//................ Padded Dress ............... //
/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dress
	name = "padded dress"
	desc = "Favored by the female nobility, to maintain both vitality and good taste while out hunting."
	icon_state = "armordress"
	allowed_race = list("human", "tiefling", "elf", "aasimar")
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	sellprice = VALUE_PADDED_DRESS

	body_parts_covered = COVERAGE_FULL

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dress/alt
	icon_state = "armordressalt"

//................ Winter Dress ............... //
/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress
	name = "winter dress"
	icon = 'icons/roguetown/clothing/shirts_royalty.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts_royalty.dmi'
	desc = "A thick, padded, and comfortable dress to maintain both temperature and safety when leaving the keep."
	body_parts_covered = COVERAGE_FULL
	icon_state = "winterdress"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts_royalty.dmi'
	boobed = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_SOOT_BLACK
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress/Destroy()
	GLOB.lordcolor -= src
	return ..()


//................ Arming Jacket ............... //
/obj/item/clothing/suit/roguetown/armor/gambeson/arming
	name = "arming jacket"
	desc = "Thick quilted cloth, a gambesson for the discerning knight. it is meant to be used under heavier armor."
	icon_state = "arming"
	sellprice = VALUE_GAMBESSON+BONUS_VALUE_MODEST

	body_parts_covered =  COVERAGE_ALL_BUT_LEGS


//................ Stalker Robe ............... //
/obj/item/clothing/suit/roguetown/armor/gambeson/shadowrobe
	name = "stalker robe"
	desc = "A robe-like gambeson of moth-eaten cloth and cheap purple dye. No self-respecting elf would be seen wearing this."
	mob_overlay_icon = 'icons/roguetown/clothing/newclothes/onmob/onmobdrip.dmi'
	sleeved = 'icons/roguetown/clothing/newclothes/onmob/sleeves_robes.dmi'
	icon_state = "shadowrobe"


//................ Striped Tunic ............... // - Light gambesson type
/obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	name = "striped tunic"
	desc = "A common tunic worn by just about anyone. Nothing special, but essential."
	icon_state = "striped"
	sleevetype = null
	sleeved = null
	nodismemsleeves = TRUE

	body_parts_covered = COVERAGE_VEST

/obj/item/clothing/suit/roguetown/armor/gambeson/light/striped/Initialize()
	color = pick(CLOTHING_SALMON, CLOTHING_BERRY_BLUE, CLOTHING_SPRING_GREEN, CLOTHING_PEAR_YELLOW)
	..()



/*--------------\
| Leather Armor |	- Medium-poor melee defense, poor arrow defense
\--------------*/

//................ Leather Armor ............... //
/obj/item/clothing/suit/roguetown/armor/leather
	name = "leather armor"
	desc = "A light armor typically made out of boiled leather. Offers slight protection from most weapons."
	icon_state = "leather"
	resistance_flags = FLAMMABLE
	blade_dulling = DULLING_BASHCHOP
	blocksound = SOFTHIT
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	smeltresult = /obj/item/ash
	sellprice = VALUE_LEATHER_ARMOR

	armor_class = AC_LIGHT
	armor = ARMOR_LEATHER_BAD
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_EXCEPT_CHOP_AND_STAB
	max_integrity = INTEGRITY_STANDARD
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/suit/roguetown/armor/leather/advanced
	name = "hardened leather coat"
	desc = "Sturdy, durable, flexible. Will keep you alive in style."
	max_integrity = 350
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 75, "slash" = 60, "stab" = 30, "piercing" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/roguetown/armor/leather/masterwork
	name = "masterwork leather coat"
	desc = "This coat is a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	icon_state = "leather"
	max_integrity = 400
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP) //we're adding chop here!
	armor = list("blunt" = 100, "slash" = 70, "stab" = 40, "piercing" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/roguetown/armor/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

//................ Hide Armor ............... //
/obj/item/clothing/suit/roguetown/armor/leather/hide
	name = "hide armor"
	desc = "A leather armor with additional internal padding of creacher fur. Offers slightly higher integrity and comfort."
	icon_state = "hidearmor"
	sellprice = VALUE_LEATHER_ARMOR_FUR

	armor = ARMOR_LEATHER
	salvage_result = /obj/item/natural/hide/cured

//................ Splint Mail ............... //
/obj/item/clothing/suit/roguetown/armor/leather/splint
	name = "splint armor"
	desc = "The smell of a leather coat, with pieces of recycled metal from old breastplates or cooking utensils riveted to the inside."
	icon_state = "splint"
	sellprice = VALUE_LEATHER_ARMOR_PLUS

	armor = ARMOR_LEATHER_GOOD
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONG


//................ Leather Vest ............... //	- has no sleeves.  - can be worn in armor OR shirt slot
/obj/item/clothing/suit/roguetown/armor/leather/vest
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "leather vest"
	desc = "Obviously no sleeves, won't really protect much but it's at least padded enough to be an armor, and can be worn against the skin snugly."
	icon_state = "vest"
	color = CLOTHING_BARK_BROWN
	blade_dulling = DULLING_BASHCHOP
	blocksound = SOFTHIT
	sewrepair = TRUE
	sleevetype = null
	sleeved = null

	armor = ARMOR_LEATHER_BAD
	body_parts_covered = COVERAGE_VEST
	prevent_crits = CUT_AND_MINOR_CRITS
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/suit/roguetown/armor/leather/vest/random/Initialize()
	color = pick(CLOTHING_SOOT_BLACK, CLOTHING_BARK_BROWN, CLOTHING_FOREST_GREEN)
	..()

//................ Butchers Vest ............... //
/obj/item/clothing/suit/roguetown/armor/leather/vest/butcher
	name = "butchers vest"
	icon_state = "leathervest"
	color = "#d69c87" // custom coloring

//................ Other Vests ............... //
/obj/item/clothing/suit/roguetown/armor/leather/vest/butler
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/suit/roguetown/armor/leather/vest/butler/Initialize()
	..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src
/obj/item/clothing/suit/roguetown/armor/leather/vest/butler/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/suit/roguetown/armor/leather/vest/black
	color = CLOTHING_DARK_INK

/obj/item/clothing/suit/roguetown/armor/leather/vest/innkeep // repath to correct padded vest some day
	name = "padded vest"
	desc = "Dyed green, belongs to the owner of the Drunken Saiga inn."
	icon_state = "striped"
	color = "#638b45"

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket
	name = "winter jacket"
	desc = "The most elegant of furs and vivid of royal dyes combined together into a most classy jacket."
	icon_state = "winterjacket"
	detail_tag = "_detail"
	color = CLOTHING_WHITE
	detail_color = CLOTHING_SOOT_BLACK

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket/Destroy()
	GLOB.lordcolor -= src
	return ..()

//................ Jacket ............... //	- Has a small storage space
/obj/item/clothing/suit/roguetown/armor/leather/jacket
	name = "tanned jacket"
	icon_state = "leatherjacketo"
	desc = "A heavy leather jacket with wooden buttons, favored by workers who can afford it."

	body_parts_covered = COVERAGE_SHIRT

/obj/item/clothing/suit/roguetown/armor/leather/jacket/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/cloak)

/obj/item/clothing/suit/roguetown/armor/leather/jacket/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/suit/roguetown/armor/leather/jacket/artijacket
	name = "artificer jacket"
	icon_state = "artijacket"
	desc = "A thick leather jacket adorned with fur and cog decals. The height of Heartfelt fashion."

//................ Sea Jacket ............... //
/obj/item/clothing/suit/roguetown/armor/leather/jacket/sea
	slot_flags = ITEM_SLOT_ARMOR
	name = "sea jacket"
	desc = "A sturdy jacket worn by daring seafarers. The leather it's made from has been tanned by the salt of Abyssor's seas."
	icon_state = "sailorvest"
	sleevetype = "shirt"

	armor = ARMOR_LEATHER
	body_parts_covered = COVERAGE_VEST

//................ Silk Coat ............... //
/obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat
	name = "silk coat"
	desc = "An expertly padded coat made from the finest silks. Long may live the nobility that dons it."
	icon_state = "bliaut"
	sleevetype = "shirt"
	sellprice = VALUE_LEATHER_ARMOR_LORD

	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	prevent_crits = CUT_AND_MINOR_CRITS

/obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat/Initialize()
	color = pick(CLOTHING_PLUM_PURPLE, CLOTHING_WHITE,CLOTHING_BLOOD_RED)
	..()

//................ Silk Jacket ............... //
/obj/item/clothing/suit/roguetown/armor/leather/jacket/apothecary
	name = "silk jacket"
	icon_state = "nightman"
	desc = "Displaying wealth while keeping your guts safe from blades with thick leather pads underneath."
	sellprice = VALUE_LEATHER_ARMOR_LORD

	body_parts_covered = COVERAGE_SHIRT

//................ Hand´s Coat ............... //
/obj/item/clothing/suit/roguetown/armor/leather/jacket/hand
	name = "noble coat"
	icon_state = "handcoat"
	desc = "A quality silken coat, discretely lined with thin metal platr on the inside to protect its affluent wearer."
	sellprice = VALUE_LEATHER_ARMOR_LORD

	body_parts_covered = COVERAGE_ALL_BUT_ARMS

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket
	name = "noble jacket"
	icon_state = "handcoat"
	icon = 'icons/roguetown/clothing/special/hand.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/hand.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/hand.dmi'
	detail_tag = "_detail"
	detail_color = CLOTHING_BERRY_BLUE
	body_parts_covered = COVERAGE_SHIRT

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/leather/jacket/handjacket/Destroy()
	GLOB.lordcolor -= src
	return ..()

//................ Amazon chainkini ............... //
/obj/item/clothing/suit/roguetown/armor/amazon_chainkini
	name = "amazonian armor"
	desc = "Fur skirt and maille chest holder, typically worn by warrior women of the isle of Issa."
	icon_state = "chainkini"
	item_state = "chainkini"
	allowed_sex = list(FEMALE)
	sewrepair = TRUE
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR_UNUSUAL

	armor_class = AC_LIGHT
	armor = ARMOR_LEATHER_GOOD
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_EXCEPT_BLUNT


//................ Copper Heart-protector ............... //
/obj/item/clothing/suit/roguetown/armor/cuirass/copperchest
	name = "heart protector"
	desc = "Very simple and crude protection for the chest. Ancient fighters once used similar gear, with better quality..."
	icon_state = "copperchest"
	item_state = "copperchest"
	smeltresult = /obj/item/ingot/copper
	sellprice = VALUE_DIRT_CHEAP

	armor_class = AC_LIGHT
	armor = ARMOR_PLATE_BAD
	body_parts_covered = CHEST
	prevent_crits = ONLY_VITAL_ORGANS
	max_integrity = INTEGRITY_POOR



//..................................................................................................................................
/*---------------\
|			 	 |
|  Medium Armor	 |
|			 	 |
\---------------*/

//................ Maille ............... //
/obj/item/clothing/suit/roguetown/armor/chainmail
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "maille"
	desc = "Made out of interlocked steel rings. Offers superior resistance against arrows, stabs and cuts. \nUsually worn as padding for proper armor, it is also called a haubergon, the little hauberk."
	icon_state = "maille"
	blocksound = CHAINHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_STEEL_ARMOR

	armor_class = AC_MEDIUM
	armor = ARMOR_MAILLE
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	prevent_crits = ALL_EXCEPT_BLUNT
	max_integrity = INTEGRITY_STRONG


//................ Iron Maille ............... //
/obj/item/clothing/suit/roguetown/armor/chainmail/iron
	name = "iron maille"
	desc = "A short-sleeved shirt made of iron rings. Offers good protection against arrows, stabs and cuts."
	icon_state = "ichainmail"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR

	armor = ARMOR_MAILLE_IRON
	body_parts_covered = COVERAGE_TORSO
	max_integrity = INTEGRITY_STANDARD


//................ Hauberk ............... //
/obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	name = "hauberk"
	desc = "A long shirt of maille, heavy on the shoulders. Can be worn as a shirt, but some men with hairy chests consider it torture."
	icon_state = "hauberk"
	item_state = "hauberk"
	sellprice = VALUE_STEEL_ARMOR_FINE

	body_parts_covered = COVERAGE_FULL
	do_sound_chain = TRUE

/*-----------------------\
|  Cuirass & Breastplate |
\-----------------------*/
// A cuirass is armor that covers both stomach and chest front as well as your back. A breastplate only covers your front torso.
//................ Steel Cuirass ............... //
/obj/item/clothing/suit/roguetown/armor/cuirass
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel cuirass"
	desc = "A cuirass of steel. Lightweight and highly durable."
	icon_state = "cuirass"
	item_state = "cuirass"
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	boobed = FALSE
	sellprice = VALUE_STEEL_ARMOR

	armor_class = AC_MEDIUM
	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONG

//................ Grenzelhoft Cuirass ............... //
/obj/item/clothing/suit/roguetown/armor/cuirass/grenzelhoft
	name = "grenzelhoft cuirass"
	desc = "Simple armor, but made from Grenzelhoftian black-steel, famed afar for its strength."
	icon_state = "grenzelcuirass"
	item_state = "grenzelcuirass"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	boobed = TRUE

	armor = ARMOR_PLATE_GOOD

//................ Black Oak Cuirass ............... //
/obj/item/clothing/suit/roguetown/armor/cuirass/elven
	name = "elven guardian cuirass"
	desc = "A cuirass made of steel with a thin decorative gold plating. Lightweight and durable."
	icon_state = "halfplate"
	item_state = "cuirasse"
	color = COLOR_ASSEMBLY_GOLD
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 2 SECONDS
	sellprice = VALUE_SNOWFLAKE_STEEL

//................ Iron Breastplate ............... //	- A breastplate is a cuirass without its back plate.
/obj/item/clothing/suit/roguetown/armor/cuirass/iron
	name = "iron breastplate"
	desc = "Many cooking pots ended their daes on the anvil to form this protective plate."
	icon_state = "ibreastplate"
	item_state = "ibreastplate"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR

	armor = ARMOR_PLATE_BAD
	body_parts_covered = COVERAGE_VEST
	max_integrity = INTEGRITY_STANDARD

//................ Rusted Breastplate ............... //
/obj/item/clothing/suit/roguetown/armor/cuirass/iron/rust
	name = "rusted breastplate"
	desc = "Old but still useful to keep sharp objects from your innards."
	icon_state = "rusthalf"
	item_state = "rusthalf"
	sellprice = VALUE_IRON_ARMOR/2

	max_integrity = INTEGRITY_POOR

//................ Scourge Breastplate ............... //
/obj/item/clothing/suit/roguetown/armor/cuirass/iron/shadowplate
	name = "scourge breastplate"
	desc = "More form over function, this armor is fit for demonstration of might rather than open combat. The aged gilding slowly tarnishes away."
	icon_state = "shadowplate"
	item_state = "shadowplate"
	allowed_race = list("elf", "dark elf")


//................ Scalemail ............... //
/obj/item/clothing/suit/roguetown/armor/medium/scale // important is how this item covers legs too compared to halfplate
	name = "scalemail"
	desc = "Overlapping steel plates almost makes the wearer look like he has silvery fish scales."
	icon_state = "scale"
	sellprice = VALUE_STEEL_ARMOR_FINE

	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	prevent_crits = ALL_CRITICAL_HITS
	max_integrity = INTEGRITY_STRONG


//................ Armored Surcoat ............... //	- splint mail looking armor thats colored
/obj/item/clothing/suit/roguetown/armor/medium/surcoat
	name = "armored surcoat"
	desc = "Metal plates partly hidden by cloth, fitted for a man."
	icon_state = "surcoat"
	item_state = "surcoat"
	detail_tag = "_metal"		// metal bits are the details so keep them uncolorer = white
	detail_color = COLOR_WHITE

/obj/item/clothing/suit/roguetown/armor/medium/surcoat/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/suit/roguetown/armor/medium/surcoat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

//................ Armored surcoat (Heartfelt) ............... //
/obj/item/clothing/suit/roguetown/armor/medium/surcoat/heartfelt
	desc = "A lordly protection in Heartfelt colors. Masterfully crafted coat of plates, for important nobility."
	color = CLOTHING_BLOOD_RED
	sellprice = VALUE_SNOWFLAKE_STEEL+BONUS_VALUE_SMALL

	body_parts_covered = COVERAGE_FULL




//..................................................................................................................................
/*---------------\
|			 	 |
|  Heavy Armor	 |
|			 	 |
\---------------*/

//................ Half-plate Armor ............... //
/obj/item/clothing/suit/roguetown/armor/plate
	name = "steel half-plate"
	desc = "Plate armor with shoulder guards. An incomplete, bulky set of excellent armor."
	icon_state = "halfplate"
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	sellprice = VALUE_STEEL_ARMOR
	clothing_flags = CANT_SLEEP_IN

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONGEST
	do_sound_plate = TRUE

//................ Full Plate Armor ............... //
/obj/item/clothing/suit/roguetown/armor/plate/full
	name = "plate armor"
	desc = "Full plate. Leg protecting tassets, groin cup, armored vambraces."
	icon_state = "plate"
	item_state = "plate"
	equip_delay_self = 8 SECONDS
	unequip_delay_self = 7 SECONDS
	sellprice = VALUE_FULL_PLATE

	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_FULL


//................ Iron Plate Armor ............... //
/obj/item/clothing/suit/roguetown/armor/plate/iron
	name = "iron plate armor"
	desc = "A rough set of iron armor, complete with chainmail joints and pauldrons. A simple and cheap design to protect vital zones, but not the arms."
	icon_state = "ironplate"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR*2

	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STRONG


//................ Rusted Half-plate ............... //
/obj/item/clothing/suit/roguetown/armor/plate/rust
	name = "rusted half-plate"
	desc = "Old glory, old defeats, most of the rust comes from damp and not the blood of previous wearers, one would hope."
	icon_state = "rustplate"
	item_state = "rustplate"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR/2

	max_integrity = INTEGRITY_STRONG


//................ Brigandine ............... //
/obj/item/clothing/suit/roguetown/armor/brigandine
	name = "brigandine"
	desc = "A coat with plates concealed inside an exterior fabric. Protects the user from melee impacts and also ranged attacks to an extent."
	icon_state = "brigandine"
	blocksound = SOFTHIT
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_BRIGANDINE
	clothing_flags = CANT_SLEEP_IN

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE_BAD
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_STAB
	do_sound_plate = TRUE

/obj/item/clothing/suit/roguetown/armor/brigandine/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/captain
	name = "captain's brigandine"
	desc = "A coat with plates specifically tailored and forged for the captain of Vanderlin."
	icon_state = "capplate"
	icon = 'icons/roguetown/clothing/special/captain.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	detail_tag = "_detail"
	detail_color = CLOTHING_BERRY_BLUE
	blocksound = SOFTHIT
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_BRIGANDINE
	clothing_flags = CANT_SLEEP_IN
	armor_class = AC_HEAVY
	armor = ARMOR_PLATE_BAD
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_STAB
	do_sound_plate = TRUE

/obj/item/clothing/suit/roguetown/armor/captain/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/suit/roguetown/armor/captain/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/suit/roguetown/armor/captain/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/suit/roguetown/armor/captain/Destroy()
	GLOB.lordcolor -= src
	return ..()

//................ Coat of Plate ............... //
/obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	name = "coat of plates"
	desc = "A Zybantine leather coat with steel scales woven with miniscule threads of adamantine, \
			ensuring the wearer an optimal defence with forgiving breathability and mobility."
	icon_state = "coat_of_plates"
	blocksound = PLATEHIT
	sellprice = VALUE_SNOWFLAKE_STEEL

	max_integrity = INTEGRITY_STRONG


//................ Snowflake Plate ............... //
/obj/item/clothing/suit/roguetown/armor/rare
	name = "rare armor template"
	icon = 'icons/roguetown/clothing/Racial_Armour.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/onmob_racial.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/onmob_racial.dmi'
	sleevetype = null
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	sellprice = VALUE_SNOWFLAKE_STEEL
	clothing_flags = CANT_SLEEP_IN

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE_GOOD
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONGEST

/obj/item/clothing/suit/roguetown/armor/rare/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/foley/footsteps/armor/fullplate (1).ogg',\
												'sound/foley/footsteps/armor/fullplate (2).ogg',\
												'sound/foley/footsteps/armor/fullplate (3).ogg'), 80)

/obj/item/clothing/suit/roguetown/armor/rare/elfplate
	name = "dark elf plate"
	desc = "A fine suit of sleek, moulded dark elf metal. Its interlocking nature and light weight allow for increased maneuverability."
	icon_state = "elfchest"
	allowed_race = list("elf", "half-elf", "dark elf")
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 2 SECONDS

	armor_class = AC_MEDIUM // Elven craft, also a cuirass
	body_parts_covered = COVERAGE_VEST

/obj/item/clothing/suit/roguetown/armor/rare/elfplate/welfplate
	name = "elvish plate"
	desc = "A suit of steel interwoven, through honed elven technique, with hardened bark plates."
	icon_state = "welfchest"

/obj/item/clothing/suit/roguetown/armor/rare/dwarfplate
	name = "dwarvish plate"
	desc = "Plate armor made out of the sturdiest, finest dwarvish metal armor. It's as heavy and durable as it gets."
	icon_state = "dwarfchest"
	allowed_race = list("dwarf")

/obj/item/clothing/suit/roguetown/armor/rare/grenzelplate
	name = "grenzelhoftian plate regalia"
	desc = "Engraved on this masterwork of humen metallurgy lies \"Thrice Slain, Thrice Risen, Thrice Pronged\" alongside the symbol of Psydon in its neck guard."
	icon_state = "human_swordchest"
	allowed_race = list("human")
	allowed_sex = list(MALE)

/obj/item/clothing/suit/roguetown/armor/rare/zybanplate
	name = "kataphractoe scaleskin"
	desc = "Steel scales woven into armor with miniscule threads of adamantine, \
			ensuring the wearer optimal defence with forgiving breathability. \
			The sigil of the Zybantu Kataphractoe is embezzeled at the throat guard."
	icon_state = "human_spearchest"
	allowed_race = list("human")
	allowed_sex = list(MALE)

// Aasimar hoplite armor, a very rare armor indeed
/obj/item/clothing/suit/roguetown/armor/rare/hoplite
	name = "ancient plate armor"
	desc = "A battered set of bronze plate armor. Intricate runes and carvings once adorned the pieces, but most have faded with age."
	icon = 'icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/armor.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_armor.dmi'
	icon_state = "aasimarplate"
	allowed_race = list("aasimar")
	smeltresult = null // No bronze ingots yet, unfortunately
	sellprice = VALUE_SNOWFLAKE_STEEL+BONUS_VALUE_MODEST // It has great value to historical collectors

	body_parts_covered = COVERAGE_ALL_BUT_ARMS



//..................................................................................................................................
/*-----------------\
| Antagonist Armor |
\-----------------*/


//................ Ancient Ceremonial Plate ............... //
/obj/item/clothing/suit/roguetown/armor/cuirass/vampire
	name = "ancient plate"
	desc = "A ornate, ceremonial plate cuirass of considerable age."
	icon_state = "vplate"

	armor_class = AC_MEDIUM
	armor = ARMOR_PLATE_GOOD
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_CRITICAL_HITS_VAMP

//................ Ancient Haubergon ............... //
/obj/item/clothing/suit/roguetown/armor/haubergon_vampire
	name = "ancient haubergon"
	desc = "A style of armor long out of use. Rests easy on the shoulders."
	icon_state = "vunder"
	blocksound = CHAINHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_IRON_ARMOR_UNUSUAL

	armor_class = AC_LIGHT
	armor = ARMOR_SCALE
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	prevent_crits = ALL_EXCEPT_BLUNT


//................ Blacksteel Plate ............... //
/obj/item/clothing/suit/roguetown/armor/plate/blkknight
	name = "blacksteel plate"
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	armor_class = AC_MEDIUM
	icon_state = "bkarmor"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/blacksteel


// VAMPIRE ARMORS BELOW

/obj/item/clothing/under/roguetown/platelegs/vampire
	name = "ancient plate greaves"
	desc = ""
	gender = PLURAL
	icon_state = "vpants"
	item_state = "vpants"
	sewrepair = FALSE
	armor = ARMOR_PLATE_GOOD
	prevent_crits = ALL_CRITICAL_HITS_VAMP // Vampire armors don't protect against lashing, Castlevania reference
	blocksound = PLATEHIT
	do_sound = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD

/obj/item/clothing/suit/roguetown/shirt/vampire
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "regal silks"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	prevent_crits = list(BCLASS_BITE, BCLASS_TWIST)
	icon_state = "vrobe"
	item_state = "vrobe"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/head/roguetown/vampire
	name = "crown of darkness"
	icon_state = "vcrown"
	body_parts_covered = null
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = null
	sellprice = 1000
	resistance_flags = FIRE_PROOF

/obj/item/clothing/shoes/roguetown/boots/armor/vampire
	name = "ancient ceremonial boots"
	desc = "Antediluvian boots with ceremonial ornamets from ages past."
	body_parts_covered = FEET
	icon_state = "vboots"
	item_state = "vboots"
	prevent_crits = ALL_CRITICAL_HITS_VAMP
	color = null
	blocksound = PLATEHIT
	smeltresult = /obj/item/ingot/steel
	armor = ARMOR_PLATE_GOOD

/obj/item/clothing/gloves/roguetown/chain/vampire
	name = "ancient ceremonial gloves"
	icon_state = "vgloves"
	smeltresult = /obj/item/ingot/steel
