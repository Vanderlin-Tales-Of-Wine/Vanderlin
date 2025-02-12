/datum/anvil_recipe/tools
	i_type = "Utilities"
	craftdiff = 1

/datum/anvil_recipe/tools/blankeys
	name = "5x Blank Custom Keys"
	recipe_name = "five Blank Keys"
	req_bar = /obj/item/ingot/iron
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/key_custom_blank
	createmultiple = TRUE
	createditem_num = 4
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
	name = "3x Cogs"
	recipe_name = "three Cogs"
	req_bar = /obj/item/ingot/iron
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/roguegear
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/tools/cogstee
	name = "4x Cogs"
	recipe_name = "four Cogs"
	req_bar = /obj/item/ingot/steel
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/roguegear
	createmultiple = TRUE
	createditem_num = 3

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
	created_item = /obj/item/rogueweapon/knife/scissors
	i_type = "Tools"

/datum/anvil_recipe/tools/steelscissors
	name = "Steel Scissors"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/rogueweapon/knife/scissors/steel
	i_type = "Tools"

/datum/anvil_recipe/tools/pick/steel
	name = "Steel Pick (+Stick)"
	recipe_name = "a digging Pick"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick/steel
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
	created_item = /obj/item/rogueweapon/hammer/iron
	i_type = "Tools"

/datum/anvil_recipe/tools/hoe
	name = "Hoe (+Stick x2)"
	recipe_name = "a gardening Hoe"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hoe
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
	name = "5x Custom Locks"
	recipe_name = "five Locks"
	req_bar = /obj/item/ingot/iron
	appro_skill = /datum/skill/craft/engineering // To train engineering
	created_item = /obj/item/customlock
	createmultiple = TRUE
	createditem_num = 4
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
	craftdiff = 0

/datum/anvil_recipe/tools/fishinghooks
	name = "3x Fishing hooks"
	req_bar = /obj/item/ingot/iron
	created_item = list(/obj/item/fishing/hook/iron, /obj/item/fishing/hook/iron, /obj/item/fishing/hook/iron)
	i_type = "Tools"

/datum/anvil_recipe/tools/pick
	name = "Pick (+Stick)"
	recipe_name = "a digging Pick"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick
	i_type = "Tools"

/datum/anvil_recipe/tools/pitchfork
	name = "Pitchfork (+Stick x2)"
	recipe_name = "a Pitchfork"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pitchfork
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
	created_item = /obj/item/rogueweapon/shovel
	i_type = "Tools"

/datum/anvil_recipe/tools/sickle
	name = "Sickle (+Stick)"
	recipe_name = "a Sickle"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/sickle
	i_type = "Tools"

/datum/anvil_recipe/tools/tongs
	name = "Tongs"
	recipe_name = "a pair of Tongs"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/rogueweapon/tongs
	i_type = "Tools"

/datum/anvil_recipe/tools/torch
	name = "5x Iron Torches (+Coal)"
	recipe_name = "five Torches"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rogueore/coal)
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
	name = "Platter (copper)"
	recipe_name = "a platter"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/kitchen/platter/copper
	craftdiff = 1

/datum/anvil_recipe/tools/hoe/copper
	name = "Copper Hoe (+Stick x2)"
	recipe_name = "a gardening Hoe"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/hoe/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/sickle/copper
	name = "Copper Sickle (+Stick)"
	recipe_name = "a Sickle"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/sickle/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/pitchfork/copper
	name = "Copper Pitchfork (+Stick x2)"
	recipe_name = "a Pitchfork"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick,/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pitchfork/copper
	i_type = "Tools"

/datum/anvil_recipe/tools/pick/copper
	name = "Copper Pick (+Stick)"
	recipe_name = "a digging Pick"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/rogueweapon/pick/copper
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
	created_item = /obj/item/rogueweapon/hammer/copper
	i_type = "Tools"
