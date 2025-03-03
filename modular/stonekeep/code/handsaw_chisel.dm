#define BCLASS_CHISEL			"chisel"

//................	Handsaw	............... //
/obj/item/weapon/handsaw
	force = 5
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver)
	gripped_intents = null
	name = "handsaw"
	desc = "Iron tool for woodworking."
	icon_state = "handsaw"
	item_state = "handsaw"
	icon = 'modular/stonekeep/icons/crafting.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/onmob.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	grid_width = 32
	grid_height = 96
	sharpness = IS_SHARP
	wdefense = 0
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	tool_behaviour = TOOL_IMPROVISED_SAW
	swingsound = list('sound/combat/wooshes/blunt/shovel_swing.ogg','sound/combat/wooshes/blunt/shovel_swing2.ogg')
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/knives
	max_blade_int = 50

//................	Chisel	............... //
/obj/item/weapon/chisel
	name = "chisel"
	desc = "Add something to strike it with before doing stonework. Like a mallet or a stone."
	icon_state = "chisel"
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	grid_width = 32
	grid_height = 64
	force = 10
	throwforce = 2
	possible_item_intents = list(/datum/intent/stab)
	sharpness = IS_SHARP
	dropshrink = 0.9
	w_class = WEIGHT_CLASS_SMALL
	wdefense = 0
	blade_dulling = 0
	max_integrity = 140
	slot_flags = ITEM_SLOT_HIP
	swingsound = list('sound/combat/wooshes/blunt/shovel_swing.ogg','sound/combat/wooshes/blunt/shovel_swing2.ogg')
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	associated_skill = /datum/skill/combat/knives
	max_blade_int = 50
	dropshrink = 0.9
	var/already_assembled

/obj/item/weapon/chisel/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if(already_assembled)
		return

	if(istype(W,/obj/item/natural/stoneblock))
		playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/weapon/chisel/assembly/stoneblock/F = new(src.loc)
		qdel(W)
		user.put_in_hands(F)
		qdel(src)
		return

	else if(istype(W,/obj/item/natural/stone))
		playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/weapon/chisel/assembly/stone/F = new(src.loc)
		qdel(W)
		user.put_in_hands(F)
		qdel(src)
		return

	else if(istype(W, /obj/item/weapon/hammer/steel))
		playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/weapon/chisel/assembly/hammerclaw/F = new(src.loc)
		qdel(W)
		user.put_in_hands(F)
		qdel(src)
		return

	else if(istype(W, /obj/item/weapon/hammer/iron))
		playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/weapon/chisel/assembly/hammer/F = new(src.loc)
		qdel(W)
		user.put_in_hands(F)
		qdel(src)
		return

	else if(istype(W, /obj/item/weapon/hammer/wood))
		playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
		user.visible_message("<span class='info'>[user] adds a striking tool to the chisel set.</span>")
		var/obj/item/weapon/chisel/assembly/mallet/F = new(src.loc)
		qdel(W)
		user.put_in_hands(F)
		qdel(src)
		return

//................	Chisel toolset	............... //
/obj/item/weapon/chisel/assembly	// template
	name = "chisel set"
	desc = "Ready to shape stones when held in a steady grip. Can be separated easily."
	grid_width = 64
	grid_height = 64
	possible_item_intents = list(/datum/intent/hit)
	gripped_intents =  list(/datum/intent/chisel)
	already_assembled = TRUE

/obj/item/weapon/chisel/assembly/mallet
	icon_state = "chiselm"
	item_state = "hammer_w"
/obj/item/weapon/chisel/assembly/mallet/attack_right(mob/user)
	var/obj/item/weapon/chisel/F = new(user.loc)
	var/obj/item/weapon/hammer/wood/E = new(user.loc)
	user.put_in_hands(E)
	playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
	qdel(src)
	user.put_in_hands(F)

/obj/item/weapon/chisel/assembly/hammer
	icon_state = "chiselh"
	item_state = "hammer_i"
/obj/item/weapon/chisel/assembly/hammer/attack_right(mob/user)
	var/obj/item/weapon/chisel/F = new(user.loc)
	var/obj/item/weapon/hammer/iron/E = new(user.loc)
	user.put_in_hands(E)
	playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
	qdel(src)
	user.put_in_hands(F)

/obj/item/weapon/chisel/assembly/hammerclaw
	icon_state = "chiselc"
	item_state = "hammer_s"
/obj/item/weapon/chisel/assembly/hammerclaw/attack_right(mob/user)
	var/obj/item/weapon/chisel/F = new(user.loc)
	var/obj/item/weapon/hammer/steel/E = new(user.loc)
	user.put_in_hands(E)
	playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
	qdel(src)
	user.put_in_hands(F)

/obj/item/weapon/chisel/assembly/stone
	icon_state = "chisels"
	item_state = "stone"
