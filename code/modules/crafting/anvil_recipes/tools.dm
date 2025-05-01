/datum/anvil_recipe/tools
	i_type = "Utilities"
	craftdiff = 1
	abstract_type = /datum/anvil_recipe/tools

/datum/anvil_recipe/tools/blankeys
	name = "3x Blank Custom Keys"
	recipe_name = "three Blank Keys"
	req_bar = /obj/item/ingot/iron
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/key/custom
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/chains
	name = "3x Chains"
	recipe_name = "three lengths of Chain"
	req_bar = /obj/item/ingot/iron
	appro_skill = /datum/skill/craft/traps // To train trapmaking
	created_item = /obj/item/rope/chain
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/cogiron
	name = "Cog"
	recipe_name = "a Cog"
	req_bar = /obj/item/ingot/iron
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/gear/metal/iron
	craftdiff = 0

/datum/anvil_recipe/tools/cogstee
	name = "2x Cogs"
	recipe_name = "two Cogs"
	req_bar = /obj/item/ingot/steel
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/gear/metal/steel
	createmultiple = TRUE
	createditem_num = 1

/datum/anvil_recipe/tools/cups
	name = "3x Metal Cups"
	recipe_name = "three drinking Cups"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/cup
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/scissors
	name = "Scissors"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/knife/scissors
	i_type = "Tools"

/datum/anvil_recipe/tools/steelscissors
	name = "Steel Scissors"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/knife/scissors/steel
	i_type = "Tools"

/datum/anvil_recipe/tools/pick/steel
	name = "Steel Pick (+Stick)"
	recipe_name = "a digging Pick"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick/steel
	i_type = "Tools"

/datum/anvil_recipe/tools/frypan
	name = "Pan"
	recipe_name = "a Frypan"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/cooking/pan
	craftdiff = 0

/datum/anvil_recipe/tools/gobletsteel
	name = "3x Goblets"
	recipe_name = "three Goblets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/reagent_containers/glass/cup/steel
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/gobletgold
	name = "3x Golden Goblets"
	recipe_name = "three Goblets"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/reagent_containers/glass/cup/golden
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 2

/datum/anvil_recipe/tools/gobletsilver
	name = "3x Silver Goblets"
	recipe_name = "three Goblets"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/reagent_containers/glass/cup/silver
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 2

/datum/anvil_recipe/tools/carafegold
	name = "Golden Carafe"
	recipe_name = "Golden Carafe"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/reagent_containers/glass/carafe/gold
	craftdiff = 0

/datum/anvil_recipe/tools/carafesilver
	name = "Silver Carafe"
	recipe_name = "Silver Carafe"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/reagent_containers/glass/carafe/silver
	craftdiff = 0

/datum/anvil_recipe/tools/hammer
	name = "Hammer (+Stick)"
	recipe_name = "a blacksmithing Hammer"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hammer/iron
	i_type = "Tools"

/datum/anvil_recipe/tools/hoe
	name = "Hoe (+Stick x2)"
	recipe_name = "a gardening Hoe"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hoe
	i_type = "Tools"

/datum/anvil_recipe/tools/keyring
	name = "3x Keyrings"
	recipe_name = "three Keyrings"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/storage/keyring
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/lamptern
	name = "Iron Lamptern"
	recipe_name = "a Lamptern"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/flashlight/flare/torch/lantern

/datum/anvil_recipe/tools/locks
	name = "3x Custom Locks"
	recipe_name = "three Locks"
	req_bar = /obj/item/ingot/iron
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/customlock
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/lockpicks
	name = "3x Lockpicks"
	recipe_name = "three Lockpicks"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/lockpick
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 2

/datum/anvil_recipe/tools/lockpickring
	name = "3x Lockpickrings"
	recipe_name = "three Lockpickrings"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/lockpickring
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/mantrap
	name = "Mantrap"
	recipe_name = "a mantrap"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/restraints/legcuffs/beartrap/crafted
	appro_skill = /datum/skill/craft/traps
	craftdiff = 1

/datum/anvil_recipe/tools/fishinghooks
	name = "3x Fishing hooks"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/fishing/hook/iron
	createmultiple = TRUE
	createditem_num = 2
	i_type = "Tools"

/datum/anvil_recipe/tools/pick
	name = "Pick (+Stick)"
	recipe_name = "a digging Pick"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick
	i_type = "Tools"

/datum/anvil_recipe/tools/pitchfork
	name = "Pitchfork (+Stick x2)"
	recipe_name = "a Pitchfork"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pitchfork
	i_type = "Tools"

