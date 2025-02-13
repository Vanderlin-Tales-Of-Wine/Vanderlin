/obj/item/clothing/head/roguetown
	slot_flags = ITEM_SLOT_HEAD
	name = "hat"
	desc = ""
	icon = 'icons/roguetown/clothing/head.dmi'
	icon_state = "surghood"
	dynamic_hair_suffix = "+generic"
	bloody_icon_state = "helmetblood"
	equip_sound = "rustle"
	pickup_sound = "rustle"
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	resistance_flags = FLAMMABLE
	sewrepair = TRUE
	anvilrepair = null
	smeltresult = /obj/item/ash // Helmets have pre-defined smeltresults, this is for hats
	body_parts_covered = COVERAGE_SKULL
	sellprice = VALUE_CHEAP_CLOTHING

	max_integrity = INTEGRITY_WORST

/obj/item/clothing/head/roguetown/equipped(mob/user, slot)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/roguetown/dropped(mob/user)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/roguetown/padded	// slightly armored subtype for convenience
	armor = ARMOR_MINIMAL
	prevent_crits = MINOR_CRITICALS

/obj/item/clothing/head/roguetown/crown		// doesn't hide hair
	dynamic_hair_suffix = ""				// this just means hair does not change when item is worn
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing


//................ Simple Hats ............... //
/obj/item/clothing/head/roguetown/menacing
	name = "sack hood"
	desc = "A crude way to conceal one's identity, these are usually worn by local brigands to not get recognised."
	icon_state = "menacing"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	fiber_salvage = FALSE

/obj/item/clothing/head/roguetown/strawhat
	name = "crude straw hat"
	desc = "Welcome to the grain fields, thou plowerer of the fertile."
	icon_state = "strawhat"
	salvage_result = /obj/item/natural/fibers

/obj/item/clothing/head/roguetown/fisherhat
	name = "straw hat"
	desc = "Wenches shall lust for thee. Fishe will fear thee. \
			Humen will cast their gaze aside. As thou walk, \
			no creecher shall dare make a sound on thy presence. \
			Thou wilt be alone on these barren lands."
	icon_state = "fisherhat"

/obj/item/clothing/head/roguetown/stewardtophat
	name = "top hat"
	icon_state = "stewardtophat"
	icon = 'icons/roguetown/clothing/special/steward.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/roguetown/knitcap
	name = "knit cap"
	desc = "A crude peasant cap worn by about every serf under Astrata's radiance."
	icon_state = "knitcap"

/obj/item/clothing/head/roguetown/headband
	name = "headband"
	desc = "A piece of cloth worn around the temple."
	icon_state = "headband"
	dynamic_hair_suffix = ""
	fiber_salvage = FALSE
	salvage_amount = 1

/obj/item/clothing/head/roguetown/headband/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/head/roguetown/softcap
	name = "soft cap"
	desc = "A white cap worn by most manual laborers to protect from sunburn."
	icon_state = "armingcap"
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/shawl
	name = "shawl"
	desc = "Keeps the hair in check, and looks proper."
	icon_state = "shawl"
	flags_inv = HIDEEARS

/obj/item/clothing/head/roguetown/brimmed
	desc = "A simple brimmed hat that provides some relief from the sun."
	icon_state = "brimmed"

/obj/item/clothing/head/roguetown/articap
	desc = "A sporting cap with a small gear adornment. Popular fashion amongst Heartfelt engineers."
	icon_state = "articap"

//................ Fur Hats ............... //
/obj/item/clothing/head/roguetown/hatfur
	name = "fur hat"
	desc = "A hat made of fur typically worn by guildsmen."
	icon_state = "hatfur"

/obj/item/clothing/head/roguetown/hatblu
	name = "fur hat"
	icon_state = "hatblu"

/obj/item/clothing/head/roguetown/papakha
	name = "papakha"
	desc = "A fuzzy helmet of fur typically worn by frontiersmen of the far steppes."
	icon_state = "papakha"
	sellprice = VALUE_FINE_CLOTHING
	max_integrity = INTEGRITY_POOR


//................ Chaperon Hat ............... //
/obj/item/clothing/head/roguetown/chaperon
	name = "chaperon hat"
	icon_state = "chaperon"
	flags_inv = HIDEEARS
	sellprice = VALUE_FINE_CLOTHING

/obj/item/clothing/head/roguetown/chaperon/greyscale
	name = "chaperon hat"
	desc = "A comfortable and fashionable headgear."
	icon_state = "chap_alt"
	flags_inv = HIDEEARS
	color = CLOTHING_LINEN
/obj/item/clothing/head/roguetown/chaperon/greyscale/random/Initialize()
	. = ..()
	color = RANDOM_NOBLE_DYES

/obj/item/clothing/head/roguetown/chaperon/greyscale/silk
	icon_state = "chap_silk"
/obj/item/clothing/head/roguetown/chaperon/greyscale/silk/random/Initialize()
	. = ..()
	color = RANDOM_NOBLE_DYES

/obj/item/clothing/head/roguetown/chaperon/greyscale/chaperonsecondary
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/head/roguetown/chaperon/greyscale/chaperonsecondary/Initialize()
	..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/head/roguetown/chaperon/greyscale/chaperonsecondary/lordcolor(primary,secondary)
	if(secondary)
		color = secondary

/obj/item/clothing/head/roguetown/chaperon/greyscale/chaperonsecondary/Destroy()
	GLOB.lordcolor -= src
	return ..()

//................ Cook Hat ............... //
/obj/item/clothing/head/roguetown/cookhat
	name = "cook hat"
	desc = "A white top hat typically worn by distinguished kitchen workers."
	icon_state = "chef"
	item_state = "chef"
	flags_inv = HIDEEARS

//................ Fancy Hats ............... //
/obj/item/clothing/head/roguetown/nun
	name = "nun's habit"
	desc = "Habits worn by nuns of the pantheon's faith."
	icon_state = "nun"
	allowed_race = list("human", "tiefling", "elf", "dwarf", "aasimar")

/obj/item/clothing/head/roguetown/fancyhat
	name = "fancy hat"
	icon_state = "fancyhat"
	sellprice = VALUE_FINE_CLOTHING

/obj/item/clothing/head/roguetown/courtierhat
	name = "fancy hat"
	icon_state = "courtier"
	flags_inv = HIDEEARS
	sellprice = VALUE_FINE_CLOTHING

