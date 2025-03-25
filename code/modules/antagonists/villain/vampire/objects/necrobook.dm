#define SUN_STEAL_COST 5000
#define DEATH_KNIGHT_COST 2500

/obj/structure/vampire/necromanticbook // Used to summon undead to attack town/defend manor.
	name = "Tome of Souls"
	icon_state = "tome"
	var/list/useoptions = list("Create Death Knight", "Steal the Sun")
	var/sunstolen = FALSE

/obj/structure/vampire/necromanticbook/attack_hand(mob/living/carbon/human/user)
	var/datum/antagonist/vampire/lord/lord_datum = user.mind.has_antag_datum(/datum/antagonist/vampire/lord)
	if(!lord_datum)
		return

	var/datum/team/vampires/vamp_team = lord_datum.team
	if(vamp_team.power_level < 3)
		to_chat(user, span_warning("I have yet to regain this aspect of my power."))
		return TRUE

	switch(browser_input_list(user, "What to do?", null, useoptions))
		if("Create Death Knight")
			if(browser_alert(user, "Create a Death Knight?<BR>Cost:[DEATH_KNIGHT_COST]",null,DEFAULT_INPUT_CHOICES) != CHOICE_YES)
				return
			if(length(SSmapping.retainer.death_knights) >= 3)
				to_chat(user, span_warning("I cannot summon any more death knights."))
				return
			if(!lord_datum.has_vitae(DEATH_KNIGHT_COST))
				to_chat(user, span_warning("I do not have enough vitae."))
				return
			if(!do_after(user, 10 SECONDS, src))
				return
			if(!lord_datum.has_vitae(DEATH_KNIGHT_COST))
				to_chat(user, span_warning("I no longer have enough vitae."))
				return

			lord_datum.adjust_vitae(DEATH_KNIGHT_COST)
			user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)
			to_chat(user, span_notice("I have summoned a knight from the underworld. I need only wait for them to materialize."))
			SSmapping.add_world_trait(/datum/world_trait/death_knight, -1)
			for(var/mob/dead/observer/D in GLOB.player_list)
				D.death_knight_spawn()
			for(var/mob/living/carbon/spirit/D in GLOB.player_list)
				D.death_knight_spawn()

		if("Steal the Sun")
			if(!can_steal_sun(lord_datum))
				return
			if(browser_alert(user, "Force Vanderlin into Night?<BR>Cost:[SUN_STEAL_COST]","",DEFAULT_INPUT_CHOICES) != CHOICE_YES)
				return
			if(!do_after(user, 10 SECONDS, src))
				return
			if(!can_steal_sun(lord_datum))
				return

			lord_datum.adjust_vitae(SUN_STEAL_COST)

			GLOB.todoverride = "night"
			sunstolen = TRUE
			settod()
			spawn(10 MINUTES)
				GLOB.todoverride = null
				sunstolen = FALSE
			priority_announce("The Sun is torn from the sky!", "Terrible Omen", 'sound/misc/astratascream.ogg')
			addomen(OMEN_SUNSTEAL)
			for(var/mob/living/carbon/human/astrater as anything in GLOB.human_list)
				if(!istype(astrater.patron, /datum/patron/divine/astrata))
					continue
				to_chat(astrater, span_userdanger("You feel the pain of [astrater.patron]!"))
				astrater.emote("painscream", intentional = FALSE)

/obj/structure/vampire/necromanticbook/proc/can_steal_sun(datum/antagonist/vampire/lord/thief)
	if(sunstolen)
		to_chat(thief.owner, span_warning("The Sun is already stolen."))
		return
	if(GLOB.tod == "night")
		to_chat(thief.owner, span_warning("The Moon is watching. I must wait for Her to return."))
		return
	if(!thief.has_vitae(SUN_STEAL_COST))
		to_chat(thief.owner, span_warning("I do not have enough vitae."))
		return

	return TRUE

#undef SUN_STEAL_COST
#undef DEATH_KNIGHT_COST
