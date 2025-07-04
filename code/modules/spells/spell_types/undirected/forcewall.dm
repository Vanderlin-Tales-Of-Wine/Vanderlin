/datum/action/cooldown/spell/undirected/forcewall
	name = "Forcewall"
	desc = "Conjure a wall of arcyne force, preventing anyone and anything other than you from moving through it."
	button_icon_state = "forcewall"

	point_cost = 3
	attunements = list(
		/datum/attunement/illusion = 0.3,
	)
	school = SCHOOL_TRANSMUTATION

	charge_time = 2 SECONDS
	charge_drain = 1
	charge_slowdown = 3
	cooldown_time = 35 SECONDS
	spell_cost = 30

	var/wall_type = /obj/effect/forcefield/wizard

/datum/action/cooldown/spell/undirected/forcewall/cast(atom/cast_on)
	. = ..()

	if(owner.dir == SOUTH || owner.dir == NORTH)
		new wall_type(get_step(owner, EAST), owner, antimagic_flags)
		new wall_type(get_step(owner, WEST), owner, antimagic_flags)

	else
		new wall_type(get_step(owner, NORTH), owner, antimagic_flags)
		new wall_type(get_step(owner, SOUTH), owner, antimagic_flags)

/datum/action/cooldown/spell/undirected/forcewall/breakable
	name = "Lesser Forcewall"
	wall_type = /obj/structure/forcefield/casted
