
/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt
	name = "Bolt of Lightning"
	desc = "Emit a bolt of lightning that burns and stuns a target."
	action_icon_state = "lightning"
	clothes_req = FALSE
	overlay_state = "lightning"
	sound = 'sound/magic/lightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/lightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokelightning
	associated_skill = /datum/skill/magic/arcane
	sparks_spread = 3
	sparks_amt = 5
	cost = 3

/obj/projectile/magic/lightning
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	light_color = LIGHT_COLOR_WHITE
	damage = 15
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#ffffff"
	light_outer_range =  7

/obj/projectile/magic/lightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		var/mob/living/carbon/H = target
		H.set_heartattack(FALSE)
		H.revive(full_heal = FALSE, admin_revive = FALSE)
		H.emote("breathgasp")
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.electrocute_act(1, src)
			// Experience gain!
			var/boon = sender.mind?.get_learning_boon(/datum/skill/magic/arcane)
			var/amt2raise = sender.STAINT*2
			sender.mind?.adjust_experience(/datum/skill/magic/arcane, floor(amt2raise * boon), FALSE)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/bloodlightning
	name = "Blood Bolt"
	desc = ""
	clothes_req = FALSE
	overlay_state = "bloodlightning"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodlightning
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood

/obj/projectile/magic/bloodlightning
	name = "blood bolt"
	tracer_type = /obj/effect/projectile/tracer/blood
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 35
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#802121"
	light_outer_range =  7

/obj/projectile/magic/bloodlightning/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(isliving(target))
			var/mob/living/L = target
			L.electrocute_act(1, src)
			// Experience gain!
			var/boon = sender.mind?.get_learning_boon(/datum/skill/magic/blood)
			var/amt2raise = sender.STAINT*2
			sender.mind?.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/bloodsteal
	name = "Blood Steal"
	desc = ""
	clothes_req = FALSE
	overlay_state = "bloodsteal"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodsteal
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood

/obj/projectile/magic/bloodsteal
	name = "blood steal"
	tracer_type = /obj/effect/projectile/tracer/bloodsteal
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 25
	damage_type = BRUTE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#e74141"
	light_outer_range =  7

/obj/projectile/magic/bloodsteal/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/datum/antagonist/vampirelord/VDrinker = sender.mind.has_antag_datum(/datum/antagonist/vampirelord)
			H.blood_volume = max(H.blood_volume-45, 0)
			if(H.vitae_pool >= 500) // You'll only get vitae IF they have vitae.
				H.vitae_pool -= 500
				VDrinker.handle_vitae(500)
			var/boon = sender.mind?.get_learning_boon(/datum/skill/magic/blood)
			var/amt2raise = sender.STAINT*2
			sender.mind?.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
			H.handle_blood()
			H.visible_message(span_danger("[target] has their blood ripped from their body!"), \
					span_userdanger("My blood erupts from my body!"), span_hear("..."), COMBAT_MESSAGE_RANGE, target)
			new /obj/effect/decal/cleanable/blood/puddle(H.loc)
	qdel(src)

/obj/effect/proc_holder/spell/invoked/projectile/fireball
	name = "Fireball"
	desc = "Shoot out a ball of fire that emits a light explosion on impact, setting the target alight."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue
	overlay_state = "fireball"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	cost = 4

/obj/projectile/magic/aoe/fireball/rogue
	name = "fireball"
	exp_heavy = 0
	exp_light = 3
	exp_flash = 0
	exp_fire = 3
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/fireball.ogg'
	aoe_range = 0
	speed = 3

/obj/projectile/magic/aoe/fireball/rogue/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		else
			// Experience gain!
			var/boon = sender?.mind?.get_learning_boon(/datum/skill/magic/arcane)
			var/amt2raise = sender?.STAINT*2
			sender?.mind?.adjust_experience(/datum/skill/magic/arcane, floor(amt2raise * boon), FALSE)



/obj/effect/proc_holder/spell/invoked/projectile/fireball/greater
	name = "Fireball (Greater)"
	desc = "Shoot out an immense ball of fire that explodes on impact."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue/great
	overlay_state = "fireball_greater"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 50
	chargedrain = 3
	chargetime = 15
	charge_max = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokefire
	cost = 10

