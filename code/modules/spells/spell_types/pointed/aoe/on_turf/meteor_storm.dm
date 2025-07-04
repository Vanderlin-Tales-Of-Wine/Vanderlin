/datum/action/cooldown/spell/aoe/on_turf/meteor_storm
	name = "Meteor Storm"
	desc = "Summons forth meteors from the sky."
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_NO_MOVE
	button_icon_state = "fireball_greater"
	sound = 'sound/magic/meteorstorm.ogg'

	point_cost = 8
	attunements = list(
		/datum/attunement/fire = 1.2
	)

	charge_time = 25 SECONDS
	charge_drain = 2
	charge_slowdown = 3
	cooldown_time = 3 MINUTES
	spell_cost = 120

	aoe_radius = 6
	respect_LOS = FALSE

	var/exp_heavy = 0
	var/exp_light = 3
	var/exp_flash = 0
	var/exp_fire = 3
	var/exp_hotspot = 1

/datum/action/cooldown/spell/aoe/on_turf/meteor_storm/cast_on_thing_in_aoe(atom/victim, atom/caster)
	. = ..()
	victim.visible_message(span_boldwarning("Fire is raining from the sky!"))
	if(prob(20 * attuned_strength))
		var/time = rand(0.8 SECONDS, 1.6 SECONDS)
		new /obj/effect/temp_visual/fireball(victim, time)
		addtimer(CALLBACK(src, PROC_REF(fell_meteor), victim), time)

/datum/action/cooldown/spell/aoe/on_turf/meteor_storm/proc/fell_meteor(turf/victim)
	var/static/list/sounds = list('sound/misc/explode/incendiary (1).ogg', 'sound/misc/explode/incendiary (2).ogg')
	playsound(victim, 'sound/magic/meteorstorm.ogg', 60, TRUE)
	for(var/mob/living/L in victim)
		L.adjustFireLoss(40)
		L.adjust_fire_stacks(8)
		L.IgniteMob()
	explosion(victim, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, hotspot_range = exp_hotspot, soundin = pick(sounds))

/obj/effect/temp_visual/fireball
	name = "meteor"
	desc = "Get out of the way!"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "meteor"
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 9
	pixel_z = 270

/obj/effect/temp_visual/fireball/Initialize(mapload, incoming_duration)
	duration = incoming_duration || duration
	. = ..()
	animate(src, pixel_z = 0, time = duration)