/obj/item/clothing/head/roguetown/bardhat
	name = "plumed hat"
	desc = "A simple leather hat with a fancy plume on top. A corny attempt at appearing regal \
			despite one's status. Typically worn by travelling minstrels of all kinds."
	icon_state = "bardhat"

/obj/item/clothing/head/roguetown/antlerhood
	name = "antlerhood"
	desc = "a hood suited for druids and shamans."
	color = null
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "antlerhood"
	item_state = "antlerhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	max_integrity = 100
	armor = list("blunt" = 16, "slash" = 19, "stab" = 15,  "piercing" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_TWIST)
	anvilrepair = null
	sewrepair = TRUE
	blocksound = SOFTHIT
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide

/obj/item/clothing/head/roguetown/helmet/leather/saiga
	name = "saiga skull"
	desc = "Skull from big game. Looks like it could withstand some damage."
	icon_state = "saigahead"
	item_state = "saigahead"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	armor = list("blunt" = 60, "slash" = 40, "stab" = 45,  "piercing" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES

/*------\
| Hoods |	- Defined as can be toggled
\------*/

/obj/item/clothing/head/roguetown/roguehood
	name = "hood"
	desc = "Conceals your face, whether against the rain, or the gazes of others."
	icon_state = "basichood"
	dynamic_hair_suffix = ""
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	var/default_hidden = null

	body_parts_covered = NECK
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide

/obj/item/clothing/head/roguetown/roguehood/uncolored
	color = CLOTHING_LINEN

/obj/item/clothing/head/roguetown/roguehood/brown
	color = CLOTHING_BARK_BROWN

/obj/item/clothing/head/roguetown/roguehood/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/head/roguetown/roguehood/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/head/roguetown/roguehood/green
	color = CLOTHING_FOREST_GREEN

/obj/item/clothing/head/roguetown/roguehood/random/Initialize()
	color = pick( CLOTHING_PEASANT_BROWN, CLOTHING_SPRING_GREEN, CLOTHING_CHESTNUT, CLOTHING_YELLOW_OCHRE)
	..()

/obj/item/clothing/head/roguetown/roguehood/mage/Initialize()
	color = pick(CLOTHING_MAGE_BLUE, CLOTHING_MAGE_GREEN, CLOTHING_MAGE_ORANGE, CLOTHING_MAGE_YELLOW)
	..()

/obj/item/clothing/head/roguetown/roguehood/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
			body_parts_covered = NECK|HAIR|EARS|HEAD
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
			block2add = FOV_BEHIND
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = default_hidden
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()



/*------------\
| Temple hats |	- Minor armor to encourage Temple characters to retain them.
\------------*/

//................ Moon Hood ............... //		- Basic Noc Acolyte
/obj/item/clothing/head/roguetown/roguehood/nochood
	name = "moon hood"
	desc = "The face of the Moon Prince. Worn by the faitful of Noc."
	icon_state = "nochood"
	flags_inv = HIDEEARS|HIDEHAIR
	default_hidden = HIDEEARS|HIDEHAIR
	dropshrink = 0.8

	armor = ARMOR_WEAK
	prevent_crits = MINOR_CRITICALS


//................ Death Face ............... //
/obj/item/clothing/head/roguetown/padded/deathface
	name = "death shroud"
	desc = "When inducted into the cult of Necra, the supplicant must make a talisman from the remains of a deceased loved one. Many favor a chin-guard made from a jawbone."
	icon_state = "deathface"
	flags_inv = HIDEEARS | HIDEHAIR | HIDEFACIALHAIR

	armor = ARMOR_WEAK
	prevent_crits = MINOR_CRITICALS

//................ Death Shroud ............... //	- Necra headwear that conceals indentity
/obj/item/clothing/head/roguetown/padded/deathshroud
	name = "death shroud"
	desc = "Worn by the faithful of Necra, or less savory individuals."
	icon_state = "necrahood"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR


//................ Briar Thorns ............... //	- Dendor Briar
/obj/item/clothing/head/roguetown/padded/briarthorns
	name = "briar thorns"
	desc = "The pain it causes perhaps can distract from the whispers of a mad God overpowering your sanity..."
	icon_state = "briarthorns"

/obj/item/clothing/head/roguetown/padded/briarthorns/pickup(mob/living/user)
	. = ..()
	to_chat(user, span_warning ("The thorns prick me."))
	user.adjustBruteLoss(4)


//................ Opera Visage ............... //	- Basic Eora Acolyte
/obj/item/clothing/head/roguetown/padded/operavisage
	name = "opera visage"
	desc = "A painted wooden opera mask worn by the faithful of Eora, usually during their rituals."
	icon_state = "eoramask"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	dynamic_hair_suffix = ""
	salvage_result = /obj/item/natural/silk

//................ Opera Hood ............... //	- The "upgraded" headwear for Eoran acolytes
/obj/item/clothing/head/roguetown/roguehood/eora
	name = "opera hood"
	desc = "A silver opera mask worn by the faithful of Eora, usually during their rituals. Comes with a hood that can be pulled up for warmth."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "eorahood"
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	resistance_flags = FIRE_PROOF // Made of metal
	armor = ARMOR_WEAK
	salvage_result = NUTRITION_LEVEL_HUNGRY


//................ Sun Hood ............... //	- Basic Astrata Acolyte
/obj/item/clothing/head/roguetown/roguehood/astrata
	name = "sun hood"
	desc = "Worn by the faithful of Astrata."
	icon_state = "astratahood"
	resistance_flags = FIRE_PROOF // Not the sun hat!

	armor = ARMOR_MINIMAL
	prevent_crits = MINOR_CRITICALS

//................ Solar Visage ............... //	- The new improved Priest headwear. Integratged magic resist so don't need the null ring, and inverted toggle.
/obj/item/clothing/head/roguetown/roguehood/priest
	name = "solar visage"
	desc = "The sanctified headwear of the most devoted. The mask can be removed."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "solar"
	dynamic_hair_suffix = "+generic"
	dropshrink = 0.8
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	default_hidden = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	resistance_flags = FIRE_PROOF

	armor = ARMOR_WEAK
	body_parts_covered = FULL_HEAD | NECK
	prevent_crits = MINOR_CRITICALS

/obj/item/clothing/head/roguetown/roguehood/priest/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "rustle", 70, TRUE, -5)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = HIDEEARS|HIDEHAIR
			body_parts_covered = NECK|HAIR|EARS|HEAD
			dynamic_hair_suffix = "+generic"
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = default_hidden
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()

