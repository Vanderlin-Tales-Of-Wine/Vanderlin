/obj/effect/proc_holder/spell/invoked/mimicry
	name = "Mimicry"
	desc = "Takes on the appearance of your target."
	overlay_state = "invisibility"
	releasedrain = 20
	chargedrain = 1
	chargetime = 4 SECONDS
	recharge_time = 300 SECONDS
	range = 1
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/dark = 0.4,
		/datum/attunement/polymorph = 1.2,
		)
	var/datum/dna/old_dna
	var/old_hair
	var/old_hair_color
	var/old_eye_color
	var/old_facial_hair
	var/old_facial_hair_color
	var/old_gender
	var/transformed = FALSE

/obj/effect/proc_holder/spell/invoked/mimicry/on_gain(mob/living/carbon/human/user)
	. = ..()
	old_dna = user.dna
	old_hair = user.hairstyle
	old_hair_color = user.hair_color
	old_eye_color = user.eye_color
	old_facial_hair_color = user.facial_hair_color
	old_facial_hair = user.facial_hair_color
	old_gender = user.gender

/obj/effect/proc_holder/spell/invoked/mimicry/cast(list/targets, mob/living/user)
	if(transformed)
		addtimer(CALLBACK(src, PROC_REF(return_to_normal), user), 5 SECONDS)
	if (ishuman(targets[1]))
		if(targets[1] == user)
			return FALSE
		to_chat(user, "You have memorized [targets[1]] face in 5 seconds you will attempt to transform into them.")
		addtimer(CALLBACK(src, PROC_REF(try_transform), targets[1], user), 5 SECONDS)
		return TRUE

	return FALSE

/obj/effect/proc_holder/spell/invoked/mimicry/proc/try_transform(mob/living/carbon/human/target, mob/living/carbon/human/user)
	visible_message("[user]'s skin starts to shift.")
	if(!do_after(user, 10 SECONDS, target = user))
		return
	target.dna.transfer_identity(user)
	user.updateappearance(mutcolor_update = TRUE)
	user.real_name = target.dna.real_name
	user.name = target.get_visible_name()
	user.gender = target.gender

	var/picked = FALSE
	if(prob(40))
		user.eye_color = target.eye_color
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.hair_color = target.hair_color
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.hairstyle = target.hairstyle
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.facial_hair_color = target.facial_hair_color
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.facial_hairstyle = target.facial_hairstyle
	else
		picked = TRUE


	user.updateappearance(mutcolor_update = TRUE)

/obj/effect/proc_holder/spell/invoked/mimicry/proc/return_to_normal(mob/living/carbon/human/user)
	visible_message("[user]'s skin starts to shift.")
	user.Immobilize(4 SECONDS)
	if(!do_after(user, 10 SECONDS, target = user))
		return
	old_dna.transfer_identity(user)
	user.real_name = old_dna.real_name
	user.name = user.get_visible_name()
	user.gender = old_gender

	user.hair_color = old_hair_color
	user.eye_color = old_eye_color
	user.hairstyle = old_hair
	user.facial_hair_color = old_facial_hair_color
	user.facial_hairstyle = old_facial_hair

	user.updateappearance(mutcolor_update = TRUE)
