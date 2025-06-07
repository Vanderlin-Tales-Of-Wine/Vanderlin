/obj/effect/proc_holder/spell/invoked/flowerfield
	name = "Flower Field"
	desc = "Summons a magical field of flowers using a single flower."
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	recharge_time = 60 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	sound = 'sound/blank.ogg'
	overlay_state = "flower_field"
	range = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 6
	attunements = list(
		/datum/attunement/earth = 0.4,
		/datum/attunement/life = 0.4,
	)

/obj/effect/proc_holder/spell/invoked/flowerfield/cast(list/targets, mob/living/user = usr)
	var/static/list/flower_type_map = list(
		/obj/item/alch/rosa = /obj/structure/flora/field/rosa,
		/obj/item/alch/salvia = /obj/structure/flora/field/salvia,
		/obj/item/alch/calendula = /obj/structure/flora/field/calendula,
		/obj/item/reagent_containers/food/snacks/produce/manabloom = /obj/structure/flora/field/manabloom,
		/obj/item/alch/matricaria = /obj/structure/flora/field/matricaria,
		/obj/item/reagent_containers/food/snacks/produce/poppy = /obj/structure/flora/field/poppy
	)

	var/obj/item/alch/flower_item = null
	var/field_type = null

	for (var/obj/item/I in user.contents)
		if (flower_type_map[I.type])
			flower_item = I
			field_type = flower_type_map[I.type]
			break

	if (!flower_item)
	{
		to_chat(user, span_warning("No suitable flower found. Summoning hostile thorns instead."))
		field_type = /obj/structure/flora/field/euphorbia
	}
	else
	{
		animate(flower_item, alpha = 0, time = 5)
		sleep(5)
		qdel(flower_item)
	}

	user.apply_status_effect(/datum/status_effect/buff/flowerfield_resistance)// so you wont be affected by the plants for 5 seconds
	playsound(user, sound, 60, TRUE)

	var/turf/center = get_turf(targets[1])
	if (!center.density && !istype(center, /turf/open/transparent/openspace) && !(locate(/obj/structure/flora/field) in center.contents))
		var/obj/structure/flora/field/F = new field_type(center)
		F.dir = pick(NORTH, SOUTH, EAST, WEST)

	for (var/i = 1, i <= range, i++)
		var/list/ring_turfs = list()
		for (var/turf/T in range(center, i))
			if ((get_dist(center, T) == i) && (!T.density) && (!istype(T, /turf/open/transparent/openspace)))
			{
				if (i == range)
				{
					var/dx = abs(T.x - center.x)
					var/dy = abs(T.y - center.y)
					if (dx == range && dy == range)
						continue
				}
				if (prob(75))
					ring_turfs += T
			}
		if (ring_turfs.len)
			addtimer(CALLBACK(src, PROC_REF(apply_flowerfield), ring_turfs, field_type), i * 5)

	return TRUE

/obj/effect/proc_holder/spell/invoked/flowerfield/proc/apply_flowerfield(list/affected_turfs, type)
	for (var/turf/T in affected_turfs)
		if (T.density || istype(T, /turf/open/transparent/openspace) || locate(/obj/structure/flora/field) in T.contents)
			continue
		var/obj/structure/flora/field/F = new type(T)
		F.dir = pick(NORTH, SOUTH, EAST, WEST)


/*-----------------\
|  Flower Fields   |
\-----------------*/
/obj/structure/flora/field
	name = ""
	desc = ""
	anchored = TRUE
	density = FALSE
	icon = 'icons/roguetown/misc/foliage.dmi'
	icon_state = ""
	dir = SOUTH
	attacked_sound = "plantcross"
	destroy_sound = "plantcross"
	layer = ABOVE_NORMAL_TURF_LAYER
	max_integrity = 25
	blade_dulling = DULLING_CUT
	resistance_flags = FLAMMABLE
	object_slowdown = 2

