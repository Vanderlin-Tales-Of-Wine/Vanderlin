/* * * * * * * * * * * **
 *						*
 *		 Clothing		*
 *						*
 *						*
 * * * * * * * * * * * **/

// =============================================================================
// ==============================	HEAD	====================================

//................ Rabbet Visage ............... //
/obj/item/clothing/head/padded/rabbetvisage
	name = "rabbet visage"
	desc = "A painted wooden rabbet worn by the faithful of Eora, usually during their rituals."
	icon_state = "eoramask"
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/64x64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	dynamic_hair_suffix = ""
	body_parts_covered = HEAD | NOSE | EYES

/obj/item/clothing/head/roguehood/random/heavy
	desc = "Thick leather, with a reinforced cap under it."
	armor = ARMOR_LEATHER_BAD
	prevent_crits = CUT_AND_MINOR_CRITS
	max_integrity = INTEGRITY_STANDARD
	salvage_result = /obj/item/natural/hide/cured

//................ Crimson Marauder ............... //
/obj/item/clothing/head/helmet/ironpot/marauder
	name = "jinete helmet"
	desc = "A solid bronze helmet from the age of the Apotheosis war. It has been reinforced and decorated for hundreds of yils, the symbol of pride for any Jinete, if not entirely outdated and ceremonial"
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/64x64.dmi'
	icon_state = "crimson_marauder"
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	flags_inv = HIDEEARS
	sellprice = VALUE_LEATHER_HELMET/2
	armor =  ARMOR_PLATE
	body_parts_covered = NECK|HAIR|EARS|HEAD

/obj/item/clothing/head/roguehood/pashmina
	name = "pashmina"
	desc = "A thick hood that covers one's entire head, should they desire, or merely acts as a scarf otherwise."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "deserthood"
	item_state = "deserthood"
	color = "#4065bb"


//................ Malum Acolyte Helmet ............... //
/obj/item/clothing/head/helmet/leather/minershelm/malumite
	name = "bowl of fire"
	desc = "The fires of industry burn ever on, to praise saint Malum."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/64x64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64
	armor = ARMOR_PLATE_BAD

/obj/item/clothing/head/roguehood/monk
	name = "pashmina"
	desc = "A slim hood with thin, yet dense fabric. Stretchy and malleable, allowing for full flexibility and mobility."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "monkhood"
	item_state = "monkhood"
/obj/item/clothing/head/roguehood/monk/Initialize()
	. = ..()
	color = pick(GLOB.peasant_dyes)

/obj/item/clothing/head/archercap
	name = "archer's cap"
	desc = "For the merry men."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "archercap"

/obj/item/clothing/head/helmet/heavy/psydonbarbute	// crusader helmet
	name = "psydonian barbute"
	desc = "A ceremonial barbute, masterfully forged to represent Psydon's divine authority. The Order of Saint Malum's artisans have chiseled this pronged visage into more statues than you could possibly imagine."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "psydonbarbute"
	item_state = "psydonbarbute"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

/obj/item/clothing/head/helmet/heavy/crusader	// crusader helmet
	name = "great helm"
	desc = "Proud knights of the Totod order displays their faith and their allegiance openly."
	icon_state = "totodhelm"
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/64x64.dmi'
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64

/obj/item/clothing/head/helmet/heavy/chevalier
	name = "chevalier armet"
	desc = "An ornate helmet, whose visor has been bound shut with blacksteel chains."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "psydonarmet"
	item_state = "psydonarmet"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

/obj/item/clothing/head/helmet/heavy/chevalier/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/helmet/heavy/chevalier/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/helmet/visored/hounskull
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'

//................ Plumed Knights helmet ............... //
/obj/item/clothing/head/helmet/visored/knight
	name = "knights helmet"
	desc = "A lightweight armet that protects dreams of chivalrous friendship, fair maidens to rescue, and glorious deeds of combat. Its visor can be flipped over for higher visibility at the cost of eye protection."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "knight"
	bloody_icon = 'icons/effects/blood.dmi'
	bloody_icon_state = "itemblood"
	worn_x_dimension = 32
	worn_y_dimension = 32
	emote_environment = 3

