/obj/item/melee
	item_flags = NEEDS_PERMIT

/obj/item/melee/proc/check_martial_counter(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(target.check_block())
		target.visible_message("<span class='danger'>[target.name] blocks [src] and twists [user]'s arm behind [user.p_their()] back!</span>",
					"<span class='danger'>I block the attack!</span>")
		user.Stun(40)
		return TRUE

/obj/item/melee/classic_baton
	name = "police baton"
	desc = ""
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "baton"
	item_state = "classic_baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 12 //9 hit crit
	w_class = WEIGHT_CLASS_NORMAL

	var/cooldown_check = 0 // Used interally, you don't want to modify

	var/cooldown = 40 // Default wait time until can stun again.
	var/knockdown_time_carbon = (1.5 SECONDS) // Knockdown length for carbons.
	var/stun_time_silicon = (5 SECONDS) // If enabled, how long do we stun silicons.
	var/stamina_damage = 55 // Do we deal stamina damage.
	var/affect_silicon = FALSE // Does it stun silicons.
	var/on_sound // "On" sound, played when switching between able to stun or not.
	var/on_stun_sound = "sound/effects/woodhit.ogg" // Default path to sound for when we stun.
	var/stun_animation = TRUE // Do we animate the "hit" when stunning.
	var/on = TRUE // Are we on or off.

	var/on_icon_state // What is our sprite when turned on
	var/off_icon_state // What is our sprite when turned off
	var/on_item_state // What is our in-hand sprite when turned on
	var/force_on // Damage when on - not stunning
	var/force_off // Damage when off - not stunning
	var/weight_class_on // What is the new size class when turned on

// Description for trying to stun when still on cooldown.
/obj/item/melee/classic_baton/proc/get_wait_description()
	return

// Description for when turning their baton "on"
/obj/item/melee/classic_baton/proc/get_on_description()
	. = list()

	.["local_on"] = "<span class ='warning'>I extend the baton.</span>"
	.["local_off"] = "<span class ='notice'>I collapse the baton.</span>"

	return .

// Default message for stunning mob.
/obj/item/melee/classic_baton/proc/get_stun_description(mob/living/target, mob/living/user)
	. = list()

	.["visible"] =  "<span class ='danger'>[user] knocks [target] down with [src]!</span>"
	.["local"] = "<span class ='danger'>[user] knocks you down with [src]!</span>"

	return .

// Default message for stunning a silicon.
/obj/item/melee/classic_baton/proc/get_silicon_stun_description(mob/living/target, mob/living/user)
	. = list()

	.["visible"] = "<span class='danger'>[user] pulses [target]'s sensors with the baton!</span>"
	.["local"] = "<span class='danger'>I pulse [target]'s sensors with the baton!</span>"

	return .

// Are we applying any special effects when we stun to carbon
/obj/item/melee/classic_baton/proc/additional_effects_carbon(mob/living/target, mob/living/user)
	return

// Are we applying any special effects when we stun to silicon
/obj/item/melee/classic_baton/proc/additional_effects_silicon(mob/living/target, mob/living/user)
	return

/obj/item/melee/classic_baton/attack(mob/living/target, mob/living/user)
	if(!on)
		return ..()

	add_fingerprint(user)
	if(!isliving(target))
		return
	if (user.used_intent.type == INTENT_HARM)
		if(!..())
			return
	else
		if(cooldown_check <= world.time)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				if (H.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK))
					return
				if(check_martial_counter(H, user))
					return

			var/list/desc = get_stun_description(target, user)

			if (stun_animation)
				user.do_attack_animation(target)

			playsound(get_turf(src), on_stun_sound, 75, TRUE, -1)
			target.Knockdown(knockdown_time_carbon)
			target.adjustStaminaLoss(stamina_damage)
			additional_effects_carbon(target, user)

			log_combat(user, target, "stunned", src)
			add_fingerprint(user)

			target.visible_message(desc["visible"], desc["local"])

			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = user
			cooldown_check = world.time + cooldown
		else
			var/wait_desc = get_wait_description()
			if (wait_desc)
				to_chat(user, wait_desc)