/obj/item/weapon/chisel/assembly/stone/attack_right(mob/user)
	var/obj/item/weapon/chisel/F = new(user.loc)
	var/obj/item/natural/stone/E = new(user.loc)
	user.put_in_hands(E)
	playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
	qdel(src)
	user.put_in_hands(F)

/obj/item/weapon/chisel/assembly/stoneblock
	icon_state = "chiselb"
	item_state = "block"
/obj/item/weapon/chisel/assembly/stoneblock/attack_right(mob/user)
	var/obj/item/weapon/chisel/F = new(user.loc)
	var/obj/item/natural/stoneblock/E = new(user.loc)
	user.put_in_hands(E)
	playsound(get_turf(user.loc), 'modular/stonekeep/sound/brick_drop.ogg', 100)
	qdel(src)
	user.put_in_hands(F)


/datum/intent/chisel
	name = "chisel"
	icon_state = "inchisel"
	attack_verb = list("chisels")
	hitsound = list('sound/combat/hits/pick/genpick (1).ogg', 'sound/combat/hits/pick/genpick (2).ogg')
	animname = "strike"
	item_damage_type = "stab"
	blade_class = BCLASS_CHISEL
	chargetime = 0
	swingdelay = 3



/obj/item/natural/stone/attackby(obj/item/W, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/craft/masonry)
	var/work_time = (35 - (skill_level * 5))
	if(istype(W, /obj/item/natural/stone))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message(span_info("[user] strikes the stones together."))
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
	if( user.used_intent.type == /datum/intent/chisel )
		playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
		user.visible_message("<span class='info'>[user] chisels the stone into a block.</span>")
		if(do_after(user, work_time))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/effect/decal/cleanable/debris/stony(get_turf(src))
			playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
			qdel(src)
			user.mind.add_sleep_experience(/datum/skill/craft/masonry, (user.STAINT*0.2))
		return
	else if(istype(W, /obj/item/weapon/chisel/assembly))
		to_chat(user, span_warning("You most use both hands to chisel blocks."))
	else
		..()

/obj/item/natural/stone/pre_attack_right(atom/A, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(A, /obj/item/natural/stone))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message(span_info("[user] strikes the stones together."))
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
		return
	if(istype(A, /obj/item/natural/rock))
		user.visible_message(span_info("[user] strikes the stone against the rock.</span>"))
		playsound(src.loc, 'sound/items/stonestone.ogg', 100)
		if(prob(35))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
		return
	. = ..()

/obj/structure/roguerock/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if( user.used_intent.type == /datum/intent/chisel )
		playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
		user.visible_message("<span class='info'>[user] chisels the rock into blocks.</span>")
		if(do_after(user, 10 SECONDS))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/effect/decal/cleanable/debris/stony(get_turf(src))
			playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
			user.mind.add_sleep_experience(/datum/skill/craft/masonry, (user.STAINT*1))
			qdel(src)
		return
	else if(istype(W, /obj/item/weapon/chisel/assembly))
		to_chat(user, span_warning("You most use both hands to chisel blocks."))


/obj/item/natural/rock/attackby(obj/item/W, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/craft/masonry)
	var/work_time = (120 - (skill_level * 15))
	if(user.cmode)
		if(istype(W, /obj/item/natural/stone))
			user.visible_message(span_info("[user] strikes the stone against the rock.</span>"))
			playsound(src.loc, 'sound/items/stonestone.ogg', 100)
			if(prob(35))
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_turf(src)
				S.set_up(1, 1, front)
				S.start()
			return
		if(istype(W, /obj/item/natural/rock))
			playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
			user.visible_message(span_info("[user] strikes the rocks together."))
			if(prob(10))
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_turf(src)
				S.set_up(1, 1, front)
				S.start()
			return
	if( user.used_intent.type == /datum/intent/chisel )
		playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
		user.visible_message("<span class='info'>[user] chisels the rock into blocks.</span>")
		if(do_after(user, work_time))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/effect/decal/cleanable/debris/stony(get_turf(src))
			playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
			user.mind.add_sleep_experience(/datum/skill/craft/masonry, (user.STAINT*0.5))
			qdel(src)
		return
	else if(istype(W, /obj/item/weapon/chisel/assembly))
		to_chat(user, span_warning("You most use both hands to chisel blocks."))
	..()


//................	Stone blocks	............... //
/obj/item/natural/stoneblock
	name = "stone block"
	desc = "A rectangular stone block for building."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	icon_state = "stoneblock"
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	item_state = "block"
	experimental_inhand = FALSE
	drop_sound = 'modular/stonekeep/sound/brick_drop.ogg'
	hitsound = 'modular/stonekeep/sound/brick_drop.ogg'
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 18
	w_class = WEIGHT_CLASS_SMALL
	bundletype = /obj/item/natural/bundle/stoneblock
	sellprice = 2