/obj/item/clothing/head/roguetown/roguehood/priest/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_HEAD && istype(user))
		ADD_TRAIT(user, TRAIT_ANTIMAGIC,"Anti-Magic")
	else
		REMOVE_TRAIT(user, TRAIT_ANTIMAGIC,"Anti-Magic")

/obj/item/clothing/head/roguetown/roguehood/priest/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_ANTIMAGIC,"Anti-Magic")

/obj/item/clothing/head/roguetown/roguehood/priest/pickup(mob/living/user)
	if((user.job != "Priest") && (user.job != "Priestess"))
		playsound(user, 'sound/misc/astratascream.ogg', 80,  falloff = 0.2)
		user.visible_message(span_reallybig("UNWORTHY HANDS TOUCH MY VISAGE, CEASE OR BE PUNISHED"))
		spawn(30)
			if(loc == user)
				user.adjust_divine_fire_stacks(3)
				user.IgniteMob()
		return
	else
		. = ..()

//................ Solar Visage (old) ............... //		- Old priest hat
/obj/item/clothing/head/roguetown/priestmask
	name = "solar visage"
	desc = "The sanctified helm of the most devoted. Thieves beware."
	icon_state = "priesthead"
	dynamic_hair_suffix = ""
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/roguetown/priestmask/pickup(mob/living/user)
	if((user.job != "Priest") && (user.job != "Priestess"))
		to_chat(user, "<font color='yellow'>UNWORTHY HANDS TOUCH THE VISAGE, CEASE OR BE PUNISHED</font>")
		spawn(30)
			if(loc == user)
				user.adjust_divine_fire_stacks(5)
				user.IgniteMob()
		return
	else
		. = ..()


/*----------\
| Rare hats |	- Not craftable but importable usually
\-----------*/

//................ Golden Circlet ............... //
/obj/item/clothing/head/roguetown/crown/circlet
	name = "golden circlet"
	icon_state = "goldcirclet"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/roguetown/crown/nyle
	name = "jewel of nyle"
	icon_state = "nile"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/roguetown/crown/nyle/consortcrown
	name = "jewel of nyle"
	icon_state = "consortcrown"
	sellprice = VALUE_GOLD_ITEM

//................ Hennin ............... //
/obj/item/clothing/head/roguetown/hennin
	name = "hennin"
	desc = "A fashionable conical hat typically worn by princesses."
	icon_state = "hennin"
	sellprice = VALUE_FINE_CLOTHING



/*------------\
| Unique hats |	- Not craftable, not importable
\------------*/

/obj/item/clothing/head/roguetown/crown/serpcrown
	name = "crown of Vanderlin"
	desc = "Heavy is the weight of the crown, and even heavier the responsibility it infers to its wearer."
	icon_state = "serpcrown"
	sellprice = VALUE_EXTREME
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF|UNACIDABLE|INDESTRUCTIBLE

/obj/item/clothing/head/roguetown/crown/serpcrown/Initialize()
	. = ..()
	if(type == /obj/item/clothing/head/roguetown/crown/serpcrown && !istype(loc, /mob/living/carbon/human/dummy)) //dummies spawn this in character setup
		SSroguemachine.crown = src

