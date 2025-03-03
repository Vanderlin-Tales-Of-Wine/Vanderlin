/* WEAVING	-	sewing skill
==========================================================*/
// The only ingridients these recipes can require is SILK and CLOTH
// They all require a loom

/datum/crafting_recipe/roguetown/weaving
	structurecraft = /obj/machinery/loom
	skillcraft = /datum/skill/misc/sewing
	subtype_reqs = TRUE // so you can use any subtype of fur
	reqs = list(/obj/item/natural/silk = 2)
	craftdiff = 1

/*========= SKILL LEVEL: 1 REQUIRED ==========*/

/datum/crafting_recipe/roguetown/weaving/rags
	name = "shirt (webbed)"
	result = list(/obj/item/clothing/shirt/undershirt/webs)

/datum/crafting_recipe/roguetown/weaving/webbing
	name = "trousers (webbed leggings)"
	result = list(/obj/item/clothing/pants/webs)

/datum/crafting_recipe/roguetown/weaving/shepardmask
	name = "mask (silk)"
	result = list(/obj/item/clothing/face/shepherd)
	reqs = list(/obj/item/natural/silk = 1)
	sellprice = 30

/*========= SKILL LEVEL: 2 REQUIRED ==========*/

/* craftdif of 2 = APPRENTICE */


/datum/crafting_recipe/roguetown/weaving/shadowgloves
	name = "gloves (shadow)"
	result = list(/obj/item/clothing/gloves/fingerless/shadowgloves)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2


/datum/crafting_recipe/roguetown/weaving/stockings_white_silk
	name = "stockings (white silk)"
	result = list(/obj/item/clothing/pants/tights/stockings/silk/white)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/weaving/stockings_black_silk
	name = "stockings (black silk)"
	result = list(/obj/item/clothing/pants/tights/stockings/silk/black)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/weaving/stockings_blue_silk
	name = "stockings (blue silk)"
	result = list(/obj/item/clothing/pants/tights/stockings/silk/blue)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/weaving/stockings_red_silk
	name = "stockings (red silk)"
	result = list(/obj/item/clothing/pants/tights/stockings/silk/red)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/weaving/stockings_purple_silk
	name = "stockings (purple silk)"
	result = list(/obj/item/clothing/pants/tights/stockings/silk/purple)
	reqs = list(/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/weaving/cloak
	name = "cloak (silk half cloak)"
	result = list(/obj/item/clothing/cloak/half)
	craftdiff = 2
	sellprice = 19

/datum/crafting_recipe/roguetown/weaving/bathrobe
	name = "bathrobe"
	result = list(/obj/item/clothing/shirt/robe/bath)
	reqs = list(/obj/item/natural/silk = 2,
				/obj/item/natural/fur = 1)
	craftdiff = 2
	sellprice = 10

/datum/crafting_recipe/roguetown/weaving/mundies
	name = "masculine smallclothes"
	result = list(/obj/item/undies)
	craftdiff = 2
	sellprice = 20

/datum/crafting_recipe/roguetown/weaving/fundies
	name = "feminine smallclothes"
	result = list(/obj/item/undies/f)
	craftdiff = 2
	sellprice = 20

/datum/crafting_recipe/roguetown/weaving/chaperonesilk
	name = "hat (chaperone)"
	result = list(/obj/item/clothing/head/chaperon/greyscale/silk)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/weaving/shadowcloak
	name = "cloak (shadow)"
	result = list(/obj/item/clothing/cloak/half/shadowcloak)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/weaving/shadowshirt
	name = "shirt (shadow)"
	result = list(/obj/item/clothing/shirt/shadowshirt)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4

/datum/crafting_recipe/roguetown/weaving/shadowpants
	name = "trousers (shadow)"
	result = list(/obj/item/clothing/pants/trou/shadowpants)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4



/*========= SKILL LEVEL: 3 REQUIRED ==========*/

/datum/crafting_recipe/roguetown/weaving/shirt
	name = "shirt (formal silks)"
	result = list(/obj/item/clothing/shirt/undershirt/puritan)
	craftdiff = 3
	sellprice = 35

/datum/crafting_recipe/roguetown/weaving/silkdress
	name = "dress (chemise)"
	result = list (/obj/item/clothing/shirt/dress/silkdress/random)
	craftdiff = 3
	sellprice = 30

/datum/crafting_recipe/roguetown/weaving/barmaid
	name = "dress (innkeep)"
	result = list (/obj/item/clothing/shirt/dress)
	craftdiff = 3
	sellprice = 27

/datum/crafting_recipe/roguetown/weaving/valorian
	name = "dress (valorian)"
	result = list(/obj/item/clothing/shirt/dress/valorian)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/weaving/silkpantaloons
	name = "trousers (silk pantaloons)"
	result = list (/obj/item/clothing/under/pantaloons/random)
	craftdiff = 3
	sellprice = 20

/datum/crafting_recipe/roguetown/weaving/cape_silk
	name = "cloak (silk cape)"
	result = list(/obj/item/clothing/cloak/cape/silk/random)
	reqs = list(/obj/item/natural/silk = 3)
	craftdiff = 3
	sellprice = 40


/*========= SKILL LEVEL: 4 REQUIRED ==========*/

/datum/crafting_recipe/roguetown/weaving/silkcoat
	name = "armor (silk coat)"
	result = list (/obj/item/clothing/armor/leather/jacket/silk_coat)
	reqs = list(/obj/item/natural/silk = 4,
				/obj/item/natural/cloth = 1)
	craftdiff = 4
	sellprice = 60

/datum/crafting_recipe/roguetown/weaving/armordress
	name = "armor (padded dress)"
	result = /obj/item/clothing/armor/gambeson/heavy/dress
	reqs = list(/obj/item/natural/silk = 4,
				/obj/item/natural/cloth = 1)
	craftdiff = 4
	sellprice = 80

/datum/crafting_recipe/roguetown/weaving/eorastraps
	name = "robe (eora straps)"
	result = list(/obj/item/clothing/shirt/robe/eora/alt)
	reqs = list(/obj/item/natural/silk = 3)
	craftdiff = 4
	sellprice = 50

/*========= SKILL LEVEL: 5 REQUIRED ==========*/

/datum/crafting_recipe/roguetown/weaving/lordcloak
	name = "cloak (lord)"
	result = list(/obj/item/clothing/cloak/lordcloak)
	reqs = list(/obj/item/natural/fur = 2,
				/obj/item/natural/silk = 4)
	craftdiff = 5


/datum/crafting_recipe/roguetown/weaving/gown
	name = "gown (spring)"
	result = /obj/item/clothing/shirt/dress/gown
	reqs = list(/obj/item/natural/silk = 4)
	craftdiff = 4

/datum/crafting_recipe/roguetown/weaving/gown/summer
	name = "gown (summer)"
	result = /obj/item/clothing/shirt/dress/gown/summergown

/datum/crafting_recipe/roguetown/weaving/gown/fall
	name = "gown (fall)"
	result = /obj/item/clothing/shirt/dress/gown/fallgown

/datum/crafting_recipe/roguetown/weaving/gown/winter
	name = "gown (winter)"
	result = /obj/item/clothing/shirt/dress/gown/wintergown
	reqs = list(/obj/item/natural/silk = 3,
				/obj/item/natural/fur/cabbit = 1)

