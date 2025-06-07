/obj/effect/proc_holder/spell/invoked/projectile/frostbolt
	name = "Frost Bolt"
	desc = "A ray of frozen energy, slowing the first thing it touches and lightly damaging it."
	range = 8
	projectile_type = /obj/projectile/magic/frostbolt
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 15 SECONDS //cooldown

	overlay_state = "frost_bolt"
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1
	attunements = list(
		/datum/attunement/ice = 0.7,
	)

/obj/effect/proc_holder/spell/self/frostbolt/cast(mob/user = usr)
	var/mob/living/target = user
	target.visible_message(span_warning("[target] hurls a frosty beam!"), span_notice("You hurl a frosty beam!"))
	. = ..()

/obj/effect/proc_holder/spell/invoked/projectile/frostbolt/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/projectile/magic/frostbolt/Initialize()
	. = ..()
	var/obj/effect/proc_holder/spell/spell_ref = spell_source
	if(spell_ref?.attuned_strength)
		var/strength = spell_ref.attuned_strength
		damage = round(damage * spell_ref.attuned_strength)
		var/matrix/matrix = matrix()
		matrix.Scale(strength, strength)
		transform = matrix

/obj/projectile/magic/frostbolt/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			var/obj/effect/proc_holder/spell/spell_ref = spell_source
			var/strength = spell_ref?.attuned_strength || 1
			L.apply_status_effect(/datum/status_effect/buff/frostbite5e, strength)
			new /obj/effect/temp_visual/snap_freeze(get_turf(L))
	qdel(src)

/obj/projectile/magic/frostbolt
	name = "frost bolt"
	icon_state = "ice_2"
	damage = 25
	damage_type = BURN
	flag = "magic"
	range = 10
	speed = 1 //higher is slower
	var/aoe_range = 0

/obj/projectile/magic/frostbolt/modify_matrix(matrix/matrix)
	var/strength = min(max(0.1, spell_source?.attuned_strength || 1),10)
	return matrix.Scale(strength, strength)


/obj/projectile/magic/frostbolt/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.apply_status_effect(/datum/status_effect/buff/frostbite5e)
			new /obj/effect/temp_visual/snap_freeze(get_turf(L))
	qdel(src)

/datum/status_effect/buff/frostbite5e
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/frostbite5e
	duration = 20 SECONDS
	effectedstats = list(STATKEY_SPD = -2)
	var/strength_multiplier = 1

/datum/status_effect/buff/frostbite5e/New(atom/A, strength = 1)
	strength_multiplier = strength
	// Scale duration and slow effect with attunement
	duration = round(20 SECONDS * strength)
	effectedstats = list(STATKEY_SPD = round(-2 * strength))
	. = ..()

/atom/movable/screen/alert/status_effect/buff/frostbite5e
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"
	color = "#00fffb" //talk about a coder sprite

/datum/status_effect/buff/frostbite5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.update_vision_cone()
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 20 SECONDS)
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)

/datum/status_effect/buff/frostbite5e/on_remove()
	var/mob/living/target = owner
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
	. = ..()
