/obj/effect/proc_holder/spell/invoked/projectile/arcanebolt
	name = "Arcane Bolt"
	desc = "Shoot out rapid bolts of arcane magic, that firmly hits on impact."
	range = 12
	projectile_type = /obj/projectile/magic/energy/rogue3
	overlay_state = "force_dart"
	sound = list('sound/magic/vlightning.ogg')
	active = FALSE
	releasedrain = 20
	chargedrain = 1
	chargetime = 7
	recharge_time = 5 SECONDS
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
	overlay_state = "arcane_bolt"

/obj/effect/proc_holder/spell/invoked/projectile/arcanebolt/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/projectile/magic/energy/rogue3
	name = "arcane bolt"
	icon_state = "arcane_barrage"
	damage = 30
	damage_type = BRUTE
	armor_penetration = 10
	nodamage = FALSE
	flag = "piercing"
	hitsound = 'sound/blank.ogg'
	speed = 2

/obj/projectile/magic/energy/rogue3/modify_matrix(matrix/matrix)
	var/strength = min(max(0.1, spell_source?.attuned_strength || 1),10)
	return matrix.Scale(strength, strength)

/obj/projectile/magic/energy/rogue3/Initialize()
	. = ..()
	var/obj/effect/proc_holder/spell/spell_ref = spell_source
	if(spell_ref?.attuned_strength)
		var/strength = spell_ref.attuned_strength
		damage = round(damage * spell_ref.attuned_strength)
		armor_penetration = round(armor_penetration * spell_ref.attuned_strength)
		var/matrix/matrix = matrix()
		matrix.Scale(strength, strength)
		transform = matrix
