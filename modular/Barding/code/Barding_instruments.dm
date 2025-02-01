
/obj/item/rogue/instrument
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/music.dmi'
	icon_state = ""
	mob_overlay_icon = 'icons/roguetown/onmob/onmob.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK_R|ITEM_SLOT_BACK_L
	can_parry = FALSE
	force = 0
	minstr = 0
	wbalance = 0
	wdefense = 0
	throwforce = 0
	throw_range = 4
	blade_dulling = DULLING_BASH
	max_integrity = 80 // Flimsy instruments of wood.
	destroy_message = "falls apart!"
	dropshrink = 0.8
	grid_height = 64
	grid_width = 32
	var/datum/looping_sound/instrument/soundloop
	var/list/song_list = list()
	var/playing = FALSE
	var/dynamic_icon
	var/icon_prefix

/datum/looping_sound/instrument
	mid_sounds = list()
	mid_length = 60
	volume = 100
	falloff = 2
	extra_range = 5
	var/stress2give = /datum/stressevent/music
	persistent_loop = TRUE

/datum/looping_sound/instrument/on_hear_sound(mob/M)
	. = ..()
	if(stress2give)
		if(isliving(M))
			var/mob/living/carbon/L = M
			L.add_stress(stress2give)

/obj/item/rogue/instrument/equipped(mob/living/user, slot)
	. = ..()
	if(playing && user.get_active_held_item() != src)
		playing = FALSE
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)

	// Prevents an exploit
	for(var/mob/living/carbon/L in viewers(7))
		var/mob/living/carbon/buffed = L
		if(buffed.mind?.has_antag_datum(/datum/antagonist))
			if(buffed.mind?.isactuallygood())
				for(var/datum/status_effect/bardicbuff/b in L.status_effects)
					buffed.remove_status_effect(b)
			else
				return
		else
			for(var/datum/status_effect/bardicbuff/b in L.status_effects)
				buffed.remove_status_effect(b)

/obj/item/rogue/instrument/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = 0,"sy" = 2,"sx" = 0,"sy" = 2,"wx" = -1,"wy" = 2,"ex" = 5,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogue/instrument/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/item/rogue/instrument/dropped(mob/living/user, silent)
	..()
	if(soundloop)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)
	// Prevents an exploit
	for(var/mob/living/carbon/L in viewers(7))
		var/mob/living/carbon/buffed = L
		if(buffed.mind?.has_antag_datum(/datum/antagonist))
			if(buffed.mind?.isactuallygood())
				for(var/datum/status_effect/bardicbuff/b in L.status_effects)
					buffed.remove_status_effect(b)
			else
				return
		else
			for(var/datum/status_effect/bardicbuff/b in L.status_effects)
				buffed.remove_status_effect(b)

