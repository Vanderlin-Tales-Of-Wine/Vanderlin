#define COOLDOWN_STUN 1200
#define COOLDOWN_DAMAGE 600
#define COOLDOWN_MEME 300
#define COOLDOWN_NONE 100

/obj/item/organ/vocal_cords //organs that are activated through speech with the :x/MODE_KEY_VOCALCORDS channel
	name = "vocal cords"
	icon_state = "appendix"	//Temporary, replace when able!
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
	//icon_state = "harpysong"		//Pulsating heart energy thing.
	desc = "The blessed essence of harpysong. How did you get this... you monster!"
	var/granted_song
	var/obj/effect/proc_holder/spell/self/harpysong/harpysong

/obj/item/organ/vocal_cords/harpy/on_life()
	. = ..()
	if(!granted_song && owner)
		if(!owner?.mind?.has_spell(harpysong.type))
			owner.mind.AddSpell(harpysong)
			granted_song = TRUE

/obj/item/organ/vocal_cords/harpy/Insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	if(!harpysong)
		harpysong = new
	M.mind?.AddSpell(harpysong)

/obj/item/organ/vocal_cords/harpy/Remove(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	if(harpysong)
		M.mind?.RemoveSpell(harpysong)
	granted_song = FALSE

/obj/effect/proc_holder/spell/self/harpysong
	name = "Harpy Song"
	desc = "Release your inner mimickry to serenade your onlookers."
	overlay_state = "orison"
	antimagic_allowed = TRUE
	invocation_type = "shout"
	recharge_time = 1 SECONDS
	var/playing = FALSE
	var/instrument_buff
	var/datum/looping_sound/harpysong/soundloop
	var/note_color = "#7f7f7f"
	var/stressevent = /datum/stressevent/music
	var/list/song_list = list(
	"Harpy's Call (Feminine)" = 'sound/instruments/vocalsf (1).ogg',
	"Necra's Lullaby (Feminine)" = 'sound/instruments/vocalsf (2).ogg',
	"Death Touched Aasimar (Feminine)" = 'sound/instruments/vocalsf (3).ogg',
	"Our Mother, Our Divine (Feminine)" = 'sound/instruments/vocalsf (4).ogg',
	"Wed, Forever More (Feminine)" = 'sound/instruments/vocalsf (5).ogg',
	"Paper Boats (Feminine + Vocals)" = 'sound/instruments/vocalsf (6).ogg',
	"The Dragon's Blood Surges (Masculine)" = 'sound/instruments/vocalsm (1).ogg',
	"Timeless Temple (Masculine)" = 'sound/instruments/vocalsm (2).ogg',
	"Angel's Earnt Halo (Masculine)" = 'sound/instruments/vocalsm (3).ogg',
	"A Fabled Choir (Masculine)" = 'sound/instruments/vocalsm (4).ogg',
	"A Pained Farewell (Masculine + Feminine)" = 'sound/instruments/vocalsx (1).ogg'
	)

/datum/looping_sound/harpysong
	mid_length = 2400
	volume = 100
	falloff = 2
	extra_range = 5
	var/stress2give = /datum/stressevent/music
	persistent_loop = TRUE
	sound_group = /datum/sound_group/instruments

/datum/looping_sound/harpysong/on_hear_sound(mob/M)
	. = ..()
	if(stress2give)
		if(isliving(M))
			var/mob/living/carbon/L = M
			L.add_stress(stress2give)

/datum/looping_sound/harpysong/on_stop(mob/M)
	. = ..()
	if(istype(parent, /obj/effect/proc_holder/spell/self/harpysong))
		var/obj/effect/proc_holder/spell/self/harpysong/harpysong = parent
		harpysong.terminate_playing(M)

/obj/effect/proc_holder/spell/self/harpysong/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/effect/proc_holder/spell/self/harpysong/cast(list/targets, mob/living/carbon/user)
	..()

	if(playing)
		name = "Stop Singing"
	else
		name = "Harpy Song"
		terminate_playing(loc)

	user.emote("me",1,"chirps into song!",TRUE, custom_me = TRUE)
	var/music_level = user.mind?.get_skill_level(/datum/skill/misc/music)
	var/curfile = input(user, "Which song do you want to play?", "Pick a song", name) as null|anything in song_list
	if(!curfile)
		return
	curfile = song_list[curfile]
	if(!curfile)
		return

	switch(music_level)
		if(1)
			stressevent = /datum/stressevent/music
		if(2)
			note_color = "#ffffff"
			stressevent = /datum/stressevent/music/two
		if(3)
			note_color = "#1eff00"
			stressevent = /datum/stressevent/music/three
		if(4)
			note_color = "#0070dd"
			stressevent = /datum/stressevent/music/four
		if(5)
			note_color = "#a335ee"
			stressevent = /datum/stressevent/music/five
		if(6)
			note_color = "#ff8000"
			stressevent = /datum/stressevent/music/six

	playing = TRUE
	soundloop.mid_sounds = list(curfile)
	soundloop.cursound = null
	soundloop.stress2give = stressevent
	soundloop.start()
	soundloop.start()
	user.apply_status_effect(/datum/status_effect/buff/playing_music, stressevent, note_color)
	GLOB.vanderlin_round_stats[STATS_SONGS_PLAYED]++
	START_PROCESSING(SSprocessing, src)
	return TRUE

/obj/effect/proc_holder/spell/self/harpysong/proc/terminate_playing(mob/living/user)
	playing = FALSE
	STOP_PROCESSING(SSprocessing, src)
	instrument_buff = null

	if(soundloop)
		soundloop.stop()
		soundloop.stress2give = initial(soundloop.stress2give)

/obj/effect/proc_holder/spell/self/harpysong/process()
	..()
	var/mob/living/carbon/human/user = loc
	if(!playing || !ishuman(loc))
		terminate_playing(loc)
		return PROCESS_KILL

	user.apply_status_effect(/datum/status_effect/buff/playing_music) // Handles regular stress event in tick()
	var/boon = user?.mind?.get_learning_boon(/datum/skill/misc/music)
	user?.mind?.adjust_experience(/datum/skill/misc/music, ceil((user.STAINT*0.2) * boon) * 0.2) // And gain exp

	for(var/obj/structure/soil/soil in view(7, loc))
		var/distance = max(1, get_dist(loc, soil))
		soil.process_growth(round(2 / distance, 0.1))

	for(var/obj/item/reagent_containers/food/snacks/smallrat/I in view(4, user))
		if(I.loc != user)
			step_towards(I, user)

	START_PROCESSING(SSprocessing, src)

