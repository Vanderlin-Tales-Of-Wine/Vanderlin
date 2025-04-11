///Whether we should not attempt to clean.
#define DO_NOT_CLEAN "do_not_clean"

//Cleaning tool strength
// 1 is also a valid cleaning strength but completely unused so left undefined
#define CLEAN_WEAK 			2
/// Acceptable tools
#define CLEAN_MEDIUM		3
/// Industrial strength
#define CLEAN_STRONG		4
/// Cleaning strong enough your granny would be proud
#define CLEAN_IMPRESSIVE	5
/// Cleans things spotless down to the atomic structure
#define CLEAN_GOD			6

//How strong things have to be to wipe forensic evidence...
#define CLEAN_STRENGTH_FINGERPRINTS CLEAN_IMPRESSIVE
#define CLEAN_STRENGTH_BLOOD CLEAN_MEDIUM
#define CLEAN_STRENGTH_FIBERS CLEAN_IMPRESSIVE

#define CLEAN_EFFECTIVENESS_WATER 0.6
#define CLEAN_EFFECTIVENESS_DIRTY_WATER 0.4
#define CLEAN_EFFECTIVENESS_SOAP 7
