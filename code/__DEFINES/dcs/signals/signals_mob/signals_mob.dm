#define COMSIG_MOB_MOVESPEED_UPDATED "mob_updated_movespeed"
///from base of /mob/Login(): ()
#define COMSIG_MOB_LOGIN "mob_login"
///from base of /mob/Logout(): ()
#define COMSIG_MOB_LOGOUT "mob_logout"
#define COMSIG_MOB_STATCHANGE "mob_statchange"

/// Sent from /proc/do_after if someone starts a do_after action bar.
#define COMSIG_DO_AFTER_BEGAN "mob_do_after_began"
/// Sent from /proc/do_after once a do_after action completes, whether via the bar filling or via interruption.
#define COMSIG_DO_AFTER_ENDED "mob_do_after_ended"
#define COMSIG_PHASE_CHANGE "phase_change"

///from /datum/element/footstep/prepare_step(): (list/steps)
#define COMSIG_MOB_PREPARE_STEP_SOUND "override_mob_stepsound"

///from base of mob/can_cast_magic(): (mob/user, magic_flags, charge_cost)
#define COMSIG_MOB_RESTRICT_MAGIC "mob_cast_magic"
///from base of mob/can_block_magic(): (mob/user, casted_magic_flags, charge_cost)
#define COMSIG_MOB_RECEIVE_MAGIC "mob_receive_magic"
	#define COMPONENT_MAGIC_BLOCKED (1<<0)
