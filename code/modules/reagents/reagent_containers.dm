/obj/item/reagent_containers
	name = "Container"
	desc = ""
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	w_class = WEIGHT_CLASS_TINY

	grid_height = 64
	grid_width = 32
	/// Starting transfer amount
	var/amount_per_transfer_from_this = 5
	/// List of selectable transfer amounts
	var/list/possible_transfer_amounts = list(5, 10, 15, 20, 25, 30)
	/// Reagents max volume
	var/volume = 30
	var/reagent_flags
	/// Whether this can be splashed
	var/spillable = FALSE
	/// Current reagents
	var/list/list_reagents = null
	/// List of thresholds to change the filling icon. If null no filling icons are used.
	var/list/fill_icon_thresholds = null // list(10, 50, 100)
	/// Optional custom name for reagent fill icon_state prefix
	var/fill_icon_state = null
	/// Underlays fill state instead of overlaying it
	var/fill_icon_under_override = FALSE
	/// Sounds when consuming
	var/drinksounds = list('sound/items/drink_gen (1).ogg','sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg')
	/// Sounds when filling another container
	var/fillsounds
	/// Sounds when pouring out of
	var/poursounds
	/// Short cooktime, when high cooking skill
	var/short_cooktime = FALSE
	/// Long cooktime, when low cooking skill
	var/long_cooktime = FALSE

	COOLDOWN_DECLARE(weather_act_cooldown)

/obj/item/reagent_containers/Initialize(mapload, vol)
	. = ..()
	if(isnum(vol) && vol > 0)
		volume = vol
	create_reagents(volume, reagent_flags)

	add_initial_reagents()

	if(spillable)
		GLOB.weather_act_upon_list |= src

/obj/item/reagent_containers/weather_act_on(weather_trait, severity)
	if(weather_trait != PARTICLEWEATHER_RAIN || !COOLDOWN_FINISHED(src, weather_act_cooldown))
		return
	if(!isturf(loc))
		return
	reagents.add_reagent(/datum/reagent/water, clamp(severity * 0.5, 1, 5))
	COOLDOWN_START(src, weather_act_cooldown, 10 SECONDS)

/obj/item/reagent_containers/Destroy()
	if(spillable)
		GLOB.weather_act_upon_list -= src
	return ..()

/obj/item/reagent_containers/proc/add_initial_reagents()
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/reagent_containers/attack(mob/M, mob/user, def_zone)
	return ..()

/obj/item/reagent_containers/proc/canconsume(mob/eater, mob/user, silent = FALSE)
	if(!iscarbon(eater))
		return 0
	var/mob/living/carbon/C = eater
	var/covered = ""
	if(C.is_mouth_covered(head_only = 1))
		covered = "headgear"
	else if(C.is_mouth_covered(mask_only = 1))
		covered = "mask"
	if(C != user)
		if(isturf(eater.loc))
			if(C.body_position != LYING_DOWN)
				if(get_dir(eater, user) != eater.dir)
					to_chat(user, "<span class='warning'>I must stand in front of [C.p_them()].</span>")
					return 0
	if(covered)
		if(!silent)
			var/who = (isnull(user) || eater == user) ? "your" : "[eater.p_their()]"
			to_chat(user, "<span class='warning'>I have to remove [who] [covered] first!</span>")
		return 0
	return 1

/obj/item/reagent_containers/ex_act()
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			R.on_ex_act()
	if(!QDELETED(src))
		..()

/obj/item/reagent_containers/fire_act(added, maxstacks)
	reagents.expose_temperature(added)
	..()

/obj/item/reagent_containers/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	SplashReagents(hit_atom, TRUE)

/obj/item/reagent_containers/proc/bartender_check(atom/target)
	. = FALSE
	if(target.CanPass(src, get_turf(src)) && thrownby && HAS_TRAIT(thrownby, TRAIT_BOOZE_SLIDER))
		. = TRUE

/obj/item/reagent_containers/proc/SplashReagents(atom/target, thrown = FALSE)
	if(!reagents || !reagents.total_volume || !spillable)
		return

	if(ismob(target) && target.reagents)
		if(thrown)
			reagents.total_volume *= rand(5,10) * 0.1 //Not all of it makes contact with the target
		var/mob/M = target
		var/R
		target.visible_message("<span class='danger'>[M] has been splashed with something!</span>", \
						"<span class='danger'>[M] has been splashed with something!</span>")
		for(var/datum/reagent/A in reagents.reagent_list)
			R += "[A.type]  ([num2text(A.volume)]),"

		if(thrownby)
			log_combat(thrownby, M, "splashed", R)
		reagents.reaction(target, TOUCH)

	else if(bartender_check(target) && thrown)
		visible_message("<span class='notice'>[src] lands onto the [target.name] without spilling a single drop.</span>")
		return

	else
		if(isturf(target))
			var/turf/target_turf = target
			if(istype(target_turf, /turf/open))
				target_turf.add_liquid_from_reagents(reagents, FALSE, reagents.chem_temp)
			if(reagents.reagent_list.len && thrownby)
				log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]", "in [AREACOORD(target)]")
				log_game("[key_name(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [AREACOORD(target)].")
				message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [ADMIN_VERBOSEJMP(target)].")
		visible_message("<span class='notice'>[src] spills its contents all over [target].</span>")
		reagents.reaction(target, TOUCH)
		if(QDELETED(src))
			return

	reagents.clear_reagents()

/obj/item/reagent_containers/heating_act()
	reagents.expose_temperature(1000)
	..()

/obj/item/reagent_containers/temperature_expose(exposed_temperature, exposed_volume)
	reagents.expose_temperature(exposed_temperature)

/obj/item/reagent_containers/on_reagent_change(changetype)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/reagent_containers/update_overlays()
	. = ..()
	if(!reagents?.total_volume)
		return
	if(!fill_icon_thresholds)
		return
	var/fill_name = fill_icon_state ? fill_icon_state : icon_state
	var/use_underlays = FALSE
	var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[fill_name][fill_icon_thresholds[1]]")

	if(fill_icon_under_override || reagent_flags & TRANSPARENT)
		use_underlays = TRUE

	var/percent = round((reagents.total_volume / volume) * 100)
	for(var/i in 1 to length(fill_icon_thresholds))
		var/threshold = fill_icon_thresholds[i]
		var/threshold_end = (i == length(fill_icon_thresholds)) ? INFINITY : fill_icon_thresholds[i+1]
		if(threshold <= percent && percent < threshold_end)
			filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"

	filling.color = mix_color_from_reagents(reagents.reagent_list)
	filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)

	if(use_underlays)
		underlays.Cut()
		underlays += filling
	else
		. += filling

	var/datum/reagent/master = reagents.get_master_reagent()
	if(master?.glows)
		. += emissive_appearance(filling.icon, filling.icon_state, alpha = filling.alpha)
