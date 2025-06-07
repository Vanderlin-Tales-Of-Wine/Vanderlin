///From post-can inject check of syringe after attack (mob/user)
#define COMSIG_LIVING_TRY_SYRINGE "living_try_syringe"

#define COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_DOWN	"keybinding_living_item_pixelshift_down"
#define COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_UP	"keybinding_living_item_pixelshift_up"
#define COMSIG_KB_LIVING_PIXELSHIFT				"keybinding_living_pixelshift"
#define COMSIG_KB_LIVING_PIXEL_SHIFT_DOWN		"keybinding_living_pixelshift_down"
#define COMSIG_KB_LIVING_PIXEL_SHIFT_UP			"keybinding_living_pixelshift_up"

///from base of mob/living/set_buckled(): (new_buckled)
#define COMSIG_LIVING_SET_BUCKLED "living_set_buckled"

///Signal sent when a keybind is deactivated
#define DEACTIVATE_KEYBIND(A) "[A]_DEACTIVATED"
#define COMSIG_KB_LIVING_VIEW_PET_COMMANDS "keybinding_living_view_pet_commands"

// /mob/living signals
#define COMSIG_LIVING_SET_RESTING "comsig_set_resting"
#define COMSIG_LIVING_RESIST "living_resist"					//from base of mob/living/resist() (/mob/living)
#define COMSIG_LIVING_IGNITED "living_ignite"					//from base of mob/living/IgniteMob() (/mob/living)
#define COMSIG_LIVING_EXTINGUISHED "living_extinguished"		//from base of mob/living/ExtinguishMob() (/mob/living)
#define COMSIG_LIVING_ELECTROCUTE_ACT "living_electrocute_act"		//from base of mob/living/electrocute_act(): (shock_damage, source, siemens_coeff, flags)
#define COMSIG_LIVING_MINOR_SHOCK "living_minor_shock"			//sent by stuff like stunbatons and tasers: ()
#define COMSIG_LIVING_REVIVE "living_revive"					//from base of mob/living/revive() (full_heal, admin_revive)
#define COMSIG_PROCESS_BORGCHARGER_OCCUPANT "living_charge"		//sent from borg recharge stations: (amount, repairs)
#define COMSIG_MOB_CLIENT_LOGIN "comsig_mob_client_login"		//sent when a mob/login() finishes: (client)
#define COMSIG_BORG_SAFE_DECONSTRUCT "borg_safe_decon"			//sent from borg mobs to itself, for tools to catch an upcoming destroy() due to safe decon (rather than detonation)
#define COMSIG_MOB_ACTIVE_PERCEPTION "comsig_mob_active_perception"	//sent from mob/living/proc/look_around(): (mob/living/source)

//ALL OF THESE DO NOT TAKE INTO ACCOUNT WHETHER AMOUNT IS 0 OR LOWER AND ARE SENT REGARDLESS!
///from base of mob/living/OffBalance() (amount, ignore_canstun)
#define COMSIG_LIVING_STATUS_OFFBALANCED "living_offbalanced"
///from base of mob/living/Stun() (amount, ignore_canstun)
#define COMSIG_LIVING_STATUS_STUN "living_stun"
///from base of mob/living/Knockdown() (amount, ignore_canstun)
#define COMSIG_LIVING_STATUS_KNOCKDOWN "living_knockdown"
///from base of mob/living/Paralyze() (amount, ignore_canstun)
#define COMSIG_LIVING_STATUS_PARALYZE "living_paralyze"
///from base of mob/living/Immobilize() (amount, ignore_canstun)
#define COMSIG_LIVING_STATUS_IMMOBILIZE "living_immobilize"
///from base of mob/living/Immobilize() (amount, ignore_canstun)
#define COMSIG_LIVING_STATUS_UNCONSCIOUS "living_unconscious"
/// from base of mob/living/updatehealth(amount)
#define COMSIG_LIVING_HEALTH_UPDATE "living_health_update"
///from base of mob/living/Sleeping() (amount, ignore_canstun)
#define COMSIG_LIVING_STATUS_SLEEP "living_sleeping"
	#define COMPONENT_NO_STUN 1			//For all of them
///from base of /mob/living/can_track(): (mob/user)
#define COMSIG_LIVING_CAN_TRACK "mob_cantrack"
	#define COMPONENT_CANT_TRACK 1
///from base of mob/living/death(): (gibbed)
#define COMSIG_LIVING_DEATH "living_death"
/// From /mob/living/befriend() : (mob/living/new_friend)
#define COMSIG_LIVING_BEFRIENDED "living_befriended"
/// From /mob/living/unfriend() : (mob/living/old_friend)
#define COMSIG_LIVING_UNFRIENDED "living_unfriended"

#define COMSIG_BEAM_ENTERED "beam_entered"
