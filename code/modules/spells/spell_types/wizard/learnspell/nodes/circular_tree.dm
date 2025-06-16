/datum/spell_node/arcyne_eye
	name = "Arcane Eye"
	desc = "Create an invisible, magical eye."
	node_x = 0
	node_y = 0
	spell_type = /obj/effect/proc_holder/spell/self/arcyne_eye

/datum/spell_node/illusionist
	name = "Illusionist"
	desc = "Bend reality with deception and trickery."
	cost = 8
	node_x = 50
	node_y = -50
	prerequisites = list(/datum/spell_node/air_affinity, /datum/spell_node/death_affinity)
	is_passive = TRUE

/datum/spell_node/illusionist/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/illusion, 0.3)
	user.mana_pool?.adjust_attunement(/datum/attunement/dark, 0.1)
	user.mana_pool?.adjust_attunement(/datum/attunement/light, 0.1)
	to_chat(user, span_notice("Reality bends to your whims."))

/datum/spell_node/nondetection
	name = "Nondetection"
	desc = "Hide a target from divination magic."
	node_x = 90
	node_y = -110
	prerequisites = list(/datum/spell_node/illusionist)
	spell_type = /obj/effect/proc_holder/spell/targeted/touch/nondetection

/datum/spell_node/forcewall_weak
	name = "Weak Force Wall"
	desc = "Create a weak barrier of magical force."
	node_x = 110
	node_y = -90
	prerequisites = list(/datum/spell_node/illusionist)
	spell_type = /obj/effect/proc_holder/spell/invoked/forcewall_weak

/datum/spell_node/mana_well
	name = "Mana Well"
	desc = "Dig deeper into your magical reserves."
	node_x = -290
	node_y = 290
	cost = 6
	is_passive = TRUE

/datum/spell_node/mana_well/on_node_buy(mob/user)
	var/current_max = user.mana_pool?.maximum_mana_capacity || 100
	user.mana_pool?.set_max_mana(current_max + 50, TRUE, TRUE)
	user.mana_overload_threshold += 50
	to_chat(user, span_notice("Your magical well deepens considerably."))

/datum/spell_node/meditation
	name = "Meditation"
	desc = "Improve your natural mana recovery."
	cost = 6
	node_x = -290
	node_y = 390
	prerequisites = list(/datum/spell_node/mana_well)
	is_passive = TRUE

/datum/spell_node/meditation/on_node_buy(mob/user)
	user.mana_pool?.set_natural_recharge(user.mana_pool.ethereal_recharge_rate + 0.25)
	to_chat(user, span_notice("Your mind achieves greater focus and clarity."))

/datum/spell_node/expanded_reserves
	name = "Expanded Reserves"
	desc = "Increase your magical capacity."
	cost = 8
	node_x = -390
	node_y = 290
	prerequisites = list(/datum/spell_node/mana_well)
	is_passive = TRUE

/datum/spell_node/expanded_reserves/on_node_buy(mob/user)
	var/current_max = user.mana_pool?.maximum_mana_capacity || 100
	user.mana_pool?.set_max_mana(current_max + 100, TRUE, TRUE)
	user.mana_overload_threshold += 100
	to_chat(user, span_notice("Your magical reserves expand."))

/datum/spell_node/eternal_wellspring
	name = "Eternal Wellspring"
	desc = "Achieve perfect harmony with magical forces."
	cost = 12
	node_x = -440
	node_y = 440
	prerequisites = list(/datum/spell_node/expanded_reserves, /datum/spell_node/meditation)
	is_passive = TRUE

/datum/spell_node/eternal_wellspring/on_node_buy(mob/user)
	var/current_max = user.mana_pool?.maximum_mana_capacity || 100
	user.mana_pool?.set_max_mana(current_max + 200, TRUE, TRUE)
	user.mana_pool?.set_natural_recharge(user.mana_pool.ethereal_recharge_rate + 1.0)
	user.mana_overload_threshold += 200
	to_chat(user, span_notice("You become one with the eternal flow of magic."))