/obj/structure/flora/field/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(flower_decay)), 1 MINUTES)

/obj/structure/flora/field/Crossed(atom/movable/AM)
	. = ..()
	if (isliving(AM))
		var/mob/living/L = AM
		if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
			return
		if (L.m_intent == MOVE_INTENT_SNEAK)
			return
		playsound(src.loc, "plantcross", 90, FALSE, -1)
		var/oldx = pixel_x
		animate(src, pixel_x = oldx + 1, time = 0.5)
		animate(pixel_x = oldx - 1, time = 0.5)
		animate(pixel_x = oldx, time = 0.5)
		L.consider_ambush()


/obj/structure/flora/field/proc/flower_decay()
	playsound(src, "plantcross", 100, FALSE)
	icon_state = "leaf_dying"
	sleep(10)
	qdel(src)

/obj/structure/flora/field/proc/apply_flower_effect(mob/living/L, effect_path)
	if (!L) return
	if (!L.has_status_effect(effect_path))
		L.apply_status_effect(effect_path)

// ---------------------- ROSA FIELD ----------------------------
/obj/structure/flora/field/rosa
	name = "rosa field"
	icon_state = "rosa"

/obj/structure/flora/field/rosa/Crossed(atom/movable/AM)
	. = ..()
	if (isliving(AM))
		var/mob/living/L = AM
		if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
			return
		apply_flower_effect(L, /datum/status_effect/debuff/rosa_pacification)

// ---------------------- SALVIA FIELD ----------------------------
/obj/structure/flora/field/salvia
	name = "salvia field"
	icon_state = "salvia"
	object_slowdown = 4

/obj/structure/flora/field/salvia/Crossed(atom/movable/AM)
	. = ..()
	if (isliving(AM))
		var/mob/living/L = AM
		if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
			return
		if (prob(20))
			L.emote("spin", forced=TRUE)
			L.Stun(5)
		apply_flower_effect(L, /datum/status_effect/debuff/salvia_madness)

// ---------------------- EUPHORBIA FIELD ----------------------------
/obj/structure/flora/field/euphorbia
	name = "euphorbia field"
	icon_state = "euphorbia"
	object_slowdown = 3

/obj/structure/flora/field/euphorbia/Crossed(atom/movable/AM)
	. = ..()
	if (!isliving(AM)) return
	var/mob/living/L = AM
	if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
		return
	if (!L.buckled && prob(45))
	{
		L.visible_message(span_warning("[L] is snagged by the briars!"))
		if (buckle_mob(L, TRUE, check_loc = FALSE))
		{
			if (!HAS_TRAIT(L, TRAIT_NOPAIN))
				L.emote("agony")
			L.Stun(2 SECONDS)
		}
	}
	if (!HAS_TRAIT(L, TRAIT_PIERCEIMMUNE))
	{
		L.adjustBruteLoss(15)
		to_chat(L, span_danger("Thorns rip into you as you push through!"))
	}
	apply_flower_effect(L, /datum/status_effect/debuff/euphorbia_thorns)

// ---------------------- CALENDULA FIELD ----------------------------
/obj/structure/flora/field/calendula
	name = "calendula field"
	icon_state = "calendula"

/obj/structure/flora/field/calendula/Crossed(atom/movable/AM)
	. = ..()
	if (isliving(AM))
		var/mob/living/L = AM
		if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
			return
		apply_flower_effect(L, /datum/status_effect/debuff/calendula_sedation)

// ---------------------- MANABLOOM FIELD ----------------------------
/obj/structure/flora/field/manabloom
	name = "manabloom field"
	icon_state = "mana"

/obj/structure/flora/field/manabloom/Crossed(atom/movable/AM)
	. = ..()
	if (isliving(AM))
		var/mob/living/L = AM
		if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
			return
		apply_flower_effect(L, /datum/status_effect/debuff/manabloom_silence)

