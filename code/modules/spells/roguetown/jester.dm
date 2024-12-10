/obj/effect/proc_holder/spell/self/telljoke
	name = "Comedia"
	desc = "Say something funny to someone in high spirits, it will brighten their mood."
	overlay_state = "comedy"
	antimagic_allowed = TRUE
	invocation_type = "shout"
	charge_max = 1 MINUTES

/obj/effect/proc_holder/spell/self/telljoke/cast(list/targets,mob/user = usr)
	..()
	var/joker = input(user, "Say something funny!", "Comedia")
	if(!joker)
		return FALSE
	user.say(joker, forced = "spell")
	sleep(20)
	playsound(get_turf(user), 'sound/magic/comedy.ogg', 100)
	for(var/mob/living/carbon/CA in view(7, get_turf(user)))
		if(CA == user)
			continue
		if(CA.cmode)
			continue
		if(CA.stress <= 0)
			CA.add_stress(/datum/stressevent/joke)
			CA.emote(pick("laugh","chuckle","giggle"), forced = TRUE)
		sleep(rand(1,5))

/obj/effect/proc_holder/spell/self/telltragedy
	name = "Tragedia"
	desc = "Remind someone in low spirits that it could be much worse."
	overlay_state = "tragedy"
	antimagic_allowed = TRUE
	invocation_type = "shout"
	charge_max = 1 MINUTES

/obj/effect/proc_holder/spell/self/telltragedy/cast(list/targets,mob/user = usr)
	..()
	var/joker = input(user, "Say something sad!", "Tragedia")
	if(!joker)
		return FALSE
	user.say(joker, forced = "spell")
	sleep(20)
	playsound(get_turf(user), 'sound/magic/tragedy.ogg', 100)
	for(var/mob/living/carbon/CA in view(7, get_turf(user)))
		if(CA == user)
			continue
		if(CA.cmode)
			continue
		if(CA.stress > 0)
			CA.add_stress(/datum/stressevent/tragedy)
			CA.emote(pick("sigh","hmm"), forced = TRUE)
		sleep(rand(1,5))

/obj/effect/proc_holder/spell/self/fart
	name = "Fart"
	desc = "Unleash a vile sound."
	overlay_state = "orison"
	antimagic_allowed = TRUE
	invocation_type = "shout"
	charge_max = 1 MINUTES

/obj/effect/proc_holder/spell/self/fart/cast(list/targets, mob/user = usr)
	..()
	var/fard = pick('sound/vo/fart1.ogg','sound/vo/fart2.ogg','sound/vo/fart3.ogg')
	user.emote("me",1,"grits their teeth and farts!",TRUE, custom_me = TRUE)
	sleep(10)
	playsound(get_turf(user), fard, 150)
