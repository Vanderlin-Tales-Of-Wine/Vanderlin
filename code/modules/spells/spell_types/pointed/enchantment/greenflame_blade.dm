/datum/action/cooldown/spell/enchantment/green_flame
	name = "Green-Flame Blade"
	desc = "Enchant a weapon with searing flames."
	button_icon_state = "enchant_weapon"

	point_cost = 1
	attunements = list(
		/datum/attunement/fire = 0.3,
	)

	charge_required = FALSE
	spell_cost = 50

	enchantment = SEARING_BLADE_ENCHANT