/datum/spell_node/find_familiar
	name = "Find Familiar"
	desc = "Summon an animal to serve as your familiar."
	node_x = -110
	node_y = -110
	prerequisites = list(/datum/spell_node/primal_savagery)
	spell_type = /obj/effect/proc_holder/spell/invoked/findfamiliar

/datum/spell_node/primal_savagery
	name = "Primal Savagery"
	desc = "Channel primal magic to grow claws or fangs."
	node_x = -50
	node_y = -50
	prerequisites = list(/datum/spell_node/earth_affinity, /datum/spell_node/arcyne_affinity)
	spell_type = /obj/effect/proc_holder/spell/self/primalsavagery5e


/datum/spell_node/blood_pact
	name = "Blood Pact"
	desc = "Bind your life force to dark magic."
	cost = 5
	node_x = -50
	node_y = 50
	prerequisites = list(/datum/spell_node/dark_attunement, /datum/spell_node/electric_affinity)
	is_passive = TRUE

/datum/spell_node/blood_pact/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/death, 0.12)
	user.mana_pool?.adjust_attunement(/datum/attunement/blood, 0.12)
	to_chat(user, span_notice("Dark power flows through your lifeblood."))

/datum/spell_node/blood_lightning
	name = "Blood Lightning"
	desc = "Channel crimson lightning through blood."
	node_x = -110
	node_y = 110
	prerequisites = list(/datum/spell_node/blood_pact)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning

/datum/spell_node/elemental_harmony
	name = "Elemental Harmony"
	desc = "Balance fire and ice within yourself."
	cost = 5
	node_x = 50
	node_y = 50
	prerequisites = list(/datum/spell_node/fire_affinity, /datum/spell_node/frost_affinity)
	is_passive = TRUE

/datum/spell_node/elemental_harmony/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/fire, 0.1)
	user.mana_pool?.adjust_attunement(/datum/attunement/ice, 0.1)
	to_chat(user, span_notice("Fire and ice flow in harmony within you."))


#define RIGHT_X_TIER_1 150
#define RIGHT_X_TIER_2 RIGHT_X_TIER_1 + 50
#define RIGHT_X_TIER_3 RIGHT_X_TIER_2 + 90
#define RIGHT_Y_RIGHT 50
#define RIGHT_Y_LEFT -50

/datum/spell_node/create_bonfire
	name = "Create Bonfire"
	desc = "Create a bonfire on the ground."
	node_x = 100
	node_y = 0
	prerequisites = list(/datum/spell_node/arcyne_eye)
	spell_type = /obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e

/datum/spell_node/fire_affinity
	name = "Fire Affinity"
	desc = "Deepen your connection to the flames."
	cost = 3
	node_x = RIGHT_X_TIER_1
	node_y = RIGHT_Y_RIGHT
	prerequisites = list(/datum/spell_node/create_bonfire)
	is_passive = TRUE

/datum/spell_node/fire_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/fire, 0.15)
	to_chat(user, span_notice("You feel the flames dance within your soul."))

/datum/spell_node/death_affinity
	name = "Death Affinity"
	desc = "Touch the void and understand mortality."
	cost = 3
	node_x = RIGHT_X_TIER_1
	node_y = RIGHT_Y_LEFT
	prerequisites = list(/datum/spell_node/create_bonfire)
	is_passive = TRUE

/datum/spell_node/death_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/death, 0.15)
	to_chat(user, span_notice("The void whispers secrets to you."))