/obj/item/clothing/head/helmet/visored/knight/black
	color = CLOTHING_ASH_GREY

/obj/item/clothing/head/helmet/visored/knight/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Plume") as anything in colors
		detail_color = colors[choice]
		detail_tag = "_detail"
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/helmet/visored/knight/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)



//................ Plumed Bascinet ............... //
/obj/item/clothing/head/helmet/bascinet
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "bascinet"
/obj/item/clothing/head/helmet/bascinet/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/feather) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/helmet/bascinet/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state]_detail"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)


//................ Great helm ............... //
/obj/item/clothing/head/helmet/heavy/bucket
	name = "great helm"
	desc = "An immovable bulkwark of protection for the head of the faithful. Antiquated and impractical, but offering incredible defense."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "topfhelm"
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR

	armor = ARMOR_PLATE
	prevent_crits = ALL_CRITICAL_HITS

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/roguetown/helmet/heavy/bucket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)


//................ Kettle Helmet ............... //
/obj/item/clothing/head/helmet/kettle
	name = "kettle helmet"
	desc = "A steel helmet which protects the top and sides of the head. Can be decorated with a twisted cloth circlet."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "kettle"
	bloody_icon = 'icons/effects/blood.dmi'
	bloody_icon_state = "itemblood"
	worn_x_dimension = 32
	worn_y_dimension = 32
	flags_inv = HIDEEARS
	sellprice = VALUE_CHEAP_IRON_HELMET
	body_parts_covered = COVERAGE_HEAD

/obj/item/clothing/head/helmet/kettle/attackby(obj/item/W, mob/living/user, params)
	..()
	if(istype(W, /obj/item/natural/cloth) && !detail_tag)
		var/list/colors = list(
		"Swan White"="#ffffff",
		"Lavender"="#865c9c",
		"Royal Purple"="#5E4687",
		"Wine Rouge"="#752B55",
		"Sow's skin"="#CE929F",
		"Knight's Red"="#933030",
		"Madroot Red"="#AD4545",
		"Marigold Orange"="#E2A844",
		"Politely, Yuck"="#685542",
		"Astrata's Yellow"="#FFFD8D",
		"Bog Green"="#375B48",
		"Seafoam Green"="#49938B",
		"Woad Blue"="#395480",
		"Cornflower Blue"="#749EE8",
		"Blacksteel Grey"="#404040",)

		var/choice = input(user, "Choose a color.", "Orle") as anything in colors
		user.visible_message(span_warning("[user] adds [W] to [src]."))
		qdel(W)
		detail_color = colors[choice]
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/obj/item/clothing/head/helmet/kettle/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)


//................ Kettle Helmet (Slitted)............... //
/obj/item/clothing/head/helmet/kettle/slit
	icon_state = "kettle_slit"
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	worn_x_dimension = 32
	worn_y_dimension = 32
	bloody_icon_state = "helmetblood"
	bloody_icon = 'icons/effects/blood.dmi'


//............... Klappvisier ............... //
/obj/item/clothing/head/helmet/visored/klappvisier
	name = "klappvisier"
	desc = "A steel helmet offering good overall protection. Its visor can be flipped over for higher visibility at the cost of eye protection."
	icon_state = "kettle_slit"
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/64x64.dmi'
	icon_state = "klappvisor"
	dropshrink = 0.8
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	worn_x_dimension = 64
	worn_y_dimension = 64

//................ Crown edit............... //
/obj/item/clothing/head/crown/serpcrown
	name = "royal crown"
	desc = "The royal circlet of bright gold rests lightly on my brow, I once thought only of the rights this circlet would endow. But once I took the crown to which I had been schooled and bred, I found it heavy on the heart, though light upon the head."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'

/obj/item/clothing/head/crown/serpcrown/surplus
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'

//................ Padded Coif edit............... //
/obj/item/clothing/neck/coif/cloth
	dropshrink = 0.6

//................ Rain hood edit............... //
/obj/item/clothing/head/hooded/rainhood
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'


//................ Templar Helmets. I made the necked ones, I regreet it, better avoid overlap and muddled boundaries ............... //
/obj/item/clothing/head/helmet/heavy/bucket/templar
	icon_state = "astrata"
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon = 'modular/stonekeep/icons/clothing.dmi'

