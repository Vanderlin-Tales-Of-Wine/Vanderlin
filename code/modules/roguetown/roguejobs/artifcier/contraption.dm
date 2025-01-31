/obj/item/contraption
	name = "random piece of machinery"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"
	var/on_icon
	var/off_icon
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = /obj/item/ingot/bronze
	slot_flags = ITEM_SLOT_HIP
	var/obj/item/accepted_power_source = /obj/item/roguegear
	/// This is the amount of charges we get per power source
	var/charge_per_source = 5
	var/current_charge = 0
	var/misfire_chance
	/// Are we misfiring? Important for chain reactions.
	var/misfiring = FALSE
	obj_flags_ignore = TRUE

/obj/item/contraption/examine(mob/user)
	. = ..()
	if(!istype(user, /mob/living))
		return
	var/mob/living/player = user
	var/skill = player.mind.get_skill_level(/datum/skill/craft/engineering)
	if(current_charge)
		. += span_warning("The contraption has [current_charge] charges left.")
	if(!current_charge)
		. += span_warning("This contraption requires a new [initial(accepted_power_source.name)] to function.")
	if(misfire_chance)
		if(skill > 2)
			. += span_warning("You calculate this contraptions chance of failure to be anywhere between [max(0, (misfire_chance - skill) - rand(4))]% and [max(2, (misfire_chance - skill) + rand(3))]%.")
		else
			. += span_warning("It seems slightly unstable...")

/obj/item/contraption/proc/battery_collapse(obj/O, mob/living/user)
	to_chat(user, span_info("The [accepted_power_source.name] wastes away into nothing."))
	playsound(src, pick('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, FALSE)
	shake_camera(user, 1, 1)
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_turf(src)
	S.set_up(1, 1, front)
	S.start()
	return

/obj/item/contraption/proc/misfire(obj/O, mob/living/user)
	user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT * 5))
	to_chat(user, span_info("Oh fuck."))
	playsound(src, 'sound/misc/bell.ogg', 100)
	addtimer(CALLBACK(src, PROC_REF(misfire_result)), rand(5, 30))

/obj/item/contraption/proc/misfire_result()
	misfiring = TRUE
	explosion(src, light_impact_range = 3, flame_range = 1, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)

/obj/item/contraption/attackby(obj/item/I, mob/user, params)
	if(istype(I, accepted_power_source))
		user.changeNext_move(CLICK_CD_FAST)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(src)
		S.set_up(1, 1, front)
		S.start()
		if(current_charge)
			to_chat(user, span_info("I try to insert the [I.name] but theres already \a [initial(accepted_power_source.name)] inside!"))
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			shake_camera(user, 1, 1)
		else
			to_chat(user, span_info("I insert the [I.name] and the [name] starts ticking."))
			current_charge = charge_per_source
			playsound(src, 'sound/combat/hits/blunt/woodblunt (2).ogg', 100, TRUE)
			qdel(I)
			addtimer(CALLBACK(src, PROC_REF(play_clock_sound)), 5)
	if(istype(I, /obj/item/rogueweapon/hammer))
		user.changeNext_move(CLICK_CD_FAST)
		flick(off_icon, src)
		user.visible_message(span_info("[user] beats the [name] into submission!"))
		playsound(src, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg', 'sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 100, TRUE)
		shake_camera(user, 1, 1)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(I)
		S.set_up(1, 1, front)
		S.start()
		var/probability = rand(1, 100)
		if(!current_charge)
			misfire(I, user)
			return
		if(probability <= 5)
			misfire(I, user)
		else if(probability <= 40)
			if(current_charge < charge_per_source)
				current_charge += 1
			misfire_chance = rand(1, 30)
		else
			misfire_chance = rand(10, 100)
	..()

/obj/item/contraption/proc/play_clock_sound()
	playsound(src, 'sound/misc/clockloop.ogg', 25, TRUE)

/obj/item/contraption/attack_obj(obj/O, mob/living/user)
	if(!current_charge)
		flick(off_icon, src)
		to_chat(user, span_info("The contraption beeps! It requires \a [initial(accepted_power_source.name)]!"))
		playsound(src, 'sound/magic/magic_nulled.ogg', 100, TRUE)
		return

/obj/item/contraption/wood_metalizer
	name = "wood metalizer"
	desc = "A creation of genious or insanity. This cursed contraption is somehow able to turn wood into metal."
	icon_state = "metalizer"
	on_icon = "metalizer_flick"
	off_icon = "metalizer_off"
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/ingot/bronze
	misfire_chance = 15
	charge_per_source = 5

/obj
	/// This is the result when the wood metalizer artifact is used on this item
	var/metalizer_result
	/// The smelting result, used by the smelter or by the portable smelter
	var/smeltresult

