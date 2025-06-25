/obj/item/reagent_containers/glass/cup
	name = "metal cup"
	desc = "An iron cup, it's rim gnawed upon and grimey."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "cup_iron"
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	fill_icon_thresholds = list(0)
	reagent_flags = TRANSFERABLE | AMOUNT_VISIBLE
	force = 5
	throwforce = 10
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	dropshrink = 0.75
	w_class = WEIGHT_CLASS_NORMAL
	volume = 24
	obj_flags = CAN_BE_HIT
	sellprice = 1
	drinksounds = list('sound/items/drink_cup (1).ogg','sound/items/drink_cup (2).ogg','sound/items/drink_cup (3).ogg','sound/items/drink_cup (4).ogg','sound/items/drink_cup (5).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	gripped_intents = list(INTENT_POUR)

/obj/item/reagent_containers/glass/cup/wooden
	name = "wooden cup"
	desc = "A wooden cup that has seen it's fair share of use and barfights."
	icon_state = "cup_wooden"
	resistance_flags = FLAMMABLE
	grid_height = 32
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	metalizer_result = /obj/item/reagent_containers/glass/cup

/obj/item/reagent_containers/glass/cup/steel
	name = "goblet"
	desc = "A steel goblet that bears a few dents from previous scuffles."
	icon_state = "cup_steel"
	sellprice = 10

/obj/item/reagent_containers/glass/cup/silver
	name = "silver goblet"
	desc = "A silver goblet, its surface adorned with intricate carvings and runes."
	icon_state = "cup_silver"
	dropshrink = 0.65
	sellprice = 30
	last_used = 0
	is_silver = TRUE

/obj/item/reagent_containers/glass/cup/golden
	name = "golden goblet"
	desc = "A golden gilded goblet which gleams pathetically despite it's illustrious metal."
	icon_state = "cup_golden"
	dropshrink = 0.65
	sellprice = 50

/obj/item/reagent_containers/glass/cup/skull
	name = "skull goblet"
	desc = "The hollow eye sockets tell you of forgotten, dark rituals."
	icon_state = "cup_skull"
	dropshrink = 0.8

/obj/item/reagent_containers/glass/cup/clay
	name = "clay cup"
	desc = "A cup made from fired clay."
	icon = 'icons/obj/handmade/cup.dmi'
	icon_state = "world"
	dropshrink = 1

/obj/item/reagent_containers/glass/cup/clay/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] clay cup"

/obj/item/reagent_containers/glass/cup/fancy_clay
	name = "fancy clay cup"
	desc = "A cup made from fired clay."
	icon = 'icons/obj/handmade/cup_fancy.dmi'
	icon_state = "world"
	dropshrink = 1

/obj/item/reagent_containers/glass/cup/fancy_clay/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] fancy clay cup"

/obj/item/reagent_containers/glass/cup/clay_mug
	name = "clay mug"
	desc = "A mug made from fired clay."
	icon = 'icons/obj/handmade/mug.dmi'
	icon_state = "world"
	dropshrink = 1

/obj/item/reagent_containers/glass/cup/clay_mug/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] clay mug"

// ----- Glassware -----

/obj/item/reagent_containers/glass/cup/glassware
	name = "glass cup"
	desc = "A fancy glass cup- the few scratches that are upon it tell grand tales of lies and betrayal. It tends to break easily..."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	icon_state = "clear_cup1"
	reagent_flags = OPENCONTAINER
	sellprice = VALUE_COMMON_GOODS * 2
	dropshrink = 1
	max_integrity = 5
	volume = 24
	fill_icon_thresholds = list(0, 10, 50, 100)
	grid_width = 32
	grid_height = 64

/obj/item/reagent_containers/glass/cup/glassware/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	var/turf/location = get_turf(src)
	playsound(location, "glassbreak", 100, TRUE)
	new /obj/effect/decal/cleanable/debris/glass (location)
	var/obj/item/natural/glass/shard/bottleshard = new(location)
	bottleshard.pixel_x = rand(-6,6)
	bottleshard.pixel_y = rand(-6,6)
	// If someone got hit- wound them with the glass shard
	if(ishuman(hit_atom))
		var/mob/living/carbon/victim = hit_atom
		var/obj/item/bodypart/affecting = victim.get_bodypart(check_zone(thrownby.zone_selected))
		if(!affecting)
			affecting = victim.get_bodypart(pickweight(list(BODY_ZONE_HEAD = 1, BODY_ZONE_CHEST = 1, BODY_ZONE_L_ARM = 4, BODY_ZONE_R_ARM = 4, BODY_ZONE_L_LEG = 4, BODY_ZONE_R_LEG = 4)))
		affecting.add_embedded_object(bottleshard)
		if(prob(50))
			affecting.try_crit(pickweight(list(BCLASS_STAB = 1, BCLASS_PICK = 2, BCLASS_CUT = 5)), 85) // Bottles are quite expensive and not very many people can make them- they're also made of glass...
	qdel(src)

/obj/item/reagent_containers/glass/cup/glassware/shotglass
	name = "shot glass"
	desc = "A fancy shot glass- the few scratches that are upon it tell grand tales of lies and betrayal. It tends to break easily..."
	icon_state = "clear_shotglass1"
	sellprice = VALUE_COMMON_GOODS * 1.5
	volume = 9
	grid_height = 32

/obj/item/reagent_containers/glass/cup/glassware/wineglass
	name = "wine glass"
	desc = "A fancy wine glass- the few scratches that are upon it tell grand tales of lies and betrayal. It tends to break easily..."
	icon_state = "clear_wineglass1"
