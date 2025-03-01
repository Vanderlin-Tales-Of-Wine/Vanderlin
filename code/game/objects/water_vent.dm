/obj/structure/water_vent
	name = "water vent"
	desc = "Shoots out liquids."
	icon = 'icons/roguetown/misc/vents.dmi'
	icon_state = "vent"

	accepts_water_input = TRUE

	var/obj/particle_emitter/emitter

/obj/structure/water_vent/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/water_vent/valid_water_connection(direction, obj/structure/water_pipe/pipe)
	if(direction == dir)
		input = pipe
		return TRUE

/obj/structure/water_vent/process()
	if(input)
		spew_water()

/obj/structure/water_vent/proc/spew_water()
	emitter = locate(/obj/particle_emitter) in particle_emitters
	if(!emitter)
		emitter = MakeParticleEmitter(/particles/smoke/steam/water_pipe)
	var/datum/reagent/reagent = input.carrying_reagent
	emitter.color = initial(reagent.color)

	var/matrix/matrix = matrix()
	switch(dir)
		if(SOUTH)
			matrix.Turn(180)
		if(EAST)
			matrix.Turn(90)
		if(WEST)
			matrix.Turn(270)
	emitter.transform = matrix
