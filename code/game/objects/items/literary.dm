
/obj/item/textbook
	name = "novice's guide to"
	desc = "A textbook that teaches the alphabet, sentences of varying complexity, and common symbols, allowing readers to train their reading skills. The more advanced the guide, the higher the limit and the more literate you must be to study it."
	icon = 'icons/roguetown/items/books.dmi'
	icon_state = "book_1"
	var/exppercycle = 5
	var/minskill = 0
	var/maxskill = 1
	var/skilltoteach = /datum/skill/misc/reading
	var/title = "literature"
	w_class = WEIGHT_CLASS_NORMAL
	grid_height = 64
	grid_width = 64
	slot_flags = ITEM_SLOT_HIP
	resistance_flags = FLAMMABLE
	force = 5
	throw_speed = 1
	throw_range = 5
	dropshrink = 0.6
	drop_sound = 'sound/foley/dropsound/book_drop.ogg'
	attack_verb = list("bashed", "whacked", "educated")
	drop_sound = 'sound/blank.ogg'
	pickup_sound =  'sound/blank.ogg'
	firefuel = 2 MINUTES

/obj/item/textbook/Initialize()
	. = ..()
	name = name + " " + title

/obj/item/textbook/apprentice
	name = "apprentice's guide to"
	icon_state = "book2_1"
	minskill = 1
	maxskill = 2
	exppercycle = 10

/obj/item/textbook/journeyman
	name = "journeyman's guide to"
	icon_state = "book3_1"
	minskill = 2
	maxskill = 3
	exppercycle = 25

/obj/item/textbook/expert
	name = "expert's guide to"
	icon_state = "book4_1"
	minskill = 3
	maxskill = 4
	exppercycle = 35

/obj/item/textbook/master
	name = "master's guide to"
	icon_state = "book5_1"
	minskill = 4
	maxskill = 5
	exppercycle = 50

/obj/item/textbook/attack_self(mob/user)
	. = ..()
	attemptlearn(user)

/obj/item/textbook/proc/attemptlearn(mob/user)
	if(user.mind && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/userskill = H.mind.get_skill_level(skilltoteach)
		var/intbonus = H.STAINT - 10
		if(userskill < minskill)
			to_chat(user, span_warning("This guide is too advanced for me to study!"))
			return
		if(userskill < maxskill)
			to_chat(user, span_info("You begin to study the [src.name]."))
			if(do_after(H, 5 SECONDS))
				user.mind.adjust_experience(skilltoteach, exppercycle + intbonus)
				attemptlearn(user)
		else
			to_chat(user, span_warning("This guide is too simple for me to learn any more from!"))
			return
	else
		return

/obj/item/textbook/mathematics
	skilltoteach = /datum/skill/labor/mathematics
	desc = "A textbook focused on teaching mathematic notation and the applications for arithmetic, calculus, and other areas of math. The more advanced the guide, the higher the limit and the more literate you must be to study it."
	title = "mathematics"

/obj/item/textbook/apprentice/mathematics
	skilltoteach = /datum/skill/labor/mathematics
	title = "mathematics"

/obj/item/textbook/journeyman/mathematics
	skilltoteach = /datum/skill/labor/mathematics
	title = "mathematics"

/obj/item/textbook/expert/mathematics
	skilltoteach = /datum/skill/labor/mathematics
	title = "mathematics"

/obj/item/textbook/master/mathematics
	skilltoteach = /datum/skill/labor/mathematics
	title = "mathematics"
