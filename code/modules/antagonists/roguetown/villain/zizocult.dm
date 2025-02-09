GLOBAL_LIST_EMPTY(ritualslist)

/datum/antagonist/zizocultist
	name = "Zizoid Lackey"
	roundend_category = "zizoid cultists"
	antagpanel_category = "Zizoid Cult"
	job_rank = ROLE_ZIZOIDCULTIST
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "cultist"
	confess_lines = list(
		"DEATH TO THE TEN!",
		"PRAISE ZIZO!",
		"I AM THE FUTURE!",
		"NO GODS! ONLY MASTERS!",
	)
	var/islesser = TRUE

/datum/antagonist/zizocultist/leader
	name = "Zizoid Cultist"
	islesser = FALSE

/proc/iszizolackey(mob/living/M)
	return istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/zizocultist)

/proc/iszizocultist(mob/living/M)
	return istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/zizocultist/leader)

/datum/antagonist/zizocultist/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/zizocultist/leader))
		return "<span class='boldnotice'>OUR LEADER!</span>"
	if(istype(examined_datum, /datum/antagonist/zizocultist))
		return "<span class='boldnotice'>A lackey for the future.</span>"
	if(istype(examined_datum, /datum/antagonist/assassin))
		return "<span class='boldnotice'>A GRAGGAROID! A CULTIST OF GRAGGAR!</span>"

/datum/antagonist/zizocultist/on_gain()
	. = ..()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/mob/living/carbon/human/H = owner.current
	C.cultists |= owner
	H.set_patron(/datum/patron/inhumen/zizo)

	owner.special_role = "Zizoid Lackey"
	H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
	owner.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/maniac.ogg', 80, FALSE, pressure_affected = FALSE)
	owner.current.verbs |= /mob/living/carbon/human/proc/praise
	owner.current.verbs |= /mob/living/carbon/human/proc/communicate
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_VILLAIN, TRAIT_GENERIC)

	H.change_stat("strength", 2)

	if(islesser)
		add_objective(/datum/objective/zizoserve)
		owner.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.change_stat("intelligence", -2)
		greet()
	else
		add_objective(/datum/objective/zizo)
		owner.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		owner.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("speed", 1)
		greet()
		owner.special_role = ROLE_ZIZOIDCULTIST
		owner.current.verbs |= /mob/living/carbon/human/proc/draw_sigil
		owner.current.verbs |= /mob/living/carbon/human/proc/release_minion

/datum/antagonist/zizocultist/greet()
	to_chat(owner, "<span class='danger'>I'm a lackey to the LEADER. A new future begins.</span>")
	owner.announce_objectives()

/datum/antagonist/zizocultist/leader/greet()
	to_chat(owner, "<span class='danger'>I'm a cultist to the ALMIGHTY. They call it the UNSPEAKABLE. I require LACKEYS to make my RITUALS easier. I SHALL ASCEND.</span>")
	owner.announce_objectives()

/datum/antagonist/zizocultist/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(.)
		if(new_owner.current == SSticker.rulermob)
			return FALSE
		if(new_owner.assigned_role in GLOB.noble_positions)
			return FALSE
		if(new_owner.assigned_role in GLOB.garrison_positions)
			return FALSE
		if(new_owner.assigned_role in GLOB.church_positions)
			return FALSE
		if(new_owner.unconvertable)
			return FALSE
		if(new_owner.current && HAS_TRAIT(new_owner.current, TRAIT_MINDSHIELD))
			return FALSE

/datum/antagonist/zizocultist/proc/add_cultist(datum/mind/cult_mind)
	cult_mind.add_antag_datum(/datum/antagonist/zizocultist)
	return TRUE

/datum/objective/zizo
	name = "ASCEND"
	explanation_text = "Ensure that I ascend."
	team_explanation_text = "Ensure that I ascend."
	triumph_count = 5

/datum/objective/zizo/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.cultascended)
		return TRUE

/datum/objective/zizoserve
	name = "Serve your Leader"
	explanation_text = "Serve your leader and ensure that they ascend."
	team_explanation_text = "Serve your leader and ensure that they ascend."
	triumph_count = 3