/obj/item/clothing/head/helmet/heavy/bucket/templar/noc
	icon_state = "noc"

/obj/item/clothing/head/helmet/heavy/bucket/templar/dendor
	icon_state = "dendor"

/obj/item/clothing/head/helmet/heavy/bucket/templar/necra
	icon_state = "necra"

/obj/item/clothing/head/helmet/heavy/bucket/templar/abyssor
	icon_state = "abyssor"

/obj/item/clothing/head/helmet/heavy/bucket/templar/ravox
	icon_state = "ravoxhelm"
	item_state = "ravoxhelm"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'
/obj/item/clothing/head/helmet/heavy/bucket/templar/malum
	icon_state = "malumhelm"
	item_state = "malumhelm"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi'


/obj/item/clothing/head/helmet/pestracage	// not great armor value but very durable and best coverage
	name = "iron cage"
	desc = "A simple steel helmet with no attachments. Helps protect the ears."
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	icon_state = "headcage"
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"
	armor =  ARMOR_LEATHER_GOOD
	body_parts_covered = HEAD|EARS|HAIR|NOSE|EYES|MOUTH
	max_integrity = INTEGRITY_STRONGEST

/obj/item/clothing/neck/monke
	name = "collar"
	desc = "Fits snug."
	icon_state = "surgcollar"
	item_state = "surgcollar"
	armor =  ARMOR_LEATHER_BAD
	prevent_crits = MINOR_CRITICALS



// =============================================================================
// ==============================	CLOAKS	====================================

//................ Silk Cape ............... //
/obj/item/clothing/cloak/cape/silk
	name = "silk cape"
	color = CLOTHING_WET
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "cape_silk"
	boobed = TRUE
	sleevetype = "shirt"
	nodismemsleeves = TRUE

/obj/item/clothing/cloak/cape/silk/dark
	color = CLOTHING_DARK_INK

/obj/item/clothing/cloak/cape/silk/random/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	add_overlay(mutable_appearance('modular/stonekeep/icons/clothing.dmi', "clasp"))
	..()

/obj/item/clothing/cloak/raincloak/woodsman/Initialize()
	color = pick_assoc(GLOB.peasant_dyes)
	..()

/obj/item/clothing/cloak/half/random/Initialize()
	color = pick(CLOTHING_WINESTAIN_RED, CLOTHING_PEAR_YELLOW, CLOTHING_SOOT_BLACK, CLOTHING_BARK_BROWN, CLOTHING_BOG_GREEN, CLOTHING_SKY_BLUE)
	..()

/obj/item/clothing/cloak/apron
	armor = ARMOR_MINIMAL

/obj/item/clothing/cloak/apron/brown
	name = "leather apron"
	armor = ARMOR_WEAK

// =============================================================================
// ==============================	ARMOR	====================================

/obj/item/clothing/armor/rare	// already got huge armor values. Lets balance with crappy integrity. OP classes no fun for everyone else.
	max_integrity = INTEGRITY_STANDARD

/obj/item/clothing/armor/leather/vest/bard
	name = "leather vest"
	icon_state = "leathervest"
	color = "#ffffff"

//................ Iron breastplate ............... //
/obj/item/clothing/armor/cuirass/iron
	icon = 'modular/stonekeep/icons/clothing.dmi'

//................ Steel cuirass ............... //
/obj/item/clothing/armor/cuirass
	icon_state = "cuirasse"

//................ Silk Jacket ............... //
/obj/item/clothing/armor/leather/jacket/niteman
	name = "silk jacket"
	desc = "Displaying wealth while keeping your guts safe from blades with thick leather pads underneath."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "niteman"
	sellprice = VALUE_LEATHER_ARMOR_LORD

	body_parts_covered = COVERAGE_SHIRT


//................ Crimson Marauder ............... //
/obj/item/clothing/armor/leather/jacket/sea/marauder
	slot_flags = ITEM_SLOT_ARMOR
	name = "jinete's linothorax"
	desc = "A stained leather cuirass bearing the snarling face of a demon. The tiefling nomads of the Crimsonlands shape this armor to hearken to that which their ancestors wore."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "crimson_armor"
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	armor = ARMOR_LEATHER_GOOD
	body_parts_covered = CHEST|GROIN|LEGS|VITALS

