/* smoothing_flags */
/// Smoothing system in where adjacencies are calculated and used to select a pre-baked icon_state, encoded by bitmasking.
#define SMOOTH_BITMASK	(1<<0)
/// Limits SMOOTH_BITMASK to only cardinal directions, for use with cardinal smoothing
#define SMOOTH_BITMASK_CARDINALS (1<<1)
/**
 * turf only, will smooth via overlaying adjacent turfs
 * Uses var/neighborlay
 * compatible with other smoothing flags
 */
#define SMOOTH_EDGE		(1<<2)
/// atom will smooth with the borders of the map
#define SMOOTH_BORDER	(1<<3)
/// smooths with objects, and will thus need to scan turfs for contents.
#define SMOOTH_OBJ		(1<<4)
/// atom is currently queued to smooth.
#define SMOOTH_QUEUED	(1<<5)

#define USES_SMOOTHING (SMOOTH_BITMASK|SMOOTH_BITMASK_CARDINALS|SMOOTH_EDGE)

DEFINE_BITFIELD(smooth, list(
	"SMOOTH_BORDER" = SMOOTH_BORDER,
	"SMOOTH_BITMASK" = SMOOTH_BITMASK,
	"SMOOTH_BITMASK_CARDINALS" = SMOOTH_BITMASK_CARDINALS,
	"SMOOTH_EDGE" = SMOOTH_EDGE,
	"SMOOTH_OBJ" = SMOOTH_OBJ,
	"SMOOTH_QUEUED" = SMOOTH_QUEUED,
))

/*smoothing macros*/

#define QUEUE_SMOOTH(thing_to_queue) if(thing_to_queue.smoothing_flags & USES_SMOOTHING) {SSicon_smooth.add_to_queue(thing_to_queue)}

#define QUEUE_SMOOTH_NEIGHBORS(thing_to_queue) for(var/atom/atom_neighbor as anything in orange(1, thing_to_queue)) {QUEUE_SMOOTH(atom_neighbor)}


/**SMOOTHING GROUPS
 * Groups of things to smooth with.
 * * Contained in the `list/smoothing_groups` variable.
 * * Matched with the `list/canSmoothWith` variable to check whether smoothing is possible or not.
 */

#define S_TURF(num) (#num + ",")
/* /turf only */

#define SMOOTH_GROUP_TURF_OPEN S_TURF(0)				///turf/open
#define SMOOTH_GROUP_FLOOR_WATER S_TURF(1)				///turf/open/lava/smooth
#define SMOOTH_GROUP_FLOOR_OPEN_SPACE S_TURF(2)			///turf/open/transparent/openspace

#define SMOOTH_GROUP_OPEN_FLOOR S_TURF(3)				///turf/open/floor

#define SMOOTH_GROUP_CARPET S_TURF(4)					///turf/open/floor/carpet
#define SMOOTH_GROUP_CARPET_PURPLE S_TURF(5)			///turf/open/floor/carpet/purple
#define SMOOTH_GROUP_CARPET_STELLAR S_TURF(6)			///turf/open/floor/carpet/stellar
#define SMOOTH_GROUP_CARPET_RED S_TURF(7)				///turf/open/floor/carpet/red
#define SMOOTH_GROUP_CARPET_ROYAL_BLACK S_TURF(8)		///turf/open/floor/carpet/royalblack
#define SMOOTH_GROUP_CARPET_GREEN S_TURF(9)				///turf/open/floor/carpet/green
#define SMOOTH_GROUP_CARPET_LORD S_TURF(10)				///turf/open/floor/carpet/lord

#define SMOOTH_GROUP_GRASS S_TURF(11)
#define SMOOTH_GROUP_DIRT S_TURF(12)
#define SMOOTH_GROUP_SNOW S_TURF(13)
#define SMOOTH_GROUP_STONE_FLOOR S_TURF(14)
#define SMOOTH_GROUP_WOOD S_TURF(15)
#define SMOOTH_GROUP_WOOD_ALT S_TURF(16)
#define SMOOTH_GROUP_WOOD_SAIGA S_TURF(17)
#define SMOOTH_GROUP_WOODTURNED S_TURF(18)
#define SMOOTH_GROUP_WOODTURNED_ALT S_TURF(19)