// ---------------------- MATRICARIA FIELD ----------------------------
/obj/structure/flora/field/matricaria
	name = "matricaria field"
	icon_state = "matricaria"
	object_slowdown = 3

/obj/structure/flora/field/matricaria/Crossed(atom/movable/AM)
	. = ..()
	if (!isliving(AM)) return
	var/mob/living/L = AM
	if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
		return
	apply_flower_effect(L, /datum/status_effect/debuff/matricaria_remedy)
	if (!L.has_status_effect(/datum/status_effect/frozen_solid) && prob(30))
		L.apply_status_effect(/datum/status_effect/frozen_solid)

// ---------------------- POPPY FIELD ----------------------------
/obj/structure/flora/field/poppy
	name = "poppy field"
	icon_state = "poppy"
	object_slowdown = 4

/obj/structure/flora/field/poppy/Crossed(atom/movable/AM)
	. = ..()
	if (isliving(AM))
		var/mob/living/L = AM
		if (HAS_TRAIT(L, TRAIT_FLOWERFIELD_IMMUNITY))
			return
		apply_flower_effect(L, /datum/status_effect/debuff/poppy_arena)

/*-----------------\
|  Flower Debuffs  |
\-----------------*/

#define FOLIAGE_ICON 'icons/effects/effects.dmi'

/datum/status_effect/debuff/flower_base
	var/overlay_state = null
	var/field_path = null
	var/image/flower_overlay

/datum/status_effect/debuff/flower_base/on_apply()
	. = ..()
	if (ismob(owner) && overlay_state)
		var/mob/M = owner
		flower_overlay = mutable_appearance(FOLIAGE_ICON, overlay_state)
		M.overlays += flower_overlay
		RegisterSignal(M, COMSIG_MOVABLE_MOVED, PROC_REF(_check_flower_field))

/datum/status_effect/debuff/flower_base/on_remove()
	. = ..()
	if (ismob(owner))
		var/mob/M = owner
		if (flower_overlay)
			M.overlays -= flower_overlay
		UnregisterSignal(M, COMSIG_MOVABLE_MOVED)

/datum/status_effect/debuff/flower_base/proc/_check_flower_field(mob/living/L)
	if (!field_path || !locate(field_path) in get_turf(L))
		L.remove_status_effect(src)

/datum/status_effect/debuff/flower_base/proc/check_field_presence()
	var/mob/living/L = owner
	if (!L) return
	if (!locate(field_path) in get_turf(L))
		L.remove_status_effect(src)


// ---------------------- ROSA PACIFICATION ----------------------------
/datum/status_effect/debuff/rosa_pacification
	parent_type = /datum/status_effect/debuff/flower_base
	id = "rosa_pacification"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/rosa_pacification
	duration = -1
	status_type = STATUS_EFFECT_REFRESH
	overlay_state = "rosa_overlay"
	field_path = /obj/structure/flora/field/rosa
	tick_interval = 10

/datum/status_effect/debuff/rosa_pacification/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_PACIFISM, TRAIT_GENERIC)

/datum/status_effect/debuff/rosa_pacification/tick()
	check_field_presence()

/datum/status_effect/debuff/rosa_pacification/on_remove()
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, TRAIT_GENERIC)
	. = ..()

/atom/movable/screen/alert/status_effect/debuff/rosa_pacification
	name = "Pacified"
	desc = span_notice("You are unable to do violence.")
	icon_state = "pacify"

// ---------------------- SALVIA MADNESS ----------------------------
/datum/status_effect/debuff/salvia_madness
	parent_type = /datum/status_effect/debuff/flower_base
	id = "salvia_madness"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/salvia_madness
	duration = -1
	tick_interval = 30
	status_type = STATUS_EFFECT_REFRESH
	overlay_state = "salvia_overlay"
	field_path = /obj/structure/flora/field/salvia
	var/tick_counter = 0

