/datum/thaumic_research_node
	var/name = "Unknown Research"
	var/desc = "A mysterious field of study."
	var/icon = 'icons/roguetown/misc/alchemy.dmi'
	var/icon_state = "essence"
	var/list/required_essences = list()
	var/list/prerequisites = list()
	var/list/unlocks = list()
	var/experience_reward = 100
	var/node_x = 0
	var/node_y = 0
	var/list/connected_nodes = list()

/datum/thaumic_research_node/Destroy(force, ...)
	connected_nodes = null
	return ..()

/datum/thaumic_research_node/basic_understanding
	name = "Fundamental Thaumaturgy"
	desc = "The foundational principles of essence manipulation and magical theory. Understanding the basic flow of arcane energies is essential before attempting more complex workings."
	icon_state = "node"
	node_x = 140
	node_y = 340
	// No essence cost - this is the starting node

/datum/thaumic_research_node/basic_splitter
	name = "Essence Division"
	desc = "Learn to safely divide and separate magical essences into their component parts. This fundamental technique allows for more precise control over thaumic materials."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/basic_understanding)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 5,
		/datum/thaumaturgical_essence/earth = 5,
		/datum/thaumaturgical_essence/water = 5,
		/datum/thaumaturgical_essence/life = 5,
		/datum/thaumaturgical_essence/air = 5,
		/datum/thaumaturgical_essence/order = 5,
		/datum/thaumaturgical_essence/chaos = 5,
	)
	node_x = 220
	node_y = 160

/datum/thaumic_research_node/advanced_splitter
	name = "Refined Separation"
	desc = "Advanced techniques for essence splitting that preserve more of the original magical potency while achieving cleaner divisions."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/basic_splitter)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 15,
		/datum/thaumaturgical_essence/earth = 15,
		/datum/thaumaturgical_essence/water = 15,
		/datum/thaumaturgical_essence/life = 15,
		/datum/thaumaturgical_essence/air = 15,
		/datum/thaumaturgical_essence/order = 15,
		/datum/thaumaturgical_essence/chaos = 15,
	)
	node_x = 460
	node_y = 80

/datum/thaumic_research_node/expert_splitter
	name = "Master's Division"
	desc = "Expert-level essence separation capable of isolating even the most volatile and complex magical compounds without loss of power."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/advanced_splitter)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 45,
		/datum/thaumaturgical_essence/earth = 45,
		/datum/thaumaturgical_essence/water = 45,
		/datum/thaumaturgical_essence/life = 45,
		/datum/thaumaturgical_essence/air = 45,
		/datum/thaumaturgical_essence/order = 45,
		/datum/thaumaturgical_essence/chaos = 45,
	)
	node_x = 300
	node_y = 200

/datum/thaumic_research_node/master_splitter
	name = "Grandmaster's Cleaving"
	desc = "The pinnacle of separation arts, allowing for perfect division of any essence while maintaining absolute purity and potency of each component."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/expert_splitter)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 100,
		/datum/thaumaturgical_essence/earth = 100,
		/datum/thaumaturgical_essence/water = 100,
		/datum/thaumaturgical_essence/life = 100,
		/datum/thaumaturgical_essence/air = 100,
		/datum/thaumaturgical_essence/order = 100,
		/datum/thaumaturgical_essence/chaos = 100,
	)
	node_x = 260
	node_y = 320

/datum/thaumic_research_node/splitter_speed
	name = "Swift Division"
	desc = "Techniques to accelerate the essence splitting process through optimized channeling patterns and improved focus methods."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/basic_splitter)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 10,
		/datum/thaumaturgical_essence/air = 15,
		/datum/thaumaturgical_essence/energia = 10,
	)
	node_x = 480
	node_y = 20

/datum/thaumic_research_node/splitter_speed_two
	name = "Rapid Separation"
	desc = "Further acceleration of splitting processes through advanced magical circuitry and enhanced essence flow control."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/splitter_speed)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 25,
		/datum/thaumaturgical_essence/energia = 20,
		/datum/thaumaturgical_essence/cycle = 15,
	)
	node_x = 720
	node_y = 40

/datum/thaumic_research_node/splitter_speed_three
	name = "Lightning Division"
	desc = "Near-instantaneous essence separation achieved through mastery of temporal acceleration fields and perfected channeling techniques."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/splitter_speed_two)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 50,
		/datum/thaumaturgical_essence/energia = 40,
		/datum/thaumaturgical_essence/cycle = 30,
		/datum/thaumaturgical_essence/magic = 20,
	)
	node_x = 580
	node_y = 120

/datum/thaumic_research_node/gnomes
	name = "Life Synthesis"
	desc = "Understand the principals behind life."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/transmutation)
	required_essences = list(/datum/thaumaturgical_essence/life = 200)
	node_x = 480
	node_y = 300

