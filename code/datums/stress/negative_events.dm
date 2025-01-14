/datum/stressevent/vice
	timer = 5 MINUTES
	stressadd = 5
	desc = list(span_boldred("I don't indulge my vice."),span_boldred("I need to sate my vice."))

/datum/stressevent/vice1
	timer = 5 MINUTES
	stressadd = 8
	desc = list("<span class='red'>I don't indulge my vice.</span>","<span class='red'>I need to sate my vice.</span>")

/datum/stressevent/vice2
	timer = 5 MINUTES
	stressadd = 10
	desc = list("<span class='red'>I don't need it. I don't need it. I don't need it.</span>","<span class='red'>I'm better than my vices.</span>")

/datum/stressevent/vice3
	timer = 5 MINUTES
	stressadd = 20
	desc = list("<span class='red'>If I don't sate my desire soon, I am going to kill myself..</span>","<span class='red'>I need it. I need it. I need it.</span>")

/*
/datum/stressevent/failcraft
	timer = 15 SECONDS
	stressadd = 1
	max_stacks = 10
	desc = "<span class='red'>I've failed to craft something.</span>"
*/
/datum/stressevent/miasmagas
	timer = 10 SECONDS
	stressadd = 2
	desc = "<span class='red'>Smells like death here.</span>"

/datum/stressevent/peckish
	timer = 10 MINUTES
	stressadd = 1
	desc = "<span class='red'>I'm peckish.</span>"

/datum/stressevent/hungry
	timer = 10 MINUTES
	stressadd = 2
	desc = "<span class='red'>I'm hungry.</span>"

/datum/stressevent/starving
	timer = 10 MINUTES
	stressadd = 5
	desc = "<span class='red'>I'm starving.</span>"

/datum/stressevent/drym
	timer = 10 MINUTES
	stressadd = 1
	desc = "<span class='red'>I'm a little thirsty.</span>"

/datum/stressevent/thirst
	timer = 10 MINUTES
	stressadd = 3
	desc = "<span class='red'>I'm thirsty.</span>"

/datum/stressevent/parched
	timer = 10 MINUTES
	stressadd = 3
	desc = "<span class='red'>I'm going to die of thirst.</span>"

/datum/stressevent/dismembered
	timer = 40 MINUTES
	stressadd = 5
	desc = "<span class='red'>I WAS USING THAT APPENDAGE!</span>"

/datum/stressevent/dwarfshaved
	timer = 40 MINUTES
	stressadd = 6
	desc = "<span class='red'>I'd rather cut my own throat than my beard.</span>"

/datum/stressevent/viewdeath
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>Death...</span>"

/datum/stressevent/viewdeath/get_desc(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.dna?.species)
			return "<span class='red'>Another [H.dna.species.id] perished.</span>"
	return desc

/datum/stressevent/viewdismember
	timer = 5 MINUTES
	stressadd = 2
	desc = "<span class='red'>I've seen men lose their limbs.</span>"

/datum/stressevent/fviewdismember
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>This land is brutal.</span>"

/datum/stressevent/viewgib
	timer = 5 MINUTES
	stressadd = 2
	desc = "<span class='red'>Battle stress is getting to me.</span>"

/datum/stressevent/bleeding
	timer = 2 MINUTES
	stressadd = 1
	desc = list("<span class='red'>I think I'm bleeding.</span>","<span class='red'>I'm bleeding.</span>")

/datum/stressevent/bleeding/can_apply(mob/living/user)
	if(user.has_flaw(/datum/charflaw/masochist))
		return FALSE
	return TRUE

/datum/stressevent/painmax
	timer = 1 MINUTES
	stressadd = 2
	desc = "<span class='red'>THE PAIN!</span>"

/datum/stressevent/painmax/can_apply(mob/living/user)
	if(user.has_flaw(/datum/charflaw/masochist))
		return FALSE
	return TRUE

/datum/stressevent/freakout
	timer = 15 SECONDS
	stressadd = 2
	desc = "<span class='red'>I'm panicking!</span>"

/datum/stressevent/felldown
	timer = 1 MINUTES
	stressadd = 1
//	desc = "<span class='red'>I fell. I'm a fool.</span>"

/datum/stressevent/uncookedfood
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>IT'S FUCKING RAW!!</span>"

/datum/stressevent/hatezizo
	timer = 99999 MINUTES
	stressadd = 666 // :)
	desc = "<span class='red'>ZIZOZIZOZIZO</span>"

/datum/stressevent/burntmeal
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>YUCK!</span>"

/datum/stressevent/rotfood
	timer = 2 MINUTES
	stressadd = 4
	desc = "<span class='red'>YUCK! MAGGOTS!</span>"

/datum/stressevent/psycurse
	timer = INFINITY
	stressadd = 5
	desc = "<span class='red'>Oh no! I've received divine punishment!</span>"

/datum/stressevent/badmeal
	timer = 3 MINUTES
	stressadd = 2
	desc = "<span class='red'>It tastes VILE!</span>"

