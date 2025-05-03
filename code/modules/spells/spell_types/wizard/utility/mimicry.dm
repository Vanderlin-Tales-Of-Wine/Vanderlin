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
	var/datum/bodypart_feature/hair/feature = user.get_bodypart_feature_of_slot(BODYPART_FEATURE_HAIR)
	var/datum/bodypart_feature/hair/facial = user.get_bodypart_feature_of_slot(BODYPART_FEATURE_FACIAL_HAIR)
	old_dna = user.dna
	old_hair = feature?.accessory_type
	old_hair_color = user.get_hair_color()
	old_eye_color = user.get_eye_color()
	old_facial_hair_color = user.get_facial_hair_color()
	old_facial_hair = facial?.accessory_type
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

	var/datum/bodypart_feature/hair/target_feature = target.get_bodypart_feature_of_slot(BODYPART_FEATURE_HAIR)
	var/datum/bodypart_feature/hair/target_facial = target.get_bodypart_feature_of_slot(BODYPART_FEATURE_FACIAL_HAIR)

	var/picked = FALSE
	if(prob(40))
		var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
		eyes.eye_color = target.get_eye_color()
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.set_hair_color(target.get_hair_color(), FALSE)
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.set_hair_style(target_feature?.accessory_type, FALSE)
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.set_facial_hair_color(target.get_facial_hair_color(), FALSE)
	else
		picked = TRUE

	if(prob(70) && !picked)
		user.set_facial_hair_style(target_facial?.accessory_type, FALSE)
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
	var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)

	eyes.eye_color = old_eye_color
	user.set_facial_hair_color(old_facial_hair_color, FALSE)
	user.set_facial_hair_style(old_facial_hair, FALSE)
	user.set_hair_color(old_hair_color, FALSE)
	user.set_hair_style(old_hair, FALSE)

	user.updateappearance(mutcolor_update = TRUE)
