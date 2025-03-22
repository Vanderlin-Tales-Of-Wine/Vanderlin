
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
	attunements = list(
		/datum/attunement/electric = 0.5,
	)

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
	attunements = list(
		/datum/attunement/electric = 0.3,
		/datum/attunement/blood = 0.7,
	)

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
	attunements = list(
		/datum/attunement/blood = 0.7,
	)

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
	attunements = list(
		/datum/attunement/fire = 0.5
		)
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
	attunements = list(
		/datum/attunement/fire = 1.1,
	)

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
	attunements = list(
		/datum/attunement/fire = 0.3,
	)

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
	attunements = list(
		/datum/attunement/arcyne = 0.7,
	)

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
	attunements = list(
		/datum/attunement/aeromancy = 0.3,
	)

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
			var/boon = sender?.mind?.get_learning_boon(/datum/skill/magic/arcane)
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
	attunements = list(
		/datum/attunement/arcyne = 0.2,
	)

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
	var/gatherspeed = 35

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
			if(istype(target,/obj/structure/well/fountain/mana) || istype(target, /turf/open/lava))
				gather_thing(target, user)
				return
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

/obj/item/melee/touch_attack/prestidigitation/proc/gather_thing(atom/target, mob/living/carbon/human/user)
	// adjusted from /obj/item/soap in clown_items.dm, some duplication unfortunately (needed for flavor)

	// let's adjust the clean speed based on our skill level
	var/skill_level = user.mind?.get_skill_level(attached_spell.associated_skill)
	gatherspeed = initial(gatherspeed) - (skill_level * 3) // 3 cleanspeed per skill level, from 35 down to a maximum of 17 (pretty quick)
	if (istype(target, /turf/open/lava))
		if (do_after(user, src.gatherspeed, target = target))
			to_chat(user, span_notice("I mold a handful of oozing lava  with my arcane power, rapidly hardening it!"))
			new /obj/item/natural/obsidian(user.loc)

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
		/obj/effect/proc_holder/spell/invoked/guidance5e,
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
	attunements = list(
		/datum/attunement/illusion = 0.3,
	)

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
	attunements = list(
		/datum/attunement/time = 0.3,
		/datum/attunement/arcyne = 0.4,
	)
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


/obj/effect/proc_holder/spell/aoe_turf/repulse
	name = "Repulse"
	desc = ""
	charge_max = 400
	clothes_req = TRUE
	invocation = "GITTAH WEIGH"
	invocation_type = "shout"
	range = 5
	cooldown_min = 150
	selection_type = "view"
	sound = 'sound/blank.ogg'
	var/maxthrow = 5
	var/sparkle_path = /obj/effect/temp_visual/gravpush
	var/anti_magic_check = TRUE
	var/repulse_force = MOVE_FORCE_EXTREMELY_STRONG

	action_icon_state = "repulse"

/obj/effect/proc_holder/spell/aoe_turf/repulse/cast(list/targets,mob/user = usr, stun_amt = 40)
	var/list/thrownatoms = list()
	var/atom/throwtarget
	var/distfromcaster
	playMagSound()
	for(var/turf/T in targets) //Done this way so things don't get thrown all around hilariously.
		for(var/atom/movable/AM in T)
			thrownatoms += AM

	for(var/am in thrownatoms)
		var/atom/movable/AM = am
		if(AM == user || AM.anchored)
			continue

		if(ismob(AM))
			var/mob/M = AM
			if(M.anti_magic_check(anti_magic_check, FALSE))
				continue

		throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(AM, user)))
		distfromcaster = get_dist(user, AM)
		if(distfromcaster == 0)
			if(isliving(AM))
				var/mob/living/M = AM
				M.Paralyze(100)
				M.adjustBruteLoss(5)
				to_chat(M, span_danger("You're slammed into the floor by [user]!"))
		else
			new sparkle_path(get_turf(AM), get_dir(user, AM)) //created sparkles will disappear on their own
			if(isliving(AM))
				var/mob/living/M = AM
				M.Paralyze(stun_amt)
				to_chat(M, span_danger("You're thrown back by [user]!"))
			AM.safe_throw_at(throwtarget, ((CLAMP((maxthrow - (CLAMP(distfromcaster - 2, 0, distfromcaster))), 3, maxthrow))), 1,user, force = repulse_force)//So stuff gets tossed around at the same time.

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
	attunements = list(
		/datum/attunement/aeromancy = 0.4,
	)
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
	attunements = list(
		/datum/attunement/earth = 0.4,
	)
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
	attunements = list(
		/datum/attunement/illusion = 0.4,
	)

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
	attunements = list(
		/datum/attunement/light = 0.6,
	)

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
	attunements = list(
		/datum/attunement/aeromancy = 0.5,
	)

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
	attunements = list(
		/datum/attunement/aeromancy = 0.5,
	)

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
	attunements = list(
		/datum/attunement/arcyne = 0.4,
	)

/obj/effect/proc_holder/spell/invoked/findfamiliar/cast(list/targets,mob/user = usr)
	. = ..()
	var/mob/M = new /mob/living/simple_animal/hostile/retaliate/wolf/familiar(get_turf(user), user)
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


/obj/effect/proc_holder/spell/self/arcyne_eye
	name = "Arcyne Eye"
	desc = "Tap into the arcyne and see the leylines."
	clothes_req = FALSE
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 0
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/arcyne = 0.1
		)
	cost = 1
	overlay_state = "transfix"

/obj/effect/proc_holder/spell/self/arcyne_eye/cast(list/targets, mob/living/user)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	user.apply_status_effect(/datum/status_effect/arcyne_eye)
	return TRUE

/datum/status_effect/arcyne_eye
	duration = 1 MINUTES
	alert_type = null

/datum/status_effect/arcyne_eye/on_apply()
	ADD_TRAIT(owner, TRAIT_SEE_LEYLINES, type)
	owner.hud_used?.plane_masters_update()
	return TRUE

/datum/status_effect/arcyne_eye/on_remove()
	REMOVE_TRAIT(owner, TRAIT_SEE_LEYLINES, type)
	owner.hud_used?.plane_masters_update()


/obj/effect/proc_holder/spell/invoked/shadowstep
	name = "Shadow Step"
	desc = "Step into the shadows making you invisible for a duration."
	overlay_state = "invisibility"
	releasedrain = 0
	chargedrain = 14
	chargetime = 1 SECONDS
	charge_max = 60 SECONDS
	range = 3
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/misc/sneaking
	attunements = list(
		/datum/attunement/dark = 0.4
		)
	cost = 1

