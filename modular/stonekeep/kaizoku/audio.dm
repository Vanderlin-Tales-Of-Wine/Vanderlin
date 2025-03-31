
/obj/item/instrument/shamisen //I know shamisen should be used while sitting/on knees. butt you think bards really need to be SITTING during battle?
	name = "shamisen"
	desc = "shamisen, or just 'three-stings' is a abyssariad puckled stringed musical instrument, usually played using a Bachi."
	icon = 'modular/stonekeep/kaizoku/icons/misc/music.dmi'
	icon_state = "shamisen"
	lefthand_file = 'modular/stonekeep/kaizoku/icons/misc/lefthand_music.dmi'
	righthand_file = 'modular/stonekeep/kaizoku/icons/misc/righthand_music.dmi'
	song_list = list(
	"Cursed Apple" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen1.ogg', //Credit; "Bad Apple by しゃみお - Shamisen player Shamio"
	"Fire Dance" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen2.ogg', //Credit; "Fire Dance by しゃみお - Shamisen player Shamio"
	"Lute" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen3.ogg', //Credit; "Lute (shamisen) by Museum of Fine Arts, Boston"
	"Tsugaru Ripple" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen4.ogg', //Credit; "Tsugaru Shamisen (using Ripple) by Shamisen Komatsuya"
	"Tsugaru" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen5.ogg', //Credit; "Tsugaru Shamisen by Roger Walch"
	"Season" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen6.ogg', //Credit; "相棒 Season 遊郭編しゃみお - Shamisen player Shamio"
	"Parade" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen7.ogg', //Credit; "「雨天PARADE」三味線オリジナル曲 - しゃみお - Shamisen player Shamio"
	"Koshiro" = 'modular/stonekeep/kaizoku/sound/instrument/shamisen8.ogg' //Credit; “KOSHIRO” -幸四郎- by SENZO"
	)

// =================================================================
// ========================		AMBIENCE	============================

/area/rogue/outdoors/mountains
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night =  'modular/stonekeep/kaizoku/sound/ambience/Sanctumocean.ogg'

/area/rogue/indoors/shelter/mountains
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Sanctumocean.ogg'

/area/rogue/outdoors
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Diaspora.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/indoors/shelter

/area/rogue/indoors/shelter
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Sanctumocean.ogg'

/area/rogue/outdoors
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Diaspora.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/indoors/shelter
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Zephyr.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Sanctumocean.ogg'


/area/rogue/outdoors/woods
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Sibilant.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Penumbra.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Sibilant_night.ogg'

/area/rogue/indoors/shelter/woods
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Sussurus.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Diaspora.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Sibilant_night.ogg'


/area/rogue/outdoors/river
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Abyssanctum.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/kaizoku.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Abyssariad.ogg'

/area/rogue/under
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Oceansanct.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Town_in_Rogue.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Defenestration.ogg'


/area/rogue/outdoors/exposed
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Oceansanct.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Town_in_Rogue.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Defenestration.ogg'

/area/rogue/under/cave
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Torment.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Bucolic.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Nebula.ogg'

/area/rogue/outdoors/caves
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Torment.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Bucolic.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Nebula.ogg'

/area/rogue/under/cavewet
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Bucolic.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Nebula.ogg'



/area/rogue/under/town/kaizoku
	name = "kaizoku isle"
	icon_state = "town"
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Abyssanctum.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/kaizoku.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Abyssariad.ogg'


// =================================================================
// ========================	STORAGE	================================

