/datum/crafting_recipe
	always_availible = TRUE
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/blowgun
	name = "blowgun"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
	reqs = list(/obj/item/grown/log/tree/stick = 1)
	craftdiff = 0

/datum/crafting_recipe/clothsash
	name = "cloth sash"
	result = /obj/item/storage/belt/leather/cloth
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0
	verbage = "tie"
	verbage_tp = "ties"

/datum/crafting_recipe/unclothsash
	name = "untie cloth sash"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/storage/belt/leather/cloth = 1)
	craftdiff = 0
	verbage = "untie"
	verbage_tp = "unties"

/datum/crafting_recipe/ropebelt
	name = "rope belt"
	result = /obj/item/storage/belt/leather/rope
	reqs = list(/obj/item/rope = 1)
	craftdiff = 0
	verbage = "untie"
	verbage_tp  = "unties"

/datum/crafting_recipe/unropebelt
	name = "untie rope belt"
	result = /obj/item/rope
	reqs = list(/obj/item/storage/belt/leather/rope = 1)
	craftdiff = 0
	verbage = "untie"
	verbage_tp  = "unties"

/datum/crafting_recipe/candle
	name = "candle (x2)"
	result = list(/obj/item/candle/yellow,
				/obj/item/candle/yellow)
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 1)

/datum/crafting_recipe/woodclub
	name = "wood club"
	result = /obj/item/weapon/mace/woodclub/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0

/obj/item/weapon/mace/woodclub/crafted
	sellprice = 8

/datum/crafting_recipe/woodstaff
	name = "wood staff"
	result = list(/obj/item/weapon/polearm/woodstaff,
	/obj/item/weapon/polearm/woodstaff,
	/obj/item/weapon/polearm/woodstaff)
	reqs = list(/obj/item/grown/log/tree = 1)

/obj/item/weapon/shield/wood/crafted
	sellprice = 6

/datum/crafting_recipe/spoon
	name = "wooden spoon"
	result = list(/obj/item/kitchen/spoon,
				/obj/item/kitchen/spoon)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/rollingpin
	name = "wooden rollingpin"
	result = /obj/item/kitchen/rollingpin
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/woodbucket
	name = "wooden bucket"
	result = /obj/item/reagent_containers/glass/bucket/wooden
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/woodbowl
	name = "wooden bowls (x3)"
	result = list(/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/woodcup
	name = "wooden cups (x3)"
	result = list(/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/woodtray
	name = "wooden trays (x2)"
	result = list(/obj/item/plate/tray,
				/obj/item/plate/tray)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/obj/item/reagent_containers/glass/cup/wooden/crafted
	sellprice = 3

/obj/item/storage/sack/crafted
	sellprice = 4

/datum/crafting_recipe/bait
	name = "bait"
	result = /obj/item/bait
	reqs = list(/obj/item/storage/sack = 1,
				/obj/item/reagent_containers/food/snacks/produce/wheat = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/sbaita
	name = "sweetbait (apple)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/sack = 1,
				/obj/item/reagent_containers/food/snacks/produce/apple = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/sbait
	name = "sweetbait (berry)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/sack = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/bloodbait
	name = "bloodbait"
	result = /obj/item/bait/bloody
	reqs = list(/obj/item/storage/sack = 1,
				/obj/item/reagent_containers/food/snacks/meat = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/woodplatter
	name = "wood platters (x2)"
	result = list(/obj/item/kitchen/platter,
				/obj/item/kitchen/platter)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/pipe
	name = "wood pipe"
	result = /obj/item/clothing/face/cigarette/pipe/crafted
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	craftdiff = 1
	tools = list(/obj/item/weapon/knife)

/obj/item/clothing/face/cigarette/pipe/crafted
	sellprice = 6

/datum/crafting_recipe/rod
	name = "fishing rod"
	result = /obj/item/fishingrod/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2)

/obj/item/fishingrod/crafted
	sellprice = 8

/datum/crafting_recipe/woodspade
	name = "wood spade"
	result = /obj/item/weapon/shovel/small
	reqs = list(/obj/item/grown/log/tree/small = 1,
			/obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/broom
	name = "broom"
	result = /obj/item/broom
	reqs = list(/obj/item/natural/fibers = 1,
			/obj/item/grown/log/tree/stick = 4)
	craftdiff = 1

/obj/item/weapon/shovel/small/crafted
	sellprice = 5

/datum/crafting_recipe/basket_wicker
	name = "basket (wicker)"
	result = /obj/structure/closet/crate/chest/wicker
	reqs = list(/obj/item/natural/fibers = 4)
	craftdiff = 1

/datum/crafting_recipe/mantrap
	name = "mantrap"
	result = list(/obj/item/restraints/legcuffs/beartrap) // Intentionally old. Don't change.
	reqs = list(/obj/item/grown/log/tree/stake = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/rope = 1)
	req_table = FALSE
	skillcraft = /datum/skill/craft/traps
	craftdiff = 1
	verbage = "put together"
	verbage_tp = "puts together"

/datum/crafting_recipe/stonearrow
	name = "stone arrow (x2)"
	result = list(/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone)
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/stonearrow_five
	name = "stone arrow (x10)"
	result = list(
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone)
	reqs = list(/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/stone = 5)

/datum/crafting_recipe/poisondart
	name = "poison dart"
	result = /obj/item/ammo_casing/caseless/dart/poison
	reqs = list(/obj/item/ammo_casing/caseless/dart = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)
	craftdiff = 0

/datum/crafting_recipe/poisonarrow
	name = "poison arrow"
	result = /obj/item/ammo_casing/caseless/arrow/poison
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)
	craftdiff = 0

/datum/crafting_recipe/poisonarrow/alt
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/datum/reagent/berrypoison = 5)

/datum/crafting_recipe/poisonarrow/potent
	name = "poison arrow (potent)"
	result = /obj/item/ammo_casing/caseless/arrow/poison/potent
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/datum/reagent/strongpoison = 5)

/datum/crafting_recipe/pyroarrow
	name = "pyroclastic arrow"
	result = /obj/item/ammo_casing/caseless/arrow/pyro
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/poisonbolt
	name = "poison bolt"
	result = /obj/item/ammo_casing/caseless/bolt/poison
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)
	craftdiff = 0