/obj/item/clothing/head/roguetown/crown/serpcrown/proc/anti_stall()
	src.visible_message(span_warning("[src] crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	SSroguemachine.crown = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/clothing/head/roguetown/crown/serpcrown/surplus
	name = "crown"
	desc = "A replacement for the Crown of Vanderlin, every bit as valid as proof of sovereignity as the original."
	icon_state = "serpcrowno"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/roguetown/crown/sparrowcrown
	name = "champions circlet"
	desc = "Winner of tournaments, bask in Ravox's glory."
	icon_state = "sparrowcrown"
	sellprice = VALUE_GOLD_ITEM

/obj/item/clothing/head/roguetown/jester
	name = "jester's hat"
	desc = "Just remember that the last laugh is on you."
	icon_state = "jester"

/obj/item/clothing/head/roguetown/cookhat/chef // only unique thing is the name
	name = "chef's hat"

/obj/item/clothing/head/roguetown/tophat
	name = "teller's hat"
	icon_state = "tophat"
	color = CLOTHING_SOOT_BLACK



//......................................................................................................
/*------------------\
|			 	 	|
|  Basic Helmets	|
|			 	 	|
\------------------*/

/obj/item/clothing/head/roguetown/helmet
	equip_sound = 'sound/foley/equip/equip_armor.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	break_sound = 'sound/foley/breaksound.ogg'
	pickup_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	blocksound = PLATEHIT
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ITEM
	clothing_flags = CANT_SLEEP_IN

	armor = ARMOR_PLATE_BAD
	body_parts_covered = COVERAGE_SKULL
	prevent_crits = ALL_EXCEPT_STAB

	grid_height = 64
	grid_width = 64


//................ Nasal Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/nasal
	name = "nasal helmet"
	desc = "A steel nasal helmet, usually worn by the guards of any respectable fief."
	icon_state = "nasal"
	sellprice = VALUE_CHEAP_IRON_HELMET

	body_parts_covered = COVERAGE_NASAL
	max_integrity = INTEGRITY_STANDARD

//................ Skull Cap ............... //
/obj/item/clothing/head/roguetown/helmet/skullcap
	name = "skull cap"
	desc = "A humble iron helmet. The most standard and antiquated protection for one's head from harm."
	icon_state = "skullcap"
	sellprice = VALUE_CHEAP_IRON_HELMET

	max_integrity = INTEGRITY_POOR

//............... Grenzelhoft Plume Hat ............... // - worn over a skullcap
/obj/item/clothing/head/roguetown/helmet/skullcap/grenzelhoft
	name = "grenzelhoft plume hat"
	desc = "Slaying foul creachers or fair maidens: Grenzelhoft stands."
	icon_state = "grenzelhat"
	item_state = "grenzelhat"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	detail_tag = "_detail"
	dynamic_hair_suffix = ""
	colorgrenz = TRUE
	sellprice = VALUE_FANCY_HAT

/obj/item/clothing/head/roguetown/helmet/skullcap/grenzelhoft/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

//................ Cultist Hood ............... //
/obj/item/clothing/head/roguetown/helmet/skullcap/cult
	name = "ominous hood"
	desc = "It echoes with ominous laughter. Worn over a skullcap"
	icon_state = "warlockhood"
	dynamic_hair_suffix = ""
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

	body_parts_covered = NECK|HAIR|EARS|HEAD


//................ Horned Cap ............... //
/obj/item/clothing/head/roguetown/helmet/horned
	name = "horned cap"
	desc = "A crude horned cap usually worn by brute barbarians to invoke fear unto their enemies."
	icon_state = "hornedcap"
	sellprice = VALUE_CHEAP_IRON_HELMET

//................ Winged Cap ............... //
/obj/item/clothing/head/roguetown/helmet/winged
	name = "winged cap"
	icon_state = "wingedcap"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

//................ Kettle Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/kettle
	name = "kettle helmet"
	desc = "A lightweight steel helmet generally worn by crossbowmen and garrison archers."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "kettle"
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEEARS
	sellprice = VALUE_CHEAP_IRON_HELMET

	body_parts_covered = COVERAGE_HEAD

//................ Kettle Helmet (Slitted)............... //
/obj/item/clothing/head/roguetown/helmet/kettle/slit
	name = "kettle helmet"
	desc = "A lightweight steel helmet generally worn by crossbowmen and garrison archers. This one has eyeslits for the paranoid."
	icon_state = "slitkettle"
	flags_cover = HEADCOVERSEYES
	body_parts_covered = HEAD|HAIR|EARS|EYES


//................ Iron Pot Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/ironpot
	name = "pot helmet"
	desc = "Simple iron helmet with a noseguard, designs like those are outdated but they are simple to make in big numbers."
	icon_state = "ironpot"
	flags_inv = HIDEEARS
	sellprice = VALUE_IRON_HELMET

	body_parts_covered = COVERAGE_HEAD_NOSE


//................ Copper Lamellar Cap ............... //
/obj/item/clothing/head/roguetown/helmet/coppercap
	name = "lamellar cap"
	desc = "A heavy lamellar cap made out of copper, a primitive material with an effective design to keep the head safe"
	icon_state = "lamellar"
	flags_inv = HIDEEARS
	smeltresult = /obj/item/ingot/copper
	sellprice = VALUE_LEATHER_HELMET // until copper/new mats properly finished and integrated this is a stopgap

	armor = ARMOR_PADDED_GOOD
	body_parts_covered = COVERAGE_HEAD
	prevent_crits = ONLY_VITAL_ORGANS
	max_integrity = INTEGRITY_POOR

//............... Battle Nun ........................... (unique kit for the role, iron coif mechanically.)
/obj/item/clothing/head/roguetown/helmet/battlenun
	name = "veil over coif"
	desc = "A gleaming coif of metal half-hidden by a black veil."
	icon_state = "battlenun"
	dynamic_hair_suffix = ""	// this hides all hair
	flags_inv = HIDEEARS|HIDEHAIR
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	blocksound = CHAINHIT
	resistance_flags = FIRE_PROOF

	armor = ARMOR_MAILLE
	body_parts_covered = NECK|HAIR|EARS|HEAD
	prevent_crits = ALL_EXCEPT_BLUNT


/*-------------\
| Steel Helmet |
\-------------*/

//................ Sallet ............... //
/obj/item/clothing/head/roguetown/helmet/sallet
	name = "sallet"
	icon_state = "sallet"
	desc = "A simple steel helmet with no attachments. Helps protect the ears."
	flags_inv = HIDEEARS
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_STEEL_HELMET

	armor =  ARMOR_PLATE
	body_parts_covered = COVERAGE_HEAD
	max_integrity = INTEGRITY_STRONG

//................ Elf Sallet ............... //
/obj/item/clothing/head/roguetown/helmet/sallet/elven	// blackoak merc helmet
	desc = "A steel helmet with a thin gold plating designed for Elven woodland guardians."
	icon_state = "bascinet_novisor"
	color = COLOR_ASSEMBLY_GOLD
	sellprice = VALUE_STEEL_HELMET+BONUS_VALUE_MODEST

//	icon_state = "elven_barbute_winged"
//	item_state = "elven_barbute_winged"

//................ Zybantine Kulah Khud ............... //
/obj/item/clothing/head/roguetown/helmet/sallet/zybantine // Unique Zybantu merc kit
	name = "kulah khud"
	desc = "Known as devil masks amongst the Western Kingdoms, these serve part decorative headpiece, part protective helmet."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "iranian"
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

//................ Bascinet ............... //
/obj/item/clothing/head/roguetown/helmet/bascinet
	name = "bascinet"
	icon_state = "bascinet_novisor"
	desc = "A simple steel bascinet without a visor. Makes up for what it lacks in protection in visibility."
	flags_inv = HIDEEARS
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_STEEL_HELMET

	body_parts_covered = COVERAGE_HEAD
	max_integrity = INTEGRITY_STRONG




//......................................................................................................
/*----------------\
| Visored helmets |
\----------------*/

/obj/item/clothing/head/roguetown/helmet/visored
	name = "parent visored helmet"
	desc = "If you're reading this, someone forgot to set an item description or spawned the wrong item. Yell at them."
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	adjustable = CAN_CADJUST
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	equip_delay_self = 3 SECONDS
	unequip_delay_self = 3 SECONDS
	smeltresult = /obj/item/ingot/steel // All visored helmets are made of steel
	sellprice = VALUE_STEEL_HELMET+BONUS_VALUE_TINY

	armor = ARMOR_PLATE
	body_parts_covered = FULL_HEAD
	max_integrity = INTEGRITY_STRONG
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/roguetown/helmet/visored/AdjustClothes(mob/user)
	if(loc == user)
		playsound(user, "sound/items/visor.ogg", 100, TRUE, -1)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_raised"
			body_parts_covered = COVERAGE_HEAD
			flags_inv = HIDEEARS
			flags_cover = null
			prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT) // Vulnerable to eye stabbing while visor is open
			block2add = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_head()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
//			body_parts_covered = FULL_HEAD
//			prevent_crits = ALL_CRITICAL_HITS
//			flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
//			flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_head()
		user.update_fov_angles()
	else // Failsafe.
		to_chat(user, "<span class='warning'>Wear the helmet on your head to open and close the visor.</span>")
		return

//............... Visored Sallet ............... //
/obj/item/clothing/head/roguetown/helmet/visored/sallet
	name = "visored sallet"
	desc = "A steel helmet offering good overall protection. Its visor can be flipped over for higher visibility at the cost of eye protection."
	icon_state = "sallet_visor"


//............... Hounskull ............... //
/obj/item/clothing/head/roguetown/helmet/visored/hounskull
	name = "hounskull" // "Pigface" is a modern term, hounskull is a c.1400 term.
	desc = "A bascinet with a mounted pivot to protect the face by deflecting blows on its conical surface, \
			highly favored by knights of great renown. Its visor can be flipped over for higher visibility \
			at the cost of eye protection."
	icon_state = "hounskull"
	emote_environment = 3

	armor = ARMOR_PLATE_GOOD

//............... Knights Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/visored/knight
	name = "knights helmet"
	desc = "A lightweight armet that protects dreams of chivalrous friendship, fair maidens to rescue, and glorious deeds of combat. Its visor can be flipped over for higher visibility at the cost of eye protection."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "knight"
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64

	emote_environment = 3

/obj/item/clothing/head/roguetown/helmet/visored/knight/black
	color = CLOTHING_SOOT_BLACK

//................. Captain's Helmet .............. //
/obj/item/clothing/head/roguetown/helmet/visored/captain
	name = "captain's helmet"
	desc = "An elegant barbute, fitted with the gold trim and polished metal of nobility."
	icon = 'icons/roguetown/clothing/special/captain.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	icon_state = "capbarbute"

//......................................................................................................
/*------------------\
|			 	 	|
|  Heavy Helmets	|	- Limited FOV but good armor and coverage
|			 	 	|
\------------------*/

/obj/item/clothing/head/roguetown/helmet/heavy
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

/obj/item/clothing/head/roguetown/helmet/heavy/necked		// includes a coif or gorget part to cover neck. Why? So templars can wear their cross on their neck basically, also special thing for Temple
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	body_parts_covered = HEAD_NECK
	prevent_crits = ALL_EXCEPT_BLUNT


//................ Iron Plate Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/heavy/ironplate
	name = "iron plate helmet"
	desc = "An iron masked helmet usually worn by armed men, it is a solid design yet antiquated and cheap."
	icon_state = "ironplate"
	flags_inv = HIDEEARS
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_CHEAP_IRON_HELMET

	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STRONG //isn't the same as a steel helmet but is better than a skullcap, costs 2 bars and protects the mouth

//............... Rusted Barbute ............... //
/obj/item/clothing/head/roguetown/helmet/heavy/rust
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
/obj/item/clothing/head/roguetown/helmet/heavy/bucket
	name = "great helm"
	desc = "An immovable bulkwark of protection for the head of the faithful. Antiquated and impractical, but offering incredible defense."
	icon_state = "topfhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

	armor = ARMOR_PLATE
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/gold
	icon_state = "topfhelm_gold"


// Vampire Lord is no longer as OP, but the armor should protect against dreaded stabs or it makes the vitae spent on it pointless.
/obj/item/clothing/head/roguetown/helmet/heavy/savoyard
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
/obj/item/clothing/head/roguetown/helmet/heavy/frog
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
/obj/item/clothing/head/roguetown/helmet/heavy/necked/astrata
	name = "astrata helmet"
	desc = "A great helmet decorated with a golden sigil of the solar order and a maille neck cover. The dependable companion of many holy warriors of Astrata."
	icon_state = "astratahelm"

//............... Noc Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/heavy/necked/noc
	name = "noc helmet"
	desc = "A sleek and rounded heavy helmet with a maille neck cover. Its unique craft is said to allow holy warriors of Noc additional insight before battle."
	icon_state = "nochelm"

//............... Necra Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/heavy/necked/necra
	name = "necra helmet"
	desc = "A reinforced helmet shaped into the visage of a skull with a maille neck cover under the cloth. A symbol of authority for the battle servants of the Undermaiden."
	icon_state = "necrahelm"

//............... Dendor Helmet ............... //	This one seems a bit out of place
/obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
	name = "dendor helmet"
	desc = "A great helmet with twisted metalwork that imitates the twisting of bark, or the horns of a beast."
	icon_state = "dendorhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	prevent_crits = ALL_EXCEPT_BLUNT

//............... Eora Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/sallet/eoran
	name = "eora helmet"
	desc = "A standard helmet forged in the style typical of Eoran worshippers, a simple yet practical protective piece of equipment. Upon it lays several laurels of flowers and other colorful ornaments, followed by several symbols and standards of the user's chapter, accomplishments or even punishment"
	icon_state = "eorahelm"
	item_state = "eorahelm"


//............... Pestra Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/heavy/pestrahelm
	name = "pestran helmet"
	desc = "A great helmet made of coarse, tainted steel. It is modeled after a plagued carrion, a blessed abomination of Pestra."
	icon_state = "pestrahelm"
	item_state = "pestrahelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

//................ Malum Helmet ............. //
/obj/item/clothing/head/roguetown/helmet/heavy/malumhelm
	name = "malumite helmet"
	desc = "A great helmet of sturdy dark steel. Its chiseled countenance reminds the viewer of Malum's stern gaze."
	icon_state = "malumhelm"
	item_state = "malumhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

/obj/item/clothing/head/roguetown/helmet/heavy/ravox
	name = "ravoxian helmet"
	desc = "Headwear commonly worn by Templars in service to Ravox. It resembles an heavily adorned visored sallet."
	icon_state = "ravoxhelm"
	item_state = "ravoxhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

//............... Sinistar (Graggar) Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/heavy/sinistar
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



//......................................................................................................
/*------------------\
| Decorated helmets |
\------------------*/

/obj/item/clothing/head/roguetown/helmet/heavy/decorated	// template
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

/obj/item/clothing/head/roguetown/helmet/heavy/decorated/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)