/obj/effect/proc_holder/spell/invoked/shadowstep/cast(list/targets, mob/living/user)
	if (isliving(targets[1]))
		var/mob/living/target = targets[1]
		if (target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(
			span_warning("[target] starts to fade into thin air!"),
			span_notice("You start to become invisible!")
		)
		animate(target, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
		target.mob_timers[MT_INVISIBILITY] = world.time + 7 SECONDS
		addtimer(
			CALLBACK(target, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE),
			7 SECONDS
		)
		addtimer(
			CALLBACK(target, TYPE_PROC_REF(
				/atom/movable, visible_message),
				span_warning("[target] fades back into view."),
				span_notice("You become visible again.")
			),
			7 SECONDS
		)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/mimicry
	name = "Mimicry"
	desc = "Takes on the appearance of your target."
	overlay_state = "invisibility"
	releasedrain = 20
	chargedrain = 1
	chargetime = 4 SECONDS
	charge_max = 300 SECONDS
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

/obj/effect/proc_holder/spell/invoked/frostbite5e
	name = "Frostbite"
	desc = "Freeze your enemy with an icy blast that does low damage, but reduces the target's Speed for a considerable length of time."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3
	charge_max = 25 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 7
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	attunements = list(
		/datum/attunement/ice = 0.9
	)

/obj/effect/proc_holder/spell/invoked/frostbite5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.apply_status_effect(/datum/status_effect/buff/frostbite5e/) //apply debuff
		target.adjustFireLoss(12) //damage
		target.adjustBruteLoss(12)

/datum/status_effect/buff/frostbite5e
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/frostbite5e
	duration = 20 SECONDS
	effectedstats = list("speed" = -2)

/atom/movable/screen/alert/status_effect/buff/frostbite5e
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"
	color = "#00fffb" //talk about a coder sprite

/datum/status_effect/buff/frostbite5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.update_vision_cone()
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 20 SECONDS)
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)

/datum/status_effect/buff/frostbite5e/on_remove()
	var/mob/living/target = owner
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
	. = ..()


/obj/effect/proc_holder/spell/invoked/sundering_lightning
	name = "Sundering Lightning"
	desc = "Summons forth dangerous rapid lightning strikes."
	cost = 8
	releasedrain = 50
	chargedrain = 1
	chargetime = 50
	charge_max = 50 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 4
	attunements = list(
		/datum/attunement/electric = 0.9
	)

/obj/effect/proc_holder/spell/invoked/sundering_lightning/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
//	var/list/affected_turfs = list()
	playsound(T,'sound/weather/rain/thunder_1.ogg', 80, TRUE)
	T.visible_message(span_boldwarning("The air feels crackling and charged!"))
	sleep(30)
	create_lightning(T)

//meteor storm and lightstorm.
/obj/effect/proc_holder/spell/invoked/sundering_lightning/proc/create_lightning(atom/target)
	if(!target)
		return
	var/turf/targetturf = get_turf(target)
	var/last_dist = 0
	for(var/t in spiral_range_turfs(range, targetturf))
		var/turf/T = t
		if(!T)
			continue
		var/dist = get_dist(targetturf, T)
		if(dist > last_dist)
			last_dist = dist
			sleep(2 + min(range - last_dist, 12) * 0.5) //gets faste
		new /obj/effect/temp_visual/targetlightning(T)


/obj/effect/temp_visual/lightning
	icon = 'icons/effects/32x96.dmi'
	icon_state = "lightning"
	name = "lightningbolt"
	desc = "ZAPP!!"
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 7

/obj/effect/temp_visual/lightning/Initialize(mapload)
	. = ..()
	var/mutable_appearance/MA = mutable_appearance(icon, icon_state, plane = EMISSIVE_PLANE)
	overlays += MA

/obj/effect/temp_visual/targetlightning
	icon = 'icons/effects/effects.dmi'
	icon_state = "trap"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration =15
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/targetlightning/Initialize(mapload, list/flame_hit)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(storm), flame_hit)

/obj/effect/temp_visual/targetlightning/proc/storm(list/flame_hit)	//electroshocktherapy
	var/turf/T = get_turf(src)
	sleep(duration)
	playsound(T,'sound/magic/lightning.ogg', 80, TRUE)
	new /obj/effect/temp_visual/lightning(T)

	for(var/mob/living/L in T.contents)
		L.electrocute_act(50)
		to_chat(L, span_userdanger("You're hit by lightning!!!"))

/obj/effect/proc_holder/spell/targeted/lightninglure
	name = "Lightning Lure"
	desc = "You create a lash of lightning energy that strikes a target."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 12 SECONDS
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

/obj/effect/proc_holder/spell/invoked/mending
	name = "Mending"
	desc = "Uses arcyne energy to mend an item."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 5
	charge_max = 20 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = ""
	attunements = list(
		/datum/attunement/life = 1.2
	)
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/mending/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item))
		var/obj/item/I = targets[1]
		if(I.obj_integrity < I.max_integrity)
			var/repair_percent = 0.25
			repair_percent *= I.max_integrity
			I.obj_integrity = min(I.obj_integrity + repair_percent, I.max_integrity)
			user.visible_message(span_info("[I] glows in a faint mending light."))
			if(I.obj_broken == TRUE)
				I.obj_broken = FALSE
		else
			user.visible_message(span_info("[I] appears to be in pefect condition."))
			revert_cast()
	else
		to_chat(user, span_warning("There is no item here!"))
		revert_cast()

/obj/effect/proc_holder/spell/invoked/arcyne_storm
	name = "Arcyne storm"
	desc = "Conjure ripples of force into existance over a large area, injuring any who enter"
	cost = 2
	releasedrain = 50
	chargedrain = 1
	chargetime = 12 SECONDS
	charge_max = 50 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "hierophant"
	range = 4
	attunements = list(
		/datum/attunement/arcyne = 1.2
	)
	var/damage = 10