/datum/crafting_recipe/poisonbolt/alt
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/datum/reagent/berrypoison = 5)

/datum/crafting_recipe/poisonbolt/potent
	name = "poison bolt (potent)"
	result = /obj/item/ammo_casing/caseless/bolt/poison/potent
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/datum/reagent/strongpoison = 5)

/datum/crafting_recipe/bomb
	name = "bomb"
	result = /obj/item/bomb/homemade
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
				/obj/item/reagent_containers/glass/bottle = 1)
	craftdiff = 2
	skillcraft = /datum/skill/craft/bombs
	subtype_reqs = TRUE

/datum/crafting_recipe/pyrobolt
	name = "pyroclastic bolt"
	result = /obj/item/ammo_casing/caseless/bolt/pyro
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/recurve
	name = "recurve bow"
	result = list(/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/natural/fibers = 4)
	craftdiff = 1
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/handmadebow
	name = "wooden bow"
	result = list(/obj/item/gun/ballistic/revolver/grenadelauncher/bow)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/natural/fibers = 6)
	craftdiff = 2
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/longbow
	name = "longbow"
	result = list(/obj/item/gun/ballistic/revolver/grenadelauncher/bow/long)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/natural/fibers = 8,
	/obj/item/reagent_containers/food/snacks/fat = 1)
	skillcraft = /datum/skill/craft/carpentry
	structurecraft = /obj/machinery/light/fueled/campfire
	craftdiff = 3

/datum/crafting_recipe/flint
	name = "flint"
	result = /obj/item/flint
	reqs = list(
			/obj/item/natural/stone = 1,
			/obj/item/ingot/iron = 1)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 0 // Something to practice engineering with.

/datum/crafting_recipe/readingscroll
	name = "novice's guide to literature"
	result = list(/obj/item/literary)
	reqs = list(/obj/item/paper/scroll = 3)
	tools = list(/obj/item/natural/feather)
	req_table = TRUE
	skillcraft = /datum/skill/misc/reading
	craftdiff = 2
	verbage = "write"
	verbage_tp  = "writes"

/datum/crafting_recipe/readingscroll/apprentice
	name = "apprentice's guide to literature"
	result = list(/obj/item/literary/apprentice)
	craftdiff = 3

/datum/crafting_recipe/readingscroll/journeyman
	name = "journeyman's guide to literature"
	result = list(/obj/item/literary/journeyman)
	craftdiff = 4

/datum/crafting_recipe/readingscroll/expert
	name = "expert's guide to literature"
	result = list(/obj/item/literary/expert)
	craftdiff = 5

/datum/crafting_recipe/readingscroll/master
	name = "master's guide to literature"
	result = list(/obj/item/literary/master)
	craftdiff = 6

/datum/crafting_recipe/quarterstaff
	name = "wooden quarterstaff"
	result = list(/obj/item/weapon/polearm/woodstaff/quarterstaff)
	reqs = list(/obj/item/grown/log/tree = 1)
	req_table = TRUE
	tools = list(/obj/item/weapon/knife)
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/steelstaff
	name = "steel quarterstaff"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/weapon/polearm/woodstaff/quarterstaff = 1, /obj/item/ingot/steel = 1)
	result = list(/obj/item/weapon/polearm/woodstaff/quarterstaff/steel)
	craftdiff = 3

/datum/crafting_recipe/ironstaff
	name = "iron quarterstaff"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/weapon/polearm/woodstaff/quarterstaff = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/weapon/hammer)
	result = list(/obj/item/weapon/polearm/woodstaff/quarterstaff/iron)
	craftdiff = 2