//............... Decorated Knight Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/heavy/decorated/knight
	name = "knights helmet"
	desc = "A lavish knights helmet which allows a crest to be mounted on top."
	icon_state = "decorated_knight"

/obj/item/clothing/head/roguetown/helmet/heavy/decorated/knight/attack_right(mob/user)
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
/obj/item/clothing/head/roguetown/helmet/heavy/decorated/hounskull
	name = "hounskull"
	desc = "A lavish hounskull which allows a crest to be mounted on top."
	icon_state = "decorated_hounskull"
	armor = ARMOR_PLATE_GOOD
	max_integrity = INTEGRITY_STRONG
	prevent_crits = ALL_CRITICAL_HITS


/obj/item/clothing/head/roguetown/helmet/heavy/decorated/hounskull/attack_right(mob/user)
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
/obj/item/clothing/head/roguetown/helmet/heavy/decorated/bucket
	name = "great helm"
	desc = "A lavish great helm which allows a crest to be mounted on top."
	icon_state = "decorated_bucket"
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/roguetown/helmet/heavy/decorated/bucket/attack_right(mob/user)
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
/obj/item/clothing/head/roguetown/helmet/heavy/decorated/golden
	name = "gold helm"
	desc = "A lavish gold-trimmed greathelm which allows a crest to be mounted on top."
	icon_state = "decorated_gbucket"
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/roguetown/helmet/heavy/decorated/golden/attack_right(mob/user)
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