/obj/item/rogue/instrument/attack_self(mob/living/user)
	var/stressevent = /datum/stressevent/music
	var/bardbonus = /datum/stressevent/bardicbuff
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(!playing)
		var/note_color = "#7f7f7f" // uses MMO item rarity color grading
		var/curfile = input(user, "Which song do you want to play?", "Pick a song", name) as null|anything in song_list
		if(!user)
			return
		if(user.mind)
			soundloop.stress2give = null
			switch(user.mind.get_skill_level(/datum/skill/misc/music))
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

		if(playing)
			playing = FALSE
			soundloop.stop()
			user.remove_status_effect(/datum/status_effect/buff/playing_music)
			return

		if(!(src in user.held_items))
			return

		if(user.get_inactive_held_item())
			playing = FALSE
			soundloop.stop()
			user.remove_status_effect(/datum/status_effect/buff/playing_music)
			if(dynamic_icon)
				lower_from_mouth()
				update_icon()
			return

		if(curfile)
			curfile = song_list[curfile]
			playing = TRUE
			soundloop.mid_sounds = list(curfile)
			soundloop.cursound = null
			soundloop.start()
			user.apply_status_effect(/datum/status_effect/buff/playing_music, stressevent, note_color)
			if(dynamic_icon)
				lift_to_mouth()
				update_icon()
				for(var/obj/item/reagent_containers/food/snacks/smallrat/I in view(4, user))
					if(I.loc != user)
						step_towards(I, user)
						sleep(2)
						step_towards(I, user)
						sleep(2)
						step_towards(I, user)

		// BARDIC BUFFS CODE START //

		if(playing && HAS_TRAIT(user, TRAIT_BARDIC_TRAINING)) // Non-bards will never get this prompt. Prompt doesn't show if you cancel song selection either.
			var/list/buffs2pick = list()
			var/musiclevel = user.mind.get_skill_level(/datum/skill/misc/music)
			switch(musiclevel) // There has to be a better way to do this, but so far all I've tried doesn't work as intended.
				if(1) // T1
					buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence)
				if(1 to 2) // T2
					buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
									"Malum's Resilience (+1 END)" = /datum/status_effect/bardicbuff/endurance)
				if(1 to 3) // T3
					buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
									"Malum's Resilience (+1 END)" = /datum/status_effect/bardicbuff/endurance,
									"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution)
				if(1 to 4) // T4
					buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
									"Malum's Perseverance (+1 END)" = /datum/status_effect/bardicbuff/endurance,
									"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution,
									"Xylix's Alacrity (+1 SPD)" = /datum/status_effect/bardicbuff/speed)
				if(1 to 5) // T5
					buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
									"Malum's Perseverance (+1 END)" = /datum/status_effect/bardicbuff/endurance,
									"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution,
									"Xylix's Alacrity (+1 SPD)" = /datum/status_effect/bardicbuff/speed,
									"Ravox's Righteous Fury (+1 STR, +1 PER)" = /datum/status_effect/bardicbuff/ravox)
				if(6 to INFINITY) // Legendary onwards
					buffs2pick += list("Noc's Brilliance (+1 INT)" = /datum/status_effect/bardicbuff/intelligence,
									"Malum's Perseverance (+1 END)" = /datum/status_effect/bardicbuff/endurance,
									"Pestra's Blessing (+1 CON)" = /datum/status_effect/bardicbuff/constitution,
									"Xylix's Alacrity (+1 SPD)" = /datum/status_effect/bardicbuff/speed,
									"Ravox's Righteous Fury (+1 STR, +1 PER)" = /datum/status_effect/bardicbuff/ravox,
									"Astrata's Awakening (Purges sleep, +1 FOR)" = /datum/status_effect/bardicbuff/awaken) // TAKE THE LAND THAT MUST BE TAKEN
				else // debug
					message_admins("<span class='warning'>[key_name(usr)] is a bard with zero music skill and couldn't choose a buff.</span>")
			var/buff2use = input(user, "Which buff to add to your song?", "Bardic Buffs", name) as null|anything in buffs2pick
			if(buff2use) // Prevents runtime
				buff2use = buffs2pick[buff2use] // This is to pick the buff and disregard the name defined at list level.
				for(var/mob/living/carbon/L in viewers(7))
					if(L.can_hear()) // Only good people who can hear music will get buffed
						if(L.mind?.has_antag_datum(/datum/antagonist))
							if(L.mind?.isactuallygood())
								L.add_stress(bardbonus)
								// Apply the buff every second to refresh its duration since it's timed
								while(playing)
									L.apply_status_effect(buff2use)
									var/boon = user?.mind?.get_learning_boon(/datum/skill/misc/music)
									user?.mind?.adjust_experience(/datum/skill/misc/music, ceil((user.STAINT*0.2) * boon) * 0.1) // And gain exp
									sleep(10 * world.tick_lag) // Sanity to avoid infinite loop
							else
								return
						else
							L.add_stress(bardbonus) // Additional mood increase
							// Apply the buff every second to refresh its duration since it's timed
							while(playing)
								L.apply_status_effect(buff2use)
								var/boon = user?.mind?.get_learning_boon(/datum/skill/misc/music)
								user?.mind?.adjust_experience(/datum/skill/misc/music, ceil((user.STAINT*0.2) * boon) * 0.1) // and gain exp
								sleep(10 * world.tick_lag) // Sanity to avoid infinite loop
					else
						return
			else
				to_chat(user, "I decided not to bestow any boons to my music.")
				for(var/mob/living/carbon/L in viewers(7))
					L.add_stress(bardbonus) // Give us the extra mood regardless.
				while(playing) // Grant us exp even if we did not apply buffs to anyone.
					var/boon = user?.mind?.get_learning_boon(/datum/skill/misc/music)
					user?.mind?.adjust_experience(/datum/skill/misc/music, ceil((user.STAINT*0.2) * boon * 0.1))
					sleep(10 * world.tick_lag) // Gain exp every 1 second delay of playing

		// BARDIC BUFFS CODE END //

		while(playing)
			var/boon = user?.mind?.get_learning_boon(/datum/skill/misc/music)
			user?.mind?.adjust_experience(/datum/skill/misc/music, ceil((user.STAINT*0.2) * boon * 0.1))
			sleep(10 * world.tick_lag) // Gain exp every 1 second delay of playing

	else
		playing = FALSE
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/playing_music)
		if(dynamic_icon)
			lower_from_mouth()
			update_icon()
		for(var/mob/living/carbon/L in viewers(7))
			var/mob/living/carbon/buffed = L
			if(buffed.mind?.has_antag_datum(/datum/antagonist))
				if(buffed.mind?.isactuallygood())
					for(var/datum/status_effect/bardicbuff/b in L.status_effects)
						buffed.remove_status_effect(b) // All applicable bard buffs stopped
				else
					return
			else
				for(var/datum/status_effect/bardicbuff/b in L.status_effects)
					buffed.remove_status_effect(b) // All applicable bard buffs stopped

