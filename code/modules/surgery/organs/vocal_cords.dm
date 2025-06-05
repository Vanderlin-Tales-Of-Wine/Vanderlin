#define COOLDOWN_STUN 1200
#define COOLDOWN_DAMAGE 600
#define COOLDOWN_MEME 300
#define COOLDOWN_NONE 100

/obj/item/organ/vocal_cords //organs that are activated through speech with the :x/MODE_KEY_VOCALCORDS channel
	name = "vocal cords"
	icon_state = "vocal_cords"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_VOICE
	gender = PLURAL
	decay_factor = 0	//we don't want decaying vocal cords to somehow matter or appear on scanners since they don't do anything damaged
	healing_factor = 0
	var/list/spans = null

/obj/item/organ/vocal_cords/proc/can_speak_with() //if there is any limitation to speaking with these cords
	return TRUE

/obj/item/organ/vocal_cords/proc/speak_with(message) //do what the organ does
	return

/obj/item/organ/vocal_cords/proc/handle_speech(message) //actually say the message
	owner.say(message, spans = spans, sanitize = FALSE)

/obj/item/organ/vocal_cords/harpy
	name = "harpy's song"
	icon_state = "harpysong"		//Pulsating heart energy thing.
	desc = "The blessed essence of harpysong. How did you get this... you monster!"
	var/obj/item/instrument/vocals/harpy_vocals/vocals
	var/obj/effect/proc_holder/spell/self/harpy_sing/harpy
	var/granted_singing

/obj/item/organ/vocal_cords/harpy/Initialize()
	. = ..()
	vocals = new(src)  //okay, i think it'll be tied to the organ

/obj/item/organ/vocal_cords/harpy/on_life()
	. = ..()
	if(!granted_singing && owner?.mind)
		if(!owner.mind.has_spell(harpy.type))
			owner.mind.AddSpell(harpy)
			granted_singing = TRUE

/obj/item/organ/vocal_cords/harpy/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(!harpy)
		harpy = new
	M.mind?.AddSpell(harpy)
	M.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)

/obj/item/organ/vocal_cords/harpy/Remove(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(vocals && vocals.playing)
		vocals.terminate_playing(M)  // Stop singing when removed
	if(harpy)
		M.mind?.RemoveSpell(harpy)
	granted_singing = FALSE
	M.adjust_skillrank(/datum/skill/misc/music, -1, TRUE)

/obj/effect/proc_holder/spell/self/harpy_sing
	name = "Harpy's song"
	desc = ""
	icon = 'icons/obj/surgery.dmi'
	icon_state = "harpysong"
	antimagic_allowed = TRUE
	invocation_type = "none"

/obj/effect/proc_holder/spell/self/harpy_sing/cast(list/targets, mob/living/user = usr)
	..()
	var/obj/item/organ/vocal_cords/harpy/vocal_cords = user.getorganslot(ORGAN_SLOT_VOICE)
	if(!istype(vocal_cords) || !vocal_cords.vocals)
		return
	if(vocal_cords.vocals && vocal_cords.vocals.playing)
		vocal_cords.vocals.terminate_playing(user)  // Stop singing when removed
		return TRUE
	vocal_cords.vocals.attack_self(user)
	return TRUE
