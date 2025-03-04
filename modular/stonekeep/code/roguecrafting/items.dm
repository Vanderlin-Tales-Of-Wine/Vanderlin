/* CRAFTING	uses the Crafting skill, natch. Pretty much every recipe that doesn't fit somewhere else.
==========================================================*/

/datum/crafting_recipe/roguetown
	always_availible = TRUE
	skillcraft = /datum/skill/craft/crafting
	craftdiff = 0

/*========= NO SKILL LEVEL REQUIRED ==========*/

/datum/crafting_recipe/roguetown/torch
	name = "torch"
	result = /obj/item/flashlight/flare/torch
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/tneedle
	name = "sewing needle"
	result = /obj/item/needle/thorn
	reqs = list(/obj/item/natural/thorn = 1,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/cloth
	name = "cloth"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/natural/fibers = 2)
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage = "sew"
	verbage_tp = "sews"

/datum/crafting_recipe/roguetown/pipe
	name = "wood pipe"
	result = /obj/item/clothing/face/cigarette/pipe
	reqs = list(/obj/item/grown/log/tree/stick = 2)

/datum/crafting_recipe/roguetown/sigdry
	name = "westleach zig"
	result = /obj/item/clothing/face/cigarette/rollie/nicotine
	reqs = list(/obj/item/reagent_containers/food/snacks/produce/dry_westleach = 1,
				/obj/item/paper = 1)
	time = 10 SECONDS
	verbage = "roll"
	verbage_tp = "rolls"

/datum/crafting_recipe/roguetown/sigsweet
	name = "swampweed zig"
	result = /obj/item/clothing/face/cigarette/rollie/cannabis
	reqs = list(/obj/item/reagent_containers/food/snacks/produce/swampweed_dried = 1,
				/obj/item/paper = 1)
	time = 10 SECONDS
	verbage = "roll"
	verbage_tp = "rolls"



/datum/crafting_recipe/roguetown/rope
	name = "rope"
	result = /obj/item/rope
	reqs = list(/obj/item/natural/fibers = 3)
	verbage = "braid"
	verbage_tp = "braids"

/datum/crafting_recipe/roguetown/zigbox
	name = "paper zigbox"
	result = list(/obj/item/storage/fancy/cigarettes/zig/empty)
	reqs = list(/obj/item/paper = 1)


/*========= HUNTING ==========*/
/datum/crafting_recipe/roguetown/rod
	name = "fishing rod"
	result = /obj/item/fishingrod
	reqs = list(/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2)
	tools = list(/obj/item/weapon/knife)
	craftdiff = 1

/obj/item/fishingrod/crafted

/datum/crafting_recipe/roguetown/bait
	name = "bait"
	result = /obj/item/bait
	reqs = list(/obj/item/storage/bag = 1,
				/obj/item/reagent_containers/food/snacks/produce/wheat = 2)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbaita
	name = "bait (sweetbait apple)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/bag = 1,
				/obj/item/reagent_containers/food/snacks/produce/apple = 2)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbait
	name = "bait (sweetbait berry)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/bag = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry = 2)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/bloodbait
	name = "bait (bloodbait)"
	result = /obj/item/bait/bloody
	reqs = list(/obj/item/storage/bag = 1,
				/obj/item/reagent_containers/food/snacks/meat = 1)
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/earnecklace
	name = "ear necklace"
	result = /obj/item/clothing/neck/menears
	reqs = list(/obj/item/organ/ears = 4,
				/obj/item/rope = 1)

/datum/crafting_recipe/roguetown/elfearnecklace
	name = "elf ear necklace"
	result = /obj/item/clothing/neck/elfears
	reqs = list(/obj/item/organ/ears = 4,
				/obj/item/rope = 1)

/*========= FISHING ==========*/
/datum/crafting_recipe/roguetown/fishbait
	name = "fishbait (red)"
	result = list(/obj/item/fishing/bait/meat,
				/obj/item/fishing/bait/meat)
	reqs = list(/obj/item/reagent_containers/food/snacks/meat/mince = 1)
	subtype_reqs = TRUE
	verbage = "starts rolling some bait"
	verbage_tp = "starts rolling some bait"