/datum/voicepack/female/elf/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getfold(soundin)
		if("young")
			used = getfyoung(soundin)
		if("silenced")
			used = getfsilenced(soundin)
	if(!used)
		switch(soundin)
			if("breathgasp")
				used = list('sound/vo/female/elf/breathgasp (1).ogg','sound/vo/female/elf/breathgasp (2).ogg')
			if("fatigue")
				used = 'sound/vo/female/elf/fatigue.ogg'
			if("firescream")
				used = 'sound/vo/female/elf/fatigue.ogg'
			if("gasp")
				used = list('sound/vo/female/elf/gasp (1).ogg','sound/vo/female/elf/gasp (2).ogg','sound/vo/female/elf/gasp (3).ogg')
			if("groan")
				used = 'sound/vo/female/elf/groan.ogg'
			if("haltyell")
				used = 'sound/vo/female/elf/haltyell.ogg'
			if("hmm")
				used = list('sound/vo/female/elf/hmm (1).ogg','sound/vo/female/elf/hmm (2).ogg')
			if("pain")
				used = list('sound/vo/female/elf/pain (1).ogg','sound/vo/female/elf/pain (2).ogg','sound/vo/female/elf/pain (3).ogg','sound/vo/female/elf/pain (4).ogg')
			if("embed")
				used = list('sound/vo/female/elf/pain (1).ogg','sound/vo/female/elf/pain (2).ogg','sound/vo/female/elf/pain (3).ogg','sound/vo/female/elf/pain (4).ogg')
			if("paincrit")
				used = 'sound/vo/female/elf/paincrit.ogg'
			if("painscream")
				used = list('sound/vo/female/elf/painscream (1).ogg','sound/vo/female/elf/painscream (2).ogg')
			if("scream")
				used = list('sound/vo/female/elf/scream (1).ogg','sound/vo/female/elf/scream (2).ogg','sound/vo/female/elf/scream (3).ogg','sound/vo/female/elf/scream (4).ogg')
			if("croak") //undine only.
				used = list('modular/stonekeep/kaizoku/sound/vo/general/undinecall.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall2.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall3.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall4.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall5.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall6.ogg')

	if(!used) //we haven't found a racial specific sound so use generic
		used = ..(soundin)
	return used


/datum/voicepack/male/elf/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getmold(soundin)
		if("silenced")
			used = getmsilenced(soundin)
	if(!used)
		switch(soundin)
			if("agony")
				used = 'sound/vo/male/elf/agony.ogg'
			if("chuckle")
				used = list('sound/vo/male/elf/chuckle (1).ogg','sound/vo/male/elf/chuckle (2).ogg','sound/vo/male/elf/chuckle (3).ogg','sound/vo/male/elf/chuckle (4).ogg','sound/vo/male/elf/chuckle (5).ogg','sound/vo/male/elf/chuckle (6).ogg','sound/vo/male/elf/chuckle (7).ogg','sound/vo/male/elf/chuckle (8).ogg')
			if("cry")
				used = list('sound/vo/male/elf/cry (1).ogg','sound/vo/male/elf/cry (2).ogg','sound/vo/male/elf/cry (3).ogg')
			if("embed")
				used = list('sound/vo/male/elf/embed (1).ogg','sound/vo/male/elf/embed (2).ogg')
			if("firescream")
				used = list('sound/vo/male/elf/firescream (1).ogg','sound/vo/male/elf/firescream (2).ogg','sound/vo/male/elf/firescream (3).ogg')
			if("gasp")
				used = list('sound/vo/male/elf/gasp (1).ogg','sound/vo/male/elf/gasp (2).ogg','sound/vo/male/elf/gasp (3).ogg')
			if("grumble")
				used = 'sound/vo/male/elf/grumble.ogg'
			if("haltyell")
				used = 'sound/vo/male/elf/haltyell.ogg'
			if("huh")
				used = 'sound/vo/male/elf/huh.ogg'
			if("laugh")
				used = list('sound/vo/male/elf/laugh (1).ogg','sound/vo/male/elf/laugh (2).ogg','sound/vo/male/elf/laugh (3).ogg')
			if("pain")
				used = list('sound/vo/male/elf/pain (1).ogg','sound/vo/male/elf/pain (2).ogg','sound/vo/male/elf/pain (3).ogg')
			if("paincrit")
				used = list('sound/vo/male/elf/paincrit (1).ogg','sound/vo/male/elf/paincrit (2).ogg','sound/vo/male/elf/paincrit (3).ogg')
			if("painmoan")
				used = list('sound/vo/male/elf/painmoan (1).ogg','sound/vo/male/elf/painmoan (2).ogg','sound/vo/male/elf/painmoan (3).ogg')
			if("painscream")
				used = list('sound/vo/male/elf/painscream (1).ogg','sound/vo/male/elf/painscream (2).ogg')
			if("rage")
				used = list('sound/vo/male/elf/rage (1).ogg','sound/vo/male/elf/rage (2).ogg')
			if("scream")
				used = list('sound/vo/male/elf/scream (1).ogg','sound/vo/male/elf/scream (2).ogg')
			if("croak") //undine only.
				used = list('modular/stonekeep/kaizoku/sound/vo/general/undinecall.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall2.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall3.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall4.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall5.ogg','modular/stonekeep/kaizoku/sound/vo/general/undinecall6.ogg')

	if(!used)
		used = ..(soundin)
	return used


