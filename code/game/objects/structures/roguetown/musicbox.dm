// Music Lists
#define MUSIC_TAVCAT_CHILL list(\
	"Lore" = 'sound/music/jukeboxes/chill/ac-ler.ogg',\
	"Landmarks of Lullabies" = 'sound/music/jukeboxes/chill/ac-lol.ogg',\
	"Waters of Sacrifice" = 'sound/music/jukeboxes/chill/acn-wos.ogg',\
	"Solar Wind" = 'sound/music/jukeboxes/chill/av_solar.ogg',\
	"Balthasar" = 'sound/music/jukeboxes/chill/ac-balthasar.ogg',\
	"Dead Windmills" = 'sound/music/jukeboxes/chill/dead_windmills.ogg',\
	"In Heaven Everythin" = 'sound/music/jukeboxes/chill/in_heaven_eif.ogg',\
	"Jazznocn" = 'sound/music/jukeboxes/chill/jazznocn.ogg',\
	"Vivalaluna-Damla" = 'sound/music/jukeboxes/chill/vivalaluna-damla.ogg'\
)
#define MUSIC_TAVCAT_FUCK list(\
	"Cure4Sorrow" = 'sound/music/jukeboxes/fuck/cure4sorrow.ogg',\
	"Dangerous Radiation" = 'sound/music/jukeboxes/fuck/dangeradiation.ogg',\
	"Pandora's Box" = 'sound/music/jukeboxes/fuck/fb-pandora.ogg',\
	"Anthem" = 'sound/music/jukeboxes/fuck/partyrock.ogg',\
	"Raspberry jam" = 'sound/music/jukeboxes/fuck/raspberryjam.ogg'\
)
#define MUSIC_TAVCAT_PARTY list(\
	"A Winter Kiss" = 'sound/music/jukeboxes/party/a_winter_kiss.ogg',\
	"Analogic Tale Bearer" = 'sound/music/jukeboxes/party/ac-atb.ogg',\
	"Allt Jag Vill" = 'sound/music/jukeboxes/party/allt_jag_vill.ogg',\
	"Invisible" = 'sound/music/jukeboxes/party/av_invis.ogg',\
	"Kick the Beat" = 'sound/music/jukeboxes/party/av_ktb.ogg',\
	"dAnCe nAtion" = 'sound/music/jukeboxes/party/dance_nation_remix.ogg',\
	"Imagine" = 'sound/music/jukeboxes/party/imagine.ogg'\
)
#define MUSIC_TAVCAT_SCUM list(\
	"Shades of Futility" = 'sound/music/jukeboxes/scum/fb-sofutile.ogg',\
	"Headspin" = 'sound/music/jukeboxes/scum/headspin.ogg',\
	"Mr Doubt" = 'sound/music/jukeboxes/scum/mr_doubt.ogg',\
	"Stagebox" = 'sound/music/jukeboxes/scum/stagebox.remix.ogg'\
)
#define MUSIC_TAVCAT_MISC list(\
	"Generic" = 'sound/music/jukeboxes/_misc/_generic.ogg',\
	"AndreiKabak" = 'sound/music/jukeboxes/_misc/Andrei_Kabak-Pathologic.ogg',\
	"Twyrine" = 'sound/music/jukeboxes/_misc/Twyrine-Pathologic2.ogg'\
)

/datum/looping_sound/musloop
	mid_sounds = list()
	mid_length = 18000 // This is 30 minutes- just in case something wierd happens.
	volume = 50
	extra_range = 6
	falloff = 0
	persistent_loop = TRUE
	var/stress2give = /datum/stressevent/music
	channel = CHANNEL_JUKEBOX

/datum/looping_sound/musloop/on_hear_sound(mob/M)
	. = ..()
	if(stress2give)
		if(isliving(M))
			var/mob/living/carbon/L = M
			L.add_stress(stress2give)

/obj/structure/roguemachine/musicbox
	name = "wax music device"
	desc = "A marvelous device invented to record sermons. Aleksandar Gemrald Sparks invented this machine to discover prophecies of Psydon's return but failed. It now brings us strange music from another realm."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "music0"
	density = TRUE
	anchored = TRUE
	max_integrity = 0
	var/datum/looping_sound/musloop/soundloop
	var/list/init_curfile = list('sound/music/jukeboxes/_misc/_generic.ogg') // A list of songs that curfile is set to on init. MUST BE IN ONE OF THE MUSIC_TAVCAT_'s. MAPPERS MAY TOUCH THIS.
	var/curfile // The current track that is playing right now
	var/playing = FALSE // If music is playing or not. playmusic() deals with this don't mess with it.
	var/curvol = 50 // The current volume at which audio is played. MAPPERS MAY TOUCH THIS.
	var/playuponspawn = FALSE // Does the music box start playing music when it first spawns in? MAPPERS MAY TOUCH THIS.

