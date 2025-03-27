#include "map_files\shared\CentCom.dmm" //this MUST be loaded no matter what for SSmapping's multi-z to work correctly

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\debug\roguetest.dmm"

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
