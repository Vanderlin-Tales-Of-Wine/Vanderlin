/datum/anvil_recipe/weapons
	craftdiff = 1
	i_type = "Weapons"
	abstract_type = /datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/weaponsmithing
//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- COPPER -----------
/datum/anvil_recipe/weapons/copper
	abstract_type = /datum/anvil_recipe/weapons/copper
	req_bar = /obj/item/ingot/copper
	craftdiff = 0
///////////////////////////////////////////////

// BLUNT
/datum/anvil_recipe/weapons/copper/cbludgeon
	name = "Copper Bludgeon (+Stick)"
	recipe_name = "a Bludgeon"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace/copperbludgeon

//datum/anvil_recipe/weapons/copper/cmace
//	name = "Mace (2)"
//	recipe_name = "a Mace"
//	req_bar = /obj/item/ingot/copper
//	additional_items = list(/obj/item/ingot/copper)
//	created_item = (/obj/item/weapon/mace/coppermace)
//	craftdiff = 0

// DAGGERS
/datum/anvil_recipe/weapons/copper/dagger
	name = "x2 Copper Daggers"
	recipe_name = "a couple Daggers"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/weapon/knife/copper
	createmultiple = TRUE
	createditem_num = 1

//SWORDS
/datum/anvil_recipe/weapons/copper/messer
	name = "Copper Messer (+Stick)"
	recipe_name = "a Messer"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/sword/coppermesser

//SPEARS
/datum/anvil_recipe/weapons/copper/spears
	name = "2x Copper Javelins (+Small Log)"
	recipe_name = "two Spears"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/stone/copper
	createmultiple = TRUE
	createditem_num = 1

//GREATSWORD
/datum/anvil_recipe/weapons/copper/falx
	name = "Copper Falx (+Bar)"
	recipe_name = "a great copper sword"
	req_bar = /obj/item/ingot/copper
	additional_items = list(/obj/item/ingot/copper)
	created_item = /obj/item/weapon/sword/long/rider/copper


//////////////////////////////////////////////////////////////////////////////////////////////
// --------- IRON ------------ Middle Tier, what most disgusting Men at Arms have
/datum/anvil_recipe/weapons/iron
	abstract_type = /datum/anvil_recipe/weapons/iron
	req_bar = /obj/item/ingot/iron
	craftdiff = 1
///////////////////////////////////////////////

// AMUNITION
/datum/anvil_recipe/weapons/iron/arrows
	name = "5x Arrows (+Plank)"
	recipe_name = "five Arrows"
	appro_skill = /datum/skill/craft/engineering // to train engineering
	additional_items = list(/obj/item/natural/wood/plank)
	created_item = /obj/item/ammo_casing/caseless/arrow
	createmultiple = TRUE
	createditem_num = 4
	i_type = "Ammo"
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/bolts
	name = "5x Crossbow Bolts (+Plank)"
	recipe_name = "five Crossbow Bolts"
	appro_skill = /datum/skill/craft/engineering // to train engineering
	additional_items = list(/obj/item/natural/wood/plank)
	created_item = /obj/item/ammo_casing/caseless/bolt
	createmultiple = TRUE
	createditem_num = 4
	i_type = "Ammo"
	craftdiff = 1

// POLEARMS

/datum/anvil_recipe/weapons/iron/bardiche
	name = "Bardiche (+Bar, +Small Log)"
	recipe_name = "a Bardiche"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/warcutter
	name = "Footman War Axe (+Bar, +Small Log)"
	recipe_name = "a war greataxe"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche/warcutter
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/lucerne
	name = "Lucerne (+Bar, +Small Log)"
	recipe_name = "a Lucerne"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/eaglebeak/lucerne
	craftdiff = 2

// DAGGERS

/datum/anvil_recipe/weapons/iron/dagger
	name = "Dagger x2"
	recipe_name = "a couple Daggers"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/knife/dagger
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 0 // To train with

// FLAILS AND WHIPS

