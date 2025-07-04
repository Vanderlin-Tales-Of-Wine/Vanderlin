///from base of atom/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
#define COMSIG_ATOM_HITBY "atom_hitby"

#define COMSIG_LOCKPICK_ONMOUSEDOWN "lockpick_onmousedown"
	#define COMPONENT_LOCKPICK_ONMOUSEDOWN_BYPASS (1<<0)

#define COMPONENT_PICKED "picked"

#define COMSIG_ATOM_PROXY_STEAM_USE "proxy_steam_usage"

#define COMSIG_ATOM_STEAM_USE "steam_usage"

#define COMSIG_ATOM_STEAM_INCREASE "steam_increase"

/* Attack signals. They should share the returned flags, to standardize the attack chain. */
/// tool_act -> pre_attack -> target.attackby (item.attack) -> afterattack
	///Ends the attack chain. If sent early might cause posterior attacks not to happen.
	#define COMPONENT_CANCEL_ATTACK_CHAIN (1<<0)
	///Skips the specific attack step, continuing for the next one to happen.
	#define COMPONENT_SKIP_ATTACK (1<<1)
