GLOBAL_LIST_EMPTY(all_particles)

#define GEN_NUM "num"
#define GEN_VECTOR "vector"
#define GEN_BOX "box"
#define GEN_CIRCLE "circle"
#define GEN_SPHERE "sphere"

/proc/setup_particles()
	var/list/paths = typesof(/particles)
	for (var/path in paths)
		var/particles/P = new path()
		GLOB.all_particles[P.name] = P

/proc/MakeGenerator(g_type, g_min, g_max, g_rand = UNIFORM_RAND)
	switch (g_rand)
		if (1)
			g_rand = NORMAL_RAND
		if (2)
			g_rand = LINEAR_RAND
		if (3)
			g_rand = SQUARE_RAND
		else
			g_rand = UNIFORM_RAND

	if (!isnum(g_min) || !isnum(g_max))
		return null

	return generator(g_type, g_min, g_max, g_rand)
