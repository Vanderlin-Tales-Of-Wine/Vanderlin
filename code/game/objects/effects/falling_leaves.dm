/particles/leaf
	icon 		= 'icons/effects/particles/particle.dmi'
	icon_state	= list("leaf1"=5, "leaf2"=6, "leaf3"=5)

	spin		= 6
	position 	= generator("box", list(0,32,0), list(32,48,0))
	gravity 	= list(0, -1, 0.1)
	friction 	= 0.5
	drift 		= generator("circle", 1)
	lifespan = generator("num", 35, 55)
	fade = generator("num", 2, 6)
	spawning = 1
	count = 3
	width = 800
	height = 800

/obj/effect/falling_leaves/New(loc, ...)
	. = ..()
	particles = new/particles/leaf