/datum/objective/zizoserve/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.cultascended)
		return TRUE

/datum/antagonist/zizocultist/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

/datum/antagonist/zizocultist/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/zizocultist/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(islesser) // don't need to spam up the chat with all spawn
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count
	else
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, "<span class='greentext'>The [special_role_text] has TRIUMPHED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, "<span class='redtext'>The [special_role_text] has FAILED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

// VERBS

/mob/living/carbon/human/proc/praise()
	set name = "Praise the Dark Lady!"
	set category = "ZIZO"

	if(stat >= UNCONSCIOUS || !can_speak_vocal())
		return
	audible_message("\The [src] praises <span class='bold'>Zizo</span>!")
	playsound(src.loc, 'sound/vo/cult/praise.ogg', 45, 1)

/mob/living/carbon/human/proc/communicate()
	set name = "Communicate with Cult"
	set category = "ZIZO"

	if(stat >= UNCONSCIOUS || !can_speak_vocal())
		return
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/speak = input("What do you speak of?", "VANDERLIN") as text|null
	if(!speak)
		return
	whisper("O schlet'a ty'schkotot ty'skvoro...")
	sleep(5)
	if(stat >= UNCONSCIOUS || !can_speak_vocal())
		return
	whisper("[speak]")

	for(var/datum/mind/V in C.cultists)
		to_chat(V, "<span class='boldnotice'>A message from [src.real_name]: \"[speak]\"</span>")
		playsound_local(V.current, 'sound/vo/cult/skvor.ogg', 100)

	testing("[key_name(src)] used cultist telepathy to say: [speak]")
	log_telepathy("[key_name(src)] used cultist telepathy to say: [speak]")

/obj/effect/decal/cleanable/sigil
	name = "sigils"
	desc = "Strange runics."
	icon_state = "center"
	icon = 'icons/obj/sigils.dmi'
	var/sigil_type

/obj/effect/decal/cleanable/sigil/examine(mob/user)
	. = ..()
	if(!sigil_type)
		return

	if(iszizocultist(user) || iszizolackey(user))
		to_chat(user, "It is of the [sigil_type] circle.")

/obj/effect/decal/cleanable/sigil/Initialize(mapload)
	. = ..()
	if(!LAZYLEN(GLOB.ritualslist))
		testing("initializing ritualslist")
		GLOB.ritualslist = list()
		var/static/list/rituals = subtypesof(/datum/ritual)
		for(var/path in rituals)
			var/datum/ritual/G = path
			testing("now initializing: [path]")
			testing("[G.name]")
			GLOB.ritualslist[G.name] = G

