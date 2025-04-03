/datum/anvil_recipe/tools
	i_type = "Utilities"
	abstract_type = /datum/anvil_recipe/tools
	appro_skill = /datum/skill/craft/blacksmithing // already in parent just in here so people know
//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate

// --------- COPPER -----------

/datum/anvil_recipe/tools/copper
	craftdiff = 1
	req_bar = /obj/item/ingot/copper
	abstract_type = /datum/anvil_recipe/tools/copper
///////////////////////////////////////////////

/datum/anvil_recipe/tools/copper/hoe
	name = "Copper Hoe (+Stick x2)"
	recipe_name = "a gardening Hoe"
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hoe/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/copper/sickle
	name = "Copper Sickle (+Stick)"
	recipe_name = "a Sickle"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/sickle/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/copper/pitchfork
	name = "Copper Pitchfork (+Stick x2)"
	recipe_name = "a Pitchfork"
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pitchfork/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/copper/pickaxe
	name = "Copper Pick (+Stick)"
	recipe_name = "a digging Pick"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/copper/axe
	name = "Copper Hatchet (+Bar)"
	recipe_name = "a Copper Axe"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/axe/copper
	craftdiff = 0
	i_type = "Tools"

/datum/anvil_recipe/tools/copper/lamptern
	name = "Copper Lamptern"
	recipe_name = "a Lamptern"
	created_item = /obj/item/flashlight/flare/torch/lantern/copper

/datum/anvil_recipe/tools/copper/hammer
	name = "Copper Hammer (+Stick)"
	recipe_name = "a blacksmithing Hammer"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hammer/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/copper/pot
	name = "Copper Cooking Pot"
	created_item = /obj/item/reagent_containers/glass/bucket/pot/copper

/datum/anvil_recipe/tools/copper/platter
	name = "Copper Platter"
	recipe_name = "a platter"
	created_item = /obj/item/kitchen/platter/copper
	craftdiff = 1

// --------- IRON -----------

/datum/anvil_recipe/tools/iron
	craftdiff = 1
	req_bar = /obj/item/ingot/iron
	abstract_type = /datum/anvil_recipe/valuables/iron
///////////////////////////////////////////////

/datum/anvil_recipe/tools/iron/blankeys
	name = "3x Blank Custom Keys"
	recipe_name = "three Blank Keys"
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/key_custom_blank
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/iron/keyring
	name = "3x Keyrings"
	recipe_name = "three Keyrings"
	created_item = /obj/item/storage/keyring
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/iron/locks
	name = "3x Custom Locks"
	recipe_name = "three Locks"
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/customlock
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/iron/chains
	name = "3x Iron Chains"
	recipe_name = "three lengths of Chain"
	appro_skill = /datum/skill/craft/traps // To train trapmaking
	created_item = /obj/item/rope/chain
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/iron/cog
	name = "Iron Cog"
	recipe_name = "an Iron Cog"
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/gear/metal/iron
	craftdiff = 0

/datum/anvil_recipe/tools/iron/cup
	name = "3x Iron Cups"
	recipe_name = "three drinking Cups"
	created_item = /obj/item/reagent_containers/glass/cup
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/iron/knife
	name = "3x Villager Knives"
	recipe_name = "three peasantry knives"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/knife/villager
	createmultiple = TRUE
	createditem_num = 2
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/sledgehammer
	name = "Sledgehammer (+Small Log)"
	recipe_name = "a big hammer"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = 	/obj/item/weapon/hammer/sledgehammer

/datum/anvil_recipe/tools/iron/scissors
	name = "Iron Scissors"
	created_item = /obj/item/weapon/knife/scissors
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/frypan
	name = "Iron Frypan"
	recipe_name = "a Frypan"
	created_item = /obj/item/cooking/pan
	craftdiff = 0
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/hammer
	name = "Iron Hammer (+Stick)"
	recipe_name = "a blacksmithing Hammer"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hammer/iron
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/pot
	name = "Iron Cooking pot"
	recipe_name = "a cooking pot"
	created_item = /obj/item/reagent_containers/glass/bucket/pot
	craftdiff = 1

/datum/anvil_recipe/tools/iron/hoe
	name = "Iron Hoe (+Stick x2)"
	recipe_name = "a gardening Hoe"
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/hoe
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/lamptern
	name = "Iron Lamptern"
	recipe_name = "a Lamptern"
	created_item = /obj/item/flashlight/flare/torch/lantern

/datum/anvil_recipe/tools/iron/lockpicks
	name = "3x Lockpicks"
	recipe_name = "three Lockpicks"
	created_item = /obj/item/lockpick
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 2

/datum/anvil_recipe/tools/iron/lockpickring
	name = "2x Lockpickrings"
	recipe_name = "three Lockpickrings"
	created_item = /obj/item/lockpickring
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/tools/iron/mantrap
	name = "Mantrap"
	recipe_name = "a mantrap"
	created_item = /obj/item/restraints/legcuffs/beartrap/crafted
	appro_skill = /datum/skill/craft/traps
	craftdiff = 1

