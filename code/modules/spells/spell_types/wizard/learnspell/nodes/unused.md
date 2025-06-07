/datum/spell_node/arcane_focus
	name = "Arcane Focus"
	desc = "Concentrate pure magical energy."
	cost = 5
	node_x = 275
	node_y = 250
	prerequisites = list(/datum/spell_node/mind_sliver, /datum/spell_node/expanded_reserves)

/datum/spell_node/arcane_focus/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/arcyne, 0.2)
	to_chat(user, span_notice("Pure magical energy concentrates within you."))

/datum/spell_node/earth_shaper
	name = "Earth Shaper"
	desc = "Command the bones of the world."
	cost = 6
	node_x = -150
	node_y = 350
	prerequisites = list(/datum/spell_node/decompose, /datum/spell_node/elemental_harmony)

/datum/spell_node/earth_shaper/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/earth, 0.25)
	user.mana_pool?.adjust_attunement(/datum/attunement/fire, 0.05)
	to_chat(user, span_notice("The earth's strength becomes your own."))

/datum/spell_node/light_bearer
	name = "Light Bearer"
	desc = "Become a beacon of pure radiance."
	cost = 6
	node_x = -50
	node_y = 350
	prerequisites = list(/datum/spell_node/elemental_harmony)

/datum/spell_node/light_bearer/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/light, 0.25)
	user.mana_pool?.adjust_attunement(/datum/attunement/fire, 0.05)
	user.mana_pool?.adjust_attunement(/datum/attunement/ice, 0.05)
	to_chat(user, span_notice("Radiant light fills your being."))

/datum/spell_node/void_touched
	name = "Void Touched"
	desc = "Embrace the darkness between stars."
	cost = 6
	node_x = 50
	node_y = 350
	prerequisites = list(/datum/spell_node/blood_pact, /datum/spell_node/storm_caller)

/datum/spell_node/void_touched/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/dark, 0.25)
	user.mana_pool?.adjust_attunement(/datum/attunement/death, 0.1)
	to_chat(user, span_notice("Darkness embraces you like an old friend."))

/datum/spell_node/time_walker
	name = "Time Walker"
	desc = "Perceive the flow of temporal currents."
	cost = 6
	node_x = 150
	node_y = 350
	prerequisites = list(/datum/spell_node/encode_thoughts, /datum/spell_node/arcane_focus)

/datum/spell_node/time_walker/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/time, 0.25)
	user.mana_pool?.adjust_attunement(/datum/attunement/arcyne, 0.1)
	to_chat(user, span_notice("Time flows differently around you."))

/datum/spell_node/life_weaver
	name = "Life Weaver"
	desc = "Channel the essence of living things."
	cost = 6
	node_x = 250
	node_y = 350
	prerequisites = list(/datum/spell_node/primal_savagery, /datum/spell_node/find_familiar)

/datum/spell_node/life_weaver/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/life, 0.25)
	user.mana_pool?.adjust_attunement(/datum/attunement/earth, 0.1)
	to_chat(user, span_notice("The essence of life pulses within you."))

/datum/spell_node/deep_reserves
	name = "Deep Reserves"
	desc = "Vastly expand your magical capacity."
	cost = 8
	node_x = 350
	node_y = 350
	prerequisites = list(/datum/spell_node/mana_well, /datum/spell_node/time_walker)

/datum/spell_node/deep_reserves/on_node_buy(mob/user)
	var/current_max = user.mana_pool?.maximum_mana_capacity || 100
	user.mana_pool?.set_max_mana(current_max + 100, TRUE, TRUE)
	to_chat(user, span_notice("Your magical capacity expands dramatically."))

/datum/spell_node/mana_surge
	name = "Mana Surge"
	desc = "Dramatically improve mana regeneration."
	cost = 8
	node_x = 450
	node_y = 350
	prerequisites = list(/datum/spell_node/meditation, /datum/spell_node/mana_well)

/datum/spell_node/mana_surge/on_node_buy(mob/user)
	user.mana_pool?.set_natural_recharge(user.mana_pool.ethereal_recharge_rate + 0.5)
	to_chat(user, span_notice("Mana flows through you like a raging river."))

/datum/spell_node/aeromancer
	name = "Aeromancer"
	desc = "Master the winds and sky."
	cost = 8
	node_x = -100
	node_y = 450
	prerequisites = list(/datum/spell_node/light_bearer, /datum/spell_node/earth_shaper)

/datum/spell_node/aeromancer/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/aeromancy, 0.3)
	user.mana_pool?.adjust_attunement(/datum/attunement/electric, 0.1)
	user.mana_pool?.adjust_attunement(/datum/attunement/light, 0.1)
	to_chat(user, span_notice("The winds themselves answer your call."))

/datum/spell_node/polymorph_adept
	name = "Polymorph Adept"
	desc = "Master the art of transformation."
	cost = 8
	node_x = 100
	node_y = 450
	prerequisites = list(/datum/spell_node/life_weaver, /datum/spell_node/time_walker)

/datum/spell_node/polymorph_adept/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/polymorph, 0.3)
	user.mana_pool?.adjust_attunement(/datum/attunement/life, 0.1)
	user.mana_pool?.adjust_attunement(/datum/attunement/time, 0.1)
	to_chat(user, span_notice("Your form becomes fluid and malleable."))

/datum/spell_node/arcyne_master
	name = "Arcane Master"
	desc = "Achieve mastery over pure magic."
	cost = 8
	node_x = 200
	node_y = 450
	prerequisites = list(/datum/spell_node/time_walker, /datum/spell_node/void_touched)

/datum/spell_node/arcyne_master/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/arcyne, 0.4)
	user.mana_pool?.adjust_attunement(/datum/attunement/time, 0.1)
	user.mana_pool?.adjust_attunement(/datum/attunement/dark, 0.1)
	to_chat(user, span_notice("Pure magic flows through your very essence."))

/datum/spell_node/omnimancer
	name = "Omnimancer"
	desc = "Transcend the boundaries of magical schools."
	cost = 12
	node_x = 0
	node_y = 550
	prerequisites = list(/datum/spell_node/aeromancer, /datum/spell_node/illusionist, /datum/spell_node/polymorph_adept)

/datum/spell_node/omnimancer/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/fire, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/ice, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/electric, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/blood, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/life, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/death, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/earth, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/light, 0.15)
	user.mana_pool?.adjust_attunement(/datum/attunement/dark, 0.15)
	to_chat(user, span_notice("You transcend the boundaries between magical schools."))

/datum/spell_node/reality_anchor
	name = "Reality Anchor"
	desc = "Become a fixed point in the flow of magic."
	cost = 12
	node_x = 150
	node_y = 550
	prerequisites = list(/datum/spell_node/omnimancer, /datum/spell_node/eternal_wellspring)

/datum/spell_node/reality_anchor/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/time, 0.3)
	user.mana_pool?.adjust_attunement(/datum/attunement/aeromancy, 0.2)
	user.mana_pool?.adjust_attunement(/datum/attunement/arcyne, 0.3)
	user.mana_pool?.adjust_attunement(/datum/attunement/illusion, 0.2)
	user.mana_pool?.adjust_attunement(/datum/attunement/polymorph, 0.2)
	var/current_max = user.mana_pool?.maximum_mana_capacity || 100
	user.mana_pool?.set_max_mana(current_max + 150, TRUE, TRUE)
	user.mana_pool?.set_natural_recharge(user.mana_pool.ethereal_recharge_rate + 0.75)
	to_chat(user, span_notice("You become an immutable anchor in the fabric of reality itself."))