/obj/effect/proc_holder/spell/invoked/arcyne_storm/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
	var/list/affected_turfs = list()
	for(var/turf/turfs_in_range in range(range, T)) // use inrange instead of view
		if(turfs_in_range.density)
			continue
		affected_turfs.Add(turfs_in_range)
	for(var/i = 1, i < 16, i++)
		addtimer(CALLBACK(src, PROC_REF(apply_damage), affected_turfs), wait = i * 1 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/arcyne_storm/proc/apply_damage(list/affected_turfs)
	for(var/turf/damage_turf in affected_turfs)
		new /obj/effect/temp_visual/hierophant/squares(damage_turf)
		for(var/mob/living/L in damage_turf.contents)
			L.adjustBruteLoss(damage)
			playsound(damage_turf, "genslash", 40, TRUE)
			to_chat(L, "<span class='userdanger'>I'm cut by arcyne force!</span>")

/obj/effect/temp_visual/trapice
	icon = 'icons/effects/effects.dmi'
	icon_state = "blueshatter"
	light_color = "#4cadee"
	duration = 6
	layer = MASSIVE_OBJ_LAYER

/obj/effect/temp_visual/snap_freeze
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldsparkles"
	name = "rippeling arcyne ice"
	desc = "Get out of the way!"
	randomdir = FALSE
	duration = 1 SECONDS
	layer = MASSIVE_OBJ_LAYER

/obj/effect/temp_visual/hierophant
	name = "vortex energy"
	layer = BELOW_MOB_LAYER
	var/mob/living/caster //who made this, anyway

/obj/effect/temp_visual/hierophant/Initialize(mapload, new_caster)
	. = ..()
	if(new_caster)
		caster = new_caster

/obj/effect/temp_visual/hierophant/squares
	icon_state = "hierophant_squares"
	duration = 3
	light_outer_range = MINIMUM_USEFUL_LIGHT_RANGE
	randomdir = FALSE

/obj/effect/temp_visual/hierophant/squares/Initialize(mapload, new_caster)
	. = ..()

/obj/effect/proc_holder/spell/invoked/meteor_storm
	name = "Meteor storm"
	desc = "Summons forth dangerous meteors from the sky to scatter and smash foes."
	cost = 8
	releasedrain = 90
	chargedrain = 1
	chargetime = 25 SECONDS
	charge_max = 50 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/fire = 1.2
	)

/obj/effect/proc_holder/spell/invoked/meteor_storm/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
//	var/list/affected_turfs = list()
	playsound(T,'sound/magic/meteorstorm.ogg', 80, TRUE)
	sleep(2)
	create_meteors(T)
	return TRUE

//meteor storm and lightstorm.
/obj/effect/proc_holder/spell/invoked/meteor_storm/proc/create_meteors(atom/target)
	if(!target)
		return
	target.visible_message(span_boldwarning("Fire rains from the sky!"))
	var/turf/targetturf = get_turf(target)
	for(var/turf/turf as anything in RANGE_TURFS(6,targetturf))
		if(prob(20))
			new /obj/effect/temp_visual/target(turf)

/obj/effect/temp_visual/fireball
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "meteor"
	name = "meteor"
	desc = "Get out of the way!"
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 9
	pixel_z = 270

/obj/effect/temp_visual/fireball/Initialize(mapload)
	. = ..()
	animate(src, pixel_z = 0, time = duration)

/obj/effect/temp_visual/target
	icon = null
	icon_state = null
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration = 9
	var/exp_heavy = 0
	var/exp_light = 3
	var/exp_flash = 0
	var/exp_fire = 3
	var/exp_hotspot = 0
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/target/Initialize(mapload, list/flame_hit)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fall), flame_hit)

/obj/effect/temp_visual/target/proc/fall(list/flame_hit)	//Potentially minor explosion at each impact point
	var/turf/T = get_turf(src)
	playsound(T,'sound/magic/meteorstorm.ogg', 80, TRUE)
	new /obj/effect/temp_visual/fireball(T)
	sleep(duration)
	if(ismineralturf(T))
		var/turf/closed/mineral/M = T
		M.gets_drilled()
	new /obj/effect/hotspot(T)
	for(var/mob/living/L in T.contents)
		if(islist(flame_hit) && !flame_hit[L])
			L.adjustFireLoss(40)
			L.adjust_fire_stacks(8)
			L.IgniteMob()
			to_chat(L, span_userdanger("You're hit by a meteor!"))
			flame_hit[L] = TRUE
		else
			L.adjustFireLoss(10) //if we've already hit them, do way less damage
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, hotspot_range = exp_hotspot, soundin = explode_sound)

//==============================================
//	BLADE WARD
//==============================================
// Notes: You extend your hand and trace a sigil of warding in the air.
/obj/effect/proc_holder/spell/self/bladeward5e
	name = "Blade Ward"
	desc = "Improves your targets constitution for a brief duration."
	clothes_req = FALSE
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = "Blades, be dulled!"
	invocation_type = "shout" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/arcyne = 0.3,
	)
// Notes: Bard, Sorcerer, Warlock, Wizard

/obj/effect/proc_holder/spell/self/bladeward5e/cast(mob/user = usr)
	var/mob/living/target = user
	target.apply_status_effect(/datum/status_effect/buff/bladeward5e)
	user.visible_message("<span class='info'>[user] traces a warding sigil in the air.</span>", "<span class='notice'>I trace a a sigil of warding in the air.</span>")
	return TRUE

/datum/status_effect/buff/bladeward5e
	id = "blade ward"
	alert_type = /atom/movable/screen/alert/status_effect/buff/bladeward5e
	effectedstats = list("constitution" = 3)
	duration = 20 SECONDS
	var/static/mutable_appearance/ward = mutable_appearance('icons/effects/beam.dmi', "purple_lightning", -MUTATIONS_LAYER)

/atom/movable/screen/alert/status_effect/buff/bladeward5e
	name = "Blade Ward"
	desc = "I am resistant to damage."
	icon_state = "buff"

/datum/status_effect/buff/bladeward5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(ward)
	target.update_vision_cone()

/datum/status_effect/buff/bladeward5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(ward)
	target.update_vision_cone()
	. = ..()

/obj/effect/proc_holder/spell/self/bladeward5e/test
	antimagic_allowed = TRUE

//==============================================
//	BOOMING BLADE
//==============================================
/obj/effect/proc_holder/spell/invoked/boomingblade5e
	name = "Booming Blade"
	desc = "Causes explosions to ripple out from your target when they move."
	overlay_state = "blade_burst"
	releasedrain = 50
	chargetime = 3
	charge_max = 15 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Stay still!" // Incantation should explain a confusing spell's mechanic.
	invocation_type = "shout" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/earth = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/boomingblade5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/mob/living/L = target
		var/mob/U = user
		var/obj/item/held_item = user.get_active_held_item() //get held item
		if(held_item)
			held_item.melee_attack_chain(U, L)
			target.apply_status_effect(/datum/status_effect/buff/boomingblade5e/) //apply buff
		return TRUE
	return FALSE

