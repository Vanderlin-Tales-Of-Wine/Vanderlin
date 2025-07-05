/obj/effect/proc_holder/spell/invoked/adopt_child
	name = "Adopt Child"
	overlay_state = "bliss"
	invocation_type = "whisper"
	overlay_state = "bless"
	range = 1
	recharge_time = 20 SECONDS
	uses_mana = FALSE

/obj/effect/proc_holder/spell/invoked/adopt_child/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return FALSE

	var/mob/living/carbon/human/target = targets[1]
	if(!istype(target))
		to_chat(H, span_warning("You must target a person!"))
		return FALSE

	if(target == H)
		to_chat(H, span_warning("You cannot adopt yourself!"))
		return FALSE

	if(target.age != AGE_CHILD)
		to_chat(H, span_warning("You can only adopt children!"))
		return FALSE

	if(target.family_datum && target.family_member_datum?.parents.len)
		to_chat(H, span_warning("This child is not an orphan!"))
		return FALSE

	if(target.job != "Orphan" && !istype(target.mind?.assigned_role, /datum/job/orphan))
		to_chat(H, span_warning("This child is not an orphan!"))
		return FALSE

	H.visible_message(span_notice("[H] begins a solemn adoption ritual."), \
					span_notice("You begin the adoption ritual with Eora's blessing..."))

	if(!do_after(H, 5 SECONDS, target = target))
		to_chat(H, span_warning("The ritual was interrupted!"))
		return FALSE

	var/choice = alert(target, "Do you wish to be adopted by [H.real_name] and become part of their family?", "Adoption Offer", "Yes", "No")
	if(choice != "Yes")
		to_chat(H, span_warning("[target] has rejected your adoption offer!"))
		return FALSE

	if(!target.Adjacent(H))
		to_chat(H, span_warning("The child is too far away!"))
		return FALSE

	if(target.family_datum)
		to_chat(H, span_warning("The child has a family already!"))
		return FALSE

	var/datum/heritage/family = H.family_datum
	if(!family)
		family = new /datum/heritage(H)
		SSfamilytree.families += family

	var/datum/family_member/parent_member = family.GetFamilyMember(H)
	if(!parent_member)
		parent_member = family.CreateFamilyMember(H)

	var/datum/family_member/child_member = family.CreateFamilyMember(target)
	child_member.AddParent(parent_member)
	child_member.adoption_status = TRUE

	if(H.spouse_mob)
		var/datum/family_member/spouse_member = family.GetFamilyMember(H.spouse_mob)
		if(!spouse_member)
			spouse_member = family.CreateFamilyMember(H.spouse_mob)
		child_member.AddParent(spouse_member)

	to_chat(H, span_love("You have adopted [target.real_name] as your child with Eora's blessing!"))
	to_chat(target, span_love("You have been adopted by [H.real_name]!"))

	SEND_SIGNAL(user, COMSIG_ORPHAN_ADOPTED, target)

	return ..()