/obj/projectile/magic/aoe/fireball/rogue/great
	name = "fireball"
	exp_devi = 0
	exp_heavy = 1
	exp_light = 5
	exp_flash = 0
	exp_fire = 4
	exp_hotspot = 0
	flag = "magic"
	speed = 6

/obj/effect/proc_holder/spell/invoked/projectile/spitfire
	name = "Spitfire"
	desc = "Shoot out a low-powered ball of fire that shines brightly on impact, potentially blinding a target."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue2
	overlay_state = "fireball_multi"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 10
	charge_max = 8 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	cost = 3

/obj/projectile/magic/aoe/fireball/rogue2
	name = "spitfire"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 1
	exp_fire = 0
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0
	speed = 2.5

/obj/projectile/magic/aoe/fireball/rogue2/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK

/obj/effect/proc_holder/spell/invoked/projectile/arcanebolt
	name = "Arcane Bolt"
	desc = "Shoot out rapid bolts of arcane magic, that firmly hits on impact."
	clothes_req = FALSE
	range = 12
	projectile_type = /obj/projectile/energy/rogue3
	overlay_state = "force_dart"
	sound = list('sound/magic/vlightning.ogg')
	active = FALSE
	releasedrain = 20
	chargedrain = 1
	chargetime = 7
	charge_max = 5 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2

/obj/projectile/energy/rogue3
	name = "arcane bolt"
	icon_state = "arcane_barrage"
	damage = 30
	damage_type = BRUTE
	armor_penetration = 10
	nodamage = FALSE
	flag =  "piercing"
	hitsound = 'sound/blank.ogg'
	speed = 2

/obj/projectile/energy/rogue3/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK

/obj/effect/proc_holder/spell/invoked/projectile/fetch
	name = "Fetch"
	desc = "Shoot out a magical bolt that draws in the target struck towards the caster."
	overlay_state = "fetch"
	clothes_req = FALSE
	range = 15
	projectile_type = /obj/projectile/magic/fetch
	sound = list('sound/magic/magnet.ogg')
	active = FALSE
	releasedrain = 5
	chargedrain = 0
	chargetime = 0
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2

/obj/projectile/magic/fetch/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[target] repells the fetch!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		else
			// Experience gain!
			var/boon = sender.mind?.get_learning_boon(/datum/skill/magic/arcane)
			var/amt2raise = sender.STAINT
			sender.mind?.adjust_experience(/datum/skill/magic/arcane, floor(amt2raise * boon), FALSE)

#define PRESTI_CLEAN "presti_clean"
#define PRESTI_SPARK "presti_spark"
#define PRESTI_MOTE "presti_mote"

/obj/effect/proc_holder/spell/targeted/touch/prestidigitation
	name = "Prestidigitation"
	desc = "A few basic tricks many apprentices use to practice basic manipulation of the arcyne."
	clothes_req = FALSE
	drawmessage = "I prepare to perform a minor arcyne incantation."
	dropmessage = "I release my minor arcyne focus."
	school = "transmutation"
	overlay_state = "prestidigitation"
	chargedrain = 0
	chargetime = 0
	releasedrain = 5 // this influences -every- cost involved in the spell's functionality, if you want to edit specific features, do so in handle_cost
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	hand_path = /obj/item/melee/touch_attack/prestidigitation
	cost = 1

/obj/item/melee/touch_attack/prestidigitation
	name = "\improper prestidigitating touch"
	desc = "You recall the following incantations you've learned:\n \
	<b>Touch</b>: Use your arcyne powers to scrub an object or something clean, like using soap. Also known as the Apprentice's Woe.\n \
	<b>Shove</b>: Will forth a spark <i>in front of you</i> to ignite flammable items and things like torches, lanterns or campfires. \n \
	<b>Use</b>: Conjure forth an orbiting mote of magelight to light your way."
	catchphrase = null
	possible_item_intents = list(INTENT_HELP, INTENT_DISARM, /datum/intent/use)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#3FBAFD" // this produces green because the icon base is yellow but someone else can fix that if they want
	var/obj/effect/wisp/prestidigitation/mote
	var/cleanspeed = 35 // adjust this down as low as 15 depending on magic skill
	var/motespeed = 20 // mote summoning speed
	var/sparkspeed = 30 // spark summoning speed
	var/spark_cd = 0
	var/xp_interval = 150 // really don't want people to spam this too much for xp - they will, but the intent is for them to not
	var/xp_cooldown = 0