/datum/status_effect/buff/boomingblade5e
	id = "booming blade"
	alert_type = /atom/movable/screen/alert/status_effect/buff/boomingblade5e
	duration = 10 SECONDS
	var/turf/start_pos
	var/static/mutable_appearance/glow = mutable_appearance('icons/effects/effects.dmi', "empdisable", -MUTATIONS_LAYER)

/datum/status_effect/buff/boomingblade5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(glow)
	target.update_vision_cone()
	start_pos = get_turf(target) //set buff starting position

/datum/status_effect/buff/boomingblade5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(glow)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/buff/boomingblade5e/tick()
	var/turf/new_pos = get_turf(owner)
	var/startX = start_pos.x
	var/startY = start_pos.y
	var/newX = new_pos.x
	var/newY = new_pos.y
	if(startX != newX || startY != newY)//if target moved
		//explosion
		if(!owner.anti_magic_check())
			boom()
		qdel(src)

/datum/status_effect/buff/boomingblade5e/proc/boom()
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 2
	var/exp_fire = 0
	var/damage = 30
	explosion(owner, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire)
	owner.adjustBruteLoss(damage)
	owner.visible_message(span_warning("A thunderous boom eminates from [owner]!"), span_danger("A thunderous boom eminates from you!"))

/atom/movable/screen/alert/status_effect/buff/boomingblade5e
	name = "Booming Blade"
	desc = "I feel if I move I am in serious trouble."
	icon_state = "debuff"

//==============================================
//	CHILL TOUCH
//==============================================
// Notes: I have taken creative liberties because I don't want to fuck with people's ability to be healed.
// This now attaches a ghost hand to a targeted body part and does different things depending on the part
/obj/effect/proc_holder/spell/invoked/chilltouch5e
	name = "Chill Touch"
	desc = "A skeletal hand grips your target, the targetted zone changes the effect."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 10
	charge_max = 50 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Be torn apart!"
	invocation_type = "shout"

	attunements = list(
		/datum/attunement/ice = 0.3,
	)


// Notes: sorcerer, warlock, wizard
/obj/effect/proc_holder/spell/invoked/chilltouch5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/bodypart/bodypart = target.get_bodypart(user.zone_selected)
		if(!bodypart)
			return FALSE
		var/obj/item/chilltouch5e/hand = new(target)
		hand.host = target
		hand.bodypart = bodypart
		hand.forceMove(target)
		bodypart.add_embedded_object(hand, silent = TRUE, crit_message = FALSE)
		target.visible_message(span_warning("A skeletal hand grips [target]'s [bodypart]!"), span_danger("A skeletal hand grips me [bodypart]!"))
		if(user.zone_selected == BODY_ZONE_CHEST && !user.cmode && !target.cmode) //must be out of combat mode and have erp panel allowed for this prompt to appear
			hand.pleasureaccepted = TRUE
		else
			hand.pleasureaccepted = FALSE
		return TRUE
	return FALSE

/obj/item/chilltouch5e
	name = "Skeletal Hand"
	desc = "A ghostly, skeletal hand which moves of it's own accord."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bounty"

	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10

	var/oxy_drain = 2
	var/pleasure = 5 //pleasurable quicker since they bleed inevitably due embed
	var/curprocs = 0
	var/procsmax = 180
	var/pleasureaccepted = FALSE
	var/mob/living/host //who are we stuck to?
	var/obj/item/bodypart/bodypart //where are we stuck to?

	embedding = list(
		"embedded_unsafe_removal_time" = 50,
		"embedded_pain_chance" = 0,
		"embedded_pain_multiplier" = 0,
		"embed_chance" = 100,
		"embedded_fall_chance" = 0)
	item_flags = DROPDEL
	destroy_sound = 'sound/magic/vlightning.ogg'

/obj/item/chilltouch5e/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/*
/obj/item/chilltouch5e/on_embed(obj/item/bodypart/bodypart)
	to_chat(bodypart.owner, "<span class='warning'>hand attached to [bodypart.owner]'s [bodypart]!</span>")
	if(bodypart.owner)
		host = bodypart.owner
		START_PROCESSING(SSobj, src)
*/

