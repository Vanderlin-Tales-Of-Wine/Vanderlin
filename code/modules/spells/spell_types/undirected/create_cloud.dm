// Orginially /poisonspray
/datum/action/cooldown/spell/undirected/create_cloud
	name = "Create Cloud"
	desc = "Hold a container in your hand, it's contents turn into a 3-radius smoke"
	button_icon_state = "aerosolize"
	sound = 'sound/magic/whiteflame.ogg'

	point_cost = 1

	charge_required = FALSE
	cooldown_time = 40 SECONDS
	spell_cost = 50

	invocation = "Create cloud!"
	invocation_type = INVOCATION_SHOUT

	attunements = list(
		/datum/attunement/blood = 0.3,
		/datum/attunement/death = 0.3,
	)

/datum/action/cooldown/spell/undirected/create_cloud/cast(atom/cast_on)
	. = ..()
	var/obj/item/held_item = owner.get_active_held_item()
	if(held_item?.is_open_container())
		return
	var/datum/reagents/reagents = held_item.reagents
	if(!reagents.total_volume)
		return
	var/datum/effect_system/smoke_spread/chem/smoke = new
	smoke.set_up(reagents, 3, get_turf(owner), FALSE)
	smoke.start()