/datum/crafting_recipe/roguetown/fishbait/dough
	name = "fishbait (dough)"
	result = list(/obj/item/fishing/bait/dough,
				/obj/item/fishing/bait/dough)
	reqs = list(/obj/item/reagent_containers/food/snacks/dough_slice = 1)

/datum/crafting_recipe/roguetown/fishreel
	name = "fishing line (fibre)"
	result = /obj/item/fishing/reel/twine
	reqs = list(/obj/item/natural/fibers = 2, /obj/item/grown/log/tree/stick = 1)
	verbage ="starts weaving a reel"
	verbage_tp ="starts weaving a reel"

/datum/crafting_recipe/roguetown/fishreel/silk
	name = "fishing line (silk)"
	result = /obj/item/fishing/reel/silk
	reqs = list(/obj/item/natural/silk = 1, /obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/roguetown/fishreel/leather
	name = "fishing line (leather)"
	result = /obj/item/fishing/reel/leather
	reqs = list(/obj/item/natural/hide = 1, /obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/roguetown/fishbobber
	name = "fishing bobber (wood)"
	result = /obj/item/fishing/line/bobber
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/roguetown/fishsinker
	name = "fishing sinker (stone)"
	result = /obj/item/fishing/line/sinker
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/fishhook
	name = "fishing hook (wood)"
	result = /obj/item/fishing/line/sinker
	reqs = list(/obj/item/grown/log/tree/stick = 2)

/datum/crafting_recipe/roguetown/fishhook/thorn
	name = "fishing hook (thorn)"
	result = /obj/item/fishing/line/sinker
	reqs = list(/obj/item/natural/thorn = 1)




/*========= SKILL LEVEL: 1 REQUIRED ==========*/
/datum/crafting_recipe/roguetown/candle
	name = "candle (x2)"
	result = list(/obj/item/candle/yellow,
				/obj/item/candle/yellow)
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/basket_wicker
	name = "wicker basket"
	result = /obj/structure/closet/crate/chest/wicker
	reqs = list(/obj/item/natural/fibers = 4)
	craftdiff = 1

/datum/crafting_recipe/roguetown/broom
	name = "broom"
	result = /obj/item/broom
	reqs = list(/obj/item/natural/fibers = 1,
			/obj/item/grown/log/tree/stick = 4)
	craftdiff = 1





/*========= ALCHEMY ==========*/
/datum/crafting_recipe/roguetown/pestle
	name = "alchemny ( stone pestle )"
	result = /obj/item/pestle
	reqs = list(/obj/item/natural/stone = 1)
	tools = list(/obj/item/weapon/chisel)
	verbage = "crafts"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/roguetown/pestle/bone
	name = "alchemy ( bone pestle )"
	reqs = list(/obj/item/alch/bone = 1)
	tools = /obj/item/weapon/knife
	subtype_reqs = TRUE
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/alchmortar
	name = "alchemy ( stone mortar )"
	result = /obj/item/mortar
	reqs = list(/obj/item/natural/stone = 3)
	tools = list(/obj/item/weapon/chisel)
	verbage = "crafts"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/roguetown/alchmortar/bone
	name = "alchemy ( bone mortar )"
	reqs = list(/obj/item/alch/bone = 3)
	tools = /obj/item/weapon/knife
	subtype_reqs = TRUE
	skillcraft = /datum/skill/craft/crafting


/*========= AMMO CRAFTING ==========*/
/datum/crafting_recipe/roguetown/stonearrow
	name = "arrows (x2 stone)"
	result = list(/obj/item/ammo_casing/caseless/arrow/stone,
				/obj/item/ammo_casing/caseless/arrow/stone)
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)
	req_table = TRUE

/datum/crafting_recipe/roguetown/stonearrow_five
	name = "arrows (x10 stone)"
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

/datum/crafting_recipe/roguetown/poisonarrow
	name = "arrow (poison)"
	result = /obj/item/ammo_casing/caseless/arrow/poison
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/poisonarrow/alt
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/datum/reagent/berrypoison = 5)

/datum/crafting_recipe/roguetown/poisonarrow/potent
	name = "arrow (potent poison)"
	result = /obj/item/ammo_casing/caseless/arrow/poison/potent
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/datum/reagent/strongpoison = 5)