/obj/item/clothing/head/roguetown/helmet/heavy/decorated/bascinet
	name = "bascinet"
	desc = "A simple steel helmet that can be decorated with a crest. Somewhat basic, but you'll be the envy of those who cannot afford such a fancy helmet."
	icon_state = "decorated_bascinet"
	flags_inv = HIDEEARS
	sellprice = VALUE_STEEL_HELMET
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 2 SECONDS
	block2add = null

	body_parts_covered = HEAD|HAIR|EARS

/obj/item/clothing/head/roguetown/helmet/heavy/decorated/bascinet/attack_right(mob/user)
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



//......................................................................................................
/*------------------\
|			 	 	|
|  Light Helmets	|	-made from leather, cloth, differ from basic in materials mostly
|			 	 	|
\------------------*/


/*----------------\
| Padded headwear |
\----------------*/

//............... Headscarf ............... //
/obj/item/clothing/head/roguetown/helmet/leather/headscarf // repathing isnt needed really
	name = "headscarf"
	desc = "Rolled cloth. Gives some protection at least."
	icon_state = "headscarf"
	color = CLOTHING_BARK_BROWN
	sellprice = VALUE_LEATHER_HELMET/2
	armor = ARMOR_PADDED
	body_parts_covered = HEAD|HAIR
	prevent_crits =  MINOR_CRITICALS
	max_integrity = INTEGRITY_POOR
	clothing_flags = NONE


//............... Arming Cap ............... //
/obj/item/clothing/head/roguetown/armingcap // arming caps are padded caps worn under maille coifs and such, should basically be on par with leather coif (it should BE the coif but whatever)
	name = "arming cap"
	desc = "A white padded cap worn by most manual laborers to protect from sunburn."
	icon_state = "armingcap"
	flags_inv = HIDEEARS

	armor = ARMOR_PADDED
	body_parts_covered = HEAD|HAIR|EARS
	prevent_crits =  MINOR_CRITICALS
	max_integrity = INTEGRITY_POOR


/*----------------\
| Leather helmets |
\----------------*/

/obj/item/clothing/head/roguetown/helmet/leather
	name = "leather helmet"
	desc = "A conical leather helmet. It's comfortable and won't protect much, but it's better than nothing."
	icon_state = "leatherhelm"
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	blocksound = SOFTHIT
	resistance_flags = FLAMMABLE // Made of leather
	smeltresult = /obj/item/ash
	anvilrepair = null
	sewrepair = TRUE
	sellprice = VALUE_LEATHER_HELMET

	armor = ARMOR_LEATHER_BAD
	body_parts_covered = HEAD|HAIR|EARS|NOSE
	prevent_crits = CUT_AND_MINOR_CRITS
	max_integrity = INTEGRITY_STANDARD
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/head/roguetown/helmet/leather/advanced
	name = "hardened leather helmet"
	desc = "Sturdy, durable, flexible. A confortable and reliable hood made of hardened leather."
	max_integrity = 250
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 70, "slash" = 60, "stab" = 30, "piercing" = 20, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/roguetown/helmet/leather/masterwork
	name = "masterwork leather helmet"
	desc = "This helmet is a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	max_integrity = 300
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP) //we're adding chop here!
	armor = list("blunt" = 100, "slash" = 70, "stab" = 40, "piercing" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/roguetown/helmet/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

//............... Buckled Hat ............... //
/obj/item/clothing/head/roguetown/helmet/leather/inquisitor
	name = "buckled hat"
	desc = "A black top hat with a buckle on top, favored by Witch Hunters and Inquisitors."
	icon_state = "puritan_hat"

//............... Ominous Hood ............... //
/obj/item/clothing/head/roguetown/helmet/leather/hood_ominous // a leather coif locked to headslot since you cannot pull it back. Crit prevent between armor items a little weird, this is leather coif, compare to helmet
	name = "ominous hood"
	desc = "Madmen. Cursed dogs. Beware."
	icon_state = "ominous"
	dynamic_hair_suffix = ""
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	sellprice = VALUE_LEATHER_HELMET/2

	armor = ARMOR_PADDED_GOOD
	body_parts_covered = NECK|HAIR|EARS|HEAD

//............... Hardened Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/leather/conical // old helmet sprite
	name = "hardened helmet"
	desc = "A conical helmet made from boiled leather and metal fittings."
	icon_state = "leatherhelm_old"

//............... Volf Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	name = "volf helmet"
	desc = "A leather helmet fashioned from a volf's pelt."
	icon_state = "volfhead"

	body_parts_covered = HEAD|HAIR|EARS

//............... Miners Helmet ............... //
/obj/item/clothing/head/roguetown/helmet/leather/minershelm
	name = "miners helmet"
	desc = "Boiled leather kettle-like helmet with a headlamp, fueled by magiks."
	icon_state = "minerslamp"
	item_state = "minerslamp"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	sellprice = VALUE_LEATHER_HELMET+BONUS_VALUE_MODEST

	armor = ARMOR_PADDED
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_TWIST, BCLASS_BLUNT)

	var/brightness_on = 4 //less than a torch; basically good for one person.
	var/on = FALSE

/obj/item/clothing/head/roguetown/helmet/leather/minershelm/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/roguetown/helmet/leather/minershelm/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_icon()

/obj/item/clothing/head/roguetown/helmet/leather/minershelm/update_icon()
	icon_state = "minerslamp[on]"
	item_state = "minerslamp[on]"
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_head()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon(force = TRUE)
	..()

