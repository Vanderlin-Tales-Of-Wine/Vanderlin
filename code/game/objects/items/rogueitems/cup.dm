/obj/item/reagent_containers/glass/cup
	name = "metal cup"
	desc = "An iron cup, it's rim gnawed upon and grimey."
	icon = 'icons/roguetown/items/cooking.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "iron"
	force = 5
	throwforce = 10
	reagent_flags = OPENCONTAINER
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

/obj/item/reagent_containers/glass/cup/update_icon(dont_fill=FALSE)
	testing("cupupdate")

	cut_overlays()

	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/cooking.dmi', "[icon_state]filling")

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		add_overlay(filling)

/obj/item/reagent_containers/glass/cup/wooden
	name = "wooden cup"
	desc = "A wooden cup that has seen it's fair share of use and barfights."
	resistance_flags = FLAMMABLE
	icon_state = "wooden"
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	metalizer_result = /obj/item/reagent_containers/glass/cup

/obj/item/reagent_containers/glass/cup/steel
	name = "goblet"
	desc = "A steel goblet that bears a few dents from previous scuffles."
	icon_state = "steel"
	sellprice = 10

/obj/item/reagent_containers/glass/cup/silver
	name = "silver goblet"
	desc = "A silver goblet, its surface adorned with intricate carvings and runes."
	icon_state = "silver"
	dropshrink = 0.65
	sellprice = 30
	last_used = 0
	is_silver = TRUE

/obj/item/reagent_containers/glass/cup/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.dna && H.dna.species)
			if(istype(H.dna.species, /datum/species/werewolf))
				return FALSE
	if(M.mind && M.mind.has_antag_datum(/datum/antagonist/vampirelord))
		return FALSE

/obj/item/reagent_containers/glass/cup/golden
	name = "golden goblet"
	desc = "A golden gilded goblet which gleams pathetically despite it's illustrious metal."
	icon_state = "golden"
	dropshrink = 0.65
	sellprice = 50

/obj/item/reagent_containers/glass/cup/skull
	name = "skull goblet"
	desc = "The hollow eye sockets tell you of forgotten, dark rituals."
	icon_state = "skull"
	dropshrink = 0.8
// ----- Glassware -----

/obj/item/reagent_containers/glass/cup/glassware
	name = "glass cup"
	desc = "A fancy glass cup- the few scratches that are upon it tell grand tales of lies and betrayal. It tends to break easily..."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	icon_state = "clear_cup1"
	sellprice = VALUE_COMMON_GOODS*2
	dropshrink = 1
	max_integrity = 5
	volume = 24
	fill_icon_thresholds = list(0, 1, 50, 100)
	grid_width = 32
	grid_height = 64

/obj/item/reagent_containers/glass/cup/glassware/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	Destroy(hit_atom, thrownby, "threw")

/obj/item/reagent_containers/glass/cup/glassware/Destroy(mob/living/carbon/target, mob/thrownby, msgverb)
	var/turf/location = get_turf(src)
	SplashReagents(location, TRUE)
	// Start the break
	playsound(location, "glassbreak", 100, TRUE)
	new /obj/effect/decal/cleanable/glass (location)
	var/obj/item/natural/glass/shard/bottleshard = new(location)
	bottleshard.pixel_x = rand(-6,6)
	bottleshard.pixel_y = rand(-6,6)
	// If someone got hit- wound them with the glass shard
	if(ishuman(target))
		var/mob/living/carbon/victim = target
		var/obj/item/bodypart/affecting = victim.get_bodypart(pickweight(list(BODY_ZONE_HEAD = 1, BODY_ZONE_CHEST = 1, BODY_ZONE_L_ARM = 4, BODY_ZONE_R_ARM = 4, BODY_ZONE_L_LEG = 4, BODY_ZONE_R_LEG = 4)))
		if(msgverb=="smashed") // The thrownby mob smashed the glass get the targeted zone.
			affecting = victim.get_bodypart(check_zone(thrownby.zone_selected))
		log_combat(thrownby, victim, "[msgverb] a cup/glassware at", src)
		affecting.add_embedded_object(bottleshard)
		if(roll(1,4)>=3)
			affecting.try_crit(pickweight(list(BCLASS_STAB = 1, BCLASS_PICK = 2, BCLASS_CUT = 5)), 85) // Bottles are quite expensive and not very many people can make them- they're also made of glass...
	..()

/obj/item/reagent_containers/glass/cup/glassware/funny_attack_effects(mob/living/target, mob/living/user)
	. = ..()
	if(ishuman(target))
		Destroy(target, user, "smashed")

/obj/item/reagent_containers/glass/cup/glassware/update_icon()
	cut_overlays()
	underlays.Cut()

	if(reagents.total_volume)
		var/fill_name = fill_icon_state? fill_icon_state : icon_state
		var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/glass_reagent_container.dmi', "[fill_name][fill_icon_thresholds[1]]")

		var/percent = round((reagents.total_volume / volume) * 100)
		for(var/i in 1 to fill_icon_thresholds.len)
			var/threshold = fill_icon_thresholds[i]
			var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
			if(threshold <= percent && percent < threshold_end)
				filling.icon_state = "[fill_name]-[fill_icon_thresholds[i]]"
		filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		underlays += filling

/obj/item/reagent_containers/glass/cup/glassware/shotglass
	name = "shot glass"
	desc = "A fancy shot glass- the few scratches that are upon it tell grand tales of lies and betrayal. It tends to break easily..."
	icon_state = "clear_shotglass1"
	sellprice = VALUE_COMMON_GOODS*1.5
	volume = 9 // 3oz
	grid_width = 32
	grid_height = 32

/obj/item/reagent_containers/glass/cup/glassware/wineglass
	name = "wine glass"
	desc = "A fancy wine glass- the few scratches that are upon it tell grand tales of lies and betrayal. It tends to break easily..."
	icon_state = "clear_wineglass1"