/obj/item/clothing/armor/leather/basic
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'

/obj/item/clothing/armor/leather/heavy
	name = "heavy leather armor"
	desc = "A heavy steerhide jerkin with enough body to stand on its own. It forms a stiff, protective mantle \
	for its wearer, shielding from blows and weather alike."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "roguearmor"
	item_state = "roguearmor"
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP)
	max_integrity = INTEGRITY_STANDARD
	sellprice = 25
/obj/item/clothing/armor/leather/heavy/New()
	. = ..()
	if(icon_state == "roguearmor")
		if(prob(30))
			icon_state = "roguearmor_belt"
			item_state = "roguearmor_belt"

/obj/item/clothing/armor/leather/heavy/coat
	name = "heavy leather coat"
	desc = "Steerhide jerkin that reaches past the hips to cover the thighs and legs somewhat."
	icon_state = "roguearmor_coat"
	item_state = "roguearmor_coat"
	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	sellprice = 40

/obj/item/clothing/shirt/robe/elegantgown
	name = "elegant gown"
	desc = "A thin piece of fabric worn under a robe to stop chafing and keep ones dignity if a harsh blow of wind comes through."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "desertgown"
	item_state = "desertgown"
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT

/obj/item/clothing/shirt/robe/prior
	name = "prior robes"
	desc = ""
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "monkcloth"
	item_state = "monkcloth"
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD

/obj/item/clothing/armor/leather/vest/monk
	name = "monk robes"
	desc = "Comes with a leather vest."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "monkleather"
	item_state = "monkleather"
	color = "#ffffff"

/obj/item/clothing/shirt/robe/bath
	name = "bathrobe"
	desc = "A bathrobe with a luxurious fur interior."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "bathrobe"
	toggle_icon_state = TRUE
	adjustable = CAN_CADJUST
	body_parts_covered = ARM_LEFT|ARM_RIGHT

/obj/item/clothing/shirt/robe/bath/AdjustClothes(mob/user)
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			if(toggle_icon_state)
				icon_state = "[initial(icon_state)]_t"
			flags_inv = null
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_armor()
				H.update_icon()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			flags_inv = HIDEBOOB
			body_parts_covered = ARM_LEFT|ARM_RIGHT|CHEST|GROIN
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_armor()
					H.update_icon()

/obj/item/clothing/shirt/robe/eora
	name = "eoran robe"
	desc = "Holy robes, intended for use by followers of Eora. Two layers, some choose to discard the outer one to display their physique."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "eorarobes"
	var/fanatic_wear = FALSE
/obj/item/clothing/shirt/robe/eora/attack_right(mob/user)
	switch(fanatic_wear)
		if(FALSE)
			name = "open eoran robe"
			desc = "Used by more radical followers of the Eoran Church"
			body_parts_covered = null
			icon_state = "eorastraps"
			fanatic_wear = TRUE
			to_chat(usr, span_warning("Now wearing radically!"))
		if(TRUE)
			name = "eoran robe"
			desc = "Holy robes, intended for use by followers of Eora"
			body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
			icon_state = "eorarobes"
			fanatic_wear = FALSE
			to_chat(usr, span_warning("Now wearing normally!"))
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/shirt/robe/eora/alt // obsolete, dont use

/obj/item/clothing/shirt/robe/malum
	name = "craftsman's robes"
	desc = "The sturdy robes of a maker-monk of Malum."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "malumrobe"
	sleeved = null
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 0) // I just wanted to give Malumite robes a tiny bit of fire protection because they're craftspeople.


/obj/item/clothing/shirt/dress/valorian
	name = "commoner dress"
	desc = "A simple deep-blue frock worn in many cities of Valoria."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "valorian"
	sellprice = 13

/obj/item/clothing/shirt/dress/gen/sexy
	icon = 'modular/stonekeep/icons/clothing.dmi'

/obj/item/clothing/armor/gambeson/heavy/dress
	slot_flags = ITEM_SLOT_ARMOR