#define SMOOTH_GROUP_CLOSED S_TURF(24)					///turf/closed
#define SMOOTH_GROUP_MATERIAL_WALLS S_TURF(25)			///turf/closed/wall/material
#define SMOOTH_GROUP_MINERAL_WALLS S_TURF(28)			///turf/closed/mineral, /turf/closed/mineral/turf/random, /closed/indestructible

#define SMOOTH_GROUP_WALLS_STONE S_TURF(29)				///turf/closed/wall/mineral/stone
#define SMOOTH_GROUP_WALLS_STONE_CRAFT S_TURF(30)		///turf/closed/wall/mineral/craftstone
#define SMOOTH_GROUP_WALLS_STONE_BRICK S_TURF(31)		///turf/closed/wall/mineral/stonebrick
#define SMOOTH_GROUP_WALLS_STONE_DECO S_TURF(32)
#define SMOOTH_GROUP_WALLS_PIPE S_TURF(33)				///turf/closed/wall/mineral/pipe
#define SMOOTH_GROUP_WALLS_EREBUS S_TURF(34)			///turf/closed/wall/mineral/underbrick
#define SMOOTH_GROUP_WALLS_WOOD S_TURF(35)				///turf/closed/wall/mineral/wood

#define MAX_S_TURF 36 //Always match this value with the one above it.


#define S_OBJ(num) ("-" + #num + ",")

/* /obj included */

#define SMOOTH_GROUP_WALLS S_OBJ(1)						///turf/closed/wall, /structure/mineral_door/secret

#define SMOOTH_GROUP_WINDOW_FULLTILE S_OBJ(2)			///obj/structure/window/fulltile, /obj/structure/window/reinforced/fulltile, /obj/structure/window/reinforced/tinted/fulltile, /obj/structure/window/plasma/fulltile, /obj/structure/window/plasma/reinforced/fulltile

#define SMOOTH_GROUP_DOOR S_OBJ(3)						///obj/structure/mineral_door

#define SMOOTH_GROUP_TABLES S_OBJ(4)					///obj/structure/table
#define SMOOTH_GROUP_WOOD_TABLES S_OBJ(5)				///obj/structure/table/wood
#define SMOOTH_GROUP_FANCY_WOOD_TABLES S_OBJ(6)		///obj/structure/table/wood/fancy
#define SMOOTH_GROUP_BRONZE_TABLES S_OBJ(7)			///obj/structure/table/bronze

#define SMOOTH_GROUP_CLEANABLE_DIRT	S_OBJ(8)			///obj/effect/decal/cleanable/dirt

/// Performs the work to set smoothing_groups and canSmoothWith.
/// An inlined function used in both turf/Initialize and atom/Initialize.
#define SETUP_SMOOTHING(...) \
	if(smoothing_groups) { \
		if(PERFORM_ALL_TESTS(focus_only/sorted_smoothing_groups)) { \
			ASSERT_SORTED_SMOOTHING_GROUPS(smoothing_groups); \
		} \
		SET_SMOOTHING_GROUPS(smoothing_groups); \
	} \
\
	if(canSmoothWith) { \
		if(PERFORM_ALL_TESTS(focus_only/sorted_smoothing_groups)) { \
			ASSERT_SORTED_SMOOTHING_GROUPS(canSmoothWith); \
		} \
		/* S_OBJ is always negative, and we are guaranteed to be sorted. */ \
		if(canSmoothWith[1] == "-") { \
			smoothing_flags |= SMOOTH_OBJ; \
		} \
		SET_SMOOTHING_GROUPS(canSmoothWith); \
	}

/// Given a smoothing groups variable, will set out to the actual numbers inside it
#define UNWRAP_SMOOTHING_GROUPS(smoothing_groups, out) \
	json_decode("\[[##smoothing_groups]0\]"); \
	##out.len--;

#define ASSERT_SORTED_SMOOTHING_GROUPS(smoothing_group_variable) \
	var/list/unwrapped = UNWRAP_SMOOTHING_GROUPS(smoothing_group_variable, unwrapped); \
	assert_sorted(unwrapped, "[#smoothing_group_variable] ([type])"); \