/datum/thaumic_research_node/transmutation
	name = "Essence Transmutation"
	desc = "The art of converting one type of magical essence into another through careful application of thaumic principles and controlled energy transfer."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/basic_understanding)
	required_essences = list(/datum/thaumaturgical_essence/fire = 10, /datum/thaumaturgical_essence/earth = 10)
	node_x = 140
	node_y = 480

/datum/thaumic_research_node/gnome_efficency
	name = "Improved Essence Handling"
	desc = "Reduces the essence needed to form form life."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/gnomes)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 50,
		/datum/thaumaturgical_essence/order = 25,
	)
	node_x = 420
	node_y = 440

/datum/thaumic_research_node/gnome_speed
	name = "Improved Essence Incorporation"
	desc = "Improves the speed at which essences form life."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/gnomes)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 50,
		/datum/thaumaturgical_essence/motion = 25,
	)
	node_x = 340
	node_y = 420

/datum/thaumic_research_node/gnome_speed_two
	name = "Enhanced Essence Incorporation"
	desc = "Further improves the speed at which essences form life."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/gnome_speed)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 75,
		/datum/thaumaturgical_essence/motion = 40,
		/datum/thaumaturgical_essence/energia = 25,
	)
	node_x = 220
	node_y = 480

/datum/thaumic_research_node/gnome_speed_three
	name = "Perfected Essence Incorporation"
	desc = "Maximizes the speed at which essences form life."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/gnome_speed_two)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 100,
		/datum/thaumaturgical_essence/motion = 60,
		/datum/thaumaturgical_essence/energia = 40,
		/datum/thaumaturgical_essence/cycle = 30,
	)
	node_x = 160
	node_y = 600

/datum/thaumic_research_node/gnome_mastery
	name = "Gnomish Perfection"
	desc = "The pinnacle of life, Gnomes with Hats. It's said that Psydon is actually just a Gnome."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/gnome_speed_three, /datum/thaumic_research_node/gnome_efficeny_three)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 300,
		/datum/thaumaturgical_essence/magic = 100,
		/datum/thaumaturgical_essence/order = 75,
		/datum/thaumaturgical_essence/crystal = 50,
	)
	node_x = 320
	node_y = 520

/datum/thaumic_research_node/gnome_efficeny_three
	name = "Masterful Essence Handling"
	desc = "Greatly reduces the essence needed to form life."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/gnome_efficeny_two)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 100,
		/datum/thaumaturgical_essence/order = 60,
		/datum/thaumaturgical_essence/crystal = 30,
	)
	node_x = 520
	node_y = 600

/datum/thaumic_research_node/gnome_efficeny_two
	name = "Advanced Essence Handling"
	desc = "Further reduces the essence needed to form life."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/gnome_efficency)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 75,
		/datum/thaumaturgical_essence/order = 40,
		/datum/thaumaturgical_essence/void = 20,
	)
	node_x = 440
	node_y = 540

/datum/thaumic_research_node/advanced_combiner_applications
	name = "Essence Fusion Mastery"
	desc = "Advanced techniques for combining different magical essences into more powerful and complex compounds. The foundation for all higher-level combination work."
	icon_state = "node"
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 30,
		/datum/thaumaturgical_essence/water = 30,
		/datum/thaumaturgical_essence/earth = 30,
		/datum/thaumaturgical_essence/air = 30,
		/datum/thaumaturgical_essence/order = 20,
		/datum/thaumaturgical_essence/chaos = 20,
	)
	node_x = 300
	node_y = 840

/datum/thaumic_research_node/resevoir_decay
	name = "Temporal Decay"
	desc = "Techniques to speed up the flow of time destroying essences in the process."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/advanced_combiner_applications)
	required_essences = list(
		/datum/thaumaturgical_essence/cycle = 40,
		/datum/thaumaturgical_essence/void = 30,
		/datum/thaumaturgical_essence/chaos = 25,
	)
	node_x = 180
	node_y = 680

/datum/thaumic_research_node/combiner_speed
	name = "Swift Fusion"
	desc = "Accelerate the essence combination process through improved channeling techniques and optimized magical flow patterns."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/advanced_combiner_applications)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 20,
		/datum/thaumaturgical_essence/energia = 15,
		/datum/thaumaturgical_essence/fire = 10,
	)
	node_x = 280
	node_y = 700

/datum/thaumic_research_node/combiner_speed_two
	name = "Rapid Synthesis"
	desc = "Further acceleration of combination processes through advanced magical circuitry and enhanced essence bonding techniques."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/combiner_speed)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 35,
		/datum/thaumaturgical_essence/energia = 30,
		/datum/thaumaturgical_essence/cycle = 20,
	)
	node_x = 360
	node_y = 800

