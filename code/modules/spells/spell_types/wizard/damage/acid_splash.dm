/obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e
	name = "Acid Splash"
	desc = "A slow-moving glob of acid that sprays over an area upon impact."
	range = 8
	projectile_type = /obj/projectile/magic/acidsplash5e
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	attunements = list(
		/datum/attunement/blood = 0.3,
		/datum/attunement/death = 0.4,
	)
	overlay_state = "acid_splash"

/obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/projectile/magic/acidsplash5e
	name = "acid bubble"
	icon_state = "green_laser"
	damage = 10
	damage_type = BURN
	flag = "magic"
	range = 15
	speed = 3
	var/aoe_range = 1

/obj/projectile/magic/acidsplash5e/Initialize()
	. = ..()
	var/strength = min(max(0.1, spell_source?.attuned_strength || 1),10)
	var/matrix/matrix = matrix()
	matrix.Scale(strength, strength)
	transform = matrix

/obj/projectile/magic/acidsplash5e/modify_matrix(matrix/matrix)
	var/strength = min(max(0.1, spell_source?.attuned_strength || 1),10)
	return matrix.Scale(strength, strength)

/obj/projectile/magic/acidsplash5e/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/turf/T = get_turf(src)
	playsound(src, 'sound/misc/drink_blood.ogg', 100)
	var/obj/effect/proc_holder/spell/spell_ref = spell_source
	var/strength = spell_ref?.attuned_strength || 1

	// Scale AOE and damage with attunement
	var/scaled_aoe = round(aoe_range * strength)
	var/scaled_damage = round(2 * strength) // Base DoT damage scaling

	for(var/mob/living/L in range(scaled_aoe, get_turf(src)))
		if(!L.anti_magic_check())
			var/mob/living/carbon/M = L
			// Create scaled status effect
			M.apply_status_effect(/datum/status_effect/buff/acidsplash5e, scaled_damage)
			new /obj/effect/temp_visual/acidsplash5e(get_turf(M))
	for(var/turf/turfs_in_range in range(scaled_aoe+1, T))
		new /obj/effect/temp_visual/acidsplash5e(T)

/datum/status_effect/buff/acidsplash5e
	id = "acid splash"
	alert_type = /atom/movable/screen/alert/status_effect/buff/acidsplash5e
	duration = 10 SECONDS
	var/damage_per_tick = 2

/datum/status_effect/buff/acidsplash5e/New(atom/A, scaled_damage = 2)
	damage_per_tick = scaled_damage
	. = ..()

/datum/status_effect/buff/acidsplash5e/tick()
	var/mob/living/target = owner
	target.adjustFireLoss(damage_per_tick)


/atom/movable/screen/alert/status_effect/buff/acidsplash5e
	name = "Acid Burn"
	desc = "My skin is burning!"
	icon_state = "debuff"

/obj/effect/temp_visual/acidsplash5e
	icon = 'icons/effects/effects.dmi'
	icon_state = "greenshatter2"
	name = "horrible acrid brine"
	desc = "Best not touch this."
	randomdir = TRUE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER
