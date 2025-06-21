#define COLLECT_ONE 0
#define COLLECT_EVERYTHING 1
#define COLLECT_SAME 2

#define DROP_NOTHING 0
#define DROP_AT_PARENT 1
#define DROP_AT_LOCATION 2

/// Must be in the user's hands to be accessed
#define STORAGE_NO_WORN_ACCESS (1<<0)
/// Must be out of the user to be accessed
#define STORAGE_NO_EQUIPPED_ACCESS (1<<1)