//................ Sheriff Brigandine ............... //
/obj/item/clothing/armor/brigandine/sheriff
	detail_tag = "_det"
	detail_color = COLOR_WHITE

/obj/item/clothing/armor/brigandine/sheriff/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state]_det"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/armor/brigandine/sheriff/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/armor/brigandine/sheriff/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src
	update_icon()

/obj/item/clothing/armor/brigandine/sheriff/Destroy()
	GLOB.lordcolor -= src
	return ..()





/obj/item/clothing/shirt/dress/gen/sexy/Initialize()
	color = pick( CLOTHING_ROYAL_MAJENTA, CLOTHING_MAGE_BLUE, CLOTHING_ROYAL_PURPLE	, CLOTHING_SALMON)
	..()

/obj/item/clothing/shirt/dress/gen/random/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	..()

/obj/item/clothing/shirt/tunic/noblecoat
	name = "fancy coat"
	desc = "A fancy tunic and coat combo. How elegant."
	detail_tag = "_detail"
	detail_color = CLOTHING_WHITE
	var/picked = FALSE
	colorgrenz = TRUE

/obj/item/clothing/shirt/tunic/noblecoat/proc/get_player_input()
	if(!ishuman(loc))
		return
	var/list/colors = list(
	"PURPLE"="#865c9c",
	"RED"="#933030",
	"BROWN"="#685542",
	"GREEN"="#79763f",
	"BLUE"="#395480",
	"YELLOW"="#b5b004",
	"TEAL"="#249589",
	"WHITE"="#ffffff",
	"ORANGE"="#b86f0c",
	"Royal Majenta"="#962e5c")
	var/mob/living/carbon/human/L = loc
	var/choice = input(L, "Choose a color.", "GRENZELHOFTIAN COLORPLEX") as anything in colors
	var/playerchoice = colors[choice]
	picked = TRUE
	detail_color = playerchoice
	update_icon()
	for(var/obj/item/clothing/V in L.get_equipped_items(FALSE))
		testing("clothes to color are [V]")
		if(V.colorgrenz)
			V.detail_color = playerchoice
			V.update_icon()
	L.regenerate_icons()

/obj/item/clothing/shirt/tunic/noblecoat/Initialize()
	. = ..()
	if(!picked)
		var/mob/living/carbon/human/L = loc
		if(!istype(L))
			return
		if(!L.client)
			return
		INVOKE_ASYNC(src, PROC_REF(get_player_input))

/obj/item/clothing/shirt/tunic/noblecoat/court
	picked = TRUE
	colorgrenz = FALSE

/obj/item/clothing/shirt/tunic/noblecoat/court/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/shirt/tunic/noblecoat/court/lordcolor(primary,secondary)
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/shirt/tunic/noblecoat/court/Destroy()
	GLOB.lordcolor -= src
	return ..()


/obj/item/clothing/shirt/robe/weaver/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	..()

/obj/item/clothing/shirt/dress/stewarddress
	name = "demure dress"
	desc = "Fashionably fitted with shining bronze buttons."


/obj/item/clothing/shirt/tunic/yellow
	color = CLOTHING_MAGE_YELLOW

/obj/item/clothing/cloak/cape/yellow
	color = CLOTHING_MAGE_YELLOW

// ==============================	GLOVES	====================================
// =============================================================================
/obj/item/clothing/gloves/reinforced
	name = "reinforced gloves"
	desc = "Metal bits protects your hands."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "roguegloves"
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	resistance_flags = FLAMMABLE // Made of leather

	armor = ARMOR_LEATHER_GOOD
	prevent_crits = ALL_EXCEPT_CHOP_AND_STAB
	max_integrity = INTEGRITY_STANDARD
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/gloves/fencer
	name = "fencing gloves"
	desc = "Excellent quality."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "fencergloves"
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	resistance_flags = FLAMMABLE // Made of leather

	armor = ARMOR_LEATHER
	prevent_crits = ALL_EXCEPT_CHOP_AND_STAB
	max_integrity = INTEGRITY_STRONG
	salvage_result = /obj/item/natural/hide/cured


// =============================================================================
// ==============================	BELT	====================================

/obj/item/storage/belt/leather/plaquegold
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'


// =============================================================================
// ==============================	ARMS	====================================

