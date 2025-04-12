/datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/weaponsmithing
	craftdiff = 1
	i_type = "Weapons"
	abstract_type = /datum/anvil_recipe/weapons

// SILVER - Harder to craft, does less damage and has less durability than steel, but banes undead.

/datum/anvil_recipe/weapons/silver/dagger
	name = "Silver Dagger"
	recipe_name = "a Silver Dagger"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/weapon/knife/dagger/silver
	craftdiff = 2

/datum/anvil_recipe/weapons/silver/sword_silver
	name = "Silver Sword"
	recipe_name = "a Silver Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/weapon/sword/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/rapier_silver
	name = "Silver Rapier"
	recipe_name = "a Silver Rapier"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/weapon/sword/rapier/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/forgotten
	name = "Forgotten Blade (+Steel Bar)"
	recipe_name = "a Forgotten Blade"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long/forgotten
	craftdiff = 4

// COPPER TIER - TODO: Move these to redsmithing in future

/datum/anvil_recipe/weapons/copper/caxe
	name = "Copper Hatchet (+Bar)"
	recipe_name = "an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/ingot/copper)
	created_item = /obj/item/weapon/axe/copper
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cbludgeon
	name = "Copper Bludgeon (+Stick)"
	recipe_name = "a Bludgeon"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace/copperbludgeon
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cdagger
	name = "x2 Copper Daggers"
	recipe_name = "a couple Daggers"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/weapon/knife/copper
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 0

//datum/anvil_recipe/weapons/copper/cmace
//	name = "Mace (2)"
//	recipe_name = "a Mace"
//	appro_skill = /datum/skill/craft/weaponsmithing
//	req_bar = /obj/item/ingot/copper
//	additional_items = list(/obj/item/ingot/copper)
//	created_item = (/obj/item/weapon/mace/coppermace)
//	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cmesser
	name = "Copper Messer (+Stick)"
	recipe_name = "a Messer"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/sword/coppermesser
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cspears
	name = "2x Copper Javelins (+Small Log)"
	recipe_name = "two Spears"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/stone/copper
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cfalx
	name = "Copper Falx (+Bar)"
	recipe_name = "a great copper sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/ingot/copper)
	created_item = /obj/item/weapon/sword/long/rider/copper
	craftdiff = 0

// IRON GEAR - Middle Tier, what most disgusting Men at Arms have

/datum/anvil_recipe/weapons/iron/arrows
	name = "5x Arrows (+Plank)"
	recipe_name = "five Arrows"
	appro_skill = /datum/skill/craft/engineering
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/wood/plank)
	created_item = /obj/item/ammo_casing/caseless/arrow
	createmultiple = TRUE
	createditem_num = 4
	i_type = "Ammo"
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/axe_iron
	name = "Iron Axe (+Stick)"
	recipe_name = "an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/axe/iron

/datum/anvil_recipe/weapons/iron/bardiche
	name = "Bardiche (+Bar, +Small Log)"
	recipe_name = "a Bardiche"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/woodcutter
	name = "Woodcutter Axe (+Small Log)"
	recipe_name = "a great axe for woodcutters"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
	craftdiff = 1

/datum/anvil_recipe/weapons/iron/warcutter
	name = "Footman War Axe (+Bar, +Small Log)"
	recipe_name = "a war greataxe"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche/warcutter
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/bolts
	name = "5x Crossbow Bolts (+Plank)"
	recipe_name = "five Crossbow Bolts"
	appro_skill = /datum/skill/craft/engineering
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/wood/plank)
	created_item = /obj/item/ammo_casing/caseless/bolt
	createmultiple = TRUE
	createditem_num = 4
	i_type = "Ammo"
	craftdiff = 1

/datum/anvil_recipe/weapons/iron/dagger_iron
	name = "Dagger x2"
	recipe_name = "a couple Daggers"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/knife/dagger
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 0 // To train with

/datum/anvil_recipe/weapons/iron/dagger_iron
	name = "3x Villager Knives"
	recipe_name = "three peasantry knives"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/knife/villager
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/flail_iron
	name = "Militia flail (+Chain, +Stick)"
	recipe_name = "a militia flail"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/flail/militia


/datum/anvil_recipe/weapons/iron/lucerne
	name = "Lucerne (+Bar, +Small Log)"
	recipe_name = "a Lucerne"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/eaglebeak/lucerne
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/sledgehammer
	name = "Sledgehammer (+Small Log)"
	recipe_name = "a big hammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = 	/obj/item/weapon/hammer/sledgehammer

/datum/anvil_recipe/weapons/iron/mace_iron
	name = "Iron Mace (+Stick)"
	recipe_name = "a Mace"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace

/datum/anvil_recipe/weapons/iron/warhammer
	name = "Iron Warhammer (+1 Stick)"
	recipe_name = "a Warhammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace/warhammer

/datum/anvil_recipe/weapons/iron/messer_iron
	name = "Messer"
	recipe_name = "a Messer"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/sword/scimitar/messer

/datum/anvil_recipe/weapons/iron/spear_iron
	name = "2x Spears (+Small Log)"
	recipe_name = "a couple Spears"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear
	createmultiple = TRUE
	createditem_num = 1

