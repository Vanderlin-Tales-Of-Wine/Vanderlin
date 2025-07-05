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
	overlay_state = ""
	range = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 6
	attunements = list(
		/datum/attunement/earth = 0.2,
		/datum/attunement/life = 0.2,
	)

/obj/effect/proc_holder/spell/invoked/flowerfield/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = max(total_value, 0.5)

/obj/effect/proc_holder/spell/invoked/flowerfield/cast(list/targets, mob/living/user = usr)
	set_attuned_strength(user?.mana_pool?.attunements || list())

	var/cd_reduction = min(15 SECONDS, attuned_strength * 10 SECONDS)
	recharge_time = max(45 SECONDS, 60 SECONDS - cd_reduction)

	var/static/list/flower_type_map = list(
		/obj/item/alch/rosa = /obj/structure/flora/field/rosa,
		/obj/item/alch/salvia = /obj/structure/flora/field/salvia,
		/obj/item/alch/calendula = /obj/structure/flora/field/calendula,
		/obj/item/reagent_containers/food/snacks/produce/manabloom = /obj/structure/flora/field/manabloom,
		/obj/item/alch/matricaria = /obj/structure/flora/field/matricaria,
		/obj/item/reagent_containers/food/snacks/produce/poppy = /obj/structure/flora/field/poppy,
		/obj/item/alch/euphorbia = /obj/structure/flora/field/euphorbia
	)

	var/obj/item/alch/flower_item = null
	var/field_type = null

	for (var/obj/item/I in user.contents)
		if (flower_type_map[I.type])
			flower_item = I
			field_type = flower_type_map[I.type]
			break

	if (!flower_item)
		to_chat(user, span_warning("I need a flower..."))
		return FALSE
	animate(flower_item, alpha = 0, time = 5)
	QDEL_IN(flower_item, 0.5 SECONDS)

	user.apply_status_effect(/datum/status_effect/buff/flowerfield_resistance)
	playsound(user, sound, 60, TRUE)

	var/turf/center = get_turf(targets[1])
	if (!center.density && !istype(center, /turf/open/transparent/openspace) && !(locate(/obj/structure/flora/field) in center.contents))
		var/obj/structure/flora/field/F = new field_type(center)
		F.dir = pick(GLOB.cardinals)

	for (var/i in 1 to range)
		var/list/ring_turfs = list()
		for (var/turf/T in orange(center, i))
			if (T.density || isopenspace(T))
				continue
			if (i == range)
				var/dx = abs(T.x - center.x)
				var/dy = abs(T.y - center.y)
				if (dx == range && dy == range)
					continue
			if (prob(75))
				ring_turfs += T
		if (length(ring_turfs))
			addtimer(CALLBACK(src, PROC_REF(apply_flowerfield), ring_turfs, field_type), i * 5)

	return ..()

/obj/effect/proc_holder/spell/invoked/flowerfield/proc/apply_flowerfield(list/affected_turfs, type)
	if(!LAZYLEN(affected_turfs || !type))
		return
	for (var/turf/T as anything in affected_turfs)
		if (T.density || istype(T, /turf/open/transparent/openspace) || locate(/obj/structure/flora/field) in T.contents)
			continue
		var/obj/structure/flora/field/F = new type(T)
		F.dir =  pick(GLOB.cardinals)