/obj/structure/roguemachine/musicbox/Initialize()
	. = ..()
	curfile = pick(init_curfile)
	soundloop = new(src, FALSE)
	if(playuponspawn)
		playmusic("START")
		update_icon()

/obj/structure/roguemachine/musicbox/Destroy()
	. = ..()
	del(soundloop)

/obj/structure/roguemachine/musicbox/update_icon()
	icon_state = "music[playing]"

/obj/structure/roguemachine/musicbox/proc/playmusic(mode="TOGGLE") // "TOGGLE" | "START" | "STOP"
	playsound(loc, 'sound/misc/Bug.ogg', 100, FALSE, -1)
	if(mode=="TOGGLE")
		if(!playing)
			if(curfile)
				playing = TRUE
				soundloop.mid_sounds = list(curfile)
				soundloop.cursound = null
				soundloop.volume = curvol
				soundloop.start()
		else
			playing = FALSE
			soundloop.stop()
	if(mode=="START")
		if(!playing)
			if(curfile)
				playing = TRUE
				soundloop.mid_sounds = list(curfile)
				soundloop.cursound = null
				soundloop.volume = curvol
				soundloop.start()
	if(mode=="STOP")
		playing = FALSE
		soundloop.stop()

/obj/structure/roguemachine/musicbox/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	user.changeNext_move(CLICK_CD_MELEE)

	var/button_selection = input(user, "What button do I press?", "\The [src]") as null | anything in list("Stop/Start","Change Song","Change Volume")
	if(!Adjacent(user))
		return
	if(!button_selection)
		to_chat(user, span_info("I change my mind..."))
		return
	user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
	playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)

	if(button_selection=="Stop/Start")
		playmusic("TOGGLE")
	
	if(button_selection=="Change Song")
		var/songlists_selection = input(user, "Which song list?", "\The [src]") as null | anything in list("CHILL"=MUSIC_TAVCAT_CHILL, "FUCK"=MUSIC_TAVCAT_FUCK, "PARTY"=MUSIC_TAVCAT_PARTY, "SCUM"=MUSIC_TAVCAT_SCUM, "MISC"=MUSIC_TAVCAT_MISC)
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		var/chosen_songlists_selection = null
		if(songlists_selection=="CHILL")
			chosen_songlists_selection = MUSIC_TAVCAT_CHILL
		if(songlists_selection=="FUCK")
			chosen_songlists_selection = MUSIC_TAVCAT_FUCK
		if(songlists_selection=="PARTY")
			chosen_songlists_selection = MUSIC_TAVCAT_PARTY
		if(songlists_selection=="SCUM")
			chosen_songlists_selection = MUSIC_TAVCAT_SCUM
		if(songlists_selection=="MISC")
			chosen_songlists_selection = MUSIC_TAVCAT_MISC
		var/song_selection = input(user, "Which song do I play?", "\The [src]") as null | anything in chosen_songlists_selection
		if(!Adjacent(user))
			return
		if(!song_selection)
			to_chat(user, span_info("I change my mind..."))
			return
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		curfile = chosen_songlists_selection[song_selection]
		playmusic("STOP")
		playmusic("START")

	if(button_selection=="Change Volume")
		var/volume_selection = input(user, "How loud do you wish me to be?", "\The [src] (Volume Currently : [curvol]/[100])") as num|null
		if(!Adjacent(user))
			return
		if(!volume_selection)
			to_chat(user, span_info("I change my mind..."))
			return
		playsound(loc, pick('sound/misc/keyboard_select (1).ogg','sound/misc/keyboard_select (2).ogg','sound/misc/keyboard_select (3).ogg','sound/misc/keyboard_select (4).ogg'), 100, FALSE, -1)
		user.visible_message(span_info("[user] presses a button on \the [src]."),span_info("I press a button on \the [src]."))
		volume_selection = clamp(volume_selection, 0, 100)
		curvol = volume_selection
		playsound(loc, 'sound/misc/Bug.ogg', 100, FALSE, -1)
		playmusic("STOP")
		playmusic("START")
		if(curvol<volume_selection)
			to_chat(user, span_info("I make \the [src] gets louder."))
		else
			to_chat(user, span_info("I make \the [src] gets quieter."))

	update_icon()

/obj/structure/roguemachine/musicbox/tavern
	init_curfile = list(\
		'sound/music/jukeboxes/_misc/_generic.ogg',\
		'sound/music/jukeboxes/_misc/Andrei_Kabak-Pathologic.ogg',\
		'sound/music/jukeboxes/_misc/Twyrine-Pathologic2.ogg',\
		'sound/music/jukeboxes/chill/ac-lol.ogg',
		'sound/music/jukeboxes/chill/ac-balthasar.ogg',\
		'sound/music/jukeboxes/chill/vivalaluna-damla.ogg',\
	)
	curvol = 65
	playuponspawn = TRUE
	
/obj/structure/roguemachine/musicbox/Initialize()
	. = ..()
	soundloop.extra_range = 12
	soundloop.falloff = 6
