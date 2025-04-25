#define IS_OPAQUE_TURF(turf) (turf.opacity) //https://github.com/tgstation/tgstation/pull/52881

//supposedly the fastest way to do this according to https://gist.github.com/Giacom/be635398926bb463b42a
///Returns a list of turf in a square
#define RANGE_TURFS(RADIUS, CENTER) \
block( \
	locate(max(CENTER.x-(RADIUS),1),          max(CENTER.y-(RADIUS),1),          CENTER.z), \
	locate(min(CENTER.x+(RADIUS),world.maxx), min(CENTER.y+(RADIUS),world.maxy), CENTER.z) \
)

#define Z_TURFS(ZLEVEL) block(locate(1,1,ZLEVEL), locate(world.maxx, world.maxy, ZLEVEL))

///Returns all currently loaded turfs
#define ALL_TURFS(...) block(locate(1, 1, 1), locate(world.maxx, world.maxy, world.maxz))