/obj/item/chilltouch5e/process()
	var/hand_proc = pick(1,2,3,4,5)
	var/mult = pick(1,2)
	var/mob/living/target = host
	if(!is_embedded)
		host = null
		return PROCESS_KILL
	if(curprocs >= procsmax)
		host = null
		return PROCESS_KILL
	if(!host)
		qdel(src)
		return FALSE
	curprocs++
	if(hand_proc == 1)
		switch(bodypart.name)
			if(BODY_ZONE_HEAD) //choke
				to_chat(host, "<span class='warning'>[host] is choked by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/shove.ogg'), 100, FALSE, -1)
				host.emote("choke")

				target.adjustOxyLoss(oxy_drain*mult*2)
			if(BODY_ZONE_CHEST) //pleasure if erp, hurt if not
				to_chat(host, "<span class='danger'>[host] is pummeled by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/hits/punch/punch_hard (1).ogg','sound/combat/hits/punch/punch_hard (2).ogg','sound/combat/hits/punch/punch_hard (3).ogg'), 100, FALSE, -1)
				target.adjustBruteLoss(oxy_drain*mult*3)
			else
				to_chat(host, "<span class='danger'>[host]'s [bodypart] is twisted by a skeletal hand!</span>")
				playsound(get_turf(host), pick('sound/combat/hits/punch/punch (1).ogg','sound/combat/hits/punch/punch (2).ogg','sound/combat/hits/punch/punch (3).ogg'), 100, FALSE, -1)
				target.apply_damage(oxy_drain*mult*3, BRUTE, bodypart)
				bodypart.update_disabled()
	return FALSE

//==============================================
//	CONTROL FLAMES
//==============================================
//lame. skip. merge it with on/off

//==============================================
//	CREATE BONFIRE
//==============================================
//Conjure temporary campfire, why not?
/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e
	name = "Create Bonfire"
	desc = "Creates a magical bonfire to cook on."
	clothes_req = FALSE
	range = 0
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = "Bonfire!"
	invocation_type = "shout"

	summon_type = list(
		/obj/machinery/light/fueled/campfire/createbonfire5e
	)
	summon_lifespan = 15 MINUTES
	summon_amt = 1

	action_icon_state = "the_traps"
	attunements = list(
		/datum/attunement/fire = 0.3,
	)

/obj/machinery/light/fueled/campfire/createbonfire5e
	name = "magical bonfire"
	icon_state = "churchfire1"
	base_state = "churchfire"
	density = FALSE
	layer = 2.8
	brightness = 7
	fueluse = 10 MINUTES
	color = "#6ab2ee"
	bulb_colour = "#6ab2ee"
	max_integrity = 30

/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e/test
	antimagic_allowed = TRUE

//==============================================
//	DANCING LIGHTS
//==============================================
//lame. skip maybe add later for a dance party or something

//==============================================
//	DECOMPOSE
//==============================================
// Notes: turn a freshly dead body into a rotman
/obj/effect/proc_holder/spell/invoked/decompose5e
	name = "Decompose"
	desc = "Instantly rots the target, if humanoid creates a deadite."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 5
	charge_max = 15 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Return to rot."
	invocation_type = "whisper"
	attunements = list(
		/datum/attunement/death = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/decompose5e/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/has_rot = FALSE
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/bodypart as anything in stinky.bodyparts)
				if(bodypart.rotted || bodypart.skeletonized)
					has_rot = TRUE
					break
		if(has_rot)
			to_chat(user, span_warning("Already rotted."))
			return FALSE
		//do some sounds and effects or something (flies?)
		if(target.mind)
			target.mind.add_antag_datum(/datum/antagonist/zombie)
		target.Unconscious(20 SECONDS)
		target.emote("breathgasp")
		target.Jitter(100)
		var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
		if(rot)
			rot.amount = 100
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/rotty in stinky.bodyparts)
				rotty.rotted = TRUE
				rotty.update_limb()
				rotty.update_disabled()
		target.update_body()
		if(HAS_TRAIT(target, TRAIT_ROTMAN))
			target.visible_message(span_notice("[target]'s body rots!"), span_green("I feel rotten!"))
		else
			target.visible_message(span_warning("[target]'s body fails to rot!"), span_warning("I feel no different..."))
		return TRUE
	return FALSE

//==============================================
//	DRUIDCRAFT
//==============================================
//lame. skip

//==============================================
//	ELDRITCH BLAST
//==============================================
// Notes:
/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e
	name = "Eldritch Blast"
	desc = "A beam of crackling energy streaks toward a target, causing moderate damage."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/eldritchblast5e
	overlay_state = "force_dart"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 5 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = "Eldritch blast!" // Bad incantation but it's funny.
	invocation_type = "shout"

	attunements = list(
		/datum/attunement/dark = 0.3,
	)


/obj/projectile/magic/eldritchblast5e
	name = "eldritch blast"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "arcane_barrage"
	damage = 25
	damage_type = BRUTE
	flag = "magic"
	range = 15
	woundclass = BCLASS_STAB

/obj/projectile/magic/eldritchblast5e/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'sound/magic/swap.ogg', 100)

/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e/empowered
	name = "empowered eldritch blast"
	charge_max = 8 SECONDS //cooldown
	releasedrain = 40
	projectile_type = /obj/projectile/magic/eldritchblast5e/empowered

/obj/projectile/magic/eldritchblast5e/empowered
	damage = 35
	range = 25

/obj/projectile/magic/eldritchblast5e/empowered/on_hit(atom/target, blocked = FALSE)
	var/atom/throw_target = get_step(target, get_dir(firer, target))
	if(isliving(target))
		var/mob/living/L = target
		if(L.anti_magic_check())
			return BULLET_ACT_BLOCK
		L.throw_at(throw_target, 200, 4)
	else
		if(isitem(target))
			var/obj/item/I = target
			I.throw_at(throw_target, 200, 4)
	playsound(src, 'sound/magic/swap.ogg', 100)
//==============================================
//	ENCODE THOUGHTS
//==============================================
//Fine. I'll add it.
/obj/effect/proc_holder/spell/targeted/encodethoughts5e
	name = "Encode Thoughts"
	desc = "Latch onto the mind of one who is nearby, weaving a particular thought into their mind."
	name = "Encode Thoughts"
	overlay_state = "null"
	releasedrain = 25
	chargetime = 1
	charge_max = 10 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = ""
	invocation_type = "shout" //can be none, whisper, emote and shout
	include_user = FALSE

	attunements = list(
		/datum/attunement/dark = 0.5,
	)

/obj/effect/proc_holder/spell/targeted/encodethoughts5e/cast(list/targets, mob/user)
	. = ..()
	for(var/mob/living/carbon/C in targets)
		if(!C)
			return
		var/message = stripped_input(user, "What thought do you wish to weave into [C]'s mind?")
		if(!message)
			return
		to_chat(C, "Your mind thinks to itself: </span><font color=#7246ff>\"[message]\"</font>")
		to_chat(user, "I pluck the strings of [C]'s mind")
		log_game("[key_name(user)] sent a thought to [key_name(C)] with contents [message]")
		return TRUE
	to_chat(user, span_warning("I wasn't able to find a mind to weave here."))
	return FALSE

/obj/effect/proc_holder/spell/targeted/encodethoughts5e/test
	antimagic_allowed = TRUE

//==============================================
//	GREEN-FLAME BLADE
//==============================================
/obj/effect/proc_holder/spell/invoked/greenflameblade5e
	name = "Green-Flame Blade"
	desc = "An attack that burns all in an aoe around your target."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3
	charge_max = 10 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = "Green flame blade!"
	invocation_type = "shout" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/fire = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/greenflameblade5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/mob/living/L = target
		var/mob/U = user
		var/obj/item/held_item = user.get_active_held_item() //get held item
		var/aoe_range = 1
		if(held_item)
			held_item.melee_attack_chain(U, L)
			L.adjustFireLoss(15) //burn target
			playsound(target, 'sound/items/firesnuff.ogg', 100)
			//burn effect and sound
			for(var/mob/living/M in range(aoe_range, get_turf(target))) //burn non-user mobs in an aoe
				if(!M.anti_magic_check())
					if(M != user)
						M.adjustFireLoss(15) //burn target
						//burn effect and sound
						new /obj/effect/temp_visual/acidsplash5e(get_turf(M))
						playsound(M, 'sound/items/firelight.ogg', 100)
		return TRUE
	return FALSE