/obj/item/melee/touch_attack/prestidigitation/Initialize()
	. = ..()
	mote = new(src)

/obj/item/melee/touch_attack/prestidigitation/Destroy()
	if (mote)
		qdel(mote)
	return ..()

/obj/item/melee/touch_attack/prestidigitation/attack_self()
	qdel(src)

/obj/item/melee/touch_attack/prestidigitation/afterattack(atom/target, mob/living/carbon/user, proximity)
	var/fatigue_used
	switch (user.used_intent.type)
		if (INTENT_HELP) // Clean something like a bar of soap
			fatigue_used = handle_cost(user, PRESTI_CLEAN)
			if (clean_thing(target, user))
				handle_xp(user, fatigue_used, TRUE) // cleaning ignores the xp cooldown because it awards comparatively little
		if (INTENT_DISARM) // Snap your fingers and produce a spark
			fatigue_used = handle_cost(user, PRESTI_SPARK)
			if (create_spark(user))
				handle_xp(user, fatigue_used)
		if (/datum/intent/use) // Summon an orbiting arcane mote for light
			fatigue_used = handle_cost(user, PRESTI_MOTE)
			if (handle_mote(user))
				handle_xp(user, fatigue_used)

/obj/item/melee/touch_attack/prestidigitation/proc/handle_cost(mob/living/carbon/human/user, action)
	// handles fatigue/stamina deduction, this stuff isn't free - also returns the cost we took to use for xp calculations
	var/obj/effect/proc_holder/spell/targeted/touch/prestidigitation/base_spell = attached_spell
	var/fatigue_used = base_spell.get_fatigue_drain() //note that as our skills/stats increases, our fatigue drain DECREASES, so this means less xp, too. which is what we want since this is a basic spell, not a spam-for-xp-forever kinda beat
	var/extra_fatigue = 0 // extra fatigue isn't considered in xp calculation
	switch (action)
		if (PRESTI_CLEAN)
			fatigue_used *= 0.2 // going to be spamming a lot of this probably
		if (PRESTI_SPARK)
			extra_fatigue = 5 // just a bit of extra fatigue on this one
		if (PRESTI_MOTE)
			extra_fatigue = 15 // same deal here

	user.adjust_stamina(fatigue_used + extra_fatigue)

	var/skill_level = user.mind?.get_skill_level(attached_spell.associated_skill)
	if (skill_level >= SKILL_LEVEL_EXPERT)
		fatigue_used = 0 // we do this after we've actually changed fatigue because we're hard-capping the raises this gives to Expert

	return fatigue_used

/obj/item/melee/touch_attack/prestidigitation/proc/handle_xp(mob/living/carbon/human/user, fatigue, ignore_cooldown = TRUE)
	if (!ignore_cooldown)
		if (world.time < xp_cooldown + xp_interval)
			return

	xp_cooldown = world.time

	var/obj/effect/proc_holder/spell/targeted/touch/prestidigitation/base_spell = attached_spell
	if (user)
		adjust_experience(user, base_spell.associated_skill, fatigue)