/datum/status_effect/debuff/salvia_madness/tick()
	var/mob/living/L = owner
	if (!L) return
	check_field_presence()
	tick_counter++
	L.Stun(5)
	L.Jitter(5)
	L.emote(pick("spin", "dance"), forced=TRUE)
	L.emote(pick("laugh", "giggle"), forced=TRUE)
	if (tick_counter >= 4)
		L.emote("faint", forced=TRUE)
		qdel(src)

/atom/movable/screen/alert/status_effect/debuff/salvia_madness
	name = "Salvia Madness"
	desc = span_notice("You have an overwhelming urge to dance and laugh.")
	icon_state = "salvia_mad"


// ---------------------- EUPHORBIA THORNS ----------------------------
/datum/status_effect/debuff/euphorbia_thorns
	parent_type = /datum/status_effect/debuff/flower_base
	id = "euphorbia_thorns"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/euphorbia_thorns
	duration = -1
	tick_interval = 20
	status_type = STATUS_EFFECT_REFRESH
	overlay_state = "euphorbia_overlay"
	field_path = /obj/structure/flora/field/euphorbia

/datum/status_effect/debuff/euphorbia_thorns/on_apply()
	. = ..()
	owner.visible_message(span_danger("[owner] is pierced by thorns!"))

/datum/status_effect/debuff/euphorbia_thorns/tick()
	var/mob/living/L = owner
	if (!L) return
	check_field_presence()
	L.adjustBruteLoss(15)

	if (locate(/obj/structure/flora/field/euphorbia) in get_turf(L))
		to_chat(L, span_warning("The spines hurt your feet"))

	if (prob(15) && ishuman(L))
		var/mob/living/carbon/human/H = L
		var/obj/item/bodypart/BP = pick(H.bodyparts)
		var/obj/item/natural/thorn/TH = new(get_turf(H))
		BP.add_embedded_object(TH, silent = TRUE)
		to_chat(H, span_danger("A thorn embeds into your [BP.name]!"))

/atom/movable/screen/alert/status_effect/debuff/euphorbia_thorns
	name = "Spiny Terrain"
	desc = "You are stepping on spines."
	icon_state = "entwined"

// ---------------------- CALENDULA SEDATION ----------------------------
/datum/status_effect/debuff/calendula_sedation
	parent_type = /datum/status_effect/debuff/flower_base
	id = "calendula_sedation"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/calendula_sedation
	duration = -1
	tick_interval = 10
	effectedstats = list(STATKEY_SPD = -2, STATKEY_STR = -1, STATKEY_END = 1)
	status_type = STATUS_EFFECT_REFRESH
	overlay_state = "calendula_overlay"
	field_path = /obj/structure/flora/field/calendula
	var/tick_counter = 0

/datum/status_effect/debuff/calendula_sedation/tick()
	tick_counter++
	var/mob/living/L = owner
	if (!L) return
	check_field_presence()

	L.adjustBruteLoss(-2.5)
	L.adjustToxLoss(-2, 0)
	L.adjustOxyLoss(-1.5)
	var/list/wounds = L.get_wounds()
	if(wounds.len > 0)
		L.heal_wounds(1)
		to_chat(L, span_notice("A wound healed"))

	if (tick_counter % 15 == 5)
		if (!HAS_TRAIT(L, TRAIT_NOSTAMINA) && prob(30))
			L.adjust_stamina(-5)
			to_chat(L, span_notice("You feel drained..."))

	if (tick_counter % 15 == 10 && !L.has_status_effect(/datum/status_effect/incapacitating/sleeping))
		L.emote("yawn", forced=TRUE)

	if (tick_counter % 15 == 0 && !L.has_status_effect(/datum/status_effect/incapacitating/sleeping))
		if(prob(65))
			L.visible_message(span_danger("[L] suddenly collapses!"))
			L.apply_status_effect(STATUS_EFFECT_UNCONSCIOUS, 5 SECONDS)
			L.emote("snore", forced=TRUE)

