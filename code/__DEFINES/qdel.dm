//! Defines that give qdel hints.
//!
//! These can be given as a return in [/atom/proc/Destroy] or by calling [/proc/qdel].

/// `qdel` should queue the object for deletion.
#define QDEL_HINT_QUEUE 0
/// `qdel` should let the object live after calling [/atom/proc/Destroy].
#define QDEL_HINT_LETMELIVE 1
/// Functionally the same as the above. `qdel` should assume the object will gc on its own, and not check it.
#define QDEL_HINT_IWILLGC 2
/// Qdel should assume this object won't GC, and queue a hard delete using a hard reference.
#define QDEL_HINT_HARDDEL 3
// Qdel should assume this object won't gc, and hard delete it posthaste.
#define QDEL_HINT_HARDDEL_NOW 4
/**
 * functionally identical to QDEL_HINT_QUEUE if TESTING is not enabled in _compiler_options.dm.
 * if TESTING is enabled, qdel will call this object's find_references() verb.
*/
#define QDEL_HINT_FINDREFERENCE	5

/// if TESTING is enabled, qdel will call this object's find_references() verb., but only if gc fails.
#define QDEL_HINT_IFFAIL_FINDREFERENCE 6
//defines for the gc_destroyed var

#define GC_QUEUE_CHECK 1
#define GC_QUEUE_HARDDELETE 2
#define GC_QUEUE_COUNT 2 //increase this when adding more steps.

#define GC_QUEUED_FOR_QUEUING -1
#define GC_CURRENTLY_BEING_QDELETED -2

#define QDELING(X) (X.gc_destroyed)
#define QDELETED(X) (!X || QDELING(X))
#define QDEL_IN_CLIENT_TIME(item, time) addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), item), time, TIMER_STOPPABLE | TIMER_CLIENT_TIME)
#define QDESTROYING(X) (!X || X.gc_destroyed == GC_CURRENTLY_BEING_QDELETED)
