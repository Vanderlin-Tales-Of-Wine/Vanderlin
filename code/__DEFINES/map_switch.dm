/// first argument is the icon displayed ingame, second argument is the icon displayed in mapping tools
#ifdef SPACEMAN_DMM
#define MAP_SWITCH(compile_time, map_time) ##map_time
#else
#define MAP_SWITCH(compile_time, map_time) ##compile_time
#endif