/datum/anvil_recipe/tools/iron/fishinghooks
	name = "3x Iron Fishing hooks"
	created_item = /obj/item/fishing/hook/iron
	createmultiple = TRUE
	createditem_num = 2

/datum/anvil_recipe/tools/iron/pickaxe
	name = "Iron Pick (+Stick)"
	recipe_name = "a digging Pick"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/axe
	name = "Iron Axe (+Stick)"
	recipe_name = "an Iron Axe"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/axe/iron
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/woodcutter
	name = "Woodcutter Axe (+Small Log)"
	recipe_name = "a great axe for woodcutters"
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/pitchfork
	name = "Iron Pitchfork (+Stick x2)"
	recipe_name = "a Pitchfork"
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pitchfork
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/sewingneedle
	name = "3x Sewing Needles"
	recipe_name = "three Sewing Needles"
	created_item = /obj/item/needle
	createmultiple = TRUE
	createditem_num = 2 // They can be refilled with fiber now
	craftdiff = 0

/datum/anvil_recipe/tools/iron/shovel
	name = "Iron Shovel (+Stick x2)"
	recipe_name = "a Shovel"
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/shovel
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/sickle
	name = "Iron Sickle (+Stick)"
	recipe_name = "a Sickle"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/sickle
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/tongs
	name = "Iron Tongs"
	recipe_name = "a pair of Tongs"
	created_item = /obj/item/weapon/tongs
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/torch
	name = "5x Iron Torches (+Coal)"
	recipe_name = "five Torches"
	additional_items = list(/obj/item/ore/coal)
	created_item = /obj/item/flashlight/flare/torch/metal
	createmultiple = TRUE
	createditem_num = 4
	craftdiff = 0

// --------- STEEL -----------

/datum/anvil_recipe/tools/steel
	craftdiff = 2
	req_bar = /obj/item/ingot/steel
	abstract_type = /datum/anvil_recipe/valuables/steel
///////////////////////////////////////////////

/datum/anvil_recipe/tools/steel/cogs
	name = "2x Cogs"
	recipe_name = "two Cogs"
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/gear/metal/steel
	createmultiple = TRUE
	createditem_num = 1

/datum/anvil_recipe/tools/steel/huntknife
	name = "Hunting Knife"
	recipe_name = "a Hunting Knife"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/knife/hunting
	craftdiff = 3
	i_type = "Tools"

/datum/anvil_recipe/tools/steel/cleaver
	name = "Cleaver"
	recipe_name = "a Cleaver"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/knife/cleaver
	craftdiff = 1
	i_type = "Tools"

/datum/anvil_recipe/tools/steel/scissors
	name = "Steel Scissors"
	created_item = /obj/item/weapon/knife/scissors/steel
	i_type = "Tools"

/datum/anvil_recipe/tools/steel/pickaxe
	name = "Steel Pick (+Stick)"
	recipe_name = "a digging Pick"
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick/steel
	i_type = "Tools"

/datum/anvil_recipe/tools/steel/axe
	name = "Steel Axe (+Stick)"
	recipe_name = "an Axe"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/axe/steel
	craftdiff = 2
	i_type = "Tools"

/datum/anvil_recipe/tools/steel/goblet
	name = "3x Goblets"
	recipe_name = "three Goblets"
	created_item = /obj/item/reagent_containers/glass/cup/steel
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

// --------- SILVER -----------

/datum/anvil_recipe/tools/silver
	craftdiff = 3
	req_bar = /obj/item/ingot/silver
	abstract_type = /datum/anvil_recipe/valuables/silver
///////////////////////////////////////////////

/datum/anvil_recipe/tools/silver/goblet
	name = "3x Silver Goblets"
	recipe_name = "three Goblets"
	created_item = /obj/item/reagent_containers/glass/cup/silver
	createmultiple = TRUE
	createditem_num = 2

/datum/anvil_recipe/tools/silver/carafe
	name = "Silver Carafe"
	recipe_name = "Silver Carafe"
	created_item = /obj/item/reagent_containers/glass/carafe/silver

// --------- GOLD -----------

/datum/anvil_recipe/tools/gold
	craftdiff = 3
	req_bar = /obj/item/ingot/gold
	abstract_type = /datum/anvil_recipe/valuables/gold
///////////////////////////////////////////////

/datum/anvil_recipe/tools/gold/carafe
	name = "Golden Carafe"
	recipe_name = "Golden Carafe"
	created_item = /obj/item/reagent_containers/glass/carafe/gold

/datum/anvil_recipe/tools/gold/goblet
	name = "3x Golden Goblets"
	recipe_name = "three Goblets"
	created_item = /obj/item/reagent_containers/glass/cup/golden
	createmultiple = TRUE
	createditem_num = 2