/obj/item/melee/touch_attack/prestidigitation/proc/handle_mote(mob/living/carbon/human/user)
	// adjusted from /obj/item/wisp_lantern & /obj/item/wisp
	if (!mote)
		return // should really never happen

	//let's adjust the light power based on our skill, too
	var/skill_level = user.mind?.get_skill_level(attached_spell.associated_skill)
	var/mote_power = clamp(4 + (skill_level - 3), 4, 7) // every step above journeyman should get us 1 more tile of brightness
	mote.light_outer_range =  mote_power
	mote.update_light()

	if (mote.loc == src)
		user.visible_message(span_notice("[user] holds open the palm of [user.p_their()] hand and concentrates..."), span_notice("I hold open the palm of my hand and concentrate on my arcyne power..."))
		if(do_after(user, motespeed))
			mote.orbit(user, 18, pick(list(TRUE, FALSE)), 2000, 48, TRUE)
			return TRUE
		return FALSE
	else
		user.visible_message(span_notice("[user] wills \the [mote.name] back into [user.p_their()] hand and closes it, extinguishing its light."), span_notice("I will \the [mote.name] back into my palm and close it."))
		mote.forceMove(src)
		return TRUE

/obj/item/melee/touch_attack/prestidigitation/proc/create_spark(mob/living/carbon/human/user)
	// adjusted from /obj/item/flint
	if (world.time < spark_cd + sparkspeed)
		return
	spark_cd = world.time
	playsound(user, 'sound/foley/finger-snap.ogg', 100, FALSE)
	user.visible_message(span_notice("[user] snaps [user.p_their()] fingers, producing a spark!"), span_notice("I will forth a tiny spark with a snap of my fingers."))
	flick("flintstrike", src)

	user.flash_fullscreen("whiteflash")
	var/datum/effect_system/spark_spread/S = new()
	var/turf/front = get_step(user, user.dir)
	S.set_up(1, 1, front)
	S.start()

/obj/item/melee/touch_attack/prestidigitation/proc/clean_thing(atom/target, mob/living/carbon/human/user)
	// adjusted from /obj/item/soap in clown_items.dm, some duplication unfortunately (needed for flavor)

	// let's adjust the clean speed based on our skill level
	var/skill_level = user.mind?.get_skill_level(attached_spell.associated_skill)
	cleanspeed = initial(cleanspeed) - (skill_level * 3) // 3 cleanspeed per skill level, from 35 down to a maximum of 17 (pretty quick)

	if (istype(target, /obj/effect/decal/cleanable))
		user.visible_message(span_notice("[user] gestures at \the [target.name], arcyne power slowly scouring it away..."), span_notice("I begin to scour \the [target.name] away with my arcyne power..."))
		if(do_after(user, cleanspeed, target))
			to_chat(user, span_notice("I expunge \the [target.name] with my mana."))
			qdel(target)
			return TRUE
		return FALSE
	else
		user.visible_message(span_notice("[user] gestures at \the [target.name], tiny motes of arcyne power surging over [target.p_them()]..."), span_notice("I begin to clean \the [target.name] with my arcyne power..."))
		if(do_after(user, cleanspeed, target))
			to_chat(user, span_notice("I render \the [target.name] clean."))
			for (var/obj/effect/decal/cleanable/C in target)
				qdel(C)
			target.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
			SEND_SIGNAL(target, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_MEDIUM)
			return TRUE
		return FALSE

// Intents for prestidigitation