/obj/effect/temp_visual/greenflameblade5e
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	name = "green-flame"
	desc = "Magical fire. Interesting."
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER

//==============================================
//	GUIDANCE
//==============================================
/obj/effect/proc_holder/spell/invoked/guidance5e
	name = "Guidance"
	desc = "Increases a targets Intelligence for a brief duration."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 30 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/arcyne = 0.4,
	)

	miracle = FALSE

	invocation = "Light the path."
	invocation_type = "whisper" //can be none, whisper, emote and shout


/obj/effect/proc_holder/spell/invoked/guidance5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/mob/living/carbon/caster = user
		target.visible_message(span_warning("You are being guided by [caster]"), span_notice("You guide [target] "))
		target.apply_status_effect(/datum/status_effect/buff/guidance5e/) // adds guidance
		return TRUE
	return FALSE

/datum/status_effect/buff/guidance5e
	id = "guidance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guidance5e
	duration = 60 SECONDS
	effectedstats = list("intelligence" = 3)
	var/static/mutable_appearance/guided = mutable_appearance('icons/effects/effects.dmi', "blessed")
	var/mob/living/carbon/giver

/datum/status_effect/buff/guidance5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(guided)
	target.update_vision_cone()

/datum/status_effect/buff/guidance5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(guided)
	target.update_vision_cone()
	. = ..()

/atom/movable/screen/alert/status_effect/buff/guidance5e
	name = "Guidance"
	desc = "Someone is guiding me."
	icon_state = "buff"


//==============================================
//	INFESTATION
//==============================================
/obj/effect/proc_holder/spell/invoked/infestation5e
	name = "Infestation"
	desc = "Causes a swarm of bugs to surround your target, bites them and causes sickness."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 10
	charge_max = 20 SECONDS
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
	if(prompt == 1)
		M.add_nausea(pick(10,20))
		to_chat(target, span_warning(message))
		//owner.playsound_local(get_turf(owner), 'sound/surgery/organ2.ogg', 35, FALSE, pressure_affected = FALSE)

/atom/movable/screen/alert/status_effect/buff/infestation5e
	name = "Infestation"
	desc = "Pestilent vermin bite and chew at my skin."
	icon_state = "debuff"

//==============================================
//	LIGHT
//==============================================
/obj/effect/proc_holder/spell/self/light5e
	name = "Light"
	desc = "Summons a condensed orb of light."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	charge_max = 30 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 2
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Let there be light."
	invocation_type = "whisper" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/light = 0.3,
	)

	var/obj/item/item
	var/item_type = /obj/item/flashlight/flare/light5e
	var/delete_old = TRUE //TRUE to delete the last summoned object if it's still there, FALSE for infinite item stream weeeee

/obj/effect/proc_holder/spell/self/light5e/cast(list/targets, mob/user = usr)
	if (delete_old && item && !QDELETED(item))
		QDEL_NULL(item)
	if(user.dropItemToGround(user.get_active_held_item()))
		user.put_in_hands(make_item(), TRUE)
		user.visible_message(span_info("An orb of light condenses in [user]'s hand!"), span_info("You condense an orb of pure light!"))
	return TRUE

/obj/effect/proc_holder/spell/self/light5e/Destroy()
	if(item)
		qdel(item)
	return ..()

/obj/effect/proc_holder/spell/self/light5e/proc/make_item()
	item = new item_type
	var/mutable_appearance/magic_overlay = mutable_appearance('icons/obj/projectiles.dmi', "gumball")
	item.add_overlay(magic_overlay)
	return item

/obj/item/flashlight/flare/light5e
	name = "condensed light"
	desc = "An orb of condensed light."
	w_class = WEIGHT_CLASS_NORMAL
	light_outer_range = 10
	light_color = LIGHT_COLOR_WHITE
	force = 10
	icon = 'icons/roguetown/rav/obj/cult.dmi'
	icon_state = "sphere0"
	item_state = "sphere0"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	light_color = "#ffffff"
	on_damage = 10
	flags_1 = null
	possible_item_intents = list(/datum/intent/use)
	slot_flags = ITEM_SLOT_HIP
	var/datum/looping_sound/torchloop/soundloop
	max_integrity = 200
	fuel = 10 MINUTES
	light_depth = 0
	light_height = 0

/obj/item/flashlight/flare/light5e/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -9,"sy" = 3,"nx" = 12,"ny" = 4,"wx" = -6,"wy" = 5,"ex" = 3,"ey" = 6,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 2,"sturn" = 2,"wturn" = -2,"eturn" = -2,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/flashlight/flare/light5e/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)
	on = TRUE
	START_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/light5e/update_brightness(mob/user = null)
	..()
	item_state = "[initial(item_state)]"

/obj/item/flashlight/flare/light5e/process()
	item_state = "[initial(item_state)]"
	on = TRUE
	update_brightness()
	open_flame(heat)
	if(!fuel || !on)
		//turn_off()
		STOP_PROCESSING(SSobj, src)
		if(!fuel)
			item_state = "[initial(item_state)]"
		return
	if(!istype(loc,/obj/machinery/light/fueled/torchholder))
		if(!ismob(loc))
			if(prob(23))
				//turn_off()
				STOP_PROCESSING(SSobj, src)
				return

/obj/item/flashlight/flare/light5e/turn_off()
	playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
	soundloop.stop()
	STOP_PROCESSING(SSobj, src)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
		M.update_inv_belt()
	damtype = BRUTE
	qdel(src)

/obj/item/flashlight/flare/light5e/fire_act(added, maxstacks)
	if(fuel)
		if(!on)
			playsound(src.loc, 'sound/items/firelight.ogg', 100)
			on = TRUE
			damtype = BURN
			update_brightness()
			force = on_damage
			soundloop.start()
			if(ismob(loc))
				var/mob/M = loc
				M.update_inv_hands()
			START_PROCESSING(SSobj, src)
			return TRUE
	..()