/obj/item/clothing/wrists/bracers/leather
	armor = ARMOR_LEATHER_BAD
/obj/item/clothing/wrists/bracers/leather/heavy
	name = "heavy leather bracers"
	desc = ""
	color = "#d5c2aa"
	armor = ARMOR_LEATHER
	prevent_crits = ALL_EXCEPT_BLUNT_AND_STAB

/obj/item/clothing/wrists/bracers/splint
	name = "splint vambraces"
	desc = ""
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "splintarms"
	item_state = "splintarms"
	armor = ARMOR_LEATHER_GOOD
	blocksound = SOFTHIT
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/iron
	armor = ARMOR_LEATHER_GOOD
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONG

// ==============================	LEGS	====================================
// =============================================================================

/obj/item/clothing/pants/trou
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/pants/trou/leather
	name = "leather trousers"
	desc = "Standard leather pants for hardy workers."
	icon_state = "leathertrou"
	armor = ARMOR_PADDED
	max_integrity = INTEGRITY_POOR
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/pants/trou/baggy
	name = "baggy pants"
	desc = "A pair of baggy, comfortable pants. They end in a tight stocking around the calf, ballooning out around the thigh."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "monkpants"
	item_state = "monkpants"
	armor = ARMOR_WEAK
/obj/item/clothing/pants/trou/baggy/Initialize()
	. = ..()
	color = pick_assoc(GLOB.noble_dyes)
/obj/item/clothing/pants/trou/leather
	salvage_result = /obj/item/natural/hide/cured
	armor =  ARMOR_LEATHER_BAD


/obj/item/clothing/pants/trou/leather/heavy
	name = "heavy leather trousers"
	desc = "Thick hide cut and sewn into a pair of very protective trousers. The dense leather can \
	turn away errant chops."
	gender = PLURAL
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "roguepants"
	item_state = "roguepants"
	armor =  ARMOR_LEATHER
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	max_integrity = INTEGRITY_STANDARD
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	resistance_flags = FIRE_PROOF
	armor_class = AC_LIGHT

/obj/item/clothing/pants/trou/leather/padded
	name = "fine leather trousers"
	desc = "Protects your legs from minor cuts and slashes well enough."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "fencerpants"
	resistance_flags = FIRE_PROOF
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	max_integrity = INTEGRITY_STRONG
	armor = 	ARMOR_LEATHER

/obj/item/clothing/pants/splintlegs
	name = "splint chausses"
	desc = "Worn by many a wandering warrior."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "splintlegs"
	item_state = "splintlegs"
	blocksound = SOFTHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	armor_class = AC_LIGHT
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	sewrepair = FALSE

	armor = ARMOR_LEATHER_GOOD
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/pants/chainlegs/reinforced
	name = "platemail chausses"
	desc = "Chain and plate for the best leg protection possible without going plate."
	icon_state = "heavyleggies"
	item_state = "heavyleggies"

/obj/item/clothing/pants/platelegs
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "plate_legs"
	item_state = "plate_legs"

/obj/item/clothing/pants/platelegs/captain
	icon = 'icons/roguetown/clothing/special/captain.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/captain.dmi'

/obj/item/clothing/pants/platelegs/rust
	icon = 'icons/roguetown/clothing/special/rust_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'

/obj/item/clothing/pants/platelegs/vampire
	icon = 'icons/roguetown/clothing/pants.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_pants.dmi'

//................ Stockings ............... //
/obj/item/clothing/pants/tights/stockings
	name = "stockings"
	desc = "A legwear made just for the pure aesthetics. Popular in courts and brothels alike."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "stockings"
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	body_parts_covered = null
	flags_inv = null

/obj/item/clothing/pants/tights/stockings/random/Initialize()
	color = pick(GLOB.peasant_dyes)
	..()
/obj/item/clothing/pants/tights/stockings/white
	color = CLOTHING_LINEN
/obj/item/clothing/pants/tights/stockings/black
	color = CLOTHING_SOOT_BLACK
/obj/item/clothing/pants/tights/stockings/blue
	color = CLOTHING_BERRY_BLUE
/obj/item/clothing/pants/tights/stockings/red
	color = CLOTHING_WINESTAIN_RED
