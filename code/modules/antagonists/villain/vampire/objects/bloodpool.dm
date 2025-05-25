#define VAMPCOST_ONE 10000
#define VAMPCOST_TWO 12000
#define VAMPCOST_THREE 15000
#define VAMPCOST_FOUR 20000

/obj/structure/vampire/bloodpool
	name = "Crimson Crucible"
	icon_state = "vat"
	var/maximum = 8000
	var/current = 8000
	var/list/useoptions = list("Grow Power", "Shape Amulet", "Shape Armor")
	var/list/levelup_thresholds = list(
		VAMPCOST_ONE,
		VAMPCOST_TWO,
		VAMPCOST_THREE,
		VAMPCOST_FOUR,
	)

	var/datum/team/vampires/owner_team

/obj/structure/vampire/bloodpool/Initialize()
	. = ..()
	set_light(3, 3, 20, l_color = LIGHT_COLOR_BLOOD_MAGIC)

/obj/structure/vampire/bloodpool/examine(mob/user)
	. = ..()
	to_chat(user, span_boldnotice("Blood level: [current]"))

/obj/structure/vampire/bloodpool/attack_hand(mob/living/user)
	var/datum/antagonist/vampire/lord/lord = user.mind.has_antag_datum(/datum/antagonist/vampire/lord)
	if(!lord)
		return
	switch(browser_input_list(user, "What to do?", "VANDERLIN", useoptions))
		if("Grow Power")
			var/datum/team/vampires/vamp_team = lord.team
			if(lord.ascended)
				to_chat(user, span_warning("I have already reached my pinnacle."))
				return

			var/next_level = levelup_thresholds[vamp_team.power_level + 1]

			if(browser_alert(user, "Increase vampire level?<BR>Cost:[next_level]", "ASCENSION", DEFAULT_INPUT_CHOICES) == CHOICE_YES)
				if(!check_withdraw(-next_level))
					to_chat(user, span_warning("I do not have enough vitae."))
					return

				if(!do_after(user, 10 SECONDS))
					to_chat(user, span_warning("My growth has been interrupted."))
					return

				if(!check_withdraw(-next_level))
					to_chat(user, span_warning("I do not have enough vitae."))
					return

				lord.adjust_vitae(-next_level)
				to_chat(user, span_greentext("My power grows."))
				vamp_team.grow_in_power()
				user.playsound_local(get_turf(src), 'sound/misc/batsound.ogg', 100, FALSE, pressure_affected = FALSE)

		if("Shape Amulet")
			if(browser_alert(user, "Craft a new amulet?<BR>Cost:500", "WORLD ANCHOR", DEFAULT_INPUT_CHOICES) == CHOICE_YES)
				if(!check_withdraw(-500))
					to_chat(user, span_warning("I do not have enough vitae."))
					return
				if(do_after(user, 10 SECONDS, src))
					lord.adjust_vitae(-500)
					var/naming = input(user, "Select a name for the amulet.", "VANDERLIN") as text|null
					var/obj/item/clothing/neck/portalamulet/P = new(src.loc)
					if(naming)
						P.name = naming
					user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)

		if("Shape Armor")
			if(browser_alert(user, "Craft a new set of armor?<BR>Cost:5000", "WICKED PLATE", DEFAULT_INPUT_CHOICES) == CHOICE_YES)
				if(!check_withdraw(-5000))
					to_chat(user, span_warning("I do not have enough vitae."))
					return
				if(do_after(user, 10 SECONDS, src))
					lord.adjust_vitae(-5000)
					new /obj/item/clothing/pants/platelegs/vampire (src.loc)
					new /obj/item/clothing/gloves/chain/vampire (src.loc)
					new /obj/item/clothing/armor/chainmail/hauberk/vampire (src.loc)
					new /obj/item/clothing/armor/cuirass/vampire (src.loc)
					new /obj/item/clothing/shoes/boots/armor/vampire (src.loc)
					new /obj/item/clothing/head/helmet/heavy/savoyard (src.loc)
					user.playsound_local(get_turf(src), 'sound/misc/vcraft.ogg', 100, FALSE, pressure_affected = FALSE)

/obj/structure/vampire/bloodpool/proc/update_pool(change)
	if(!change)
		return

	maximum = 8000
	if(owner_team)
		maximum += 4000 * length(owner_team.thralls)

	current = clamp(current + change, 0, maximum)

/obj/structure/vampire/bloodpool/proc/check_withdraw(change)
	if(change < 0)
		if(abs(change) > current)
			return FALSE
		return TRUE