/obj/item/flashlight/flare/light5e/afterattack(atom/movable/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(on)
		if(prob(50) || (user.used_intent.type == /datum/intent/use))
			if(ismob(A))
				A.spark_act()
			else
				A.fire_act(3,3)

/obj/item/flashlight/flare/light5e/spark_act()
	fire_act()

/obj/item/flashlight/flare/light5e/get_temperature()
	if(on)
		return 150+T0C
	return ..()

/obj/item/flashlight/flare/light5e/update_brightness(mob/user = null)
	..()
	if(on)
		item_state = "[initial(item_state)]"
	else
		item_state = "[initial(item_state)]"


//==============================================
//	MAGIC STONE
//==============================================
/obj/effect/proc_holder/spell/invoked/magicstone5e
	name = "Enchant Stone"
	desc = "Enchants a held stone empowering it, useful for grimoire making."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 10
	charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	attunements = list(
		/datum/attunement/earth = 0.3,
	)

	invocation = "Stay sharp and strong."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	var/magic_color = "#c8daff"

/obj/effect/proc_holder/spell/invoked/magicstone5e/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item/natural/stone))
		var/obj/item/natural/stone/S = targets[1]
		if (!S.magicstone)
			to_chat(user, "<span class='info'>[S] is infused with magical energy!</span>")
			S.name = "magic "+S.name
			S.force *= 1.5 //ouchy
			S.throwforce *= 1.5 //ouchy
			S.color = magic_color
			S.magicstone = TRUE
			var/mutable_appearance/magic_overlay = mutable_appearance('icons/effects/effects.dmi', "electricity")
			//PLAY A SOUND OR SOMETHING
			S.add_overlay(magic_overlay)
		else
			to_chat(user, span_warning("That stone can't get any more magical!"))
			return FALSE
	else
		to_chat(user, span_warning("There is no stone here!"))
		return FALSE
	return TRUE

//	MIND SLIVER
//==============================================

/obj/effect/proc_holder/spell/invoked/mindsliver5e
	name = "Mind Sliver"
	desc = "You drive a disorienting spike of psychic energy into the mind of your target. Causing brain damage."
	overlay_state = "null"
	releasedrain = 30
	chargetime = 10
	charge_max = 15 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/dark = 0.5,
	)

	miracle = FALSE

	invocation = "Steal their thoughts!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	var/delay = 7


/obj/effect/proc_holder/spell/invoked/mindsliver5e/cast(list/targets, mob/user)
	var/turf/T = get_turf(targets[1])
	new /obj/effect/temp_visual/mindsliver5e_p1(T)
	sleep(delay)
	new /obj/effect/temp_visual/mindsliver5e_p2(T)
	playsound(T,'sound/magic/charged.ogg', 80, TRUE)
	for(var/mob/living/L in T.contents)
		var/obj/item/organ/brain/brain = L.getorganslot(ORGAN_SLOT_BRAIN)
		brain.applyOrganDamage((brain.maxHealth/8))
		playsound(T, "genslash", 80, TRUE)
		to_chat(L, "<span class='userdanger'>Psychic energy is driven into my skull!!</span>")
	return TRUE

/obj/effect/temp_visual/mindsliver5e_p1
	icon = 'icons/effects/effects.dmi'
	icon_state = "bluestream_fade"
	name = "rippeling psionic energy"
	desc = "Get out of the way!"
	light_outer_range = 2
	duration = 7
	layer = ABOVE_ALL_MOB_LAYER //this doesnt render above mobs? it really should

/obj/effect/temp_visual/mindsliver5e_p2
	icon = 'icons/effects/effects.dmi'
	icon_state = "rift"

	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER


//==============================================
//	Poison Spray
//==============================================
//hold a container in your hand, it's contents turn into a 3-radius smoke, more interesting than the source material
//in the source material this would just be some sort of poison, since we have all sorts of potions, this is better.
//my hope is that it doesn't work with love poiton...
/obj/effect/proc_holder/spell/invoked/poisonspray5e
	name = "Poison Cloud" //renamed to better reflect wtf this does -- vide
	desc = "Hold a container in your hand, it's contents turn into a 3-radius smoke"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3
	charge_max = 20 SECONDS
	//chargetime = 10
	//charge_max = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	antimagic_allowed = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/blood = 0.3,
		/datum/attunement/death = 0.3,
	)

	miracle = FALSE

	invocation = "Poison Cloud!"
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/poisonspray5e/cast(list/targets, mob/living/user)
	var/turf/T = get_turf(targets[1]) //check for turf
	if(T)
		var/obj/item/held_item = user.get_active_held_item() //get held item
		var/obj/item/reagent_containers/con = held_item //get held item
		if(con)
			if(con.spillable)
				if(con.reagents.total_volume > 0)
					var/datum/reagents/R = con.reagents
					var/datum/effect_system/smoke_spread/chem/smoke = new
					smoke.set_up(R, 1, T, FALSE)
					smoke.start()

					user.visible_message(span_warning("[user] sprays the contents of the [held_item], creating a cloud!"), span_warning("You spray the contents of the [held_item], creating a cloud!"))
					con.reagents.clear_reagents() //empty the container
					playsound(user, 'sound/magic/webspin.ogg', 100)
				else
					to_chat(user, "<span class='warning'>The [held_item] is empty!</span>")
					return FALSE
			else
				to_chat(user, "<span class='warning'>I can't get access to the contents of this [held_item]!</span>")
				return FALSE
		else
			to_chat(user, "<span class='warning'>I need to hold a container to cast this!</span>")
			return FALSE
	else
		to_chat(user, "<span class='warning'>I couldn't find a good place for this!</span>")
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/poisonspray5e/test
	antimagic_allowed = TRUE

//==============================================
//	Primal Savagery
//==============================================
/obj/effect/proc_holder/spell/self/primalsavagery5e
	name = "Primal Savagery"
	desc = "For a short duration you develop the ability to inject targets with poisons with each bite."
	clothes_req = FALSE
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/druidic //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/earth = 0.3,
	)

	miracle = FALSE

	invocation = "Teeth of a serpent."
	invocation_type = "whisper" //can be none, whisper, emote and shout
// Notes: Bard, Sorcerer, Warlock, Wizard

/obj/effect/proc_holder/spell/self/primalsavagery5e/cast(mob/user = usr)
	var/mob/living/target = user
	target.apply_status_effect(/datum/status_effect/buff/primalsavagery5e)
	ADD_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	user.visible_message(span_info("[user] looks more primal!"), span_info("You feel more primal."))
	return TRUE

/datum/status_effect/buff/primalsavagery5e
	id = "primal savagery"
	alert_type = /atom/movable/screen/alert/status_effect/buff/primalsavagery5e
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/primalsavagery5e
	name = "Primal Savagery"
	desc = "I have grown venomous fangs inject my victims with poison."
	icon_state = "buff"