/obj/effect/decal/cleanable/sigil/proc/consume_ingredients(datum/ritual/R)

	for(var/atom/A in get_step(src, NORTH))
		if(istype(A, R.n_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in get_step(src, SOUTH))
		if(istype(A, R.s_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in get_step(src, EAST))
		if(istype(A, R.e_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in get_step(src, WEST))
		if(istype(A, R.w_req) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

	for(var/atom/A in loc.contents)
		if(istype(A, R.center_requirement) && !ishuman(A))
			playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(A)

/obj/effect/decal/cleanable/sigil/attack_hand(mob/living/user)
	. = ..()
	testing("clicked by [user]")
	var/list/rituals = list()
	if(icon_state != "center") // fucking awful but it has to be this way
		return
	if(iszizocultist(user) || iszizolackey(user))
		for(var/G in GLOB.ritualslist)
			var/datum/ritual/path = GLOB.ritualslist[G]
			if(path.circle == sigil_type)
				rituals |= path.name

		var/ritualnameinput = input(user, "Rituals", "VANDERLIN") as null|anything in rituals
		testing("ritualnameinput [ritualnameinput]")
		var/datum/ritual/pickritual

		pickritual = GLOB.ritualslist[ritualnameinput]
		testing("pickritual [pickritual]")

		var/cardinal_success = FALSE
		var/center_success = FALSE

		if(!pickritual)
			return

		var/dews = 0

		if(pickritual.e_req)
			for(var/atom/A in get_step(src, EAST))
				if(istype(A, pickritual.e_req))
					dews++
					break
				else
					continue
		else
			dews++

		if(pickritual.s_req)
			for(var/atom/A in get_step(src, SOUTH))
				if(istype(A, pickritual.s_req))
					dews++
					break
				else
					continue
		else
			dews++

		if(pickritual.w_req)
			for(var/atom/A in get_step(src, WEST))
				if(istype(A, pickritual.w_req))
					dews++
					break
				else
					continue
		else
			dews++

		if(pickritual.n_req)
			for(var/atom/A in get_step(src, NORTH))
				if(istype(A, pickritual.n_req))
					dews++
					break
				else
					continue
		else
			dews++

		if(dews >= 4)
			cardinal_success = TRUE
			testing("CARDINAL SUCCESS!")

		for(var/atom/A in loc.contents)
			if(!istype(A, pickritual.center_requirement))
				continue
			else
				center_success = TRUE
				testing("CENTER SUCCESS!")
				break

		var/badritualpunishment = FALSE
		if(cardinal_success != TRUE)
			if(badritualpunishment)
				return
			to_chat(user.mind, "<span class='danger'>\"That's not how you do it, fool.\"</span>")
			user.electrocute_act(10, src)
			return

		if(center_success != TRUE)
			if(badritualpunishment)
				return
			to_chat(user.mind, "<span class='danger'>\"That's not how you do it, fool.\"</span>")
			user.electrocute_act(10, src)
			return

		testing("Now calling proc")
		consume_ingredients(pickritual)
		user.playsound_local(user, 'sound/vo/cult/tesa.ogg', 25)
		user.whisper("O'vena tesa...")
		call(pickritual.function)(user, loc)

/obj/effect/decal/cleanable/sigil/N
	icon_state = "N"

/obj/effect/decal/cleanable/sigil/NE
	icon_state = "NE"

/obj/effect/decal/cleanable/sigil/E
	icon_state = "E"

/obj/effect/decal/cleanable/sigil/SE
	icon_state = "SE"

/obj/effect/decal/cleanable/sigil/S
	icon_state = "S"

/obj/effect/decal/cleanable/sigil/SW
	icon_state = "SW"

/obj/effect/decal/cleanable/sigil/W
	icon_state = "W"

/obj/effect/decal/cleanable/sigil/NW
	icon_state = "NW"

/turf/open/floor/proc/generateSigils(mob/M, input)
	var/turf/T = get_turf(M.loc)
	for(var/obj/A in T)
		if(istype(A, /obj/effect/decal/cleanable/sigil))
			to_chat(M, "<span class='warning'>There is already a sigil here.</span>")
			return
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(M, "<span class='warning'>There is already something here!</span>")
			return
	if(do_after(M, 5 SECONDS))
		M.bloody_hands--
		M.update_inv_gloves()
		var/obj/effect/decal/cleanable/sigil/C = new(src)
		C.sigil_type = input
		playsound(M, 'sound/items/write.ogg', 100)
		var/list/sigilsPath = list(
			/obj/effect/decal/cleanable/sigil/N,
			/obj/effect/decal/cleanable/sigil/S,
			/obj/effect/decal/cleanable/sigil/E,
			/obj/effect/decal/cleanable/sigil/W,
			/obj/effect/decal/cleanable/sigil/NE,
			/obj/effect/decal/cleanable/sigil/NW,
			/obj/effect/decal/cleanable/sigil/SE,
			/obj/effect/decal/cleanable/sigil/SW
		)

		for(var/i = 1; i <= GLOB.alldirs.len; i++)
			var/turf/floor = get_step(src, GLOB.alldirs[i])
			var/sigil = sigilsPath[i]

			new sigil(floor)

/mob/living/carbon/human/proc/draw_sigil()
	set name = "Draw Sigil"
	set category = "ZIZO"

	var/list/runes = list("Servantry", "Transmutation", "Fleshcrafting")

	if(!bloody_hands)
		to_chat(src, "<span class='danger'>My hands aren't bloody enough.</span>")
		return

	var/input = input("Sigil Type", "VANDERLIN") as null|anything in runes
	if(!input)
		return

	var/turf/open/floor/T = get_turf(src.loc)
	T.generateSigils(src, input)

/mob/living/carbon/human/proc/release_minion()
	set name = "Release Lackey"
	set category = "ZIZO"

	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/mob/living/carbon/human/possible = list()
	for(var/datum/mind/V in C.cultists)
		if(V.special_role == "Zizoid Lackey")
			possible |= V.current

	var/mob/living/carbon/human/choice = input(src, "Whom do you no longer have use for?", "VANDERLIN") as null|anything in possible
	if(choice)
		var/alert = alert(src, "Are you sure?", "VANDERLIN", "Yes", "Cancel")
		if(alert == "Yes")
			visible_message("<span class='danger'>[src] reaches out, ripping up [choice]'s soul!</span>")
			to_chat(choice, "<span class='userdanger'>I HAVE FAILED MY LEADER! I HAVE FAILED ZIZO! NOTHING ELSE BUT DEATH REMAINS FOR ME NOW!</span>")
			sleep(20)
			choice.gib() // Cooler than dusting.
			C.cultists -= choice.mind

// RITUAL DATUMS

/datum/ritual
	var/name = "DVRK AND EVIL RITVAL"
	var/circle = null // Servantry, Transmutation, Fleshcrafting
	var/center_requirement = /obj/item
	// This is absolutely fucking terrible. I tried to do it with lists but it just didn't work and
	//kept runtiming. Something something, can't access list inside a datum.
	//I couldn't find a more efficient solution to do this, I'm sorry. -7
	var/n_req = null
	var/e_req = null
	var/s_req = null
	var/w_req = null
	var/function // a proc


// SERVANTRY

/datum/ritual/convert
	name = "Convert"
	circle = "Servantry"
	center_requirement = /mob/living/carbon/human

	function = /proc/convert_cultist

/proc/convert_cultist(mob/user, turf/C)
	var/datum/game_mode/chaosmode/M = SSticker.mode
	testing("NOW TESTING CONVERT")

	for(var/mob/living/carbon/human/H in C.contents)
		if(H != user)
			if(iszizocultist(H) || iszizolackey(H))
				return
			if(!H.client)
				return
			if(H.anchored) // a way to bind the person to the rune if they choose to resist converting
				return
			if(istype(H.wear_neck, /obj/item/clothing/neck/roguetown/psycross))
				to_chat(user.mind, "<span class='danger'>\"They are wearing my bane...\"</span>")
				return
			if(M.cultists.len >= 8)
				to_chat(user.mind, "<span class='danger'>\"The veil is too strong to support more than seven lackeys.\"</span>")
				return
			var/datum/antagonist/zizocultist/PR = user.mind.has_antag_datum(/datum/antagonist/zizocultist)
			var/alert = alert(H, "YOU WILL BE SHOWN THE TRUTH. DO YOU RESIST? (Resisting: 1 TRI)", "VANDERLIN", "Yield", "Resist")
			H.anchored = TRUE
			if(alert == "Yield")
				to_chat(H.mind, "<span class='notice'>I see the truth now! It all makes so much sense! They aren't HERETICS! They want the BEST FOR US!</span>")
				PR.add_cultist(H.mind)
				H.praise()
				H.anchored = FALSE
			else
				H.adjust_triumphs(-1)
				H.visible_message("<span class='danger'>\The [H] thrashes around, unyielding!</span>")
				to_chat(H.mind, "<span class='danger'>\"Yield.\"</span>")
				if(H.electrocute_act(10))
					H.emote("painscream")
				sleep(20)
				H.anchored = FALSE

/datum/ritual/skeletaljaunt
	name = "Skeletal Jaunt"
	circle = "Servantry"
	center_requirement = /mob/living/carbon/human

	n_req = /obj/item/organ/heart

	function = /proc/skeletaljaunt

/proc/skeletaljaunt(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H == user)
			return
		if(iszizocultist(H))
			to_chat(H.mind, "<span class='danger'>\"I'm not gonna let my strongest follower become a mindless brute.\"</span>")
			return
		if(H.mind)
			H.mind.special_role = "Cult Summon"
			H.mind.assigned_role = "Cult Summon"
			H.mind.current.job = null
		H.dna.species.species_traits |= NOBLOOD
		H.dna.species.soundpack_m = new /datum/voicepack/skeleton()
		H.dna.species.soundpack_f = new /datum/voicepack/skeleton()
		var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = H.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		H.regenerate_limb(BODY_ZONE_R_ARM)
		H.regenerate_limb(BODY_ZONE_L_ARM)
		for(var/obj/item/bodypart/BP in H.bodyparts)
			BP.skeletonize()
		H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
		H.update_a_intents()
		H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
		H.set_patron(/datum/patron/inhumen/zizo)
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.ambushable = FALSE
		H.underwear = "Nude"
		if(H.charflaw)
			QDEL_NULL(H.charflaw)
		H.update_body()
		H.mob_biotypes = MOB_UNDEAD
		H.faction = list("undead")

		H.TOTALSPD = rand(7,10)
		H.TOTALINT = 1
		H.TOTALCON = 3
		H.TOTALSTR = rand(8,17)

		H.verbs |= /mob/living/carbon/human/proc/praise
		H.verbs |= /mob/living/carbon/human/proc/communicate

		ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSTAMINA, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
		to_chat(H, "<span class='userdanger'>I am returned to serve. I will obey, so that I may return to rest.</span>")
		to_chat(H, "<span class='userdanger'>My master is [user].</span>")
		break

/datum/ritual/thecall
	name = "The Call"
	circle = "Servantry"
	center_requirement = /obj/item/bedsheet/rogue

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg

	function = /proc/thecall

/proc/thecall(mob/user, turf/C)
	for(var/obj/item/paper/P in C.contents)
		if(!user.mind || !user.mind.do_i_know(name=P.info))
			to_chat(user.mind, "<span class='warning'>I don't know anyone by that name.</span>")
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == P.info)
				if(HL.has_status_effect(/datum/status_effect/debuff/sleepytime))
					if(HL.mind.assigned_role in GLOB.church_positions)
						to_chat(HL.mind, "<span class='warning'>I sense an unholy presence loom near my soul.</span>")
						return
					if(HL == SSticker.rulermob)
						return
					if(istype(HL.wear_neck, /obj/item/clothing/neck/roguetown/psycross))
						return
					if(HAS_TRAIT(HL, TRAIT_NOSTAMINA))
						return
					to_chat(HL.mind, "<span class='warning'>I'm so sleepy...</span>")
					HL.SetSleeping(30)
					spawn(10 SECONDS)
						to_chat(HL.mind, "<span class='warning'>This isn't my bed... Where am I?!</span>")
						HL.playsound_local(HL.loc, pick('sound/misc/jumphumans (1).ogg','sound/misc/jumphumans (2).ogg','sound/misc/jumphumans (3).ogg'), 100)
						HL.forceMove(C)
					qdel(P)

/datum/ritual/falseappearance
	name = "Falsified Appearance"
	circle = "Servantry"
	center_requirement = /mob/living/carbon/human

	n_req = /obj/item/bodypart/head
	s_req = /obj/item/natural/glass/shard
	e_req = /obj/item/natural/glass/shard
	w_req = /obj/item/natural/glass/shard

	function = /proc/falseappearance

/proc/falseappearance(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/datum/preferences/A = new()//Randomize appearance for the guy
		var/first_names = GLOB.first_names
		if(H.gender == FEMALE)
			first_names = GLOB.first_names_female
		else
			first_names = GLOB.first_names_male
		A.real_name = "[pick(first_names)]"
		A.copy_to(H)
		H.dna.update_dna_identity()
		break

/datum/ritual/heartache
	name = "Heartaches"
	circle = "Servantry"
	center_requirement = /obj/item/organ/heart

	n_req = /obj/item/natural/worms/leech

	function = /proc/heartache

/obj/item/corruptedheart
	name = "corrupted heart"
	desc = "It sparkles with forbidden magic energy. It makes all the heart aches go away."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "heart-on"

/obj/item/corruptedheart/attack(mob/living/M, mob/living/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(iszizocultist(H) || iszizolackey(H))
			H.blood_volume = BLOOD_VOLUME_MAXIMUM
			to_chat(H, "<span class='notice'>My elixir of life is stagnant once again.</span>")
			qdel(src)
		else
			if(!do_after(user, 2 SECONDS, H))
				return
			if(M.cmode)
				user.electrocute_act(30)
			H.electrocute_act(20)
			H.Stun(10 SECONDS)
			H.silent += 30
			qdel(src)

/proc/heartache(mob/user, turf/C)
	new /obj/item/corruptedheart(C)
	to_chat(user.mind, "<span class='notice'>A corrupted heart. When used on a non-enlightened mortal their heart shall ache and they will be immobilized and too stunned to speak. Perfect for getting new soon-to-be enlightened. Now, just don't use it at the combat ready.</span>")

/datum/ritual/darksunmark
	name = "Dark Sun's Mark"
	circle = "Servantry"
	center_requirement = /obj/item/rogueweapon/knife/dagger // Requires a combat dagger. Can be iron, steel or silver.

	function = /proc/darksunmark

/proc/darksunmark(mob/user, turf/C)
	var/found_assassin = FALSE
	for(var/obj/item/paper/P in C.contents)
		if(!user.mind || !user.mind.do_i_know(name=P.info))
			to_chat(user, "<span class='warning'>I don't know anyone by that name.</span>")
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == P.info)
				for (var/mob/living/carbon/carbon in GLOB.carbon_list) // Iterate through all mobs in the world
					if (HAS_TRAIT(carbon, TRAIT_ASSASSIN) && !(carbon.stat == DEAD)) //Check if they are an assassin and alive
						found_assassin = TRUE
						for(var/obj/item/I in carbon.get_all_gear()) // Checks to see if the assassin has their dagger on them. If so, the dagger will let them know of a new target.
							if(istype(I, /obj/item/rogueweapon/knife/dagger/steel/profane)) // Checks to see if the assassin has their dagger on them.
								// carbon.visible_message("profane dagger whispers, <span class='danger'>\"The terrible Zizo has called for our aid. Hunt and strike down our common foe, [HL.real_name]!\"</span>")
								to_chat(carbon, "profane dagger whispers, <span class='danger'>\"The terrible Zizo has called for our aid. Hunt and strike down our common foe, [HL.real_name]!\"</span>")
				if(found_assassin == TRUE)
					ADD_TRAIT(HL, TRAIT_ZIZOID_HUNTED, TRAIT_GENERIC) // Gives the victim a trait to track that they are wanted dead.
					log_hunted("[key_name(HL)] playing as [HL] had the hunted flaw by Zizoid curse.")
					to_chat(HL, "<span class='danger'>My hair stands on end. Has someone just said my name? I should watch my back.</span>")
					to_chat(user, "<span class='warning'>Your target has been marked, your profane call answered by the Dark Sun. [HL.real_name] will surely perish!</span>")
					for(var/obj/item/rogueweapon/knife/dagger/D in C.contents) // Get rid of the dagger used as a sacrifice.
						qdel(D)
					qdel(P) // Get rid of the paper with the name on it too.
					HL.playsound_local(HL.loc, 'sound/magic/marked.ogg', 100)
				else
					to_chat(user, "<span class='warning'>There has been no answer to your call to the Dark Sun. It seems his servants are far from here...</span>")
				return

// TRANSMUTATION

/datum/ritual/allseeingeye
	name = "All-seeing Eye"
	circle = "Transmutation"
	center_requirement = /obj/item/organ/eyes

	function = /proc/allseeingeye

/proc/allseeingeye(mob/user, turf/C)
	new /obj/item/scrying/eye(C)

/datum/ritual/criminalstool
	name = "Criminal's Tool"
	circle = "Transmutation"
	center_requirement = /obj/item/natural/cloth

	function = /proc/criminalstool

/obj/item/soap/cult
	name = "accursed soap"
	desc = "It is pulsating."
	uses = 9
	cleanspeed = 1

/proc/criminalstool(mob/user, turf/C)
	new /obj/item/soap/cult(C)
	to_chat(user.mind, "<span class='notice'>The Criminal's Tool. Could be useful for hiding tracks or getting rid of sigils.</span>")

/datum/ritual/propaganda
	name = "Propaganda"
	circle = "Transmutation"
	center_requirement = /obj/item/natural/worms/leech
	n_req = /obj/item/paper
	s_req = /obj/item/natural/feather

	function = /proc/propaganda

/proc/propaganda(mob/user, turf/C)
	new /obj/item/natural/worms/leech/propaganda(C)
	to_chat(user.mind, "<span class='notice'>A leech to make their minds wrangled. They'll be in bad spirits.</span>")

/datum/ritual/falseidol
	name = "False Idol"
	circle = "Transmutation"
	center_requirement = /mob/living/carbon/human
	w_req = /obj/item/paper
	s_req = /obj/item/natural/feather

	function = /proc/falseidol

/obj/effect/dummy/falseidol
	name = "false idol"
	icon = 'icons/effects/effects.dmi'
	icon_state = "static"
	desc = "Through lies interwine from blood into truth."

/obj/effect/dummy/falseidol/Crossed(atom/movable/AM, oldloc)
	. = ..()
	qdel(src)

/proc/falseidol(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/obj/effect/dummy/falseidol/idol = new(C)
		var/datum/icon_snapshot/entry = new
		entry.name = H.name
		entry.icon = H.icon
		entry.icon_state = H.icon_state
		entry.overlays = H.get_overlays_copy(list(HANDS_LAYER))	//ugh
		sleep(10)
		idol.name = entry.name
		idol.icon = entry.icon
		idol.icon_state = entry.icon_state
		idol.add_overlay(entry.overlays)
		break

/datum/ritual/invademind
	name = "Invade Mind"
	circle = "Transmutation"
	center_requirement = /obj/item/natural/feather

	function = /proc/invademind

/proc/invademind(mob/user, turf/C)
	for(var/obj/item/paper/P in C.contents)
		var/info = ""
		info = sanitize(P.info)
		var/input = stripped_input(user, "To whom do we send this message?", "VANDERLIN")
		if(!input)
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == input)
				qdel(P)
				to_chat(HL, "<i>You hear a voice in your head... <b>[info]</i></b>")
		break

/datum/ritual/summonweapons
	name = "Summon Weaponry"
	circle = "Transmutation"
	center_requirement = /obj/item/ingot/steel

	function = /proc/summonweapons

/proc/summonweapons(mob/user, turf/C)
	var/datum/effect_system/spark_spread/S = new(C)
	S.set_up(1, 1, C)
	S.start()

	new /obj/item/clothing/head/roguetown/helmet/skullcap/cult(C)
	new /obj/item/clothing/head/roguetown/helmet/skullcap/cult(C)

	new /obj/item/clothing/cloak/half/shadowcloak/cult(C)
	new /obj/item/clothing/cloak/half/shadowcloak/cult(C)

	new /obj/item/rogueweapon/sword/scimitar/falchion(C)
	new /obj/item/rogueweapon/knife/hunting(C)
	new /obj/item/rogueweapon/mace/spiked(C)

	new /obj/item/rope/chain(C)
	new /obj/item/rope/chain(C)

	playsound(C,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

// FLESH CRAFTING

/datum/ritual/bunnylegs
	name = "Saliendo Pedes"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/bunnylegs

/proc/bunnylegs(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
		to_chat(H.mind, "<span class='notice'>I feel like my legs have become stronger.</span>")
		break

/datum/ritual/fleshmend
	name = "Fleshmend"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human
	n_req =  /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/fleshmend

/proc/fleshmend(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		H.fully_heal()
		to_chat(H.mind, "<span class='notice'>ZIZO EMPOWERS ME!</span>")
		break

/datum/ritual/darkeyes
	name = "Darkened Eyes"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/eyes
	e_req = /obj/item/organ/eyes
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/darkeyes

/proc/darkeyes(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		to_chat(H.mind, "<span class='notice'>I no longer fear the dark.</span>")
		break

/datum/ritual/nopain
	name = "Painless Battle"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/heart
	e_req = /obj/item/organ/brain
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/nopain

/proc/nopain(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(user, TRAIT_NOPAIN, TRAIT_GENERIC)
		to_chat(H.mind, "<span class='notice'>I no longer feel pain, but it has come at a terrible cost.</span>")
		H.change_stat("strength", -2)
		H.change_stat("constitution", -3)
		break

/datum/ritual/fleshform
	name = "Stronger Form"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/guts
	e_req = /obj/item/organ/guts
	n_req = /obj/item/reagent_containers/food/snacks/rogue/meat
	s_req = /obj/item/reagent_containers/food/snacks/rogue/meat

	function = /proc/fleshform

/proc/fleshform(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(iszizocultist(H))
			to_chat(H.mind, "<span class='danger'>\"I'm not letting my strongest follower become a mindless brute.\"</span>")
			return
		to_chat(user.mind, "<span class='danger'>SOON I WILL BECOME A HIGHER FORM!!!</span>")
		sleep(5 SECONDS)
		var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/rogue/blood(H)
		trl.forceMove(H)
		trl.ckey = H.ckey
		H.gib()

/datum/ritual/gutted
	name = "Gutted Fish"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human // One to be gutted.human

	function = /proc/guttedlikeafish

/proc/guttedlikeafish(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.stat == DEAD)
			H.take_overall_damage(500)
			C.visible_message("<span class='danger'>[H.real_name] is lifted up into the air and multiple scratches, incisions and deep cuts start etching themselves into their skin as all of their internal organs spill on the floor below!</span>")

			var/atom/drop_location = H.drop_location()
			for(var/obj/item/organ/organ as anything in H.internal_organs)
				organ.Remove(H)
				organ.forceMove(drop_location)
			var/obj/item/bodypart/chest/cavity = H.get_bodypart(BODY_ZONE_CHEST)
			if(cavity.cavity_item)
				cavity.cavity_item.forceMove(drop_location)
				cavity.cavity_item = null

/datum/ritual/badomen
	name = "Bad Omen"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	function = /proc/badomenzizo

/proc/badomenzizo(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.stat == DEAD)
			H.gib(FALSE, FALSE, FALSE)
			addomen(OMEN_ROUNDSTART)

/datum/ritual/ascend
	name = "ASCEND!"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human // cult leader

	n_req = /mob/living/carbon/human // the ruler
	s_req = /mob/living/carbon/human // virgin

	function = /proc/ascend

/proc/ascend(mob/user, turf/C)
	var/datum/game_mode/chaosmode/CM = SSticker.mode

	for(var/mob/living/carbon/human/H in C.contents)
		if(!iszizocultist(H))
			return
		for(var/mob/living/carbon/human/RULER in get_step(C, NORTH))
		for(var/mob/living/carbon/human/RULER in get_step(C, NORTH))
			if(RULER != SSticker.rulermob && RULER.stat != DEAD)
				break
			RULER.gib()
		for(var/mob/living/carbon/human/VIRGIN in get_step(C, SOUTH))
		for(var/mob/living/carbon/human/VIRGIN in get_step(C, SOUTH))
			if(!VIRGIN.virginity && VIRGIN.stat != DEAD)
				break
			VIRGIN.gib()
		CM.cultascended = TRUE
		addomen(OMEN_ASCEND)
		to_chat(user.mind, "<span class='userdanger'>I HAVE DONE IT! I HAVE REACHED A HIGHER FORM! ZIZO SMILES UPON ME WITH MALICE IN HER EYES TOWARD THE ONES WHO LACK KNOWLEDGE AND UNDERSTANDING!</span>")
		var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/rogue/blood/ascended(C)
		trl.ckey = H.ckey
		H.gib()
		to_chat(world, "\n<font color='purple'>15 minutes remain.</font>")
		for(var/mob/living/carbon/human/V in GLOB.human_list)
			if(V.mind in CM.cultists)
				V.add_stress(/datum/stressevent/lovezizo)
			else
				V.add_stress(/datum/stressevent/hatezizo)
		CM.roundvoteend = TRUE
		break