/datum/anvil_recipe/weapons/iron/flail_iron
	name = "Militia flail (+Chain, +Stick)"
	recipe_name = "a militia flail"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/flail/militia

// SWORDS

/datum/anvil_recipe/weapons/iron/sword
	name = "Sword"
	recipe_name = "a Sword"
	created_item = /obj/item/weapon/sword/iron

/datum/anvil_recipe/weapons/iron/estoc
	name = "Estoc"
	recipe_name = "a Duelist Sword"
	created_item = /obj/item/weapon/sword/rapier/ironestoc

/datum/anvil_recipe/weapons/iron/messer
	name = "Messer"
	recipe_name = "a Messer"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/weapon/sword/scimitar/messer

/datum/anvil_recipe/weapons/iron/shortsword
	name = "Short Sword"
	recipe_name = "a Short Sword"
	created_item = /obj/item/weapon/sword/short
	craftdiff = 0

// GREAT SWORDS

/datum/anvil_recipe/weapons/iron/zweihander
	name = "Zweihander (+Bar x2)"
	recipe_name = "a Zweihander"
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/weapon/sword/long/greatsword/zwei
	craftdiff = 3

// SPEARS
/datum/anvil_recipe/weapons/iron/spear
	name = "2x Spears (+Small Log)"
	recipe_name = "a couple Spears"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear
	createmultiple = TRUE
	createditem_num = 1

// SHIELDS

/datum/anvil_recipe/weapons/iron/towershield
	name = "Tower Shield (+Small Log)"
	recipe_name = "a Tower Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/shield/tower
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/buckler
	name = "Iron Buckler"
	recipe_name = "a small Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	created_item = /obj/item/weapon/shield/tower/buckleriron
	craftdiff = 1

// AXES AND MACES

/datum/anvil_recipe/weapons/iron/warclub
	name = "Warclub (+Small Log)"
	recipe_name = "a Warclub"
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/mace/goden
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/mace
	name = "Iron Mace (+Stick)"
	recipe_name = "a Mace"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace

/datum/anvil_recipe/weapons/iron/warhammer
	name = "Iron Warhammer (+1 Stick)"
	recipe_name = "a Warhammer"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace/warhammer

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- STEEL ------------  Fancy gear for Knights
/datum/anvil_recipe/weapons/steel
	abstract_type = /datum/anvil_recipe/weapons/steel
	req_bar = /obj/item/ingot/steel
	craftdiff = 1
///////////////////////////////////////////////

// AXES AND MACES
/datum/anvil_recipe/weapons/steel/sledgehammer
	name = "Steel Sledgehammer (+Small Log)"
	recipe_name = "a big Sledgehammer"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = 	/obj/item/weapon/hammer/sledgehammer/war
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/battleaxe
	name = "Battle Axe (+Bar x2)"
	recipe_name = "a Battle Axe"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/axe/battle
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/grandmace
	name = "Grand Mace (+Small Log)"
	recipe_name = "a Grand Mace"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/mace/goden/steel
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/mace_steel
	name = "Steel Mace (+Bar)"
	recipe_name = "a Mace"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/mace/steel
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/swarhammer
	name = "Steel Warhammer (+Bar)"
	recipe_name = "a Warhammer"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/mace/warhammer/steel
	craftdiff = 2

// POLEARMS
/datum/anvil_recipe/weapons/steel/eaglebeak
	name = "Eagle's Beak (+Bar, +Small Log)"
	recipe_name = "an Eagle's Beak"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/eaglebeak
	craftdiff = 3


/datum/anvil_recipe/weapons/steel/halberd
	name = "Halberd (+Bar, +Small Log)"
	recipe_name = "a Halberd"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd
	craftdiff = 4


// SWORDS
/datum/anvil_recipe/weapons/steel/rapier
	name = "Rapier"
	recipe_name = "a Rapier"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/rapier
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/saber
	name = "Sabre"
	recipe_name = "a Sabre"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/sabre
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/sword
	name = "Arming Sword"
	recipe_name = "a Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/arming
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/scimitar
	name = "Scimitar"
	recipe_name = "a Zybean Sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/scimitar
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/falchion
	name = "Falchion"
	recipe_name = "a heavy one handed sword"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/scimitar/falchion
	craftdiff = 2

