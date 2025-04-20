/// Uses the left operator when compiling, uses the right operator when not compiling.
#ifdef SPACEMAN_DMM
#define MAP_SWITCH(compile_time, map_time) ##map_time
#else
#define MAP_SWITCH(compile_time, map_time) ##compile_time
#endif