/atom/movable/screen/alert/status_effect/debuff/calendula_sedation
	name = "Tranquility"
	desc = "You feel too relaxed...."
	icon_state = "tranquil"

// ---------------------- MANABLOOM SILENCE ----------------------------
/datum/status_effect/debuff/manabloom_silence
	parent_type = /datum/status_effect/debuff/flower_base
	id = "manabloom_silence"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/manabloom_silence
	duration = -1
	status_type = STATUS_EFFECT_REFRESH
	overlay_state = "manabloom_overlay"
	field_path = /obj/structure/flora/field/manabloom
	tick_interval = 10

/datum/status_effect/debuff/manabloom_silence/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_MUTE, TRAIT_GENERIC)

/datum/status_effect/debuff/manabloom_silence/tick()
	check_field_presence()

/datum/status_effect/debuff/manabloom_silence/on_remove()
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_MUTE, TRAIT_GENERIC)
	. = ..()

/atom/movable/screen/alert/status_effect/debuff/manabloom_silence
	name = "Silenced"
	desc = span_notice("You are blocked from the arcyne.")
	icon_state = "spellblock"

// ---------------------- MATRICARIA REMEDY ----------------------------
/datum/status_effect/debuff/matricaria_remedy
	parent_type = /datum/status_effect/debuff/flower_base
	id = "matricaria_remedy"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/matricaria_remedy
	duration = -1
	tick_interval = 10
	effectedstats = list(STATKEY_SPD = -3)
	status_type = STATUS_EFFECT_REFRESH
	overlay_state = "matricaria_overlay"
	field_path = /obj/structure/flora/field/matricaria

/datum/status_effect/debuff/matricaria_remedy/tick()
	var/mob/living/M = owner
	if (!M || M.stat != CONSCIOUS) return

	check_field_presence()
	M.adjustFireLoss(-2.5)

	if (prob(10) && !M.has_status_effect(/datum/status_effect/frozen_solid))
		M.apply_status_effect(/datum/status_effect/frozen_solid)
		M.adjustFireLoss(-8)

/atom/movable/screen/alert/status_effect/debuff/matricaria_remedy
	name = "Chill"
	desc = "A chilling breeze courses through you."
	icon_state = "matricaria_cold"

// ---------------------- POPPY ARENA ----------------------------// ran out of ideas
/datum/status_effect/debuff/poppy_arena
	parent_type = /datum/status_effect/debuff/flower_base
	id = "poppy_arena"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/poppy_arena
	duration = -1
	tick_interval = 10
	status_type = STATUS_EFFECT_REFRESH
	overlay_state = "poppy_overlay"
	field_path = /obj/structure/flora/field/poppy
	effectedstats = list(STATKEY_STR = 1, STATKEY_END = -2, STATKEY_PER = -2, STATKEY_INT = -2)

/datum/status_effect/debuff/poppy_arena/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_DRUQK, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)

/datum/status_effect/debuff/poppy_arena/tick()
	check_field_presence()

/datum/status_effect/debuff/poppy_arena/on_remove()
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_DRUQK, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	. = ..()

/atom/movable/screen/alert/status_effect/debuff/poppy_arena
	name = "Arena"
	desc = span_notice("You're in for a fair fight")
	icon_state = "arena"

// ---------------------- FLOWERFIELD RESISTANCE ----------------------------
/datum/status_effect/buff/flowerfield_resistance
	id = "flowerfield_resistance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/flowerfield_resistance
	duration = 5 SECONDS

/datum/status_effect/buff/flowerfield_resistance/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_FLOWERFIELD_IMMUNITY, TRAIT_GENERIC)

/datum/status_effect/buff/flowerfield_resistance/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_FLOWERFIELD_IMMUNITY, TRAIT_GENERIC)

/atom/movable/screen/alert/status_effect/buff/flowerfield_resistance
	name = "Flower Stider"
	desc = span_notice("You are momentarily immune to the flower field's effects.")
	icon_state = "flowerfield"
