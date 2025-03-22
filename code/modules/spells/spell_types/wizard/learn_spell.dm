//A spell to choose new spells, upon spawning or gaining levels
/obj/effect/proc_holder/spell/self/learnspell
	name = "Attempt to learn a new spell"
	desc = "Weave a new spell"
	school = "transmutation"
	overlay_state = "book1"
	chargedrain = 0
	chargetime = 0

/obj/effect/proc_holder/spell/self/learnspell/cast(list/targets, mob/user = usr)
	. = ..()
	//list of spells you can learn, it may be good to move this somewhere else eventually
	//TODO: make GLOB list of spells, give them a true/false tag for learning, run through that list to generate choices
	var/list/choices = list()
	var/list/obj/effect/proc_holder/spell/spell_choices = list(
		/obj/effect/proc_holder/spell/invoked/projectile/fireball,// 4 cost
		/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt,// 3 cost
		/obj/effect/proc_holder/spell/invoked/projectile/spitfire,
		/obj/effect/proc_holder/spell/invoked/forcewall_weak,
		/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe,
		/obj/effect/proc_holder/spell/invoked/haste,
		/obj/effect/proc_holder/spell/invoked/findfamiliar,
		/obj/effect/proc_holder/spell/self/primalsavagery5e,
		/obj/effect/proc_holder/spell/invoked/projectile/bloodlightning,
//		/obj/effect/proc_holder/spell/invoked/push_spell,
//		/obj/effect/proc_holder/spell/targeted/ethereal_jaunt,
//		/obj/effect/proc_holder/spell/aoe_turf/knock,
		/obj/effect/proc_holder/spell/targeted/touch/darkvision,// 2 cost
		/obj/effect/proc_holder/spell/self/message,
		/obj/effect/proc_holder/spell/invoked/blade_burst,
		/obj/effect/proc_holder/spell/invoked/projectile/fetch,
		/obj/effect/proc_holder/spell/invoked/projectile/arcanebolt,
		/obj/effect/proc_holder/spell/targeted/touch/nondetection, // 1 cost
		/obj/effect/proc_holder/spell/targeted/touch/prestidigitation,
		/obj/effect/proc_holder/spell/invoked/featherfall,
		/obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e, //spells ported from azure in modular_azure
		/obj/effect/proc_holder/spell/invoked/snap_freeze,
		/obj/effect/proc_holder/spell/invoked/projectile/frostbolt,
		/obj/effect/proc_holder/spell/invoked/gravity,
		/obj/effect/proc_holder/spell/invoked/projectile/repel,
		/obj/effect/proc_holder/spell/invoked/longstrider,
		/obj/effect/proc_holder/spell/invoked/guidance,
		/obj/effect/proc_holder/spell/self/arcyne_eye,
		/obj/effect/proc_holder/spell/invoked/meteor_storm,
		/obj/effect/proc_holder/spell/invoked/boomingblade5e,
		/obj/effect/proc_holder/spell/invoked/arcyne_storm,
		/obj/effect/proc_holder/spell/invoked/frostbite5e,
		/obj/effect/proc_holder/spell/invoked/sundering_lightning,
		/obj/effect/proc_holder/spell/invoked/poisonspray5e,
		/obj/effect/proc_holder/spell/invoked/greenflameblade5e,
		/obj/effect/proc_holder/spell/invoked/chilltouch5e,
		/obj/effect/proc_holder/spell/invoked/infestation5e,
		/obj/effect/proc_holder/spell/invoked/magicstone5e,
		/obj/effect/proc_holder/spell/invoked/decompose5e,
		/obj/effect/proc_holder/spell/targeted/encodethoughts5e,
		/obj/effect/proc_holder/spell/invoked/mindsliver5e,
		/obj/effect/proc_holder/spell/invoked/guidance,
		/obj/effect/proc_holder/spell/self/light5e,
		/obj/effect/proc_holder/spell/self/bladeward5e,
		/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e,
		/obj/effect/proc_holder/spell/invoked/projectile/rayoffrost5e,
		/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e,
	)

	for(var/i = 1, i <= spell_choices.len, i++)
		choices["[spell_choices[i].name]: [spell_choices[i].cost]"] = spell_choices[i]

	var/choice = input("Choose a spell, points left: [user.mind.spell_points - user.mind.used_spell_points]") as null|anything in choices
	var/obj/effect/proc_holder/spell/item = choices[choice]
	if(!item)
		return     // user canceled;
	if(alert(user, "[item.desc]", "[item.name]", "Learn", "Cancel") == "Cancel") //gives a preview of the spell's description to let people know what a spell does
		return
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == item.type)
			to_chat(user,span_warning("You already know this one!"))
			return	//already know the spell
	if(item.cost > user.mind.spell_points - user.mind.used_spell_points)
		to_chat(user,span_warning("You do not have enough experience to create a new spell."))
		return		// not enough spell points
	else
		user.mind.used_spell_points += item.cost
		user.mind.AddSpell(new item, silent = FALSE)
		addtimer(CALLBACK(user.mind, TYPE_PROC_REF(/datum/mind, check_learnspell), src), 2 SECONDS) //self remove if no points
		return TRUE