/obj/item/clothing/pants/tights/stockings/green
	color = CLOTHING_SPRING_GREEN

//................ Silk stockings ............... //
/obj/item/clothing/pants/tights/stockings/silk
	name = "silk stockings"
	desc = "A legwear made just for the pure aesthetics. Made out of thin silk. Popular among nobles."
	icon_state = "silk"

/obj/item/clothing/pants/tights/stockings/silk/random/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	..()
/obj/item/clothing/pants/tights/stockings/silk/white
	color = CLOTHING_CHALK_WHITE
/obj/item/clothing/pants/tights/stockings/silk/black
	color = CLOTHING_DARK_INK
/obj/item/clothing/pants/tights/stockings/silk/blue
	color = CLOTHING_SKY_BLUE
/obj/item/clothing/pants/tights/stockings/silk/red
	color = CLOTHING_BLOOD_RED
/obj/item/clothing/pants/tights/stockings/silk/purple
	color = CLOTHING_PLUM_PURPLE

//................ Silk Pantaloons ............... //
/obj/item/clothing/pants/pantaloons
	name = "silk pantaloons"
	icon_state = "pantaloons"
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	color = CLOTHING_WET
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	adjustable = FALSE

/obj/item/clothing/pants/pantaloons/random/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	..()

/obj/item/clothing/pants/pantaloons/dark
	color = CLOTHING_DARK_INK

/obj/item/clothing/pants/platelegs/captain
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'

// ==============================	FEET	====================================
// =============================================================================

/obj/item/clothing/shoes/boots/leather
	armor = ARMOR_PADDED
	blocksound = SOFTHIT
/obj/item/clothing/shoes/boots/armor
	armor = ARMOR_PLATE
/obj/item/clothing/shoes/simpleshoes/buckle
	armor = ARMOR_WEAK
/obj/item/clothing/shoes/boots
	armor = ARMOR_PADDED_BAD

/obj/item/clothing/shoes/nobleboot
	armor = ARMOR_PADDED_BAD
/obj/item/clothing/shoes/shortboots
	armor = ARMOR_WEAK
/obj/item/clothing/shoes/ridingboots
	armor = ARMOR_PADDED
/obj/item/clothing/shoes/apothboots
	armor = ARMOR_PADDED_BAD

/obj/item/clothing/shoes/boots/armor/light
	armor = ARMOR_PLATE_BAD

/obj/item/clothing/shoes/grenzelhoft
	armor = ARMOR_PADDED
/obj/item/clothing/shoes/boots/leather/heavy
	name = "heavy leather boots"
	desc = "Well-heeled boots. The leather thick enough to resist wear and tear."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "psydonboots"
	item_state = "psydonboots"
	max_integrity = 200
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_LEATHER

/obj/item/clothing/shoes/boots/leather/fencing
	name = "fencing boots"
	desc = "Boots of outstanding craft, your fragile feet has never felt so protected and comfortable before."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "fencerboots"
	item_state = "fencerboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	max_integrity = 200
	armor = ARMOR_LEATHER_GOOD

/obj/item/clothing/shoes/boots/armor/iron
	name = "iron plated boots"
	desc = "Boots with iron for added protection."
	body_parts_covered = FEET
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "armorironboots"
	item_state = "armorironboots"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	color = null
	blocksound = PLATEHIT
	max_integrity = 200
	armor = ARMOR_SCALE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/shoes/boots/leather/inqboots
	name = "inquisitorial boots"
	desc = "Finely crafted boots, made to stomp out darkness."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "inqboots"
	item_state = "inqboots"
	armor = ARMOR_LEATHER_GOOD

/obj/item/clothing/shoes/simpleshoes
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'

/* * * * * * * * * * * **
 *						*
 *		 Underwear		*
 *						*
 *						*
 * * * * * * * * * * * **/

/obj/item/undies
	body_parts_covered = GROIN

/obj/item/undies/f
	body_parts_covered = CHEST|GROIN


//.................Guild Clothing..................//

//Maker's Guild - CLOTHING_WINESTAIN_RED, CLOTHING_SOOT_BLACK