/datum/crafting_recipe/woodflail
	name = "wooden flail x2"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope/chain = 1,
			/obj/item/grown/log/tree/stick = 1, /obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/flail/towner, /obj/item/weapon/flail/towner)
	craftdiff = 2

/datum/crafting_recipe/militia_flail
	name = "militia flail"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/weapon/flail/towner = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/flail/militia)
	craftdiff = 3

/datum/crafting_recipe/woodengreatflail
	name = "thresher"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope = 1,
			/obj/item/grown/log/tree/stick = 1, /obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/thresher)
	craftdiff = 1

/datum/crafting_recipe/bigflail
	name = "great militia flail"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope/chain = 1,
			/obj/item/weapon/thresher = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/thresher/military)
	craftdiff = 3


/datum/crafting_recipe/ironcudgel
	name = "peasant cudgels x2"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/mace/cudgel/carpenter, /obj/item/weapon/mace/cudgel/carpenter)
	craftdiff = 3

/datum/crafting_recipe/wickercloak
	name = "wickercloak"
	result = /obj/item/clothing/cloak/wickercloak
	reqs = list(/obj/item/natural/dirtclod = 1,
				/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/fibers = 3)
	craftdiff = 0

/datum/crafting_recipe/earnecklace
	name = "ear necklace"
	result = /obj/item/clothing/neck/menears
	reqs = list(/obj/item/organ/ears = 4,
				/obj/item/rope = 1)
	craftdiff = 0

/datum/crafting_recipe/elfearnecklace
	name = "elf ear necklace"
	result = /obj/item/clothing/neck/elfears
	reqs = list(/obj/item/organ/ears = 4,
				/obj/item/rope = 1)
	craftdiff = 0

/datum/crafting_recipe/bogcowl
	name = "bogcowl"
	result = /obj/item/clothing/neck/bogcowl
	reqs = list(/obj/item/natural/dirtclod = 1,
				/obj/item/grown/log/tree/stick = 3,
				/obj/item/natural/fibers = 2)
	craftdiff = 0

/datum/crafting_recipe/skullmask
	name = "skull mask"
	result = /obj/item/clothing/face/skullmask
	reqs = list(/obj/item/alch/bone = 3,
				/obj/item/natural/fibers = 1)
	sellprice = 10
	verbage = "crafted"
	craftdiff = 0

/datum/crafting_recipe/antlerhood
	name = "antlerhood"
	result = /obj/item/clothing/head/antlerhood
	reqs = list(/obj/item/natural/hide = 1,
				/obj/item/alch/bone = 2)
	sellprice = 12
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage = "sews"
	craftdiff = 0
/datum/crafting_recipe/bonespear
	name = "bone spear"
	result = /obj/item/weapon/polearm/spear/bonespear
	reqs = list(/obj/item/weapon/polearm/woodstaff = 1,
				/obj/item/alch/bone = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
/datum/crafting_recipe/boneaxe
	name = "bone axe"
	result = /obj/item/weapon/axe/boneaxe
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/alch/bone = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/parchment_scroll
	name = "parchment scroll"
	result = /obj/item/paper/scroll
	reqs = list(/obj/item/paper = 3)

// Woodcutting recipe
/datum/crafting_recipe/lumberjacking
	skillcraft = /datum/skill/labor/lumberjacking
	tools = list(/obj/item/weapon/knife = 1)

/datum/crafting_recipe/lumberjacking/cart_upgrade
	name = "wooden cog"
	result = /obj/item/gear/wood/basic
	reqs = list(/obj/item/natural/wood/plank = 2)
	craftdiff = 3

/datum/crafting_recipe/wood_hammer
	name = "wooden mallet"
	result = /obj/item/weapon/hammer/wood
	reqs = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0

/datum/crafting_recipe/confessional
	name = "confession"
	result = /obj/item/paper/confession
	reqs = list(/obj/item/paper = 1)
	tools = list(/obj/item/natural/feather)
	skillcraft = /datum/skill/misc/reading
	always_availible = FALSE
	craftsound = null
	craftdiff = 0

/datum/crafting_recipe/wpsycross
	name = "handheld psycross"
	reqs = list(/obj/item/grown/log/tree/small = 1)
	result = /obj/item/clothing/neck/psycross
	craftdiff = 0

/datum/crafting_recipe/impsaw
	name = "improvised saw"
	result = /obj/item/weapon/surgery/saw/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/stone = 1, /obj/item/grown/log/tree/stick = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/impretra
	name = "improvised clamp"
	result = /obj/item/weapon/surgery/hemostat/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2)
	craftdiff = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/imphemo
	name = "improvised retractor"
	result = /obj/item/weapon/surgery/retractor/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2)
	craftdiff = 1
	skillcraft = /datum/skill/craft/crafting
