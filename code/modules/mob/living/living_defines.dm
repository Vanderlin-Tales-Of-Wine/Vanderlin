/mob/living
	see_invisible = SEE_INVISIBLE_LIVING
	sight = 0
	see_in_dark = 8
	hud_possible = list(ANTAG_HUD)

	/// Badminnery resize, used purely in VV
	var/resize = 1
	/// Mob ref of last attacker
	var/lastattacker = null
	/// Ckey of the last mob that attacked
	var/lastattackerckey = null

	//Health and life related vars
	var/maxHealth = 100 //Maximum health that should be possible.
	var/health = 100 	//A mob's health

	//Damage related vars, NOTE: THESE SHOULD ONLY BE MODIFIED BY PROCS
	/// Brutal damage caused by brute force (punching, being hit with a sword, ect... this also accounts for pressure damage)
	var/bruteloss = 0
	/// Oxygen depravation damage (no air in lungs or blood loss)
	var/oxyloss = 0
	/// Toxic damage caused by being poisoned
	var/toxloss = 0
	/// Burn damage caused by being way too hot, too cold or burnt.
	var/fireloss = 0
	/// when the mob goes from "normal" to crit
	var/crit_threshold = HEALTH_THRESHOLD_CRIT
	/// When the mob enters hard critical state and is fully incapacitated.
	var/hardcrit_threshold = HEALTH_THRESHOLD_FULLCRIT

	/// Generic bitflags for boolean conditions at the [/mob/living] level. Keep this for inherent traits of living types, instead of runtime-changeable ones.
	var/living_flags = NONE

	/// Flags that determine the potential of a mob to perform certain actions. Do not change this directly.
	var/mobility_flags = MOBILITY_FLAGS_DEFAULT

	/// is this mob resting?
	var/resting = FALSE
	/// is this mob leaning on a wall? (makes them undense)
	var/wallpressed = FALSE

	/// has this mob pixelshifted?
	var/pixelshifted = FALSE
	/// vertical pixelshift offset
	var/pixelshift_w = 0
	/// horizontal pixelshift offset
	var/pixelshift_z = 0

	/// Variable to track the body position of a mob, regardgless of the actual angle of rotation (usually matching it, but not necessarily).
	var/body_position = STANDING_UP
	/// Number of degrees of rotation of a mob. 0 means no rotation, up-side facing NORTH. 90 means up-side rotated to face EAST, and so on.
	var/lying_angle = 0
	/// Value of lying lying_angle before last change. TODO: Remove the need for this.
	var/lying_prev = 0

	/// time in deciseconds for how long the mob is to be confused, makes the mob move in random directions.
	var/confused = 0

	/// Used by the resist verb, likely used to prevent players from bypassing next_move by logging in/out.
	var/last_special = 0
	/// world.time of when the last death() proc of this mob was called, 0 if hasn't died yet.
	var/time_of_death_world_time = 0
	/// station_time_timestamp of when the last death proc of this mob was called, null if hasn't died yet
	var/time_of_death_round_time = null // Time of death

	/**
	* Allows mobs to move through dense areas without restriction. For instance, in space or out of holder objects.
	** FALSE is off, INCORPOREAL_MOVE_BASIC is normal, INCORPOREAL_MOVE_SHADOW is for ninjas
	** and INCORPOREAL_MOVE_JAUNT is blocked by holy water/salt
	*/
	var/incorporeal_move = FALSE

	/// a list of surgery steps. generally empty, they're added when the player is performing them.
	var/list/surgeries

	/// used by living/Bump() and living/PushAM() to prevent potential infinite loop.
	var/now_pushing = null

	/// The "Are we on fire?" var
	var/on_fire = 0
	/// Tracks how many stacks of fire we have on, max is usually 20
	var/fire_stacks = 0
	/// Identical to fire stacks but has less properties like spreading. Should never be negative.
	var/divine_fire_stacks = 0

	/// 0 No vent crawling, 1 vent crawling in the nude, 2 vent crawling always
	var/ventcrawler = VENTCRAWLER_NONE
	/// 1 Sets AI behavior that allows mobs to target and dismember limbs with their basic attack.
	var/limb_destroyer = 0

	/// size of this mob, used in trap code and bump()
	var/mob_size = MOB_SIZE_HUMAN
	/// what kind of "flesh" this mob has, bitfield
	var/mob_biotypes = MOB_ORGANIC
	/// efficiency to metabolize helpful/harmful reagents and regulate body temperature.
	var/metabolism_efficiency = 1

	///How many legs does this mob have by default. This shouldn't change at runtime.
	var/default_num_legs = 2
	///How many legs does this mob currently have. Should only be changed through set_num_legs()
	var/num_legs = 2
	///How many usable legs this mob currently has. Should only be changed through set_usable_legs()
	var/usable_legs = 2

	///How many hands does this mob have by default. This shouldn't change at runtime.
	var/default_num_hands = 2
	///How many hands hands does this mob currently have. Should only be changed through set_num_hands()
	var/num_hands = 2
	///How many usable hands does this mob currently have. Should only be changed through set_usable_hands()
	var/usable_hands = 2

	/// used to prevent spam with smoke reagent reaction on mob.
	var/smoke_delay = 0

	/// what icon the mob uses for speechbubbles
	var/bubble_icon = "default"

	/// world.time of the last time this mob has bumped a movable, set in Bumped()
	var/last_bumped = 0
	var/unique_name = 0 //if a mob's name should be appended with an id when created e.g. Mob (666)

	var/list/butcher_results = null //these will be yielded from butchering with a probability chance equal to the butcher item's effectiveness
	var/list/guaranteed_butcher_results = null //these will always be yielded from butchering
	var/butcher_difficulty = 0 //effectiveness prob. is modified negatively by this amount; positive numbers make it more difficult, negative ones make it easier

	var/hellbound = 0 //People who've signed infernal contracts are unrevivable.
	/// if a mob's name should be appended with an id when created e.g. Mob (666)
	var/unique_name = FALSE

	/// these will be yielded from butchering with a probability chance equal to the butcher item's effectiveness
	var/list/butcher_results = null
	/// these will always be yielded from butchering
	var/list/guaranteed_butcher_results = null
	/// effectiveness prob. is modified negatively by this amount; positive numbers make it more difficult, negative ones make it easier
	var/butcher_difficulty = 0

	/// to differentiate between jumping and thrown mobs
	var/is_jumping = 0

	/// onverted to a list of stun absorption sources this mob has when one is added
	var/stun_absorption = null

	/// how much blood the mob has
	var/blood_volume = BLOOD_VOLUME_NORMAL

	/// 0 for no override, sets see_invisible = see_override in silicon & carbon life process via update_sight()
	var/see_override = 0

	/// a list of all status effects the mob has
	var/list/status_effects
	/// amount of druggi-ness
	var/druggy = 0

	//Speech
	var/stuttering = 0
	var/slurring = 0
	var/cultslurring = 0
	var/derpspeech = 0

	var/datum/riding/riding_datum

	var/datum/language/selected_default_language

	var/last_words	//used for database logging

	var/list/obj/effect/proc_holder/abilities = list()

	/// Whether the mob is slowed down when dragging another prone mob
	var/slowed_by_drag = TRUE

	/// max amount of energy this mob can have
	var/max_energy = 1000
	/// current amount of energy this mob has
	var/energy = 1000
	/// max amount of stamina this mob can have
	var/maximum_stamina = 100
	/// current amount of stamina this mob has
	var/stamina = 0

	/// world.time of the last time this mob's stamina was reduced
	var/last_fatigued = 0

	/// ! DEPRECATED VAR, USE TRAIT_NOAMBUSH
	var/ambushable = FALSE

	/// has this mob surrendered?
	var/surrendering = FALSE


	// Combat bonuses for Simple Mobs
	var/simpmob_attack = 0
	var/simpmob_defend = 0

	/// base chance to defend against this mob's attacks, for simple mob combat
	var/defprob = 50
	var/defdrain = 5

	/// how encumbered is this mob?
	var/encumbrance = 0

	/// are this mob's eyes closed?
	var/eyesclosed = FALSE
	var/falling_asleep = 0

	/// how much are we bleeding
	var/bleed_rate = 0
	/// boolean var for stopping bloodloss, eventually this will be limb-based like bleeding
	var/bleedsuppress = FALSE

	var/list/next_attack_msg = list()

	var/datum/component/personal_crafting/craftingthing
	var/last_crafted

	var/obj/item/grabbing/r_grab = null
	var/obj/item/grabbing/l_grab = null

	var/slowdown

	var/last_dir_change = 0

	var/rot_type = /datum/component/rot/simple

	/// descriptors, shown in examine
	var/list/mob_descriptors
	/// custom descriptors, shown in examine
	var/list/custom_descriptors

	/// is this mob currently sneaking?
	var/sneaking = FALSE

	/// how much light reveals this mob when they are sneaking
	var/sneaking_light_threshhold = 0.15

	var/voice_pitch = 1

	/// dominant hand, WHY ISN'T THIS ON CARBON?
	var/domhand = DOMINANT_HAND_NONE

	/// our blood drain for meathook, the less bloody the more we get
	var/blood_drained = 0

	/// are we skinned?
	var/skinned = FALSE

	/// our reflection child
	var/has_reflection = TRUE

	var/mutable_appearance/reflective_icon

	/// list of our offsets
	var/list/mob_offsets = list()

	var/datum/worker_mind/controller_mind

	var/tempatarget = null

	var/pet_passive = FALSE
