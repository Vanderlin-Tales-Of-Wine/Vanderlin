/obj/effect/proc_holder/spell/invoked/infestation5e
	name = "Infestation"
	desc = "Causes a swarm of bugs to surround your target, bites them and causes sickness."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 10
	recharge_time = 20 SECONDS
	range = 8
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/druidic //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Rot, take them!"
	invocation_type = "shout" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/dark = 0.3,
		/datum/attunement/death = 0.3,
	)


/obj/effect/proc_holder/spell/invoked/infestation5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_warning("[target] is surrounded by a cloud of pestilent vermin!"), span_notice("You surround [target] in a cloud of pestilent vermin!"))
		target.apply_status_effect(/datum/status_effect/buff/infestation5e/) //apply debuff
		return TRUE
	return FALSE

/datum/status_effect/buff/infestation5e
	id = "infestation"
	alert_type = /atom/movable/screen/alert/status_effect/buff/infestation5e
	duration = 5 SECONDS
	effectedstats = list("constitution" = -2)
	var/static/mutable_appearance/rotten = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")

/datum/status_effect/buff/infestation5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	to_chat(owner, span_danger("I am suddenly surrounded by a cloud of bugs!"))
	target.Jitter(20)
	target.add_overlay(rotten)
	target.update_vision_cone()

/datum/status_effect/buff/infestation5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(rotten)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/buff/infestation5e/tick()
	var/mob/living/target = owner
	var/mob/living/carbon/M = target
	target.adjustToxLoss(2)
	target.adjustBruteLoss(1)
	var/prompt = pick(1,2,3)
	var/message = pick(
		"Ticks on my skin start to engorge with blood!",
		"Flies are laying eggs in my open wounds!",
		"Something crawled in my ear!",
		"There are too many bugs to count!",
		"They're trying to get under my skin!",
		"Make it stop!",
		"Millipede legs tickle the back of my ear!",
		"Fire ants bite at my feet!",
		"A wasp sting right on the nose!",
		"Cockroaches scurry across my neck!",
		"Maggots slimily wriggle along my body!",
		"Beetles crawl over my mouth!",
		"Fleas bite my ankles!",
		"Gnats buzz around my face!",
		"Lice suck my blood!",
		"Crickets chirp in my ears!",
		"Earwigs crawl into my ears!")
	if(prompt == 1 && iscarbon(M))
		M.add_nausea(pick(10,20))
		to_chat(target, span_warning(message))
		//owner.playsound_local(get_turf(owner), 'sound/surgery/organ2.ogg', 35, FALSE, pressure_affected = FALSE)

/atom/movable/screen/alert/status_effect/buff/infestation5e
	name = "Infestation"
	desc = "Pestilent vermin bite and chew at my skin."
	icon_state = "debuff"