/datum/anvil_recipe/tools/sewingneedle
	name = "3x Sewing Needles"
	recipe_name = "three Sewing Needles"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/needle
	createmultiple = TRUE
	createditem_num = 2 // They can be refilled with fiber now
	craftdiff = 0

/datum/anvil_recipe/tools/shovel
	name = "Shovel (+Stick x2)"
	recipe_name = "a Shovel"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/shovel
	i_type = "Tools"

/datum/anvil_recipe/tools/sickle
	name = "Sickle (+Stick)"
	recipe_name = "a Sickle"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/sickle
	i_type = "Tools"

/datum/anvil_recipe/tools/tongs
	name = "Tongs"
	recipe_name = "a pair of Tongs"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/tongs
	i_type = "Tools"

/datum/anvil_recipe/tools/surgery/surgerytools
	name = "Surgeon's Bag (+1 iron +1 hide)"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/natural/hide)
	created_item = /obj/item/storage/backpack/satchel/surgbag
	i_type = "Tools"

/datum/anvil_recipe/tools/torch
	name = "5x Iron Torches (+Coal)"
	recipe_name = "five Torches"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ore/coal)
	created_item = /obj/item/flashlight/flare/torch/metal
	createmultiple = TRUE
	createditem_num = 4
	craftdiff = 0

/datum/anvil_recipe/tools/pote
	name = "Cooking pot (iron)"
	recipe_name = "a cooking pot"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/reagent_containers/glass/bucket/pot
	craftdiff = 1

/datum/anvil_recipe/tools/pote/copper
	name = "Cooking pot (copper)"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/reagent_containers/glass/bucket/pot/copper

/datum/anvil_recipe/tools/platter
	name = "2x Platters (copper)"
	recipe_name = "a platter"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/plate/copper
	craftdiff = 1
	createmultiple = TRUE
	createditem_num = 1

/datum/anvil_recipe/tools/platter/tin
	name = "2x Platters (tin)"
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/plate/pewter

/datum/anvil_recipe/tools/platter/silver
	name = "2x Platters (silver)"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/plate/silver

/datum/anvil_recipe/tools/platter/gold
	name = "2x Platters (gold)"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/plate/gold

/datum/anvil_recipe/tools/hoe/copper
	name = "Copper Hoe (+Stick x2)"
	recipe_name = "a gardening Hoe"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hoe/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/sickle/copper
	name = "Copper Sickle (+Stick)"
	recipe_name = "a Sickle"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/sickle/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/pitchfork/copper
	name = "Copper Pitchfork (+Stick x2)"
	recipe_name = "a Pitchfork"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pitchfork/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/pick/copper
	name = "Copper Pick (+Stick)"
	recipe_name = "a digging Pick"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/lamptern/copper
	name = "Copper Lamptern"
	recipe_name = "a Lamptern"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/flashlight/flare/torch/lantern/copper

/datum/anvil_recipe/tools/hammer/copper
	name = "Copper Hammer (+Stick)"
	req_bar = /obj/item/ingot/copper
	recipe_name = "a blacksmithing Hammer"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hammer/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/headhook
	name = "Iron Headhook (+Fibers x2)"
	recipe_name = "An iron headhook"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/fibers = 2)
	created_item = /obj/item/storage/hip/headhook
	craftdiff = 3

/datum/anvil_recipe/tools/chisel
	name = "Steel Chisel"
	recipe_name = "a Chisel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/chisel
	i_type = "Tools"

/datum/anvil_recipe/tools/chisel/iron
	name = "Iron Chisel"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/chisel/iron

/datum/anvil_recipe/tools/chisel/bronze
	name = "Bronze Chisel"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/weapon/chisel/bronze

/datum/anvil_recipe/tools/spoon
	name = "2x Spoons (iron)"
	recipe_name = "a Spoon"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/kitchen/spoon/iron
	craftdiff = 1
	createmultiple = TRUE
	createditem_num = 1

/datum/anvil_recipe/tools/spoon/tin
	name = "2x Spoons (tin)"
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/kitchen/spoon/pewter

/datum/anvil_recipe/tools/fork
	name = "2x Forks (iron)"
	recipe_name = "a Fork"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/kitchen/fork/iron
	craftdiff = 1
	createmultiple = TRUE
	createditem_num = 1

/datum/anvil_recipe/tools/fork/tin
	name = "2x Forks (tin)"
	req_bar = /obj/item/ingot/tin
	created_item = /obj/item/kitchen/fork/pewter

/datum/anvil_recipe/tools/drill
	craftdiff = 4
	name = "Clockwork Drill"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel = 1, /obj/item/gear/metal = 1, /obj/item/natural/wood/plank = 1)
	created_item = /obj/item/weapon/pick/drill
