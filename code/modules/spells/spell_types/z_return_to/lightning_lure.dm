/obj/effect/proc_holder/spell/targeted/lightninglure
	name = "Lightning Lure"
	desc = "You create a lash of lightning energy that strikes a target."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	recharge_time = 12 SECONDS
	range = 3
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 2 // might even deserve a cost of 3

	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	include_user = FALSE
	attunements = list(
		/datum/attunement/electric = 1.2
	)

	var/delay = 3 SECONDS
	var/sprite_changes = 10
	var/datum/beam/current_beam = null

/obj/effect/proc_holder/spell/targeted/lightninglure/cast(list/targets, mob/user = usr)
	for(var/mob/living/carbon/C in targets)
		user.visible_message(span_warning("[C] is connected to [user] with a lightning lure!"), span_warning("You create a static link with [C]."))
		playsound(user, 'sound/items/stunmace_gen (2).ogg', 100)

		var/x
		for(x=1; x < sprite_changes; x++)
			current_beam = new(user,C,time=30/sprite_changes,beam_icon_state="lightning[rand(1,12)]",btype=/obj/effect/ebeam, maxdistance=10)
			INVOKE_ASYNC(current_beam, TYPE_PROC_REF(/datum/beam, Start))
			sleep(delay/sprite_changes)

		var/dist = get_dist(user, C)
		if (dist <= range)
			C.electrocute_act(1, user) //just shock
			//var/atom/throw_target = get_step(user, get_dir(user, C))
			//C.throw_at(throw_target, 100, 2) //from source material but kinda op.
		else
			playsound(user, 'sound/items/stunmace_toggle (3).ogg', 100)
			user.visible_message(span_warning("The lightning lure fizzles out!"), span_warning("[C] is too far away!"))
	return ..()
