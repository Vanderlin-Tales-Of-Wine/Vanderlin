/* * * * * * * * * * * **
 *						*
 *		 Crafting		*
 *						*
 *						*
 * * * * * * * * * * * **/

// =================================================================================
/*-----------------\
| Crafting Recipes |
\-----------------*/
/datum/crafting_recipe/roguetown/structure/stonetable
	name = "stone table (long mid)"
	result = /obj/structure/table/stone
	reqs = list(/obj/item/natural/stone = 2)
	verbage = "build"
	verbage_tp = "builds"
	craftsound = 'sound/foley/Building-01.ogg'
	time = 4 SECONDS
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 3
/datum/crafting_recipe/roguetown/structure/stonetable/end
	name = "stone table (long end)"
	result = /obj/structure/table/stone_end

/datum/crafting_recipe/roguetown/structure/stonetable/small
	name = "stone table (single)"
	result = /obj/structure/table/stone_small

/*	.................   Unique Feldsher recipes   ................... */
/datum/crafting_recipe/nitmaiden_license
	name = "Nitemaiden health license"
	time = 4 SECONDS
	reqs = list(/obj/item/paper = 1,
		/obj/item/natural/feather = 1)
	result = /obj/item/paper/feldsher_certificate
	category = CAT_NONE

/*--------------\
| Anvil Recipes |
\--------------*/
/datum/anvil_recipe/weapons/iron/lucerne
	name = "Poleaxe (+Bar, +Small Log)"
	recipe_name = "a Poleaxe"

/datum/anvil_recipe/weapons/iron/spear_iron
	name = "Spear (+Small Log)"
	recipe_name = "a Spear"
	createmultiple = FALSE

/datum/anvil_recipe/weapons/steel/peasant_flail
	name = "Crusher (+Chain, +Small Log)"
	recipe_name = "a two-handed flail"

/datum/anvil_recipe/weapons/copper/cbludgeon
	name = "Studded club (+Club)"
	recipe_name = "a Studded Club"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/weapon/mace/woodclub)
	created_item = /obj/item/weapon/mace/copperbludgeon
	craftdiff = 0


// Disabled?
/datum/anvil_recipe/tools/hoe/copper
	req_bar = /obj/item/natural/stoneblock

/datum/anvil_recipe/tools/pitchfork/copper
	req_bar = /obj/item/natural/stoneblock

/datum/anvil_recipe/tools/pick/copper
	req_bar = /obj/item/natural/stoneblock

/datum/anvil_recipe/tools/hammer/copper
	req_bar = /obj/item/natural/stoneblock

/datum/anvil_recipe/weapons/copper/cmesser
	req_bar = /obj/item/natural/stoneblock

/datum/anvil_recipe/weapons/copper/cfalx
	req_bar = /obj/item/natural/stoneblock



/datum/crafting_recipe/roguetown/woodflail
	name = "wooden flail x2"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/weapon/flail/towner = 1,
			/obj/item/ingot/iron = 10)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	craftdiff = 2

/datum/crafting_recipe/roguetown/militia_flail
	name = "militia flail"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/weapon/flail/towner = 1, /obj/item/ingot/iron = 10)
	tools = list(/obj/item/weapon/hammer)
	req_table = TRUE
	craftdiff = 3



/datum/anvil_recipe/tools/iron/handsaw
	name = "Handsaw (+1 Stick)"
	recipe_name = "a saw for woodworking"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/handsaw
	i_type = "Tools"

/datum/anvil_recipe/tools/iron/chisel
	name = "Chisel"
	recipe_name = "a chisel for stoneworking"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/chisel
	i_type = "Tools"


/datum/anvil_recipe/armor/iron/splint_legs
	name = "Splint Chausses (+ 2 hide)"
	recipe_name = "a pair of Splint Chausses"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/natural/hide, /obj/item/natural/hide)
	created_item = /obj/item/clothing/under/splintlegs
	craftdiff = 2


/datum/anvil_recipe/armor/iron/splint_arms
	name = "Splint Vambraces (+ 2 hide)"
	recipe_name = "a pair of Splint Vambraces"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/natural/hide, /obj/item/natural/hide)
	created_item = /obj/item/clothing/wrists/roguetown/bracers/splint
	craftdiff = 2


/datum/anvil_recipe/armor/steel/brigadine
	name = "Platemail Chausses (+Bar)"
	recipe_name = "a pair of Platemail Chausses"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/under/chainlegs/reinforced
	craftdiff = 3