/obj/item/clothing/head/headband/makers
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/cloak/apron/makers
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/shirt/shortshirt/makers
	color = CLOTHING_WINESTAIN_RED

/obj/item/clothing/pants/tights/makers
	color = CLOTHING_SOOT_BLACK

//Provisoner's Guild - CLOTHING_SPRING_GREEN, CLOTHING_OLD_LEATHER

/obj/item/clothing/shirt/shortshirt/provisoner
	color = CLOTHING_SPRING_GREEN

/obj/item/clothing/pants/tights/provisoner
	color = CLOTHING_SPRING_GREEN


/obj/item/clothing/shirt/undershirt/artificer
	name = "craftsmans shirt"
	desc = "Favored by those of the Makers guild who got the money for it."

/obj/item/clothing/pants/trou/artipants
	name = "masonry trousers"

/obj/item/clothing/cloak/captain
	name = "sheriffs cape"
	desc = "A cape with fine embroidery and heraldry."
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/clothes.dmi'



/obj/item/clothing/armor/medium/surcoat
	color = CLOTHING_WINESTAIN_RED



/obj/item/clothing/cloak/volfmantle
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/clothes.dmi'
	alternate_worn_layer = BACK_LAYER
	slot_flags =  ITEM_SLOT_BACK_L|ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK

/obj/item/clothing/cloak/wickercloak
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/clothes.dmi'
	slot_flags =  ITEM_SLOT_BACK_L|ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK

/obj/item/clothing/armor/brigandine/coatplates
	desc = "A heavy armor made of smaller overlapping plates. \
			It is said to have been invented by the most famous Haiduk khan Möngke, but as with most tales, no one knows for sure."

/obj/item/clothing/neck/slave_collar
	name = "cursed collar"
	desc = "Siaves of value are often decorated with these unbreakable collars. Their manufacture is a well hidden Zybantean secret."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "collar"
	allowed_race = ALL_PLAYER_RACES_BY_NAME
	allowed_sex = list(MALE,FEMALE)
	slot_flags = ITEM_SLOT_NECK
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/neck/slave_collar/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/clothing/neck/slave_collar/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/clothing/mask/exoticsilkmask
	name = "exotic silk mask"
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "exoticsilkmask"
	flags_inv = HIDEFACIALHAIR
	body_parts_covered = NECK|MOUTH
	slot_flags = ITEM_SLOT_MASK
	sewrepair = TRUE

/obj/item/clothing/shirt/exoticsilkbra
	name = "exotic silks"
	desc = "Fanciful gold laced silks barely able to conceal what little it covers."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "exoticsilkbra"
	item_state = "exoticsilkbra"
	gender = PLURAL
	body_parts_covered = CHEST|ARMS|VITALS
	sewrepair = TRUE

/obj/item/storage/belt/leather/exoticsilk
	name = "silk loincloth"
	desc = "A flimsy coverage."
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "exoticbelt"
	item_state = "exoticbelt"

//
//   Velvet Dress
//

/obj/item/clothing/shirt/dress/velvetdress
	name = "velvet dress"
	desc = "A dress made with the finest velvet, befitting a person of high standing"
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/clothes.dmi'
	icon_state = "velvetdress"
	item_state = "velvetdress"
//	detail_tag = "_detail"
//	color = CLOTHING_WHITE
//	detail_color = "#422413"
//	alternate_worn_layer =  WRISTSLEEVE_LAYER
/obj/item/clothing/shirt/dress/velvetdress/sleeveless
	icon_state = "velvetdress_less"
	item_state = "velvetdress_less"

/obj/item/clothing/shirt/dress/velvetdress/court/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/shirt/dress/velvetdress/court/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/shirt/dress/velvetdress/court/lordcolor(secondary)
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/clothing/shirt/dress/velvetdress/court/Destroy()
	GLOB.lordcolor -= src
	return ..()






//
//   Noble dress
//

/obj/item/clothing/shirt/dress/nobledress
	name = "noble dress"
	desc = "a noble dress, fit for a person of high standing"
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon = 'modular/stonekeep/icons/clothing.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/clothes.dmi'
	sleeved = 'modular/stonekeep/icons/onmob/sleeves.dmi'
	icon_state = "nobledress"
	item_state = "nobledress"

