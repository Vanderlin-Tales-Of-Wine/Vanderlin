#define CONJURE_DURATION 3 MINUTES

/obj/effect/proc_holder/spell/self/magicians_brick
	name = "Magician's Brick"
	desc = "Conjure a magical brick in your hand. Its power scale up to your Intelligence\n\
	The brick lasts for 3 minutes. This spell has been honed over centuries to bypass anti-magic defenses \n\ "
	overlay_state = "magicians_brick"
	sound = list('sound/magic/whiteflame.ogg')

	releasedrain = 30
	recharge_time = 5 SECONDS // Quite spammable

	warnie = "spellwarning"
	antimagic_allowed = FALSE
	charging_slowdown = 3
	cost = 1

	invocation = "Valtarem!"
	invocation_type = "shout"

	attunements = list(
		/datum/attunement/earth = 0.3,
	)

/obj/effect/proc_holder/spell/self/magicians_brick/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/effect/proc_holder/spell/self/magicians_brick/cast(list/targets, mob/living/user = usr)
	var/obj/item/weapon/R = new /obj/item/weapon/magicbrick(user.drop_location())
	R.AddComponent(/datum/component/conjured_item, CONJURE_DURATION)

	if(user.STAINT > 10)
		var/int_scaling = user.STAINT - 10
		R.force = (R.force + int_scaling) * attuned_strength
		R.throwforce = (R.throwforce + int_scaling * 2 )* attuned_strength // 2x scaling for throwing. Let's go.
		R.name = "magician's brick +[int_scaling]"
	user.put_in_hands(R)
	return TRUE

/obj/item/weapon/magicbrick
	name = "magician's brick"
	desc = "A brick formed out of arcane energy. Not a actual brick and cannot be used for construction. Makes for a very deadly melee and throwing weapon."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claybrickcook"
	dropshrink = 0.75
	force = 15 // Copy pasted from real brick + 1 for neat number
	throwforce = 20 // +2 from real brick for neat scaling
	throw_speed = 4
	armor_penetration = 30 // From iron tossblade
	wdefense = 0
	wbalance = 0
	max_integrity = 50 // Don't parry with it lol
	slot_flags = ITEM_SLOT_MOUTH
	obj_flags = null
	w_class = WEIGHT_CLASS_TINY
	possible_item_intents = list(/datum/intent/mace/strike) // Not giving it smash so it don't become competetive with conjure weapon (as a melee weapon)
	associated_skill = /datum/skill/combat/axesmaces // If it was tied to Arcane it'd be too strong
	hitsound = list('sound/combat/hits/blunt/brick.ogg')


#undef CONJURE_DURATION
