/datum/crafting_recipe/roguetown/sewing
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	subtype_reqs = TRUE // so you can use any subtype of fur
	craftdiff = 0

/*.............. recipes requiring no skill..............*/

/datum/crafting_recipe/roguetown/sewing/rags
	name = "rags"
	result = list(/obj/item/clothing/suit/roguetown/shirt/rags)
	reqs = list(/obj/item/natural/cloth = 2)

/datum/crafting_recipe/roguetown/sewing/burial_shroud
	name = "winding sheet"
	result = list(/obj/item/burial_shroud)
	reqs = list(/obj/item/natural/cloth = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/loincloth
	name = "loincloth"
	result = list(/obj/item/clothing/under/roguetown/loincloth)
	reqs = list(/obj/item/natural/cloth = 1)

/datum/crafting_recipe/roguetown/sewing/halfcloak
	name = "cloth half cloak"
	result = list(/obj/item/clothing/cloak/half)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/apron
	name = "cloth apron"
	result = list(/obj/item/clothing/cloak/apron)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/clothgloves
	name = "cloth gloves"
	result = list(/obj/item/clothing/gloves/roguetown/fingerless)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/shortshirt
	name = "cloth short shirt"
	result = list(/obj/item/clothing/suit/roguetown/shirt/shortshirt/uncolored)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/clothshirt
	name = "cloth shirt"
	result = list(/obj/item/clothing/suit/roguetown/shirt/undershirt/uncolored)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/stripedtunic
	name = "striped tunic"
	result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/light/striped)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/clothtights
	name = "cloth tights"
	result = list(/obj/item/clothing/under/roguetown/tights/uncolored)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/headband
	name = "headband"
	result = list(/obj/item/clothing/head/roguetown/headband)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/strawhat
	name = "crude straw hat"
	result = list(/obj/item/clothing/head/roguetown/strawhat)
	reqs = list(/obj/item/natural/fibers = 3)

/datum/crafting_recipe/roguetown/sewing/knitcap
	name = "knit cap"
	result = list(/obj/item/clothing/head/roguetown/knitcap)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/sewing/cmask
	name = "cloth mask"
	result = list(/obj/item/clothing/mask/rogue/shepherd/clothmask)
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)

/datum/crafting_recipe/roguetown/sewing/linedanklet
	name = "cloth anklet"
	result = list(/obj/item/clothing/shoes/roguetown/boots/clothlinedanklets)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)

/datum/crafting_recipe/roguetown/sewing/zigbox
	name = "zigbox"
	result = list(/obj/item/storage/fancy/cigarettes/zig/empty)
	reqs = list(/obj/item/paper = 1,
				/obj/item/natural/fibers = 1)


/*.............. recipes requiring skill 1 ..............*/

/datum/crafting_recipe/roguetown/sewing/Reyepatch
	name = "right eye patch"
	result = list(/obj/item/clothing/mask/rogue/eyepatch)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/Leyepatch
	name = "left eye patch"
	result = list(/obj/item/clothing/mask/rogue/eyepatch/left)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/fisherhat
	name = "straw fisher hat"
	result = list(/obj/item/clothing/head/roguetown/fisherhat)
	reqs = list(/obj/item/natural/fibers = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/sack
	name = "sack hood"
	result = list(/obj/item/clothing/head/roguetown/menacing)
	reqs = list(/obj/item/natural/cloth = 3,)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/pcoif
	name = "cloth coif"
	result = list(/obj/item/clothing/neck/roguetown/coif/cloth)
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/jupon
	name = "jupon"
	result = list(/obj/item/clothing/cloak/stabard/surcoat)
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/clothtrou
	name = "cloth trousers"
	result = list(/obj/item/clothing/under/roguetown/trou)
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/lgambeson
	name = "light gambeson"
	result = list(/obj/item/clothing/suit/roguetown/armor/gambeson/light)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/sleepingbag
	name = "sleepcloth"
	result = list(/obj/item/sleepingbag)
	reqs =  list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/armingcap
	name = "arming cap"
	result = list(/obj/item/clothing/head/roguetown/armingcap)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1


/*.............. recipes requiring skill 2 ..............*/

/datum/crafting_recipe/roguetown/sewing/gambeson
	name = "gambeson"
	result = /obj/item/clothing/suit/roguetown/armor/gambeson
	reqs = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	tools = list(/obj/item/needle)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/tabard
	name = "tabard"
	result = list(/obj/item/clothing/cloak/tabard)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/stabard
	name = "surcoat"
	result = list(/obj/item/clothing/cloak/stabard)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/bedsheet
	name = "bedsheet"
	result = list(/obj/item/bedsheet/rogue/cloth)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/bedsheetpelt
	name = "leather bedsheet"
	result = list(/obj/item/bedsheet/rogue/pelt)
	reqs = list(/obj/item/natural/hide = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/Bladress
	name = "black dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/black)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/Bludress
	name = "blue dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/blue)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/Purdress
	name = "purple dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/gen/purple)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/silkdress
	name = "Silk dress"
	result = list(/obj/item/clothing/suit/roguetown/shirt/dress/silkdress)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 2

/*.............. recipes requiring skill 3 ..............*/

/datum/crafting_recipe/roguetown/sewing/robe
	name = "robes"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/plain)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/cape
	name = "cape"
	result = list(/obj/item/clothing/cloak/cape)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/silk_coat
	name = "Silk dress"
	result = list(obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/silk = 2
				/obj/item/natural/hide = 1)
	craftdiff = 3



/* .............. recipes requiring skill 4 ..............*/

/datum/crafting_recipe/roguetown/sewing/fancyhat
	name = "fancy hat"
	result = list(/obj/item/clothing/head/roguetown/fancyhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/fancyhat
	name = "fancy hat"
	result = list(/obj/item/clothing/head/roguetown/fancyhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/bardhat
	name = "bard hat"
	result = list(/obj/item/clothing/head/roguetown/bardhat)
	reqs = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/merchant_jacket
	name = "merchant jacket"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/merchant)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/feldsher
	name = "feldsher jacket"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/feld)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/feldsher
	name = "feldsher jacket"
	result = list(/obj/item/clothing/suit/roguetown/shirt/robe/archivist)
	reqs = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4

/*.............. recipes requiring skill 5 ..............*/

/datum/crafting_recipe/roguetown/sewing/lordcloak
	name = "lordly cloak"
	result = list(/obj/item/clothing/cloak/lordcloak)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide = 4)
	craftdiff = 5

/datum/crafting_recipe/roguetown/sewing/tribalrags
	name = "tribal rags"
	result = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	reqs = list(/obj/item/natural/hide = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0