/obj/item/clothing/head/roguetown/helmet/leather/minershelm/proc/turn_on(mob/user)
	set_light(brightness_on)

/obj/item/clothing/head/roguetown/helmet/leather/minershelm/proc/turn_off(mob/user)
	set_light(0)



/*------------------\
| Feldsher headwear |
\-------------------*/

//............... Feldshers Hood ............... //
/obj/item/clothing/head/roguetown/roguehood/feld
	name = "feldsher's hood"
	desc = "My cure is most effective."
	icon_state = "feldhood"
	item_state = "feldhood"
	color = null

	prevent_crits = MINOR_CRITICALS

//............... Physicians Hood ............... //
/obj/item/clothing/head/roguetown/roguehood/phys
	name = "physicker's hood"
	desc = "My cure is mostly effective."
	icon_state = "surghood"
	item_state = "surghood"
	color = null

	prevent_crits = MINOR_CRITICALS

//............... Feldshers Cage ............... //
/obj/item/clothing/head/roguetown/helmet/feld
	name = "feldsher's cage"
	desc = "To protect me from the maggets and creachers I treat."
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "headcage"
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

	body_parts_covered = FULL_HEAD
	prevent_crits = BLUNT_AND_MINOR_CRITS



//......................................................................................................
/*----------------------\
| Unique helmets & hats |	- Unique means no crafting them, no importing, nothing but spawn with the intended class
\----------------------*/


//............... Rare Helmets ............... //
///obj/item/clothing/head/roguetown/helmet/rare
/obj/item/clothing/head/roguetown/rare
	name = "rare helmet template"
	icon_state = "elfhead"
	icon = 'icons/roguetown/clothing/Racial_Armour.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/onmob_racial.dmi'
	bloody_icon = 'icons/effects/blood32x64.dmi'
	bloody_icon_state = "helmetblood_big"
	blocksound = PLATEHIT	//DELETE AFTER REPATH
	equip_delay_self = 3 SECONDS
	unequip_delay_self = 3 SECONDS
	resistance_flags = FIRE_PROOF // These are all metallic DELETE AFTER REPATH
	anvilrepair = /datum/skill/craft/armorsmithing	//DELETE AFTER REPATH
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_STEEL_HELMET+BONUS_VALUE_SMALL

	armor = ARMOR_PLATE_GOOD
	armor_class = AC_HEAVY
	prevent_crits = ALL_CRITICAL_HITS
	max_integrity = INTEGRITY_STRONG


//............... Bladesinger Helmet ............... //
/obj/item/clothing/head/roguetown/rare/elfplate // Unique Bladesinger kit
	name = "elvish plate helmet"
	desc = "A bizarrely lightweight helmet of alloyed dark elven steel, offering unparalleled protection for elite bladesingers."
	icon_state = "elfhead"
	allowed_race = list("elf", "half-elf", "dark elf")
	clothing_flags = CANT_SLEEP_IN
	armor_class = AC_MEDIUM
	body_parts_covered = HEAD|HAIR|NOSE

/obj/item/clothing/head/roguetown/rare/elfplate/welfplate // Unique Bladesinger kit
	desc = "A bizarrely lightweight helmet of alloyed elven steel, offering unparalleled protection for elite bladesingers."
	icon_state = "welfhead"

	body_parts_covered = HEAD|HAIR|NOSE|EYES


//............... Langobard Helmet ............... //
/obj/item/clothing/head/roguetown/rare/dwarfplate // Unique Longbeard kit
	name = "langobard pot helm"
	desc = "The Langobards are a cult of personality that are tasked by the Dwarven Kings to issue judgement, \
			justice and order around the realms for dwarvenkind. This helmet is a respected symbol of authority."
	icon_state = "dwarfhead"
	allowed_race = list("dwarf")
	flags_inv = HIDEEARS
	clothing_flags = CANT_SLEEP_IN
	body_parts_covered = HEAD_EXCEPT_MOUTH


//............... Swordmaster Helmet ............... //
/obj/item/clothing/head/roguetown/rare/grenzelplate // Unique Swordmaster kit
	name = "chicklet sallet"
	desc = "A Grenzelhoftian chicklet sallet, decorated with a plume of valor. \
			It has been proven with severe battle-testing that a wearer's head would crack before the helmet chips."
	icon_state = "human_swordhead"
	allowed_sex = list(MALE)
	allowed_race = list("human")
	flags_inv = HIDEEARS
	clothing_flags = CANT_SLEEP_IN
	body_parts_covered = HEAD|EARS|HAIR


//............... Kataphract/bastion/spear/zyban Helmet ............... //
/obj/item/clothing/head/roguetown/rare/zybanplate // Unique Freelancer kit
	name = "bastion helm"
	desc = "The Zybantu Kataphractoe are the ancestral guardians of the first Despot, \
			their helms designed in the fashion of the capital's majestic sky-piercing tower \
			where the old God-King resided."
	icon_state = "human_spearhead"
	item_state = "human_spearplate"
	allowed_sex = list(MALE)
	allowed_race = list("human")
	flags_inv = HIDEEARS|HIDEFACE
	clothing_flags = CANT_SLEEP_IN
	body_parts_covered = HEAD|EARS|HAIR|NOSE|MOUTH

//............... Hoplite Helmet ............... //
/obj/item/clothing/head/roguetown/rare/hoplite // Unique Hoplite kit
	name = "ancient helmet"
	desc = "A weathered bronze helmet topped with a symbol of Astrata's sun."
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	icon_state = "aasimarhead"
	worn_x_dimension = 64
	worn_y_dimension = 64
	allowed_race = list("aasimar")
	flags_inv = HIDEEARS
	clothing_flags = CANT_SLEEP_IN
	body_parts_covered = HEAD|EARS|HAIR


/*-------------------\
| Antagonist Helmets |
\-------------------*/


/*---------------------\
| Magic hats & helmets |
\---------------------*/

//............... Wizard Hat ........................... (unique effects for court mage. Not any more so just a plain hat)
/obj/item/clothing/head/roguetown/wizhat
	name = "wizard hat"
	desc = "Used to distinguish dangerous wizards from senile old men."
	icon_state = "wizardhat"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

	prevent_crits =  MINOR_CRITICALS

/obj/item/clothing/head/roguetown/wizhat/witch
	name = "witch hat"
	desc = ""
	icon_state = "witchhat"
	detail_tag = "_detail"
	detail_color = CLOTHING_SOOT_BLACK

