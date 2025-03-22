/obj/structure/vampire/necromanticbook // Used to summon undead to attack town/defend manor.
	name = "Tome of Souls"
	icon_state = "tome"
	var/list/useoptions = list("Create Death Knight", "Steal the Sun")
	var/sunstolen = FALSE

/obj/structure/vampire/necromanticbook/attack_hand(mob/living/carbon/human/user)
	var/datum/antagonist/vampire/lord/lord = user.mind.has_antag_datum(/datum/antagonist/vampire/lord)
	if(user.mind.special_role == "Vampire Lord")
		if(!unlocked)
			to_chat(user, "I have yet to regain this aspect of my power!")
			return
		var/choice = input(user,"What to do?", "VANDERLIN") as anything in useoptions|null
		switch(choice)
			if("Create Death Knight")
				if(alert(user, "Create a Death Knight? Cost:5000","","Yes","No") == "Yes")
					if(length(SSmapping.retainer.death_knights) >= 3)
						to_chat(user, "You cannot summon any more death knights.")
						return
					if(!lord.mypool.check_withdraw(-5000))
						to_chat(user, "I don't have enough vitae!")
						return
					if(do_after(user, 10 SECONDS))
						to_chat(user, "I have summoned a knight from the underworld. I need only wait for them to materialize.")
						SSmapping.add_world_trait(/datum/world_trait/death_knight, -1)
						for(var/mob/dead/observer/D in GLOB.player_list)
							D.death_knight_spawn()
						for(var/mob/living/carbon/spirit/D in GLOB.player_list)
							D.death_knight_spawn()
				user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)
			if("Steal the Sun")
				if(sunstolen)
					to_chat(user, "The sun is already stolen!")
					return
				if(GLOB.tod == "night")
					to_chat(user, "It's already night!")
					return
				if(alert(user, "Force Vanderlin into Night? Cost:5000","","Yes","No") == "Yes")
					if(!lord.mypool.check_withdraw(-2500))
						to_chat(user, "I don't have enough vitae!")
						return
					if(do_after(user, 10 SECONDS))
						GLOB.todoverride = "night"
						sunstolen = TRUE
						settod()
						spawn(6000)
							GLOB.todoverride = null
							sunstolen = FALSE
						priority_announce("The Sun is torn from the sky!", "Terrible Omen", 'sound/misc/astratascream.ogg')
						addomen(OMEN_SUNSTEAL)
						for(var/mob/living/carbon/human/astrater in GLOB.human_list)
							if(!istype(astrater.patron, /datum/patron/divine/astrata) || !length(astrater.mind?.antag_datums))
								continue
							to_chat(astrater, span_userdanger("You feel the pain of [astrater.patron]!"))
							astrater.emote_scream()

	if(user.mind.special_role == "Vampire Spawn")
		to_chat(user, "I don't have the power to use this!")