/obj/item/rogue/instrument/dropped(mob/user)
	. = ..()
	playing = FALSE
	soundloop.stop()
	if(dynamic_icon)
		lower_from_mouth()
		update_icon()
	for(var/mob/living/carbon/L in viewers(7))
		var/mob/living/carbon/buffed = L
		if(buffed.mind?.has_antag_datum(/datum/antagonist))
			if(buffed.mind?.isactuallygood())
				for(var/datum/status_effect/bardicbuff/b in L.status_effects)
					buffed.remove_status_effect(b) // All applicable bard buffs stopped
			else
				return
		else
			for(var/datum/status_effect/bardicbuff/b in L.status_effects)
				buffed.remove_status_effect(b) // All applicable bard buffs stopped

// At this point I don't know what other proc should be covered to avoid exploits.
/obj/item/rogue/instrument/obj_destruction(damage_flag)
	. = ..()
	if(playing)
		playing = FALSE
		soundloop.stop()
		for(var/mob/living/carbon/L in viewers(7))
			var/mob/living/carbon/buffed = L
			if(buffed.mind?.has_antag_datum(/datum/antagonist))
				if(buffed.mind?.isactuallygood())
					for(var/datum/status_effect/bardicbuff/b in L.status_effects)
						buffed.remove_status_effect(b) // All applicable bard buffs stopped
				else
					return
			else
				for(var/datum/status_effect/bardicbuff/b in L.status_effects)
					buffed.remove_status_effect(b) // All applicable bard buffs stopped

// Fixes an exploit. It shouldn't stack buffs anymore.
/obj/item/rogue/instrument/throw_at(atom/target, range, speed, mob/thrower, spin, diagonals_first, datum/callback/callback)
	. = ..()
	if(playing)
		playing = FALSE
		soundloop.stop()
		if(dynamic_icon)
			lower_from_mouth()
			update_icon()
		for(var/mob/living/carbon/L in viewers(7))
			var/mob/living/carbon/buffed = L
			if(buffed.mind?.has_antag_datum(/datum/antagonist))
				if(buffed.mind?.isactuallygood())
					for(var/datum/status_effect/bardicbuff/b in L.status_effects)
						buffed.remove_status_effect(b) // All applicable bard buffs stopped
				else
					return
			else
				for(var/datum/status_effect/bardicbuff/b in L.status_effects)
					buffed.remove_status_effect(b) // All applicable bard buffs stopped

