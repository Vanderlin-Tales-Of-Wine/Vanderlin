
/obj/effect/proc_holder/spell/aimed
	name = "aimed projectile spell"
	var/projectile_type = /obj/projectile/magic/teleport
	var/deactive_msg = null
	var/active_msg = null
	var/active_icon_state = "projectile"
	var/list/projectile_var_overrides = list()
	var/projectile_amount = 1	//Projectiles per cast.
	var/current_amount = 0	//How many projectiles left.
	var/projectiles_per_fire = 1		//Projectiles per fire. Probably not a good thing to use unless you override ready_projectile().

/obj/effect/proc_holder/spell/aimed/update_icon()
	if(!action)
		return
	action.button_icon_state = "[base_icon_state][active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/spell/aimed/Click()
	var/mob/living/user = usr
	if(!istype(user))
		return
	var/msg
	if(!can_cast(user))
		msg = "<span class='warning'>I can no longer cast [name]!</span>"
		remove_ranged_ability(msg)
		return
	if(active)
		if(deactive_msg)
			msg = "<span class='notice'>[deactive_msg]</span>"
		var/refund_percent = current_amount/projectile_amount
		charge_counter = recharge_time * refund_percent
		start_recharge()
		active = FALSE
		remove_ranged_ability(msg)
		on_deactivation(user)
	else
		if(active_msg)
			msg = "<span class='notice'>[active_msg] <B>Left-click to shoot it at a target!</B></span>"
		current_amount = projectile_amount
		active = TRUE
		add_ranged_ability(user, msg, TRUE)
		on_activation(user)

/obj/effect/proc_holder/spell/aimed/deactivate(mob/living/user)
	if(active)
		active = FALSE
		remove_ranged_ability()
		on_deactivation(user)

/obj/effect/proc_holder/spell/aimed/proc/on_activation(mob/user)
	return

/obj/effect/proc_holder/spell/aimed/proc/on_deactivation(mob/user)
	return

/obj/effect/proc_holder/spell/aimed/InterceptClickOn(mob/living/requester, params, atom/target)
	if(..())
		return FALSE
	var/ran_out = (current_amount <= 0)
	if(!cast_check(!ran_out, ranged_ability_user))
		remove_ranged_ability()
		return FALSE
	var/list/targets = list(target)
	perform(targets, ran_out, user = ranged_ability_user)
	return TRUE

/obj/effect/proc_holder/spell/aimed/cast(list/targets, mob/living/user)
	var/target = targets[1]
	var/turf/T = user.loc
	var/turf/U = get_step(user, user.dir) // Get the tile infront of the move, based on their direction
	if(!isturf(U) || !isturf(T))
		return FALSE
	fire_projectile(user, target)
	user.newtonian_move(get_dir(U, T))
	if(current_amount <= 0)
		charge_counter = 0
		start_recharge()
		update_icon()
	return ..()

/obj/effect/proc_holder/spell/aimed/fire_projectile(mob/living/user, atom/target)
	current_amount--
	for(var/i in 1 to projectiles_per_fire)
		var/obj/projectile/P = new projectile_type(user.loc)
		P.firer = user
		P.preparePixelProjectile(target, user)
		for(var/V in projectile_var_overrides)
			if(P.vars[V])
				P.vv_edit_var(V, projectile_var_overrides[V])
		ready_projectile(P, target, user, i)
		P.fire()
	return TRUE

/obj/effect/proc_holder/spell/aimed/proc/ready_projectile(obj/projectile/P, atom/target, mob/user, iteration)
	return

/obj/effect/proc_holder/spell/aimed/fireball // not the one used by RT
	name = "Fireball"
	desc = ""
	action_icon_state = "fireball0"
	school = "evocation"
	recharge_time = 60
	invocation = "ONI SOMA"
	invocation_type = "shout"
	range = 20
	cooldown_min = 20 //10 deciseconds reduction per rank
	projectile_type = /obj/projectile/magic/aoe/fireball
	base_icon_state = "fireball"
	sound = 'sound/blank.ogg'
	active_msg = "You prepare to cast your fireball spell!"
	deactive_msg = "You extinguish your fireball... for now."
	active = FALSE
	charge_invocation = list("inthe name","of god","st michael","and st george")
	releasedrain = 500
	chargedrain = 0
	chargetime = 50
	warnie = "mobwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE

/obj/effect/proc_holder/spell/aimed/fireball/fire_projectile(list/targets, mob/living/user)
	var/range = 6 + 2*spell_level
	projectile_var_overrides = list("range" = range)
	return ..()
