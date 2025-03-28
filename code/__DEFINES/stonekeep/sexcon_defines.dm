GLOBAL_LIST_INIT(sex_actions, build_sex_actions())

#define SEX_ACTION(sex_action_type) GLOB.sex_actions[sex_action_type]

#define MAX_AROUSAL 150
#define PASSIVE_EJAC_THRESHOLD 100
#define ACTIVE_EJAC_THRESHOLD 100
#define SEX_MAX_CHARGE 300
#define CHARGE_FOR_CLIMAX 100
#define AROUSAL_HARD_ON_THRESHOLD 20
#define CHARGE_RECHARGE_RATE (CHARGE_FOR_CLIMAX / (5 MINUTES))
#define AROUSAL_TIME_TO_UNHORNY (5 SECONDS)
#define SPENT_AROUSAL_RATE (3 / (1 SECONDS))
#define IMPOTENT_AROUSAL_LOSS_RATE (3 / (1 SECONDS))


#define AROUSAL_HIGH_UNHORNY_RATE (1.5 / (1 SECONDS))
#define AROUSAL_MID_UNHORNY_RATE (0.4 / (1 SECONDS))
#define AROUSAL_LOW_UNHORNY_RATE (0.2 / (1 SECONDS))

#define MOAN_COOLDOWN 3 SECONDS

#define SEX_SPEED_LOW 1
#define SEX_SPEED_MID 2
#define SEX_SPEED_HIGH 3

#define SEX_SPEED_MIN 1
#define SEX_SPEED_MAX 3

#define SEX_FORCE_LOW 1
#define SEX_FORCE_MID 2
#define SEX_FORCE_HIGH 3

#define SEX_FORCE_MIN 1
#define SEX_FORCE_MAX 3

#define BLUEBALLS_GAIN_THRESHOLD 15
#define BLUEBALLS_LOOSE_THRESHOLD 10

/proc/build_sex_actions()
	. = list()
	for(var/path in typesof(/datum/sex_action))
		if(is_abstract(path))
			continue
		.[path] = new path()
	return .

/mob/living
	var/datum/sex_controller/sexcon



/datum/looping_sound/femhornylite
	mid_sounds = list('modular/stonekeep/sound/sexcon/vo/female/horny1loop (1).ogg')
	mid_length = 470
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornylitealt
	mid_sounds = list('modular/stonekeep/sound/sexcon/vo/female/horny1loop (2).ogg')
	mid_length = 360
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornymed
	mid_sounds = list('modular/stonekeep/sound/sexcon/vo/female/horny2loop (1).ogg')
	mid_length = 420
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornymedalt
	mid_sounds = list('modular/stonekeep/sound/sexcon/vo/female/horny2loop (2).ogg')
	mid_length = 350
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornyhvy
	mid_sounds = list('modular/stonekeep/sound/sexcon/vo/female/horny3loop (1).ogg')
	mid_length = 440
	volume = 20
	extra_range = -4

/datum/looping_sound/femhornyhvyalt
	mid_sounds = list('modular/stonekeep/sound/sexcon/vo/female/horny3loop (2).ogg')
	mid_length = 390
	volume = 20
	extra_range = -4

/mob/living
	var/can_do_sex = TRUE

/mob/living/carbon/human/MiddleMouseDrop_T(mob/living/target, mob/living/user)
	. = ..()
	if(user.mmb_intent)
		return ..()
	if(!istype(target))
		return
	if(target != user)
		return
	if(!user.can_do_sex())
		user.visible_message(span_warning("I can't do this."))
		return
	if(stat != CONSCIOUS)
		log_combat(user, target, "tried to initiate sex with unconscious mob")
		user.visible_message(span_warning("They're asleep."))
		return
	if(stat == DEAD)
		log_combat(user, target, "tried to initiate sex with dead mob")
		user.visible_message(span_warning("That's a corpse..."))
		return
	if(target.cmode)
		log_combat(user, target, "tried to initiate sex with mob in combat mode")
		user.visible_message(span_warning("They're unwilling."))
		return FALSE
	user.sexcon.start(src)

/mob/living/proc/can_do_sex()
	return TRUE

/mob/living/carbon/human/proc/make_sucking_noise()
	if(gender == FEMALE)
		playsound(src, pick('modular/stonekeep/sound/sexcon/girlmouth (1).ogg','modular/stonekeep/sound/sexcon/girlmouth (2).ogg'), 25, TRUE, ignore_walls = FALSE)
	else
		playsound(src, pick('modular/stonekeep/sound/sexcon/guymouth (1).ogg','modular/stonekeep/sound/sexcon/guymouth (2).ogg','modular/stonekeep/sound/sexcon/guymouth (3).ogg','modular/stonekeep/sound/sexcon/guymouth (4).ogg','modular/stonekeep/sound/sexcon/guymouth (5).ogg'), 35, TRUE, ignore_walls = FALSE)

/mob/living/carbon/human/proc/get_highest_grab_state_on(mob/living/carbon/human/victim)
	var/grabstate = null
	if(r_grab && r_grab.grabbed == victim)
		if(grabstate == null || r_grab.grab_state > grabstate)
			grabstate = r_grab.grab_state
	if(l_grab && l_grab.grabbed == victim)
		if(grabstate == null || l_grab.grab_state > grabstate)
			grabstate = l_grab.grab_state
	return grabstate

/proc/add_cum_floor(turfu)
	if(!turfu || !isturf(turfu))
		return
	new /obj/effect/decal/cleanable/coom(turfu)