/obj/effect/wisp/prestidigitation
	name = "minor magelight mote"
	desc = "A tiny display of arcyne power used to illuminate."
	pixel_x = 20
	light_outer_range =  4
	light_color = "#3FBAFD"

	icon = 'icons/roguetown/items/lighting.dmi'
	icon_state = "wisp"

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
	var/list/obj/effect/proc_holder/spell/spell_choices = list(/obj/effect/proc_holder/spell/invoked/projectile/fireball,// 4 cost
		/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt,// 3 cost
		/obj/effect/proc_holder/spell/invoked/projectile/spitfire,
		/obj/effect/proc_holder/spell/invoked/forcewall_weak,
		/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe,
		/obj/effect/proc_holder/spell/invoked/haste,
		/obj/effect/proc_holder/spell/invoked/findfamiliar,
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

//forcewall
/obj/effect/proc_holder/spell/invoked/forcewall_weak
	name = "Forcewall"
	desc = "Conjure a wall of arcyne force, preventing anyone and anything other than you from moving through it."
	school = "transmutation"
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 35 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	clothes_req = FALSE
	active = FALSE
	sound = 'sound/blank.ogg'
	overlay_state = "forcewall"
	range = -1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	var/wall_type = /obj/structure/forcefield_weak/caster
	cost = 3

//adapted from forcefields.dm, this needs to be destructible
/obj/structure/forcefield_weak
	name = "arcyne wall"
	desc = "A wall of pure arcyne force."
	icon = 'icons/effects/effects.dmi'
	icon_state = "forcefield"
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	opacity = 0
	density = TRUE
	max_integrity = 80
	CanAtmosPass = ATMOS_PASS_DENSITY
	climbable = TRUE
	climb_time = 0
	var/timeleft = 20 SECONDS

/obj/structure/forcefield_weak/Initialize()
	. = ..()
	if(timeleft)
		QDEL_IN(src, timeleft) //delete after it runs out

/obj/effect/proc_holder/spell/invoked/forcewall_weak/cast(list/targets,mob/user = usr)
	var/turf/front = get_step(user, user.dir)
	new wall_type(front, user)
	if(user.dir == SOUTH || user.dir == NORTH)
		new wall_type(get_step(front, WEST), user)
		new wall_type(get_step(front, EAST), user)
	else
		new wall_type(get_step(front, NORTH), user)
		new wall_type(get_step(front, SOUTH), user)
	user.visible_message("[user] mutters an incantation and a wall of arcyne force manifests out of thin air!")
	return TRUE

/obj/structure/forcefield_weak/caster
	var/mob/caster

/obj/structure/forcefield_weak/caster/Initialize(mapload, mob/summoner)
	. = ..()
	caster = summoner

/obj/structure/forcefield_weak/caster/CanPass(atom/movable/mover, turf/target)	//only the caster can move through this freely
	if(mover == caster)
		return TRUE
	if(ismob(mover))
		var/mob/M = mover
		if(M.anti_magic_check(chargecost = 0) || structureclimber == M)
			return TRUE
	return FALSE

/obj/structure/forcefield_weak/caster/do_climb(atom/movable/A)
	if(A != caster)
		return FALSE
	. = ..()

// no slowdown status effect defined, so this just immobilizes for now
/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe
	name = "Ensnare"
	desc = "Tendrils of arcyne force hold anyone in a small area in place for a short while."
	cost = 3
	releasedrain = 20
	chargedrain = 1
	chargetime = 20
	charge_max = 25 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 6
	overlay_state = "ensnare"
	var/area_of_effect = 1
	var/duration = 4 SECONDS
	var/delay = 0.8 SECONDS

/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])

	for(var/turf/affected_turf in view(area_of_effect, T))
		if(affected_turf.density)
			continue
		new /obj/effect/temp_visual/slowdown_spell_aoe(affected_turf)

	addtimer(CALLBACK(src, PROC_REF(apply_slowdown), T, area_of_effect, duration, user), delay)
	playsound(T,'sound/magic/webspin.ogg', 50, TRUE)
	return TRUE
/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe/proc/apply_slowdown(turf/T, area_of_effect, duration)
	for(var/mob/living/simple_animal/hostile/retaliate/rogue in range(area_of_effect, T))
		rogue.Paralyze(duration, updating = TRUE, ignore_canstun = TRUE)	//i think animal movement is coded weird, i cant seem to stun them
	for(var/mob/living/L in range(area_of_effect, T))
		if(L.anti_magic_check())
			visible_message(span_warning("The tendrils of force can't seem to latch onto [L] "))  //antimagic needs some testing
			playsound(get_turf(L), 'sound/magic/magic_nulled.ogg', 100)
			return
		L.Immobilize(duration)
		L.OffBalance(duration)
		L.visible_message(span_warning("[L] is held by tendrils of arcyne force!"))
		new /obj/effect/temp_visual/slowdown_spell_aoe/long(get_turf(L))

/obj/effect/temp_visual/slowdown_spell_aoe
	icon = 'icons/effects/effects.dmi'
	icon_state = "curseblob"
	duration = 1 SECONDS

/obj/effect/temp_visual/slowdown_spell_aoe/long
	duration = 3 SECONDS