/datum/stressevent/vomit
	timer = 3 MINUTES
	stressadd = 2
	max_stacks = 3
	stressadd_per_extra_stack = 2
	desc = "<span class='red'>I puked!</span>"

/datum/stressevent/vomitself
	timer = 3 MINUTES
	stressadd = 2
	max_stacks = 3
	stressadd_per_extra_stack = 2
	desc = "<span class='red'>I puked on myself!</span>"

/datum/stressevent/leechcult
	timer = 1 MINUTES
	stressadd = 3
	desc = list("<span class='red'>There's a little goblin in my head telling me to do things and I don't like it!</span>","<span class='red'>\"Kill your friends.\"</span>","<span class='red'>\"Make them bleed.\"</span>","<span class='red'>\"Give them no time to squeal.\"</span>","<span class='red'>\"Praise Zizo.\"</span>","<span class='red'>\"Death to the Ten.\"</span>","<span class='red'>\"The Weeper weeps his last.\"</span>")

/datum/stressevent/delf
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>A loathesome dark elf.</span>"

/datum/stressevent/tieb
	timer = 1 MINUTES
	stressadd = 1
	desc = "<span class='red'>Helldweller... better stay away.</span>"

/datum/stressevent/paracrowd
	timer = 15 SECONDS
	stressadd = 2
	desc = "<span class='red'>There are too many people who don't look like me here.</span>"

/datum/stressevent/parablood
	timer = 15 SECONDS
	stressadd = 3
	desc = "<span class='red'>There is so much blood here... it's like a battlefield!</span>"

/datum/stressevent/parastr
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>That beast is stronger... and might easily kill me!</span>"

/datum/stressevent/paratalk
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>They are plotting against me in evil tongues..</span>"

/datum/stressevent/crowd
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>Why is everyone here...? Are they trying to kill me?!</span>"

/datum/stressevent/nopeople
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>Where did everyone go? Did something happen?!</span>"

/datum/stressevent/hunted // When a hunted character sees someone in a mask
	timer = 2 MINUTES
	stressadd = 2
	desc = "<span class='red'>I can't see their face! Have they found me!?</span>"

/datum/stressevent/profane // When a non-assassin touches a profane dagger
	timer = 3 MINUTES
	stressadd = 2
	desc = "<span class='red'>I hear the voices of the damned from this cursed blade!</span>"

/datum/stressevent/coldhead
	timer = 60 SECONDS
	stressadd = 1
//	desc = "<span class='red'>My head is cold and ugly.</span>"

/datum/stressevent/sleepytime
	timer = 0
	stressadd = 1
	desc = "<span class='red'>I'm tired.</span>"

/datum/stressevent/trainsleep
	timer = 0
	stressadd = 1
	desc = "<span class='red'>My muscles ache.</span>"

/datum/stressevent/tortured
	stressadd = 3
	max_stacks = 5
	desc = "<span class='red'>I'm broken.</span>"
	timer = 60 SECONDS

/datum/stressevent/confessed
	stressadd = 3
	desc = "<span class='red'>I've confessed to sin.</span>"
	timer = 15 MINUTES

/datum/stressevent/confessedgood
	stressadd = 1
	desc = "<span class='red'>I've confessed to sin, it feels good.</span>"
	timer = 15 MINUTES

/datum/stressevent/maniac
	stressadd = 4
	desc = "<span class='red'>THE MANIAC COULD BE HERE!</span>"
	timer = 30 MINUTES

/datum/stressevent/drankrat
	stressadd = 1
	desc = "<span class='red'>I drank from a lesser creature.</span>"
	timer = 1 MINUTES

/datum/stressevent/lowvampire
	stressadd = 1
	desc = "<span class='red'>I'm dead... what comes next?</span>"

/datum/stressevent/oziumoff
	stressadd = 20
	desc = "<span class='blue'>I need another hit.</span>"
	timer = 1 MINUTES

/datum/stressevent/sleepfloor
	timer = 1 MINUTES
	stressadd = 3
	desc = "<span class='red'>I slept on the floor. It was uncomfortable.</span>"

/datum/stressevent/sleepfloornoble
	timer = 3 MINUTES
	stressadd = 6
	desc = "<span class='red'>I slept on the floor! What am I, an animal?!</span>"

/datum/stressevent/sadfate
	timer = 60 MINUTES
	stressadd = 1
	desc = "<span class='red'>I feel useless...</span>"

/datum/stressevent/saw_wonder
	stressadd = 4
	desc = span_boldred("<B>I have seen something nightmarish, and I fear for my life!</B>")
	timer = 999 MINUTES

/datum/stressevent/maniac_woke_up
	stressadd = 10
	desc = span_boldred("No... I want to go back...")
	timer = 999 MINUTES

/datum/stressevent/guillotinefail
	timer = 5 MINUTES
	stressadd = 3
	desc = span_red("This execution is horrifying!")

/datum/stressevent/guillotineexecutorfail
	timer = 15 MINUTES
	stressadd = 5
	desc = span_boldred("I have failed the guillotine drop! What a shame!")