/datum/status_effect/buff/primalsavagery5e/on_remove()
	var/mob/living/target = owner
	REMOVE_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	. = ..()

//==============================================
//	RAY OF FROST
//==============================================
// Notes: another projectile, this one slows the target for a short while
/obj/effect/proc_holder/spell/invoked/projectile/rayoffrost5e
	name = "Ray of Frost"
	desc = "Shoots a ray of frost out, slowing anyone hit by it."
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/rayoffrost5e
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	charge_max = 5 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1


	attunements = list(
		/datum/attunement/ice = 0.6,
	)

	miracle = FALSE

	invocation = "Chill!"
	invocation_type = "shout" //can be none, whisper, emote and shout


/obj/projectile/magic/rayoffrost5e
	name = "ray of frost"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "ice_2"
	damage = 25
	damage_type = BRUTE
	flag = "magic"
	range = 15
	speed = 2

/obj/projectile/magic/rayoffrost5e/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'sound/items/stonestone.ogg', 100)
	if(isliving(target))
		var/mob/living/carbon/C = target
		C.apply_status_effect(/datum/status_effect/buff/rayoffrost5e/) //apply debuff
		C.adjustFireLoss(5)

/datum/status_effect/buff/rayoffrost5e
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/rayoffrost5e
	duration = 6 SECONDS
	var/static/mutable_appearance/frost = mutable_appearance('icons/roguetown/mob/coldbreath.dmi', "breath_m", ABOVE_ALL_MOB_LAYER)
	effectedstats = list("speed" = -2)

/atom/movable/screen/alert/status_effect/buff/rayoffrost5e
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"

/datum/status_effect/buff/rayoffrost5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(frost)
	target.update_vision_cone()
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 6 SECONDS)
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)

/datum/status_effect/buff/rayoffrost5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(frost)
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
	. = ..()

/*
XX	added
X	added, needs work
S	skipped, might add later
SS	skipped

XX	Acid Splash			Conjuration		1 Action		60 Feet				Instantaneous	V, S
XX 	Blade Ward			Abjuration		1 Action		Self				1 round			V, S
X 	Booming Blade		Evocation		1 Action		Self (5-foot radius)1 round			S, M
XX 	Chill Touch			Necromancy		1 Action		120 feet			1 round			V, S
SS 	Control Flames		Transmutation	1 Action		60 Feet				Instantaneous	S
XX 	Create Bonfire		Conjuration		1 Action		60 Feet				1 minute		V, S
S 	Dancing Lights		Evocation		1 Action		120 feet			1 minute		V, S, M
X 	Decompose (HB)		Necromancy		1 Action		Touch				1 minute		V, S
SS 	Druidcraft			Transmutation	1 Action		30 Feet				Instantaneous	V, S
XX 	Eldritch Blast		Evocation		1 Action		120 Feet			Instantaneous	V, S
XX 	Encode Thoughts		Enchantment		1 Action		Self				8 hours			S
XX 	Fire Bolt			Evocation		1 Action		120 feet			Instantaneous	V, S
SS 	Friends				Enchantment		1 Action		Self				1 minute		S, M
XX 	Frostbite			Evocation		1 Action		60 feet				Instantaneous	V, S
X	Green-Flame Blade	Evocation		1 Action		Self (5-foot radius)Instantaneous	S, M
XX 	Guidance			Divination		1 Action		Touch				1 minute		V, S
S 	Gust				Transmutation	1 Action		30 feet				Instantaneous	V, S
S 	Hand of Radiance	Evocation		1 Action		5 feet				Instantaneous	V, S
XX 	Infestation			Conjuration		1 Action		30 feet				Instantaneous	V, S, M
XX 	Light				Evocation		1 Action		Touch				1 hour			V, M
XX	Lightning Lure		Evocation		1 Action		Self(15-foot radius)Instantaneous	V
S	Mage Hand			Conjuration		1 Action		30 feet				1 minute		V, S
XX	Magic Stone			Transmutation	1 Bonus Action	Touch				1 minute		V, S
XX	Mending				Transmutation	1 Minute		Touch				Instantaneous	V, S, M
SS 	Message				Transmutation	1 Action		120 feet			1 round			V, S, M
XX	Mind Sliver			Enchantment		1 Action		60 feet				1 round			V
S	Minor Illusion		Illusion		1 Action		30 feet				1 minute		S, M
SS	Mold Earth			Transmutation	1 Action		30 feet				Instantaneous	S
S	On/Off (UA)			Transmutation 	1 Action		60 feet				Instantaneous	V, S
XX	Poison Spray		Conjuration		1 Action		10 feet				Instantaneous	V, S
SS	Prestidigitation	Transmutation	1 Action		10 feet				Up to 1 hour	V, S
XX	Primal Savagery		Transmutation	1 Action		Self				Self			S
SS	Produce Flame		Conjuration		1 Action		Self				10 minutes		V, S
XX	Ray of Frost		Evocation		1 Action		60 feet				Instantaneous	V, S
SS	Resistance			Abjuration		1 Action		Touch				Concentration	V, S, M
SS	Sacred Flame		Evocation		1 Action		60 feet				Instantaneous	V, S
X	Sapping Sting		Necromancy		1 Action		30 feet				Instantaneous	V, S
SS	Shape Water			Transmutation	1 Action		30 feet				Instantaneous 	S
X	Shillelagh			Transmutation	1 Bonus Action	Touch				1 minute		V, S, M
X	Shocking Grasp		Evocation		1 Action		Touch				Instantaneous	V, S
S	Spare the Dying		Necromancy		1 Action		Touch				Instantaneous	V, S
SS	Sword Burst			Conjuration		1 Action		Self				Instantaneous	V
SS	Thaumaturgy			Transmutation	1 Action		30 feet				Up to 1 minute	V
	Thorn Whip			Transmutation	1 Action		30 feet				Instantaneous	V, S, M
	Thunderclap			Evocation		1 Action		Self				Instantaneous	S
	Toll the Dead		Necromancy		1 Action		60 feet				Instantaneous	V, S
	True Strike			Divination		1 Action		30 feet				Concentration	S
XX	Vicious Mockery		Enchantment		1 Action		60 feet				Instantaneous	V
	Virtue (UA)			Abjuration		1 Action		Touch				1 round			V, S
S	Word of Radiance	Evocation		1 Action		5 feet				Instantaneous	V, M
*/