/datum/anvil_recipe/weapons/bronze/gladius
	name = "Gladius"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/weapon/sword/gladius
	craftdiff = 2

/datum/anvil_recipe/weapons/steel/cutlass
	name = "Cutlass"
	recipe_name = "a Cutlass"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/sword/sabre/cutlass
	craftdiff = 2

// GREATSWORD
/datum/anvil_recipe/weapons/steel/greatsword
	name = "Greatsword (+Bar x2)"
	recipe_name = "a Greatsword"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long/greatsword
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/longsword
	name = "Longsword (+Bar)"
	recipe_name = "a Longsword"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long
	craftdiff = 3

// SPEARS
/datum/anvil_recipe/weapons/steel/billhook
	name = "Billhook (+Small Log)"
	recipe_name = "a Billhook"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/billhook
	craftdiff = 3

// SHIELDS
/datum/anvil_recipe/weapons/steel/kiteshield
	name = "Kite Shield (+Bar, +Hide)"
	recipe_name = "a Kite Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/natural/hide)
	created_item = /obj/item/weapon/shield/tower/metal
	craftdiff = 3

// DAGGERS

/datum/anvil_recipe/weapons/steel/dagger_steel
	name = "2x Steel Daggers"
	recipe_name = "a couple Daggers"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/weapon/knife/dagger/steel
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 2

// DECORATED
/datum/anvil_recipe/weapons/steel/decorated/saber
	name = "Decorated Sabre (+Gold Bar)"
	recipe_name = "a Decorated Sabre"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/sabre/dec
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/decorated/sword
	name = "Decorated Sword (+Gold Bar)"
	recipe_name = "a Decorated Sword"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/decorated
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/decorated/rapier
	name = "Decorated Rapier (+Gold Bar)"
	recipe_name = "a Decorated Rapier"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/rapier/dec
	craftdiff = 3

// WHIPS & FLAILS
/datum/anvil_recipe/weapons/steel/flail_steel
	name = "Steel Flail (+Chain, +Stick)"
	recipe_name = "a Flail"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/flail/sflail
	craftdiff = 2

///////////////////////////////////////////////////////////////////////////////////////////////////////
// MISC/////////////
/datum/anvil_recipe/weapons/steel/paxe // this one should probably be engineering tool for artificer
	name = "Pick-Axe (+Bar, +Stick)"
	recipe_name = "a Pick that is also an Axe"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick/paxe
	craftdiff = 3

/datum/anvil_recipe/weapons/bronze/spear // smiths dont use bronze shoulve be moved to artificer
	name = "Bronze Spear (+Bar, +Small Log)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/bronze
	craftdiff = 0
///////////////////////////////////////////////////////////////////////////////////////////////////////

// --------- SILVER ------------  Harder to craft, does less damage and has less durability than steel, but banes undead.

/datum/anvil_recipe/weapons/silver
	abstract_type = /datum/anvil_recipe/weapons/silver
	req_bar = /obj/item/ingot/silver
	craftdiff = 4
///////////////////////////////////////////////

// DAGGERS
/datum/anvil_recipe/weapons/silver/dagger
	name = "Silver Dagger"
	recipe_name = "a Silver Dagger"
	created_item = /obj/item/weapon/knife/dagger/silver

// SWORDS
/datum/anvil_recipe/weapons/silver/sword
	name = "Silver Sword"
	recipe_name = "a Silver Sword"
	created_item = /obj/item/weapon/sword/silver

/datum/anvil_recipe/weapons/silver/rapier
	name = "Silver Rapier"
	recipe_name = "a Silver Rapier"
	created_item = /obj/item/weapon/sword/rapier/silver

// GREAT SWORDS
/datum/anvil_recipe/weapons/silver/forgotten
	name = "Forgotten Blade (+Steel Bar)"
	recipe_name = "a Forgotten Blade"
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long/forgotten