//................ Stone block stack	............... //
/obj/item/natural/bundle/stoneblock
	name = "stack of stone blocks"
	desc = "A stack of stone blocks."
	icon_state = "stoneblockbundle1"
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	item_state = "block"
	experimental_inhand = FALSE
	grid_width = 64
	grid_height = 64
	base_width = 64
	base_height = 64
	drop_sound = 'modular/stonekeep/sound/brick_drop.ogg'
	hitsound = list('sound/combat/hits/blunt/shovel_hit.ogg', 'sound/combat/hits/blunt/shovel_hit2.ogg', 'sound/combat/hits/blunt/shovel_hit3.ogg')
	pickup_sound = 'modular/stonekeep/sound/brick_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 2
	throwforce = 0	// useless for throwing unless solo
	throw_range = 2
	w_class = WEIGHT_CLASS_NORMAL
	stackname = "stone blocks"
	stacktype = /obj/item/natural/stoneblock
	maxamount = 4
	icon1 = "stoneblockbundle2"
	icon1step = 3
	icon2 = "stoneblockbundle3"
	icon2step = 4





//................	Wooden planks	............... //
/obj/item/natural/wood/plank
	name = "wooden plank"
	desc = "A flat piece of wood, useful for flooring."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	icon_state = "plank"
	experimental_inhand = FALSE
	grid_width = 64
	grid_height = 224
	attacked_sound = 'sound/misc/woodhit.ogg'
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 6
	throwforce = 0
	obj_flags = null
	resistance_flags = FLAMMABLE
	slot_flags = null
	max_integrity = 20
	firefuel = 5 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	bundletype = /obj/item/natural/bundle/plank
	smeltresult = /obj/item/ash

//................	Wooden plan stack	............... //
/obj/item/natural/bundle/plank
	name = "stack of wooden planks"
	desc = "Several planks in a neat pile."
	icon_state = "plankbundle1"
	item_state = "plankbundle"
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	grid_width = 128
	grid_height = 224
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	throw_range = 2
	firefuel = 10 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	stackname = "plank"
	stacktype = /obj/item/natural/wood/plank
	maxamount = 6
	icon1 = "plankbundle2"
	icon1step = 3
	icon2 = "plankbundle3"
	icon2step = 5
	smeltresult = /obj/item/ash


//................	Glass panes	............... //
/obj/item/natural/glass
	name = "glass"
	desc = "Windowpanes for construction work."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "glasspane"
	dropshrink = 0.8
	grid_width = 64
	grid_height = 64
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 8
	throw_range = 5
	obj_flags = null
	max_integrity = 20
	w_class = WEIGHT_CLASS_BULKY
	bundletype = /obj/item/natural/bundle/glass
	sellprice = 6
/obj/item/natural/glass/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(!..()) //was it caught by a mob?
		new /obj/item/natural/glass_shard(get_turf(src))
		pixel_x = rand(-3, 3)
		pixel_y = rand(-3, 3)
		new /obj/effect/decal/cleanable/debris/glassy(get_turf(src))
		playsound(src, 'modular/stonekeep/sound/glass_shatter.ogg', 90, TRUE)
		qdel(src)


//................	Glass panes stack	............... //
/obj/item/natural/bundle/glass
	name = "stack of glass"
	desc = "A stack of fragile glass panes."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "glasspane1"
	item_state = "glasspane"
	dropshrink = 0.8
	grid_width = 64
	grid_height = 64
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 15
	throwforce = 18
	throw_range = 2
	firefuel = null
	resistance_flags = null
	firemod = null
	w_class = WEIGHT_CLASS_HUGE
	stackname = "glass"
	stacktype = /obj/item/natural/glass
	maxamount = 3
	icon1 = "glasspane1"
	icon1step = 2
	icon2 = "glasspane2"
	icon2step = 3
/obj/item/natural/bundle/glass/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(!..()) //was it caught by a mob?
		new /obj/item/natural/glass_shard(get_turf(src))
		pixel_x = rand(-3, 3)
		pixel_y = rand(-3, 3)
		new /obj/item/natural/glass_shard(get_turf(src))
		new /obj/effect/decal/cleanable/debris/glassy(get_turf(src))
		playsound(src, 'modular/stonekeep/sound/glass_shatter.ogg', 95, TRUE)
		qdel(src)

//................	Glass shard	............... //
/obj/item/natural/glass_shard
	name = "shard"
	desc = "A sharp shard of glass."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "shard1"
	item_state = "shard"
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/stab)
	force = 3
	throwforce = 5
	resistance_flags = null
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	max_integrity = 40
	smeltresult = /obj/item/natural/glass
/obj/item/natural/glass_shard/New()
	..()
	icon_state = "shard[rand(1,3)]"
/obj/item/natural/glass_shard/Crossed(mob/living/L)
	. = ..()
	playsound(loc,'modular/stonekeep/sound/glass_step.ogg', 100, FALSE)


/obj/item/natural/glass/shard
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	item_state = "shard"

/obj/effect/decal/cleanable/debris/stony	// temp ROGTODO