/datum/spell_node/acid_splash
	name = "Acid Splash"
	desc = "Hurl a bubble of acid at your enemies."
	node_x = RIGHT_X_TIER_2
	node_y = RIGHT_Y_LEFT
	prerequisites = list(/datum/spell_node/death_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e

/datum/spell_node/infestation
	name = "Infestation"
	desc = "Cause a cloud of mites, fleas, and other parasites."
	node_x = RIGHT_X_TIER_2
	node_y = RIGHT_Y_LEFT - 50
	prerequisites = list(/datum/spell_node/death_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/infestation5e

/datum/spell_node/decompose
	name = "Decompose"
	desc = "Accelerate the decay of organic matter."
	node_x = RIGHT_X_TIER_3
	node_y = RIGHT_Y_LEFT - 50
	prerequisites = list(/datum/spell_node/infestation)
	spell_type = /obj/effect/proc_holder/spell/invoked/decompose5e

/datum/spell_node/poison_spray
	name = "Poison Spray"
	desc = "Extend your hand and release a puff of noxious gas."
	node_x = RIGHT_X_TIER_3
	node_y = RIGHT_Y_LEFT
	prerequisites = list(/datum/spell_node/acid_splash)
	spell_type = /obj/effect/proc_holder/spell/invoked/poisonspray5e

/datum/spell_node/green_flame_blade
	name = "Green-Flame Blade"
	desc = "Evoke fiery green flames along your weapon."
	node_x = RIGHT_X_TIER_2
	node_y = RIGHT_Y_RIGHT + 50
	prerequisites = list(/datum/spell_node/fire_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/greenflameblade5e

/datum/spell_node/spitfire
	name = "Spitfire"
	desc = "Spit a small gout of flame at your enemy."
	node_x = RIGHT_X_TIER_2
	node_y = RIGHT_Y_RIGHT
	prerequisites = list(/datum/spell_node/fire_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/spitfire

/datum/spell_node/fireball
	name = "Fireball"
	desc = "Launch an explosive ball of fire."
	node_x = RIGHT_X_TIER_3
	node_y = RIGHT_Y_RIGHT
	prerequisites = list(/datum/spell_node/spitfire)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/fireball

/datum/spell_node/meteor_storm
	name = "Meteor Storm"
	desc = "Call down meteors from the heavens."
	node_x = RIGHT_X_TIER_3
	node_y = RIGHT_Y_RIGHT + 50
	prerequisites = list(/datum/spell_node/fireball, /datum/spell_node/green_flame_blade)
	spell_type = /obj/effect/proc_holder/spell/invoked/meteor_storm


#define DOWN_Y_TIER_1 -150
#define DOWN_X_RIGHT 50
#define DOWN_X_LEFT -50
#define DOWN_Y_TIER_2 DOWN_Y_TIER_1 -50
#define DOWN_Y_TIER_3 DOWN_Y_TIER_2 -90

/datum/spell_node/message
	name = "Message"
	desc = "Send telepathic communications across distances."
	node_x = 0
	node_y = -100
	prerequisites = list(/datum/spell_node/arcyne_eye)
	spell_type = /obj/effect/proc_holder/spell/self/message

/datum/spell_node/arcyne_affinity
	name = "Arcyne Affinity"
	desc = "Devote yourself to Noc."
	cost = 3
	node_x = DOWN_X_LEFT
	node_y = DOWN_Y_TIER_1
	prerequisites = list(/datum/spell_node/message)
	is_passive = TRUE

/datum/spell_node/arcyne_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/arcyne, 0.15)
	to_chat(user, span_notice("Noc whispers to you."))

/datum/spell_node/air_affinity
	name = "Air Affinity"
	desc = "Free yourself of burden."
	cost = 3
	node_x = DOWN_X_RIGHT
	node_y = DOWN_Y_TIER_1
	is_passive = TRUE
	prerequisites = list(/datum/spell_node/message)

/datum/spell_node/booming_blade
	name = "Booming Blade"
	desc = "Evoke thunderous energy around your weapon."
	node_x = 0
	node_y = DOWN_Y_TIER_1 - 30
	prerequisites = list(/datum/spell_node/air_affinity, /datum/spell_node/arcyne_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/boomingblade5e

/datum/spell_node/blade_ward
	name = "Blade Ward"
	desc = "Extend your hand and trace a sigil of warding."
	node_x = 0
	node_y = DOWN_Y_TIER_1 - 70
	prerequisites = list(/datum/spell_node/air_affinity, /datum/spell_node/arcyne_affinity)
	spell_type = /obj/effect/proc_holder/spell/self/bladeward5e
	is_passive = TRUE

/datum/spell_node/air_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/aeromancy, 0.15)
	to_chat(user, span_notice("You feel lighter."))

/datum/spell_node/longstrider
	name = "Longstrider"
	desc = "Increase your walking speed."
	node_x = DOWN_X_RIGHT
	node_y = DOWN_Y_TIER_2
	prerequisites = list(/datum/spell_node/air_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/longstrider

/datum/spell_node/haste
	name = "Haste"
	desc = "Make a creature move and act more quickly."
	node_x = DOWN_X_RIGHT
	node_y = DOWN_Y_TIER_3
	prerequisites = list(/datum/spell_node/longstrider)
	spell_type = /obj/effect/proc_holder/spell/invoked/haste

/datum/spell_node/repel
	name = "Repel"
	desc = "Push creatures away from you with force."
	node_x = DOWN_X_RIGHT + 100
	node_y = DOWN_Y_TIER_3
	prerequisites = list(/datum/spell_node/haste)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/repel

/datum/spell_node/featherfall
	name = "Featherfall"
	desc = "Slow your descent when falling."
	node_x = DOWN_X_RIGHT + 50
	node_y = DOWN_Y_TIER_2
	prerequisites = list(/datum/spell_node/air_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/featherfall

/datum/spell_node/slowdown_aoe
	name = "Mass Slowdown"
	desc = "Slow multiple creatures in an area."
	node_x = DOWN_X_RIGHT + 50
	node_y = DOWN_Y_TIER_2 - 50
	prerequisites = list(/datum/spell_node/featherfall)
	spell_type = /obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe

/datum/spell_node/fetch
	name = "Fetch"
	desc = "Magically retrieve distant objects."
	node_x = DOWN_X_LEFT
	node_y = DOWN_Y_TIER_2
	prerequisites = list(/datum/spell_node/arcyne_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/fetch

/datum/spell_node/arcane_bolt
	name = "Arcane Bolt"
	desc = "Launch a bolt of pure magical energy."
	node_x = DOWN_X_LEFT -50
	node_y = DOWN_Y_TIER_2
	prerequisites = list(/datum/spell_node/arcyne_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/arcanebolt

/datum/spell_node/arcyne_storm
	name = "Arcane Storm"
	desc = "Unleash a devastating storm of magical energy."
	node_x = DOWN_X_LEFT -25
	node_y = DOWN_Y_TIER_3
	prerequisites = list(/datum/spell_node/arcane_bolt, /datum/spell_node/fetch)
	spell_type = /obj/effect/proc_holder/spell/invoked/arcyne_storm



#define LEFT_X_TIER_1 -150
#define LEFT_X_TIER_2 LEFT_X_TIER_1 - 50
#define LEFT_X_TIER_3 LEFT_X_TIER_1 - 90
#define LEFT_Y_RIGHT 50
#define LEFT_Y_LEFT -50

/datum/spell_node/light
	name = "Light"
	desc = "Create a magical source of illumination."
	node_x = -100
	node_y = 0
	prerequisites = list(/datum/spell_node/arcyne_eye)
	spell_type = /obj/effect/proc_holder/spell/self/light5e

/datum/spell_node/darkvision
	name = "Darkvision"
	desc = "Grant the ability to see in darkness."
	node_x = LEFT_X_TIER_1 - 30
	node_y = 0
	prerequisites = list(/datum/spell_node/light)
	spell_type = /obj/effect/proc_holder/spell/targeted/touch/darkvision

/datum/spell_node/electric_affinity
	name = "Electric Affinity"
	desc = "Attune yourself to the power of lightning."
	cost = 3
	node_x = LEFT_X_TIER_1
	node_y = LEFT_Y_RIGHT
	prerequisites = list(/datum/spell_node/light)
	is_passive = TRUE

/datum/spell_node/electric_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/electric, 0.15)
	to_chat(user, span_notice("Lightning crackles through your veins."))

/datum/spell_node/earth_affinity
	name = "Earth Affinity"
	desc = "Attune yourself to the earth."
	cost = 3
	node_x = LEFT_X_TIER_1
	node_y = LEFT_Y_LEFT
	prerequisites = list(/datum/spell_node/light)
	is_passive = TRUE

/datum/spell_node/earth_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/earth, 0.15)
	to_chat(user, span_notice("The earth moves beneath you."))

/datum/spell_node/guidance
	name = "Guidance"
	desc = "Provide divine assistance to aid in tasks."
	node_x = LEFT_X_TIER_2
	node_y = LEFT_Y_LEFT
	prerequisites = list(/datum/spell_node/earth_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/guidance

/datum/spell_node/magic_stone
	name = "Magician's Brick"
	desc = "Conjure a magical brick in your hand"
	node_x = LEFT_X_TIER_2
	node_y = LEFT_Y_LEFT - 50
	prerequisites = list(/datum/spell_node/earth_affinity)
	spell_type = /obj/effect/proc_holder/spell/self/magicians_brick

/datum/spell_node/storm_caller
	name = "Storm Caller"
	desc = "Channel the fury of tempests."
	cost = 5
	node_x = LEFT_X_TIER_2
	node_y = LEFT_Y_RIGHT
	prerequisites = list(/datum/spell_node/electric_affinity)
	is_passive = TRUE

/datum/spell_node/storm_caller/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/electric, 0.12)
	user.mana_pool?.adjust_attunement(/datum/attunement/ice, 0.08)
	to_chat(user, span_notice("The fury of storms courses through you."))

/datum/spell_node/lightning_bolt
	name = "Lightning Bolt"
	desc = "Strike your enemies with a bolt of lightning."
	node_x = LEFT_X_TIER_2
	node_y = LEFT_Y_RIGHT + 50
	prerequisites = list(/datum/spell_node/electric_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt

/datum/spell_node/mana_conservation
	name = "Mana Conservation"
	desc = "Learn to use magic more efficiently."
	cost = 5
	node_x = LEFT_X_TIER_3
	node_y = LEFT_Y_RIGHT
	prerequisites = list(/datum/spell_node/storm_caller)
	is_passive = TRUE

/datum/spell_node/mana_conservation/on_node_buy(mob/user)
	user.mana_pool?.set_natural_recharge(user.mana_pool.ethereal_recharge_rate + 0.1)
	to_chat(user, span_notice("You learn to channel magic more efficiently."))

/datum/spell_node/sundering_lightning
	name = "Sundering Lightning"
	desc = "Lightning that tears through magical defenses."
	node_x = LEFT_X_TIER_3
	node_y = LEFT_Y_RIGHT + 50
	prerequisites = list(/datum/spell_node/lightning_bolt, /datum/spell_node/mana_conservation)
	spell_type = /obj/effect/proc_holder/spell/invoked/sundering_lightning

/datum/spell_node/blade_burst
	name = "Blade Burst"
	desc = "Create a burst of spectral blades around you."
	node_x = LEFT_X_TIER_3
	node_y = LEFT_Y_LEFT
	prerequisites = list(/datum/spell_node/guidance)
	spell_type = /obj/effect/proc_holder/spell/invoked/blade_burst


#define UP_Y_TIER_1 150
#define UP_Y_TIER_2 UP_Y_TIER_1 + 50
#define UP_Y_TIER_3 UP_Y_TIER_2 + 90
#define UP_X_RIGHT 50
#define UP_X_LEFT -50

/datum/spell_node/prestidigitation
	name = "Prestidigitation"
	desc = "Simple magical tricks and minor illusions."
	node_x = 0
	node_y = 100
	prerequisites = list(/datum/spell_node/arcyne_eye)
	spell_type = /obj/effect/proc_holder/spell/targeted/touch/prestidigitation

/datum/spell_node/frost_affinity
	name = "Frost Affinity"
	desc = "Embrace the cold within your soul."
	cost = 3
	node_x = UP_X_RIGHT
	node_y = UP_Y_TIER_1
	prerequisites = list(/datum/spell_node/prestidigitation)
	is_passive = TRUE

/datum/spell_node/frost_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/ice, 0.15)
	to_chat(user, span_notice("Cold seeps into your very essence."))

/datum/spell_node/snap_freeze
	name = "Snap Freeze"
	desc = "Instantly freeze the moisture around a target."
	node_x = UP_X_RIGHT + 50
	node_y = UP_Y_TIER_1
	prerequisites = list(/datum/spell_node/frost_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/snap_freeze

/datum/spell_node/dark_attunement
	name = "Dark Affinity"
	desc = "Feel the light vanish."
	cost = 3
	node_x = UP_X_LEFT
	node_y = UP_Y_TIER_1
	prerequisites = list(/datum/spell_node/prestidigitation)
	is_passive = TRUE

/datum/spell_node/death_affinity/on_node_buy(mob/user)
	user.mana_pool?.adjust_attunement(/datum/attunement/dark, 0.15)
	to_chat(user, span_notice("The void whispers secrets to you."))

/datum/spell_node/eldritch_blast
	name = "Eldritch Blast"
	desc = "A crackling beam of otherworldly energy."
	node_x = UP_X_LEFT
	node_y = UP_Y_TIER_2
	prerequisites = list(/datum/spell_node/dark_attunement)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e

/datum/spell_node/encode_thoughts
	name = "Encode Thoughts"
	desc = "Extract a memory and crystallize it into a thought strand."
	node_x = UP_X_LEFT - 50
	node_y = UP_Y_TIER_2
	prerequisites = list(/datum/spell_node/dark_attunement)
	spell_type = /obj/effect/proc_holder/spell/targeted/encodethoughts5e

/datum/spell_node/mind_sliver
	name = "Mind Sliver"
	desc = "Drive a disorienting spike of psychic energy."
	node_x = UP_X_LEFT - 50
	node_y = UP_Y_TIER_3
	prerequisites = list(/datum/spell_node/encode_thoughts)
	spell_type = /obj/effect/proc_holder/spell/invoked/mindsliver5e

/datum/spell_node/gravity
	name = "Gravity"
	desc = "Manipulate gravitational forces."
	node_x = UP_X_LEFT
	node_y = UP_Y_TIER_3
	prerequisites = list(/datum/spell_node/mind_sliver, /datum/spell_node/eldritch_blast)
	spell_type = /obj/effect/proc_holder/spell/invoked/gravity


/datum/spell_node/ray_of_frost
	name = "Ray of Frost"
	desc = "A frigid beam of blue-white light."
	node_x = UP_X_RIGHT
	node_y = UP_Y_TIER_2
	prerequisites = list(/datum/spell_node/frost_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/beam/rayoffrost5e

/datum/spell_node/chill_touch
	name = "Chill Touch"
	desc = "Create a ghostly, skeletal hand that we	akens foes."
	node_x = UP_X_RIGHT + 50
	node_y = UP_Y_TIER_2
	prerequisites = list(/datum/spell_node/frost_affinity)
	spell_type = /obj/effect/proc_holder/spell/invoked/chilltouch5e

/datum/spell_node/frostbite
	name = "Frostbite"
	desc = "Cause numbing frost to form on a creature."
	node_x = UP_X_RIGHT + 50
	node_y = UP_Y_TIER_2 + 50
	prerequisites = list(/datum/spell_node/chill_touch)
	spell_type = /obj/effect/proc_holder/spell/invoked/frostbite5e

/datum/spell_node/frostbolt
	name = "Frostbolt"
	desc = "Launch a shard of ice at your enemy."
	node_x = UP_X_RIGHT
	node_y = UP_Y_TIER_3
	prerequisites = list(/datum/spell_node/ray_of_frost)
	spell_type = /obj/effect/proc_holder/spell/invoked/projectile/frostbolt


/datum/spell_node/gib
	name = "Xylix's Cruel Prank"
	desc = "Fucked up and evil."
	node_x = -100000
	node_y = -100000
	is_passive = TRUE

/datum/spell_node/gib/on_node_buy(mob/user)
	. = ..()
	user.gib()