/obj/effect/proc_holder/spell/self/message
	name = "Message"
	desc = "Latch onto the mind of one who is familiar to you, whispering a message into their head."
	cost = 1
	releasedrain = 30
	charge_max = 60 SECONDS
	warnie = "spellwarning"
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "message"
	var/identify_difficulty = 15 //the stat threshold needed to pass the identify check

/obj/effect/proc_holder/spell/self/message/cast(list/targets, mob/user)
	var/input = input(user, "Who are you trying to contact?")
	if(!input)
		return FALSE
	if(!user.key)
		to_chat(user, span_warning("I sense a body, but the mind does not seem to be there."))
		return FALSE
	if(!user.mind || !user.mind.do_i_know(name=input))
		to_chat(user, span_warning("I don't know anyone by that name."))
		return FALSE
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.real_name == input)
			var/message = input(user, "You make a connection. What are you trying to say?")
			if(!message)
				return ..()
			if(alert(user, "Send anonymously?", "", "Yes", "No") == "No") //yes or no popup, if you say No run this code
				identify_difficulty = 0 //anyone can clear this

			var/identified = FALSE
			if(HL.STAPER >= identify_difficulty) //quick stat check
				if(HL.mind)
					if(HL.mind.do_i_know(name=user.real_name)) //do we know who this person is?
						identified = TRUE // we do
						to_chat(HL, "Arcyne whispers fill the back of my head, resolving into [user]'s voice: <font color=#7246ff>[message]</font>")
			if(!identified) //we failed the check OR we just dont know who that is
				to_chat(HL, "Arcyne whispers fill the back of my head, resolving into an unknown [user.gender == FEMALE ? "woman" : "man"]'s voice: <font color=#7246ff>[message]</font>")

			log_game("[key_name(user)] sent a message to [key_name(HL)] with contents [message]")
			// maybe an option to return a message, here?
			return ..()
	to_chat(user, span_warning("I seek a mental connection, but can't find [input]."))
	return FALSE

/obj/effect/proc_holder/spell/invoked/push_spell
	name = "Repulse"
	desc = "Conjure forth a wave of energy, repelling anyone around you."
	overlay_state = "repulse"
	cost = 3
	releasedrain = 50
	chargedrain = 1
	chargetime = 3 SECONDS
	charge_max = 25 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	var/stun_amt = 5
	var/maxthrow = 3
	var/sparkle_path = /obj/effect/temp_visual/gravpush
	var/repulse_force = MOVE_FORCE_EXTREMELY_STRONG
	var/push_range = 1

/obj/effect/proc_holder/spell/invoked/push_spell/cast(list/targets, mob/user)
	var/list/thrownatoms = list()
	var/atom/throwtarget
	var/distfromcaster
	playsound(user, 'sound/magic/repulse.ogg', 80, TRUE)
	user.visible_message("[user] mutters an incantation and a wave of force radiates outward!")
	for(var/turf/T in view(push_range, user))
		new /obj/effect/temp_visual/kinetic_blast(T)
		for(var/atom/movable/AM in T)
			thrownatoms += AM

	for(var/am in thrownatoms)
		var/atom/movable/AM = am
		if(AM == user || AM.anchored)
			continue

		if(ismob(AM))
			var/mob/M = AM
			if(M.anti_magic_check())
				continue

		throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(AM, user)))
		distfromcaster = get_dist(user, AM)
		if(distfromcaster == 0)
			if(isliving(AM))
				var/mob/living/M = AM
				M.Paralyze(10)
				M.adjustBruteLoss(5)
				to_chat(M, span_danger("You're slammed into the floor by [user]!"))
		else
			new sparkle_path(get_turf(AM), get_dir(user, AM)) //created sparkles will disappear on their own
			if(isliving(AM))
				var/mob/living/M = AM
				M.Paralyze(stun_amt)
				to_chat(M, span_danger("You're thrown back by [user]!"))
			AM.safe_throw_at(throwtarget, ((CLAMP((maxthrow - (CLAMP(distfromcaster - 2, 0, distfromcaster))), 3, maxthrow))), 1,user, force = repulse_force)//So stuff gets tossed around at the same time.