/datum/thaumic_research_node/combiner_speed_three
	name = "Instantaneous Fusion"
	desc = "Near-instantaneous essence combination achieved through mastery of temporal acceleration and perfected synthesis methods."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/combiner_speed_two)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 50,
		/datum/thaumaturgical_essence/energia = 45,
		/datum/thaumaturgical_essence/cycle = 35,
		/datum/thaumaturgical_essence/magic = 25,
	)
	node_x = 520
	node_y = 780

/datum/thaumic_research_node/combiner_output
	name = "Enhanced Yield"
	desc = "Techniques to increase the quantity of combined essences produced from each fusion process without sacrificing quality."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/advanced_combiner_applications)
	required_essences = list(
		/datum/thaumaturgical_essence/crystal = 25,
		/datum/thaumaturgical_essence/order = 20,
		/datum/thaumaturgical_essence/earth = 15,
	)
	node_x = 520
	node_y = 880

/datum/thaumic_research_node/combiner_output_two
	name = "Amplified Production"
	desc = "Advanced methods for maximizing essence combination output through improved channeling efficiency and reduced waste."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/combiner_output)
	required_essences = list(
		/datum/thaumaturgical_essence/crystal = 40,
		/datum/thaumaturgical_essence/order = 35,
		/datum/thaumaturgical_essence/life = 20,
	)
	node_x = 700
	node_y = 840

/datum/thaumic_research_node/combiner_output_three
	name = "Abundance Creation"
	desc = "Master-level techniques for achieving extraordinary yields from essence combination processes while maintaining perfect quality."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/combiner_output_two)
	required_essences = list(
		/datum/thaumaturgical_essence/crystal = 60,
		/datum/thaumaturgical_essence/order = 50,
		/datum/thaumaturgical_essence/life = 40,
		/datum/thaumaturgical_essence/magic = 30,
	)
	node_x = 860
	node_y = 760

/datum/thaumic_research_node/combiner_output_four
	name = "Infinite Synthesis"
	desc = "The pinnacle of combination arts, allowing for theoretically unlimited output from minimal input through perfect efficiency mastery."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/combiner_output_three)
	required_essences = list(
		/datum/thaumaturgical_essence/crystal = 100,
		/datum/thaumaturgical_essence/magic = 75,
		/datum/thaumaturgical_essence/void = 50,
		/datum/thaumaturgical_essence/chaos = 50,
	)
	node_x = 660
	node_y = 740

/datum/thaumic_research_node/combiner_speed_four
	name = "Transcendent Velocity"
	desc = "Achieve combination speeds that transcend normal temporal limitations through mastery of advanced magical acceleration."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/combiner_speed_three)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 75,
		/datum/thaumaturgical_essence/energia = 60,
		/datum/thaumaturgical_essence/cycle = 50,
		/datum/thaumaturgical_essence/magic = 40,
		/datum/thaumaturgical_essence/void = 25,
	)
	node_x = 340
	node_y = 640

/datum/thaumic_research_node/combiner_speed_five
	name = "Eternal Swiftness"
	desc = "The ultimate in combination speed, allowing for continuous, instantaneous essence fusion processes that operate beyond time itself."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/combiner_speed_four)
	required_essences = list(
		/datum/thaumaturgical_essence/motion = 100,
		/datum/thaumaturgical_essence/energia = 85,
		/datum/thaumaturgical_essence/cycle = 75,
		/datum/thaumaturgical_essence/magic = 60,
		/datum/thaumaturgical_essence/void = 50,
		/datum/thaumaturgical_essence/chaos = 40,
	)
	node_x = 560
	node_y = 680

/datum/thaumic_research_node/splitter_output_four
	name = "Multiplied Division"
	desc = "Advanced splitting techniques that produce additional essence fragments beyond the normal limits of division."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/master_splitter)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 100,
		/datum/thaumaturgical_essence/earth = 100,
		/datum/thaumaturgical_essence/water = 100,
		/datum/thaumaturgical_essence/life = 100,
		/datum/thaumaturgical_essence/air = 100,
		/datum/thaumaturgical_essence/order = 100,
		/datum/thaumaturgical_essence/chaos = 100,
		/datum/thaumaturgical_essence/magic = 50,
	)
	node_x = 400
	node_y = 200

/datum/thaumic_research_node/splitter_output_five
	name = "Infinite Fragmentation"
	desc = "The ultimate splitting technique, capable of producing unlimited essence divisions while preserving the full potency of each fragment."
	icon_state = "node"
	prerequisites = list(/datum/thaumic_research_node/splitter_output_four)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 100,
		/datum/thaumaturgical_essence/earth = 100,
		/datum/thaumaturgical_essence/water = 100,
		/datum/thaumaturgical_essence/life = 100,
		/datum/thaumaturgical_essence/air = 100,
		/datum/thaumaturgical_essence/order = 100,
		/datum/thaumaturgical_essence/chaos = 100,
		/datum/thaumaturgical_essence/magic = 100,
	)
	node_x = 500
	node_y = 200