/datum/anvil_recipe/weapons/iron/shortsword_iron
	name = "Short Sword"
	recipe_name = "a Short Sword"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/sword/short
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/sword_iron
	name = "Sword"
	recipe_name = "a Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/sword/iron

/datum/anvil_recipe/weapons/iron/sword_iron
	name = "Estoc"
	recipe_name = "a Duelist Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/sword/rapier/ironestoc

/datum/anvil_recipe/weapons/iron/towershield
	name = "Tower Shield (+Small Log)"
	recipe_name = "a Tower Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/shield/tower
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/ironbuckler
	name = "Iron Buckler"
	recipe_name = "a small Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/shield/tower/buckleriron
	craftdiff = 1

/datum/anvil_recipe/weapons/iron/warclub
	name = "Warclub (+Small Log)"
	recipe_name = "a Warclub"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/mace/goden
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/zweihander
	name = "Zweihander (+Bar x2)"
	recipe_name = "a Zweihander"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/weapon/sword/long/greatsword/zwei
	craftdiff = 3

// STEEL GEAR - Fancy gear for Knights

/datum/anvil_recipe/weapons/steel/axe_steel
	name = "Steel Axe (+Stick)"
	recipe_name = "an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/axe/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/sledgehammer
	name = "Steel Sledgehammer (+Small Log)"
	recipe_name = "a big Sledgehammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = 	/obj/item/weapon/hammer/sledgehammer/war
	craftdiff = 2


/datum/anvil_recipe/weapons/steel/battleaxe
	name = "Battle Axe (+Bar x2)"
	recipe_name = "a Battle Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/axe/battle
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/billhook
	name = "Billhook (+Small Log)"
	recipe_name = "a Billhook"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/billhook
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/cleaver
	name = "Cleaver"
	recipe_name = "a Cleaver"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/knife/cleaver
	craftdiff = 1

/datum/anvil_recipe/weapons/steel/cutlass_steel
	name = "Cutlass"
	recipe_name = "a Cutlass"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/sabre/cutlass
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/dagger_steel
	name = "2x Steel Daggers"
	recipe_name = "a couple Daggers"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/knife/dagger/steel
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/decsaber
	name = "Decorated Sabre (+Gold Bar)"
	recipe_name = "a Decorated Sabre"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/sabre/dec
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/decsword
	name = "Decorated Sword (+Gold Bar)"
	recipe_name = "a Decorated Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/decorated
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/decrapier
	name = "Decorated Rapier (+Gold Bar)"
	recipe_name = "a Decorated Rapier"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/rapier/dec
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/eaglebeak
	name = "Eagle's Beak (+Bar, +Small Log)"
	recipe_name = "an Eagle's Beak"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/eaglebeak
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/flail_steel
	name = "Steel Flail (+Chain, +Stick)"
	recipe_name = "a Flail"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/flail/sflail
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/grandmace
	name = "Grand Mace (+Small Log)"
	recipe_name = "a Grand Mace"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/mace/goden/steel
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/greatsword
	name = "Greatsword (+Bar x2)"
	recipe_name = "a Greatsword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long/greatsword
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/halberd
	name = "Halberd (+Bar, +Small Log)"
	recipe_name = "a Halberd"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/huntknife
	name = "Hunting Knife"
	recipe_name = "a Hunting Knife"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/knife/hunting
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/kiteshield
	name = "Kite Shield (+Bar, +Hide)"
	recipe_name = "a Kite Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/natural/hide)
	created_item = /obj/item/weapon/shield/tower/metal
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/longsword
	name = "Longsword (+Bar)"
	recipe_name = "a Longsword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/mace_steel
	name = "Steel Mace (+Bar)"
	recipe_name = "a Mace"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/mace/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/swarhammer
	name = "Steel Warhammer (+Bar)"
	recipe_name = "a Warhammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/mace/warhammer/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/peasant_flail
	name = "Peasant Flail (+Chain, +Small Log)"
	recipe_name = "a two-handed flail"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/flail/peasant
	craftdiff = 3

/datum/anvil_recipe/weapons/iron/chain_whip
	name = "Chain Whip (+chain)"
	recipe_name = "a whip made from chains"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rope/chain)
	created_item = /obj/item/weapon/whip/chain
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/paxe
	name = "Pick-Axe (+Bar, +Stick)"
	recipe_name = "a Pick that is also an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick/paxe
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/rapier_steel
	name = "Rapier"
	recipe_name = "a Rapier"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/rapier
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/saber_steel
	name = "Sabre"
	recipe_name = "a Sabre"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/sabre
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/sword_steel
	name = "Arming Sword"
	recipe_name = "a Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/arming
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/scimitar_steel
	name = "Scimitar"
	recipe_name = "a Zybean Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/scimitar
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/falchion
	name = "Falchion"
	recipe_name = "a heavy one handed sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/scimitar/falchion
	craftdiff = 2

/datum/anvil_recipe/weapons/bronze/gladius
	name = "Gladius"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/weapon/sword/gladius
	craftdiff = 2

/datum/anvil_recipe/weapons/bronze/spear
	name = "Bronze Spear (+Bar, +Small Log)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/bronze
	craftdiff = 0