/datum/crafting_recipe/roguetown/poisonbolt
	name = "bolt (poison)"
	result = /obj/item/ammo_casing/caseless/bolt/poison
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/poisonbolt/alt
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/datum/reagent/berrypoison = 5)

/datum/crafting_recipe/roguetown/poisonbolt/potent
	name = "bolt (potent poison)"
	result = /obj/item/ammo_casing/caseless/bolt/poison/potent
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/datum/reagent/strongpoison = 5)
/* kaizoku ROGTODO
/datum/crafting_recipe/roguetown/shinobiarrow
	name = "shinobi arrow(5)"
	result = list(/obj/item/ammo_casing/caseless/arrow/poison/fog,
			/obj/item/ammo_casing/caseless/arrow/poison/fog,
			/obj/item/ammo_casing/caseless/arrow/poison/fog,
			/obj/item/ammo_casing/caseless/arrow/poison/fog,
			/obj/item/ammo_casing/caseless/arrow/poison/fog)
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 5,
				/obj/item/reagent_containers/food/snacks/fogdart = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/shinobibolt
	name = "sedative bolt(5)"
	result = list(/obj/item/ammo_casing/caseless/bolt/poison/fog,
			/obj/item/ammo_casing/caseless/bolt/poison/fog,
			/obj/item/ammo_casing/caseless/bolt/poison/fog,
			/obj/item/ammo_casing/caseless/bolt/poison/fog,
			/obj/item/ammo_casing/caseless/bolt/poison/fog)
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 5,
				/obj/item/reagent_containers/food/snacks/fogdart = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/kusaripeasant
	name = "handmade kusarigama"
	result = /obj/item/weapon/flail/kusarigama/peasant
	reqs = list(/obj/item/weapon/sickle/kama = 1,
				/obj/item/rope/chain = 1)
	craftdiff = 1
*/
/*========= ENGINEEERING CRAFTING ==========*/
/datum/crafting_recipe/roguetown/mantrap
	name = "mantrap"
	result = list(/obj/item/restraints/legcuffs/beartrap,
				/obj/item/restraints/legcuffs/beartrap)
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 2,
				/obj/item/ingot/iron = 1)
	req_table = TRUE
	skillcraft = /datum/skill/craft/traps
	craftdiff = 1
	verbage = "put together"
	verbage_tp = "puts together"

/datum/crafting_recipe/roguetown/flint
	name = "flint"
	result = /obj/item/flint
	reqs = list(
			/obj/item/natural/stone = 1,
			/obj/item/ingot/iron = 1)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 0 // Something to practice engineering with.

/datum/crafting_recipe/roguetown/pyroarrow
	name = "pyroclastic arrow"
	result = /obj/item/ammo_casing/caseless/arrow/pyro
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/pyrobolt
	name = "pyroclastic bolt"
	result = /obj/item/ammo_casing/caseless/bolt/pyro
	reqs = list(/obj/item/ammo_casing/caseless/bolt = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/bomb
	name = "bomb"
	result = /obj/item/bomb/homemade
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
				/obj/item/reagent_containers/glass/bottle = 1)
	craftdiff = 2
	skillcraft = /datum/skill/craft/bombs
	subtype_reqs = TRUE

/*========= LITERATURE CRAFTING ==========*/
/datum/crafting_recipe/roguetown/paperscroll
	name = "parchment scroll x5"
	result = list(/obj/item/paper/scroll,
				/obj/item/paper/scroll,
				/obj/item/paper/scroll,
				/obj/item/paper/scroll,
				/obj/item/paper/scroll)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/datum/reagent/water = 50)
	tools = list(/obj/item/weapon/knife/hunting)
	structurecraft = /obj/machinery/tanningrack
	craftdiff = 1

/datum/crafting_recipe/roguetown/readingscroll
	name = "novice's guide to literature"
	result = list(/obj/item/literary)
	reqs = list(/obj/item/paper/scroll = 3)
	tools = list(/obj/item/natural/feather)
	req_table = TRUE
	skillcraft = /datum/skill/misc/reading
	craftdiff = 2
	verbage = "write"
	verbage_tp  = "writes"

