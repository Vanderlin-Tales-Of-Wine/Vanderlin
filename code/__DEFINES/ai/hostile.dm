///Hostile AI controller blackboard keys
#define BB_HOSTILE_ORDER_MODE "BB_HOSTILE_ORDER_MODE"
#define BB_HOSTILE_FRIEND "BB_HOSTILE_FRIEND"
#define BB_HOSTILE_ATTACK_WORD "BB_HOSTILE_ATTACK_WORD"
#define BB_FOLLOW_TARGET "BB_FOLLOW_TARGET"
#define BB_ATTACK_TARGET "BB_ATTACK_TARGET"
#define BB_VISION_RANGE "BB_VISION_RANGE"

/// Basically, what is our vision/hearing range.
#define BB_HOSTILE_VISION_RANGE 10
/// After either being given a verbal order or a pointing order, ignore further of each for this duration
#define AI_HOSTILE_COMMAND_COOLDOWN (2 SECONDS)

// hostile command modes (what pointing at something/someone does depending on the last order the carp heard)
/// Don't do anything (will still react to stuff around them though)
#define HOSTILE_COMMAND_NONE 0
/// Will attack a target.
#define HOSTILE_COMMAND_ATTACK 1
/// Will follow a target.
#define HOSTILE_COMMAND_FOLLOW 2

#define COMMAND_FOLLOW "Follow"
#define COMMAND_STOP "Stop"
#define COMMAND_ATTACK "Attack"


//Hunting defines
#define SUCCESFUL_HUNT_COOLDOWN 5 SECONDS

///Hunting BB keys
#define BB_CURRENT_HUNTING_TARGET "BB_current_hunting_target"
#define BB_HUNTING_COOLDOWN "BB_HUNTING_COOLDOWN"

///Basic Mob Keys

///Tipped blackboards
///Bool that means a basic mob will start reacting to being tipped in it's planning
#define BB_BASIC_MOB_TIP_REACTING "BB_basic_tip_reacting"
///the motherfucker who tipped us
#define BB_BASIC_MOB_TIPPER "BB_basic_tip_tipper"

///Targetting subtrees
#define BB_TARGETED_ACTION "BB_targeted_action"
#define BB_BASIC_MOB_PRIORITY_TARGETS "BB_basic_priority_targets"
#define BB_BASIC_MOB_CURRENT_TARGET "BB_basic_current_target"
#define BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION "BB_basic_current_target_hiding_location"
#define BB_TARGETTING_DATUM "targetting_datum"
#define BB_BASIC_MOB_FOOD_TARGET "BB_basic_food_target"
#define BB_TARGETTING_DATUM_EQUIPMENT "equip_targetting_datum"
#define BB_BASIC_MOB_RUN_WITH_ITEM "BB_run_with_item"
#define BB_BASIC_MOB_EQUIPMENT_TARGET "BB_equipment_target"
#define BB_BASIC_MOB_NEED_EQUIP "BB_needs_to_equip"
#define BB_BASIC_MOB_UNEQUIPPED_WEAPON "BB_unequipped_weapon"

///list of foods this mob likes
#define BB_BASIC_FOODS "BB_basic_foods"


/// Flag to set on or off if you want your mob to prioritise running away
#define BB_BASIC_MOB_FLEEING "BB_basic_fleeing"
#define BB_BASIC_MOB_NEXT_FLEEING "BB_nex_flee"

///List of mobs who have damaged us
#define BB_BASIC_MOB_RETALIATE_LIST "BB_basic_mob_shitlist"