/obj/effect/proc_holder/spell/invoked/blade_burst
	name = "Blade Burst"
	desc = "Summon a storm of arcyne force in an area that damages through armor, wounding anything in that location after a delay."
	cost = 2
	releasedrain = 30
	chargedrain = 1
	chargetime = 20
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "blade_burst"
	var/delay = 7
	var/damage = 45

/obj/effect/temp_visual/trap
	icon = 'icons/effects/effects.dmi'
	icon_state = "trap"
	light_outer_range =  2
	duration = 7
	layer = ABOVE_ALL_MOB_LAYER //this doesnt render above mobs? it really should

/obj/effect/temp_visual/blade_burst
	icon = 'icons/effects/effects.dmi'
	icon_state = "purplesparkles"
	name = "rippeling arcyne energy"
	desc = "Get out of the way!"
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/proc_holder/spell/invoked/blade_burst/cast(list/targets, mob/user)
	var/turf/T = get_turf(targets[1])
	var/play_cleave = FALSE
	new /obj/effect/temp_visual/trap(T)
	playsound(T, 'sound/magic/blade_burst.ogg', 80, TRUE, soundping = TRUE)
	sleep(delay)
	new /obj/effect/temp_visual/blade_burst(T)
	for(var/mob/living/L in T.contents)
		var/def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		L.apply_damage(damage, BRUTE, def_zone)
		if(prob(33))
			var/obj/item/bodypart/BP = L.get_bodypart(def_zone)
			BP.add_wound(/datum/wound/fracture)
		play_cleave = TRUE
		L.adjustBruteLoss(damage)
		playsound(T, "genslash", 80, TRUE)
		to_chat(L, span_userdanger("I'm cut by arcyne force!"))
	if(play_cleave)
		playsound(T,'sound/combat/newstuck.ogg', 80, TRUE, soundping = TRUE)
	return TRUE

/obj/effect/proc_holder/spell/targeted/touch/nondetection
	name = "Nondetection"
	desc = "Consume a handful of ash and shroud a target that you touch from divination magic for 1 hour."
	clothes_req = FALSE
	drawmessage = "I prepare to form a magical shroud."
	dropmessage = "I release my arcyne focus."
	school = "abjuration"
	charge_max = 30 SECONDS
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	hand_path = /obj/item/melee/touch_attack/nondetection
	cost = 1

/obj/item/melee/touch_attack/nondetection
	name = "\improper arcyne focus"
	desc = "Touch a creature to cover them in an anti-scrying shroud for 1 hour, consumes some ash as a catalyst."
	catchphrase = null
	possible_item_intents = list(INTENT_HELP)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#3FBAFD"

/obj/item/melee/touch_attack/nondetection/attack_self()
	attached_spell.remove_hand()

/obj/effect/proc_holder/spell/targeted/touch/nondetection/proc/add_buff_timer(mob/living/user)
	addtimer(CALLBACK(src, PROC_REF(remove_buff), user), wait = 1 HOURS)

/obj/effect/proc_holder/spell/targeted/touch/nondetection/proc/remove_buff(mob/living/user)
	REMOVE_TRAIT(user, TRAIT_ANTISCRYING, MAGIC_TRAIT)
	to_chat(user, span_warning("I feel my anti-scrying shroud failing."))

/obj/item/melee/touch_attack/nondetection/afterattack(atom/target, mob/living/carbon/user, proximity)
	var/obj/effect/proc_holder/spell/targeted/touch/nondetection/base_spell = attached_spell
	var/requirement = FALSE
	var/obj/item/sacrifice

	if(isliving(target))

		var/mob/living/spelltarget = target

		for(var/obj/item/I in user.held_items)
			if(istype(I, /obj/item/ash))
				requirement = TRUE
				sacrifice = I

		if(!requirement)
			to_chat(user, span_warning("I require some ash in a free hand."))
			return

		if(!do_after(user, 5 SECONDS, spelltarget))
			return

		qdel(sacrifice)
		ADD_TRAIT(spelltarget, TRAIT_ANTISCRYING, MAGIC_TRAIT)
		if(spelltarget != user)
			user.visible_message("[user] draws a glyph in the air and blows some ash onto [spelltarget].")
		else
			user.visible_message("[user] draws a glyph in the air and covers themselves in ash.")

		base_spell.add_buff_timer(spelltarget)
		attached_spell.remove_hand()
	return