/obj/item/contraption/wood_metalizer/attack_obj(obj/O, mob/living/user)
	..()
	if(!current_charge)
		return
	if(!O.metalizer_result)
		to_chat(user, span_info("The [name] refuses to function."))
		playsound(user, 'sound/items/flint.ogg', 100, FALSE)
		flick(off_icon, src)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(O)
		S.set_up(1, 1, front)
		S.start()
		return
	var/skill = user.mind.get_skill_level(/datum/skill/craft/engineering)
	if(istype(O, /obj/structure/mineral_door/wood)) //This is to ensure the new door will retain its lock
		var/obj/structure/mineral_door/wood/I = O
		var/obj/structure/mineral_door/wood/new_door = new I.metalizer_result(get_turf(I))
		new_door.locked = I.locked
		if(I.lockid)
			new_door.lockid = I.lockid
		if(I.lockhash)
			new_door.lockhash = I.lockhash
		qdel(I)
	else
		var/obj/I = O
		new I.metalizer_result(get_turf(I))
		qdel(I)
	flick(on_icon, src)
	current_charge -= 1
	shake_camera(user, 1, 1)
	playsound(src, 'sound/magic/swap.ogg', 100, TRUE)
	user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT / 2))
	if(misfire_chance && prob(max(0, misfire_chance - user.stat_roll(STATKEY_LCK,2,10) - skill)))
		misfire(O, user)
	if(!current_charge)
		addtimer(CALLBACK(src, PROC_REF(battery_collapse), O, user), rand(5))
	return

/obj/item/contraption/smelter
	name = "portable smelter"
	desc = "Furnaces are a thing of the past. The future is here!"
	icon_state = "smelter"
	on_icon = "smelter_flick"
	off_icon = "smelter_off"
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/ingot/bronze
	accepted_power_source = /obj/item/rogueore/coal
	misfire_chance = 10
	charge_per_source = 6

/obj/item/contraption/smelter/misfire_result()
	misfiring = TRUE
	for(var/obj/object in oview(3, src))
		if(object.smeltresult)  // Check if the object is within the flame range
			if(istype(object, /obj/item/ingot))
				continue
			if(istype(object, /obj/item/contraption))
				var/obj/item/contraption/I = object
				if(I.misfiring)
					continue
				I.misfire_result()
				continue
			object.popcorn_smelt()

	explosion(src, flame_range = 3, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	qdel(src)

/obj/proc/popcorn_smelt()
	var/turf/T = get_turf(src)
	moveToNullspace()
	playsound(T, pick('sound/combat/hits/burn (1).ogg','sound/combat/hits/burn (2).ogg'), 50)
	new /obj/effect/decal/cleanable/ash(T)
	addtimer(CALLBACK(src, PROC_REF(popcorn_smelt_result), T), rand(10, 40))

/obj/proc/popcorn_smelt_result(turf)
	new smeltresult(turf)
	playsound(turf, pick('sound/combat/hits/onmetal/sheet (1).ogg', 'sound/combat/hits/onmetal/sheet (2).ogg'), 100, TRUE)
	qdel(src)

/obj/item/contraption/smelter/attack_obj(obj/O, mob/living/user)
	..()
	if(!current_charge)
		return
	if(!O.smeltresult)
		to_chat(user, span_info("The [name] refuses to function."))
		playsound(user, 'sound/items/flint.ogg', 100, FALSE)
		flick(off_icon, src)
		var/datum/effect_system/spark_spread/S = new()
		var/turf/front = get_turf(O)
		S.set_up(1, 1, front)
		S.start()
		return
	user.mind.add_sleep_experience(/datum/skill/craft/engineering, (user.STAINT / 3))
	current_charge -= 1
	flick(on_icon, src)
	playsound(loc, 'sound/misc/machinevomit.ogg', 50, TRUE)
	addtimer(CALLBACK(src, PROC_REF(smelt_part2), O, user), 5)
	return

/obj/item/contraption/smelter/proc/smelt_part2(obj/O, mob/living/user)
	var/skill = user.mind.get_skill_level(/datum/skill/craft/engineering)
	var/turf/turf = get_turf(O)
	playsound(O, pick('sound/combat/hits/burn (1).ogg','sound/combat/hits/burn (2).ogg'), 100)
	new /obj/effect/decal/cleanable/ash(turf)
	O.moveToNullspace()
	if(misfire_chance && prob(max(0, misfire_chance - user.stat_roll(STATKEY_LCK,2,10) - skill)))
		misfire(O, user)
	if(!current_charge)
		addtimer(CALLBACK(src, PROC_REF(battery_collapse), O, user), rand(5))
	addtimer(CALLBACK(O, PROC_REF(popcorn_smelt_result), turf), 20)
	return