/datum/crafting_recipe/roguetown/readingscroll/apprentice
	name = "apprentice's guide to literature"
	result = list(/obj/item/literary/apprentice)
	craftdiff = 3

/datum/crafting_recipe/roguetown/readingscroll/journeyman
	name = "journeyman's guide to literature"
	result = list(/obj/item/literary/journeyman)
	craftdiff = 4

/datum/crafting_recipe/roguetown/readingscroll/expert
	name = "expert's guide to literature"
	result = list(/obj/item/literary/expert)
	craftdiff = 5

/datum/crafting_recipe/roguetown/readingscroll/master
	name = "master's guide to literature"
	result = list(/obj/item/literary/master)
	craftdiff = 6

/datum/crafting_recipe/roguetown/parchment_scroll
	name = "parchment scroll"
	result = /obj/item/paper/scroll
	reqs = list(/obj/item/paper = 3)

/datum/crafting_recipe/roguetown/confessional
	name = "confession"
	result = /obj/item/paper/confession
	reqs = list(/obj/item/paper = 1)
	tools = list(/obj/item/natural/feather)
	skillcraft = /datum/skill/misc/reading
	always_availible = FALSE
	craftsound = null
	craftdiff = 0


/*========= COOKING ==========*/
/datum/crafting_recipe/roguetown/pot_stone
	name = "cooking pot (stone)"
	result = list(/obj/item/reagent_containers/glass/bucket/pot/stone)
	reqs = list(/obj/item/natural/stone = 2)
	skillcraft = /datum/skill/craft/masonry


// ---------	WEAPONS		-------------
/datum/crafting_recipe/roguetown/woodstaff//this is the simple staff anyone can make
	name = "wood staff"
	result = list(/obj/item/weapon/polearm/woodstaff,
	/obj/item/weapon/polearm/woodstaff,
	/obj/item/weapon/polearm/woodstaff)
	reqs = list(/obj/item/grown/log/tree = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/stoneaxe
	name = "stone axe"
	result = /obj/item/weapon/axe/stone
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/stoneknife
	name = "stone knife"
	result = /obj/item/weapon/knife/stone
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/stonespear
	name = "stone spear"
	result = /obj/item/weapon/polearm/spear/stone
	reqs = list(/obj/item/weapon/polearm/woodstaff = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/woodclub
	name = "wood club"
	result = /obj/item/weapon/mace/woodclub
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/steelstaff
	name = "quarterstaff (steel)"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/weapon/polearm/woodstaff/quarterstaff = 1, /obj/item/ingot/steel = 1)
	result = list(/obj/item/weapon/polearm/woodstaff/quarterstaff/steel)
	craftdiff = 3

/datum/crafting_recipe/roguetown/ironstaff
	name = "quarterstaff (iron)"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/weapon/polearm/woodstaff/quarterstaff = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/weapon/hammer)
	result = list(/obj/item/weapon/polearm/woodstaff/quarterstaff/iron)
	craftdiff = 2


/datum/crafting_recipe/roguetown/woodengreatflail
	name = "thresher"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope = 1,
			/obj/item/grown/log/tree/stick = 1, /obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/thresher)
	craftdiff = 1

/datum/crafting_recipe/roguetown/bigflail
	name = "militia flail"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope/chain = 1,
			/obj/item/weapon/thresher = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/thresher/military)
	craftdiff = 2

/datum/crafting_recipe/roguetown/ironcudgel
	name = "studded club"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	result = list(/obj/item/weapon/mace/cudgel/carpenter, /obj/item/weapon/mace/cudgel/carpenter)
	craftdiff = 2