/obj/effect/proc_holder/spell/targeted/touch/darkvision
	name = "Darkvision"
	desc = "Enhance the night vision of a target you touch for an hour."
	clothes_req = FALSE
	drawmessage = "I prepare to grant Darkvision."
	dropmessage = "I release my arcyne focus."
	school = "transmutation"
	charge_max = 1 MINUTES
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	hand_path = /obj/item/melee/touch_attack/darkvision
	cost = 2

/obj/item/melee/touch_attack/darkvision
	name = "\improper arcyne focus"
	desc = "Touch a creature to grant them Darkvision for 10 minutes."
	catchphrase = null
	possible_item_intents = list(INTENT_HELP)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#3FBAFD"

/obj/item/melee/touch_attack/darkvision/attack_self()
	attached_spell.remove_hand()

/obj/item/melee/touch_attack/darkvision/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(isliving(target))
		var/mob/living/spelltarget = target
		if(!do_after(user, 5 SECONDS, spelltarget))
			return
		spelltarget.apply_status_effect(/datum/status_effect/buff/darkvision)
		user.adjust_stamina(80)
		if(spelltarget != user)
			user.visible_message("[user] draws a glyph in the air and touches [spelltarget] with an arcyne focus.")
		else
			user.visible_message("[user] draws a glyph in the air and touches themselves with an arcyne focus.")
		attached_spell.remove_hand()
	return

/obj/effect/proc_holder/spell/invoked/featherfall
	name = "Featherfall"
	desc = "Grant yourself and any creatures adjacent to you some defense against falls."
	cost = 1
	school = "transmutation"
	releasedrain = 50
	chargedrain = 0
	chargetime = 10 SECONDS
	charge_max = 2 MINUTES
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "jump"

/obj/effect/proc_holder/spell/invoked/featherfall/cast(list/targets, mob/user = usr)

	user.visible_message("[user] mutters an incantation and a dim pulse of light radiates out from them.")

	for(var/mob/living/L in range(1, usr))
		L.apply_status_effect(/datum/status_effect/buff/featherfall)

	return TRUE

/obj/effect/proc_holder/spell/invoked/haste
	name = "Haste"
	desc = "Cause a target to be magically hastened."
	cost = 3
	releasedrain = 25
	chargedrain = 1
	chargetime = 1 SECONDS
	charge_max = 1.5 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/haste/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	spelltarget.apply_status_effect(/datum/status_effect/buff/haste)
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] briefly shines yellow.")
	else
		user.visible_message("[user] mutters an incantation and they briefly shine yellow.")

	return TRUE

/obj/effect/proc_holder/spell/invoked/findfamiliar
	name = "Find Familiar"
	desc = "Summons a temporary spectral volf to aid you. Prioritizes your target and is hostile to all but yourself. Summon with care."
	school = "transmutation"
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 40 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	sound = 'sound/blank.ogg'
	overlay_state = "forcewall"
	range = -1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 3

/obj/effect/proc_holder/spell/invoked/findfamiliar/cast(list/targets,mob/user = usr)
	. = ..()
	var/mob/M = new /mob/living/simple_animal/hostile/retaliate/rogue/wolf/familiar(get_turf(user), user)
	var/atom/A = targets[1]
	if(isliving(A))
		M.ai_controller?.set_blackboard_key(BB_BASIC_MOB_PRIORITY_TARGETS, A)
	else
		var/turf/target_turf = get_turf(A)
		var/list/turftargets = list()
		for(var/mob/living/L in target_turf)
			turftargets += L
		M.ai_controller?.set_blackboard_key(BB_BASIC_MOB_PRIORITY_TARGETS, turftargets)
	return TRUE

#undef PRESTI_CLEAN
#undef PRESTI_SPARK
#undef PRESTI_MOTE

