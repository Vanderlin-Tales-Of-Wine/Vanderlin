///each cell in a spatial_grid is this many turfs in length and width
#define SPATIAL_GRID_CELLSIZE 20

///Takes a coordinate, and spits out the spatial grid index (x or y) it's inside
#define GET_SPATIAL_INDEX(coord) ROUND_UP((coord) / SPATIAL_GRID_CELLSIZE)
#define GRID_INDEX_TO_COORDS(index) (index * SPATIAL_GRID_CELLSIZE)
#define SPATIAL_GRID_CELLS_PER_SIDE(world_bounds) GET_SPATIAL_INDEX(world_bounds)

#define SPATIAL_GRID_CHANNELS 2

//grid contents channels

///everything that is hearing sensitive is stored in this channel
#define SPATIAL_GRID_CONTENTS_TYPE_HEARING RECURSIVE_CONTENTS_HEARING_SENSITIVE
///every movable that has a client in it is stored in this channel
#define SPATIAL_GRID_CONTENTS_TYPE_CLIENTS RECURSIVE_CONTENTS_CLIENT_MOBS

///whether movable is itself or containing something which should be in one of the spatial grid channels.
#define HAS_SPATIAL_GRID_CONTENTS(movable) (movable.spatial_grid_key)

#define ALL_CONTENTS_OF_CELL(cell) (cell.hearing_contents | cell.client_contents)


///remove from every list
#define GRID_CELL_REMOVE_ALL(cell, movable) \
	GRID_CELL_REMOVE(cell.hearing_contents, movable) \
	GRID_CELL_REMOVE(cell.client_contents, movable)