/datum/crafting_recipe/roguetown/bonespear
	name = "bone spear"
	result = /obj/item/weapon/polearm/spear/bonespear
	reqs = list(/obj/item/weapon/polearm/woodstaff = 1,
				/obj/item/alch/bone = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/dart
	name = "dart"
	result = /obj/item/ammo_casing/caseless/dart
	reqs = list(/obj/item/natural/thorn = 1,
				/obj/item/grown/log/tree/stick = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/blowgun
	name = "blowgun"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
	reqs = list(/obj/item/grown/log/tree/stick = 1)
	craftdiff = 3


// ---------	CLOTHING		-------------
/datum/crafting_recipe/roguetown/skullmask
	name = "mask (skull)"
	result = /obj/item/clothing/face/skullmask
	reqs = list(/obj/item/alch/bone = 3,
				/obj/item/natural/fibers = 1)
	sellprice = 10
	verbage = "crafted"
	craftdiff = 0

/datum/crafting_recipe/roguetown/wickercloak
	name = "cloak (wicker)"
	result = /obj/item/clothing/cloak/wickercloak
	reqs = list(/obj/item/natural/dirtclod = 1,
				/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/fibers = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/bogcowl
	name = "hood (bogcowl)"
	result = /obj/item/clothing/neck/bogcowl
	reqs = list(/obj/item/natural/dirtclod = 1,
				/obj/item/grown/log/tree/stick = 3,
				/obj/item/natural/fibers = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/clothsash
	name = "cloth sash"
	result = /obj/item/storage/belt/leather/cloth
	reqs = list(/obj/item/natural/cloth = 1)
	verbage = "tie"
	verbage_tp = "ties"

/datum/crafting_recipe/roguetown/unclothsash
	name = "untie cloth sash"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/storage/belt/leather/cloth = 1)
	verbage = "untie"
	verbage_tp = "unties"

/datum/crafting_recipe/roguetown/ropebelt
	name = "rope belt"
	result = /obj/item/storage/belt/leather/rope
	reqs = list(/obj/item/rope = 1)
	verbage = "tie"
	verbage_tp = "ties"

/datum/crafting_recipe/roguetown/unropebelt
	name = "untie rope belt"
	result = /obj/item/rope
	reqs = list(/obj/item/storage/belt/leather/rope = 1)
	verbage = "untie"
	verbage_tp  = "unties"

/datum/crafting_recipe/roguetown/reinforce_gloves
	name = "reinforce gloves"
	result = /obj/item/clothing/gloves/reinforced
	reqs = list(/obj/item/clothing/gloves/leather = 1, /obj/item/ingot/iron = 1)
	verbage = "modifies"
	verbage_tp  = "modifies"


// ---------	LUMBERJACKING RECIPE		-------------
/datum/crafting_recipe/roguetown/lumberjacking
	skillcraft = /datum/skill/labor/lumberjacking
	tools = list(/obj/item/weapon/knife/hunting = 1)
/*
/datum/crafting_recipe/roguetown/lumberjacking/cart_upgrade
	name = "upgrade cog"
	result = /obj/item/cart_upgrade/level_1
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/stone = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/lumberjacking/cart_upgrade2
	name = "advanced upgrade cog"
	result = /obj/item/cart_upgrade/level_2
	reqs = list(/obj/item/grown/log/tree/small = 4,
				/obj/item/cart_upgrade/level_1 = 1,
				/obj/item/ingot/iron = 1)
	craftdiff = 4
*/
/datum/crafting_recipe/roguetown/wood_hammer
	name = "tool (wooden mallet)"
	result = /obj/item/weapon/hammer/wood
	reqs = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0


/datum/crafting_recipe/roguetown/wpsycross
	name = "handheld psycross"
	reqs = list(/obj/item/grown/log/tree/small = 1)
	result = /obj/item/clothing/neck/psycross
	craftdiff = 0

/datum/crafting_recipe/roguetown/impsaw
	name = "surgery (crude saw)"
	result = /obj/item/weapon/surgery/saw/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/stone = 1, /obj/item/grown/log/tree/stick = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/impretra
	name = "surgery (crude clamp)"
	result = /obj/item/weapon/surgery/hemostat/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/imphemo
	name = "surgery (crude retractor)"
	result = /obj/item/weapon/surgery/retractor/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2)
	craftdiff = 1

// ---------	PAINTING		-------------
/datum/crafting_recipe/roguetown/canvas
	name = "painting (canvas)"
	result = /obj/item/canvas
	reqs = list(/obj/item/paper = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/paintbrush
	name = "painting (brush)"
	result = /obj/item/paint_brush
	reqs = list(/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/feather = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/palette
	name = "painting (palette)"
	result = /obj/item/paint_palette
	reqs = list(/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/wood/plank = 1)
	craftdiff = 1