/obj/item/rogue/instrument/proc/lift_to_mouth()
	icon_state = "[icon_prefix]_play"

/obj/item/rogue/instrument/proc/lower_from_mouth()
	icon_state = "[icon_prefix]"



/obj/item/rogue/instrument/lute
	name = "lute"
	desc = "The favored instrument of Eora, made of wood and simple string."
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	force = 5
	icon_state = "lute"
	song_list = list(
	"A Knight's Return" = 'sound/instruments/lute (1).ogg',
	"Amongst Fare Friends" = 'sound/instruments/lute (2).ogg',
	"The Road Traveled by Few" = 'sound/instruments/lute (3).ogg',
	"Tip Thine Tankard" = 'sound/instruments/lute (4).ogg',
	"A Reed On the Wind" = 'sound/instruments/lute (5).ogg',
	"Jests On Steel Ears" = 'sound/instruments/lute (6).ogg',
	"Merchant in the Mire" = 'sound/instruments/lute (7).ogg',
	"Soilson's Song" = 'sound/instruments/lute (8).ogg')

/obj/item/rogue/instrument/accord
	name = "accordion"
	desc = "A complex piece of dwarven intuition, composed of metal, wood, hide and ivory. Favored by Abyssorian bards."
	icon_state = "accordion"
	item_state = "accordion"
	song_list = list(
	"Her Healing Tears" = 'sound/instruments/accord (1).ogg',
	"Peddler's Tale" = 'sound/instruments/accord (2).ogg',
	"We Toil Together" = 'sound/instruments/accord (3).ogg',
	"Just One More, Tavern Wench" = 'sound/instruments/accord (4).ogg',
	"Moonlight Carnival" = 'sound/instruments/accord (5).ogg',
	"'Ye Best Be Goin'" = 'sound/instruments/accord (6).ogg',
	"Song of the Falconeer" = 'sound/instruments/accord (7).ogg',
	"Dwarven Frolick" = 'sound/instruments/accord (8).ogg',
	"Beloved Blue" = 'sound/instruments/accord (9).ogg',
	)

/obj/item/rogue/instrument/guitar
	name = "guitar"
	desc = "A corrupted lute, a heritage instrument of Tiefling pedigree."
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	icon_state = "guitar"
	item_state = "guitar"
	song_list = list(
	"Fire-Cast Shadows" = 'sound/instruments/guitar (1).ogg',
	"The Forced Hand" = 'sound/instruments/guitar (2).ogg',
	"Regrets Unpaid" = 'sound/instruments/guitar (3).ogg',
	"'Took the Mammon and Ran'" = 'sound/instruments/guitar (4).ogg',
	"Poor Man's Tithe" = 'sound/instruments/guitar (5).ogg',
	"In His Arms Ye'll Find Me" = 'sound/instruments/guitar (6).ogg',
	"Sunset Ballad" = 'sound/instruments/guitar (7).ogg',
	"Romanza" = 'sound/instruments/guitar (8).ogg',
	"Malaguena" = 'sound/instruments/guitar (9).ogg',
	"Song of the Archer" = 'sound/instruments/guitar (10).ogg',
	"The Mask" = 'sound/instruments/guitar (11).ogg',
	"Evolvado" = 'sound/instruments/guitar (12).ogg',
	"Asturias" = 'sound/instruments/guitar (13).ogg',
	"The Fools Journey" = 'sound/instruments/guitar (14).ogg',
	"Prelude to Sorrow" = 'sound/instruments/guitar (15).ogg',
	"The Queen's High Seas" = 'sound/instruments/guitar (16).ogg'
	)