/datum/voicepack/male/abyssariad/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getmold(soundin)
		if("silenced")
			used = getmsilenced(soundin)
	if(!used)
		switch(soundin)
			if("chuckle")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/chuckle(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/chuckle(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/chuckle(3).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/chuckle(4).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/chuckle(5).ogg')
			if("cry")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/cry(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/cry(3).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/cry(4).ogg')
			if("embed")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painembed(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painembed(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painembed(3).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painembed(4).ogg')
			if("firescream")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(3).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(4).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(5).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(6).ogg')
			if("gasp")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/gasp(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/gasp(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/gasp(3).ogg')
			if("grumble")
				used = 'modular/stonekeep/kaizoku/sound/vo/male_abyssariad/rude.ogg'
			if("haltyell")
				used = used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/halt(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/halt(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/halt(3).ogg')
			if("huh")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh(3).ogg')
			if("laugh")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(3).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(4).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(5).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(6).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(7).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/laugh(8).ogg')
			if("pain")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(3).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(4).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(5).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(6).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(7).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/pain(8).ogg')
			if("paincrit")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/paincrit(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/paincrit(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/paincrit(3).ogg')
			if("painmoan")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/paincrit(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/paincrit(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/paincrit(3).ogg')
			if("painscream")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(3).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(4).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(5).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/painscream(6).ogg')
			if("rage")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/rage1.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/rage2.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/rage3.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/rage4.ogg')
			if("scream")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/scream(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/scream(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/scream(3).ogg')
			if("hmm") //used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh(2).ogg')
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh(4).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh(5).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/huh(6).ogg')
			if("jump")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/jump(1).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/jump(2).ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/jump(3).ogg')
			if("leap")
				used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/attack1.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/attack2.ogg')
			if("yoo")
				used = 'modular/stonekeep/kaizoku/sound/vo/male_abyssariad/yoooo.ogg'
			if("throatsing") //need to find a way to make a bigger cooldown on this one. This emote is long.
				if(prob(5))
					used = 'modular/stonekeep/kaizoku/sound/vo/male_abyssariad/throatsing_rare.ogg' //I am not afraid. I know gundam will hate me for this one. But trust me, it's worth it
				else
					used = list('modular/stonekeep/kaizoku/sound/vo/male_abyssariad/throatsing1.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/mthroatsing1.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/mthroatsing2.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/mthroatsing3.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/mthroatsing4.ogg','modular/stonekeep/kaizoku/sound/vo/male_abyssariad/mthroatsing5.ogg')
			if("birdcall")
				used = list('modular/stonekeep/kaizoku/sound/vo/general/tengucall1.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall2.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall3.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall4.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall5.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall5.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall6.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall7.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall8.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall9.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall10.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall12.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall13.ogg','modular/stonekeep/kaizoku/sound/vo/general/tengucall14.ogg','sound/vo/general/brazilianmeme.ogg')

	if(!used)
		used = ..(soundin)
	return used


/datum/language/abyssal
	name = "Abyssal"
	desc = ""
	speech_verb = "conveys"
	ask_verb = "quizzes"
	exclaim_verb = "roars"
	key = "a"
	flags = LANGUAGE_HIDE_ICON_IF_UNDERSTOOD | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 66
	default_priority = 80
	icon_state = "asse"
	spans = list(SPAN_ABYSSAL)
	syllables = list(
"ichi",
"ni",
"san",
"shi",
"yon",
"go",
"roku",
"shichi",
"nana",
"hachi",
"kyuu",
"ku",
"juu",
"hyaku",
"sen",
"man",
"en",
"ji",
"nichi",
"hi",
"getsu",
"tsuki",
"ka",
"hi",
"sui",
"mizu",
"moku",
"ki",
"kin",
"kane",
"do",
"tsuchi",
"nen",
"toshi",
"jou",
"ue",
"ka",
"shita",
"chuu",
"naka",
"shou",
"chii",
"dai",
"oo",
"san",
"yama",
"sen",
"kawa",
"sa",
"hidari",
"migi",
"sen",
"saki",
"sei",
"ikiru",
"yuu",
"tomo",
"gaku",
"manabu",
"kou",
"kan",
"aida",
"fun",
"bun",
"zen",
"mae",
"ato",
"kon",
"ima",
"ka",
"nani",
"jin",
"hito",
"hou",
"kata",
"hon",
"ji",
"aza",
"sho",
"kaku",
"ken",
"miru",
"kou",
"iku",
"shoku",
"taberu",
"in",
"nomu",
"kyuu",
"yasumu",
"nyuu",
"hairu",
"deru",
"kou",
"kuchi",
"chou",
"machi",
"son",
"mura",
"sei",
"shin",
"ko",
"furui",
"chou",
"nagai",
"tan",
"kou",
"takai",
"an",
"yasui",
"ta",
"oo",
"shou",
"sha",
"haku",
"shiro",
"koku",
"kuro",
"seki",
"aka",
"sei",
"ao",
"kou",
"ki",
"iro",
"kuu",
"kai",
"umi",
"ten",
"ama",
"u",
"ame",
"den",
"wa")


/datum/voicepack/female/abyssariad/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getfold(soundin)
		if("young")
			used = getfyoung(soundin)
		if("silenced")
			used = getfsilenced(soundin)
	if(!used)
		switch(soundin)
			if("fatigue")
				used = 'modular/stonekeep/kaizoku/sound/vo/female_abyssariad/fatigue.ogg'
			if("firescream")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/painscream1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/painscream2.ogg')
			if("gasp")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/gasp.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/gasp2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/gasp3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/gasp4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/gasp5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/gasp6.ogg')
			if("huh")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/huh.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/huh1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/huh2.ogg')
			if("laugh")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/laugh.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/laugh1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/laugh3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/laugh4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/laugh5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/laugh6.ogg')
			if("groan")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/groan.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/DISAPPOINTMENT.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/ah.ogg')
			if("pain")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/pain1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/pain2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/pain3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/pain4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/pain5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/pain6.ogg')
			if("embed")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit5.ogg')
			if("paincrit")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/paincrit5.ogg')
			if("painscream")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/painscream1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/painscream2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/painscream3.ogg')
			if("painmoan")
				used = 'modular/stonekeep/kaizoku/sound/vo/female_abyssariad/screamgasp.ogg'
			if("scream")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/scream1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/scream2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/scream3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/scream4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/scream5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/scream6.ogg')
			if("throatsing") //need to find a way to put a cooldown on this emote.
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/fthroatsing1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/fthroatsing2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/fthroatsing3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/fthroatsing4.ogg')
			if("breathgasp")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/deathgasp.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/deathgasp2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/deathgasp3.ogg')
			if("chuckle")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/chuckle3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/chuckle4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/chuckle5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/chuckle6.ogg')
			if("giggle")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/chuckle1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/chuckle2.ogg')
			if("grumble") //need to find a way to make a bigger cooldown on this one. This emote is long.
				if(prob(5))
					used = 'modular/stonekeep/kaizoku/sound/vo/female_abyssariad/wawawa.ogg' //I do not fear being murdered during my sleep.
				else
					used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/grumble1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/grumble2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/grumble3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/grumble4.ogg')
			if("jump")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/jump1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/jump2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/jump3.ogg')
			if("leap")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/jump4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/jump5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/jump6.ogg')
			if("rage")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/angry1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/angry2.ogg')
			if("sexmoanlight")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan6.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan7.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan8.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan9.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/smoan10.ogg')
			if("sexmoanhvy")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy3.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy5.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy6.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy7.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy8.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy9.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy10.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy11.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy12.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy13.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy14.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy15.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy16.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy17.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy18.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy19.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moanheavy20.ogg')
			if("moan")
				used = list('modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moan1.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moan2.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moan4.ogg','modular/stonekeep/kaizoku/sound/vo/female_abyssariad/moan5.ogg')
			if("birdcall")
				used = list('sound/vo/general/tengucall1.ogg','sound/vo/general/tengucall2.ogg','sound/vo/general/tengucall3.ogg','sound/vo/general/tengucall4.ogg','sound/vo/general/tengucall5.ogg','sound/vo/general/tengucall5.ogg','sound/vo/general/tengucall6.ogg','sound/vo/general/tengucall7.ogg','sound/vo/general/tengucall8.ogg','sound/vo/general/tengucall9.ogg','sound/vo/general/tengucall10.ogg','sound/vo/general/tengucall12.ogg','sound/vo/general/tengucall13.ogg','sound/vo/general/tengucall14.ogg','sound/vo/general/brazilianmeme.ogg')
	if(!used) //we haven't found a racial specific sound so use generic
		used = ..(soundin)
	return used
