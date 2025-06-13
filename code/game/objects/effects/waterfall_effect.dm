/obj/effect/waterfall
	name = "waterfall"
	icon = 'icons/effects/waterfall.dmi'
	icon_state = "waterfall_temp"
	pixel_y = 32
	var/datum/reagent/water_reagent = /datum/reagent/water

/obj/effect/waterfall/Initialize()
	. = ..()
	var/turf/open = get_turf(src)
	if(istransparentturf(open))
		return
	color = initial(water_reagent.color)
	var/obj/particle_emitter/effect = MakeParticleEmitter(/particles/mist/waterfall)
	effect.layer = 5
	effect.alpha = 175

/obj/effect/waterfall/acid
	water_reagent = /datum/reagent/rogueacid