/obj/item/rogue/instrument/harp
	name = "lyre"
	desc = "An elven instrument of a great and proud heritage."
	icon_state = "harp"
	song_list = list(
	"Through Thine Window, He Glanced" = 'sound/instruments/harp (1).ogg',
	"The Lady of Red Silks" = 'sound/instruments/harp (2).ogg',
	"Eora Doth Watches" = 'sound/instruments/harp (3).ogg',
	"Dance of the Mages" = 'sound/instruments/harp (4).ogg',
	"Trickster Wisps" = 'sound/instruments/harp (5).ogg',
	"On the Breeze" = 'sound/instruments/harp (6).ogg',
	"Never Enough" = 'sound/instruments/harp (7).ogg',
	"Sundered Heart" = 'sound/instruments/harp (8).ogg',
	"Corridors of Time" = 'sound/instruments/harp (9).ogg',
	"Determination" = 'sound/instruments/harp (10).ogg',
	)

/obj/item/rogue/instrument/flute // small rats approach a little when begin playing
	name = "flute"
	desc = "A cacophonous wind-instrument, played primarily by humens all around Psydonia."
	icon_state = "flute"
	icon_prefix = "flute" // used for inhands switch
	dynamic_icon = TRUE // used for inhands switch
	dropshrink = 0.6
	w_class = WEIGHT_CLASS_SMALL
	song_list = list(
	"Half-Dragon's Ten Mammon" = 'sound/instruments/flute (1).ogg',
	"The Local Favorite" = 'sound/instruments/flute (2).ogg',
	"Rous in the Cellar" = 'sound/instruments/flute (3).ogg',
	"Her Boots, So Incandescent" = 'sound/instruments/flute (4).ogg',
	"Moondust Minx" = 'sound/instruments/flute (5).ogg',
	"Quest to the Ends" = 'sound/instruments/flute (6).ogg',
	"Flower Melody" = 'sound/instruments/flute (7).ogg',
	"Noble Solace" = 'sound/instruments/flute (8).ogg')

/obj/item/rogue/instrument/drum
	name = "drum"
	desc = "The adopted instrument of Aasimar, used for signaling and rhythmic marches alike."
	icon_state = "drum"
	song_list = list(
	"Barbarian's Moot" = 'sound/instruments/drum (1).ogg',
	"Muster the Wardens" = 'sound/instruments/drum (2).ogg',
	"The Earth That Quakes" = 'sound/instruments/drum (3).ogg',
	"Marching Beat" = 'sound/instruments/drum (4).ogg',
	"Desert Heat" = 'sound/instruments/drum (5).ogg')

/obj/item/rogue/instrument/hurdygurdy
	name = "hurdy-gurdy"
	desc = "A knob-driven, wooden string instrument that reminds you of the oceans far."
	icon_state = "hurdygurdy"
	song_list = list("Ruler's One Ring" = 'sound/instruments/hurdy (1).ogg',
	"Tangled Trod" = 'sound/instruments/hurdy (2).ogg',
	"Motus" = 'sound/instruments/hurdy (3).ogg',
	"Becalmed" = 'sound/instruments/hurdy (4).ogg',
	"The Bloody Throne" = 'sound/instruments/hurdy (5).ogg',
	"We Shall Sail Together" = 'sound/instruments/hurdy (6).ogg'
	)
	experimental_inhand = TRUE //temporary inhand sprite

/obj/item/rogue/instrument/viola
	name = "viola"
	desc = "The prim and proper Viola, often the first instrument nobles are taught."
	icon_state = "viola"
	song_list = list("Far Flung Tale" = 'sound/instruments/viola (1).ogg',
	"G Major Cello Suite No. 1" = 'sound/instruments/viola (2).ogg',
	"Ursine's Home" = 'sound/instruments/viola (3).ogg',
	"Mead, Gold and Blood" = 'sound/instruments/viola (4).ogg',
	"Gasgow's Reel" = 'sound/instruments/viola (5).ogg',
	)
	experimental_inhand = TRUE

/obj/item/rogue/instrument/vocals
	name = "vocalist's talisman"
	desc = "This talisman emanates a small shimmer of light. When held, it can amplify and even change one's voice."
	icon_state = "vtalisman"
	song_list = list("Harpy's Call (Feminine)" = 'sound/instruments/vocalsf (1).ogg',
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
	experimental_inhand = TRUE