/obj/item/clothing/head/roguetown/wizhat/gen
	icon_state = "wizardhatgen"
/*
/obj/item/clothing/head/roguetown/wizhat/equipped(mob/living/user, slot)
	. = ..()
	if(user.mind && user.mind.assigned_role == "Court Magician")
		if(slot == SLOT_HEAD && istype(user))
			user.apply_status_effect(/datum/status_effect/buff/thinking_cap)
		else
			user.remove_status_effect(/datum/status_effect/buff/thinking_cap)
	else return

/obj/item/clothing/head/roguetown/wizhat/dropped(mob/living/user, slot)
	. = ..()
	user.remove_status_effect(/datum/status_effect/buff/thinking_cap)
*/


//............... Thermal Vision Circlet ............... //
/obj/item/clothing/head/roguetown/crown/circlet/vision
	name = "mystical circlet"
	desc = "A shining gold circlet, with a mysterious purple insert. You feel like you have a third eye while near it..."
	icon_state = "visioncirclet"
	item_state = "visioncirclet"
	sellprice = VALUE_MAGIC_ITEM_STRONG

/obj/item/clothing/head/roguetown/crown/circlet/vision/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_HEAD && istype(user))
		ADD_TRAIT(user, TRAIT_THERMAL_VISION,"thermal_vision")
	else
		REMOVE_TRAIT(user, TRAIT_THERMAL_VISION,"thermal_vision")

//............... Nosleep Circlet ............... //
/obj/item/clothing/head/roguetown/crown/circlet/sleepless
	name = "clouded circlet"
	desc = "A shining gold circlet, with a mysterious blue insert. You feel more energetic while near it..."
	icon_state = "sleepcirclet"
	item_state = "sleepcirclet"
	sellprice = VALUE_MAGIC_ITEM_WEAK

/obj/item/clothing/head/roguetown/crown/circlet/sleepless/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_HEAD && istype(user))
		ADD_TRAIT(user, TRAIT_NOSLEEP,"Fatal Insomnia")
	else
		REMOVE_TRAIT(user, TRAIT_NOSLEEP,"Fatal Insomnia")

//............... Stink Immunity Circlet ............... //
/obj/item/clothing/head/roguetown/crown/circlet/stink
	name = "numbing circlet"
	desc = "A shining gold circlet, with a mysterious green insert. You feel your sense of smell numb while near it..."
	icon_state = "stinkcirclet"
	item_state = "stinkcirclet"
	sellprice = VALUE_MAGIC_ITEM_WEAK


/obj/item/clothing/head/roguetown/crown/circlet/stink/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_HEAD && istype(user))
		ADD_TRAIT(user, TRAIT_NOSTINK,"Dead Nose")
	else
		REMOVE_TRAIT(user, TRAIT_NOSTINK,"Dead Nose")

//............... Black bag for inquisition ............... //
/obj/item/clothing/head/roguetown/sack
	name = "black bag"
	desc = "An eyeless sack, used to blindfold prisoners or hostages."
	icon_state = "sacked"
	item_state = "sacked"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	tint = TINT_BLIND

/obj/item/clothing/head/roguetown/sack/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HEAD)
		user.become_blind("blindfold[REF(src)]")

/obj/item/clothing/head/roguetown/sack/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/clothing/head/roguetown/sack/attack(mob/living/target, mob/living/user)
	if(target.get_item_by_slot(SLOT_HEAD))
		to_chat(user, "<span class='warning'>Remove [target.p_their()] headgear first!</span>")
		return
	target.visible_message("<span class='warning'>[user] forces [src] onto [target]'s head!</span>", \
	"<span class='danger'>[target] forces [src] onto your head!</span>", "<i>I cant see anything.</i>")
	if(ishuman(target)) // If the target is human and not in combat mode, stun them the same way a feint would.
		var/mob/living/carbon/human/T = target
		if(!T.cmode)
			T.emote("whimper", intentional = FALSE)
			T.changeNext_move(8)
			T.Immobilize(10)
	user.dropItemToGround(src)
	target.equip_to_slot_if_possible(src, SLOT_HEAD)



/*----------\
| Graveyard |	- Not used or ingame in any way except admeme spawning them.
\-----------*/

/obj/item/clothing/head/roguetown/helmet/heavy/captain
	name = "barred helmet"
	desc = "An archaic helmet whose shape resembles bars of a gate."
	icon_state = "gatehelm"
	emote_environment = 3
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR
	block2add = FOV_RIGHT|FOV_LEFT
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ITEM

/obj/item/clothing/head/roguetown/priesthat // bishops mitre really
	name = "priest's hat"
	desc = "The sacred headpiece of a priest."
	icon_state = "priest"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

	prevent_crits = MINOR_CRITICALS

/obj/item/clothing/head/roguetown/headdress // egyptian
	name = "foreign headdress"
	desc = ""
	icon_state = "headdress"

/obj/item/clothing/head/roguetown/headdress/alt
	icon_state = "headdressalt"

/obj/item/clothing/head/roguetown/armingcap/dwarf // gnome hat I guess?
	color = "#cb3434"


/*	Last remnants of hipwearing flag inverter system
//	experimental_onhip = TRUE
//	var/will_cover // used for avoiding issues when worn on hip, currently only helmets
//	var/will_hide

// Prevents coverage error when unequipping.
/obj/item/clothing/head/roguetown/helmet/visored/dropped(mob/user)
	. = ..()
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_STAB)
	will_cover = FULL_HEAD
	will_hide = HIDEEARS|HIDEFACE|HIDEHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	user.update_fov_angles()

/obj/item/clothing/head/roguetown/helmet/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		body_parts_covered = (will_cover)
		flags_inv = (will_hide)
	else
		body_parts_covered = null
		flags_inv = FALSE
*/


/obj/item/clothing/head/roguetown/helmet/blacksteel/bucket
	name = "Blacksteel Great Helm"
	desc = "A bucket helmet forged of durable blacksteel. None shall pass.."
	body_parts_covered = FULL_HEAD
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bkhelm"
	item_state = "bkhelm"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80,  "piercing" = 100, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_SMASH, BCLASS_TWIST, BCLASS_PICK)
	block2add = FOV_RIGHT|FOV_LEFT
	max_integrity = 425
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/blacksteel
