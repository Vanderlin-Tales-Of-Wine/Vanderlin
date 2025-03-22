/datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/armorsmithing
	i_type = "Armor"
	craftdiff = 1
	abstract_type = /datum/anvil_recipe/armor

// --------- COPPER -----------

/datum/anvil_recipe/armor/copper
	abstract_type = /datum/anvil_recipe/armor/copper

/datum/anvil_recipe/armor/copper/mask
	name = "Copper mask"
	recipe_name = "a mask of copper"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/face/facemask/copper
	craftdiff = 0

/datum/anvil_recipe/armor/copper/bracers
	name = "Copper bracers"
	recipe_name = "a pair of Copper bracers"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/wrists/bracers/copper
	craftdiff = 0

/datum/anvil_recipe/armor/copper/cap
	name = "Lamellar cap"
	recipe_name = "a copper cap"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/head/helmet/coppercap
	craftdiff = 0

/datum/anvil_recipe/armor/copper/gorget
	name = "Copper neck protector"
	recipe_name = "a neck protector"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/neck/gorget/copper
	craftdiff = 0

/datum/anvil_recipe/armor/copper/chest
	name = "Copper heart protector"
	recipe_name = "a very simple armor piece for the chest"
	req_bar = /obj/item/ingot/copper
	created_item = /obj/item/clothing/armor/cuirass/copperchest
	craftdiff = 0

//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate

// --------- IRON -----------
/datum/anvil_recipe/armor/iron
	req_bar = /obj/item/ingot/iron
	craftdiff = 0
	abstract_type = /datum/anvil_recipe/armor/iron

/datum/anvil_recipe/armor/iron/chainleg
	name = "Iron Chain Chausses"
	recipe_name = "a pair of Chain Chausses"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/pants/chainlegs/iron
	craftdiff = 0

/datum/anvil_recipe/armor/iron/chaincoif
	name = "Iron Chain Coif"
	recipe_name = "a Chain Coif"
	created_item = /obj/item/clothing/neck/chaincoif/iron

/datum/anvil_recipe/armor/iron/chainglove
	name = "2x Iron Chain Gauntlets"
	recipe_name = "two pairs of Chain Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/chain/iron
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/chainmail
	name = "Iron Maille"
	recipe_name = "maille shirt"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/armor/chainmail/iron


/datum/anvil_recipe/armor/iron/plate
	name = "Iron Plate Armor (+Bar x2)"
	recipe_name = "heavy armor made of iron plates"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/plate/iron
	craftdiff = 1

/datum/anvil_recipe/armor/iron/platehelmet
	name = "Iron Plate Helmet (+Bar)"
	recipe_name = "a heavy iron helmet"
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/helmet/heavy/ironplate
	craftdiff = 1

/datum/anvil_recipe/armor/iron/pothelmet
	name = "Pot Helmet"
	recipe_name = "a sturdy iron helmet"
	created_item = /obj/item/clothing/head/helmet/ironpot
	craftdiff = 1

/datum/anvil_recipe/armor/iron/platemask
	name = "2x Iron Face Masks"
	recipe_name = "a Face Mask"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/face/facemask
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/gorget
	name = "Iron Gorget"
	recipe_name = "a gorget"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/gorget
	craftdiff = 0

/datum/anvil_recipe/armor/iron/platebootlight
	name = "Light Plate Boots"
	recipe_name = "a pair of Light Plate Boots"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/shoes/boots/armor/light

/datum/anvil_recipe/armor/iron/nasal_helmet
	name = "Nasal helmet"
	recipe_name = "a Nasal helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/helmet/nasal
	craftdiff = 1

/datum/anvil_recipe/armor/iron/skullcap
	name = "Skullcap"
	recipe_name = "a skullcap"
	created_item = /obj/item/clothing/head/helmet/skullcap

/datum/anvil_recipe/armor/iron/splint
	name = "Splint Armor (+Hide)"
	recipe_name = "durable light armor"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/hide)
	created_item = /obj/item/clothing/armor/leather/splint
	craftdiff = 1

// --------- STEEL -----------
/datum/anvil_recipe/armor/steel/bevor
	name = "Bevor"
	recipe_name = "a Bevor"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/bevor
	craftdiff = 2

/datum/anvil_recipe/armor/steel/brigadine
	name = "Brigandine (+Bar x2, +Cloth)"
	recipe_name = "a Brigandine"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/armor/brigandine
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetbuc
	name = "Great Helm"
	recipe_name = "a Bucket Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = (/obj/item/clothing/head/helmet/heavy/bucket)
	craftdiff = 2

/datum/anvil_recipe/armor/steel/chainleg
	name = "Chain Chausses"
	recipe_name = "a pair of Chain Chausses"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/pants/chainlegs
	craftdiff = 2

/datum/anvil_recipe/armor/steel/chaincoif
	name = "Chain Coif"
	recipe_name = "a Chain Coif"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/neck/chaincoif
	craftdiff = 2

/datum/anvil_recipe/armor/steel/chainglove
	name = "2x Chain Gauntlets"
	recipe_name = "two pairs of Chain Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/chain
	createmultiple = TRUE
	createditem_num = 1
	craftdiff = 2

/datum/anvil_recipe/armor/steel/cuirass
	name = "Steel Cuirass"
	recipe_name = "a Cuirass"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/armor/cuirass
	craftdiff = 2

/datum/anvil_recipe/armor/steel/platemask
	name = "Steel Mask"
	recipe_name = "a Face Mask"
	req_bar = /obj/item/ingot/steel
	created_item = (/obj/item/clothing/face/facemask/steel)
	craftdiff = 2

/datum/anvil_recipe/armor/steel/halfplate
	name = "Steel Half-plate (+Bar x2)"
	recipe_name = "a Half-Plate Armor"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/plate
	craftdiff = 3

/datum/anvil_recipe/armor/steel/haubergeon
	name = "Haubergeon"
	recipe_name = "a Haubergeon"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/armor/chainmail
	craftdiff = 2

/datum/anvil_recipe/armor/steel/hauberk
	name = "Hauberk (+Bar)"
	recipe_name = "a Hauberk"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/chainmail/hauberk
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetkettle
	name = "Kettle Helmet"
	recipe_name = "a Kettle Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/helmet/kettle
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmetslitkettle
	name = "Slitted Kettle Helmet"
	recipe_name = "a slitted kettle helmets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/helmet/kettle/slit
	craftdiff = 2

/datum/anvil_recipe/armor/steel/froghelmet
	name = "Frog Helmet"
	recipe_name = "a frog helmet"
	req_bar = /obj/item/ingot/steel
	created_item = (/obj/item/clothing/head/helmet/heavy/frog)
	craftdiff = 2

/datum/anvil_recipe/armor/steel/helmetknight
	name = "Knight's helmet (+Bar)"
	recipe_name = "a Knight's Helmet"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = (/obj/item/clothing/head/helmet/visored/knight)
	craftdiff = 3

/datum/anvil_recipe/armor/steel/hounskull
	name = "Hounskull Helmet (+Bar x2)"
	recipe_name = "a Hounskull Helmet"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = (/obj/item/clothing/head/helmet/visored/hounskull)
	craftdiff = 4

/datum/anvil_recipe/armor/steel/platefull
	name = "Plate Armor (+Bar x3)"
	recipe_name = "a Full-Plate Armor"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/plate/full
	craftdiff = 4

/datum/anvil_recipe/armor/steel/platebracer
	name = "Plate Vambraces"
	recipe_name = "Plate Vambraces"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/wrists/bracers
	craftdiff = 3

/datum/anvil_recipe/armor/steel/plateleg
	name = "Plate Chausses"
	recipe_name = "a pair of Plate Chausses"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/pants/platelegs
	craftdiff = 3

/datum/anvil_recipe/armor/steel/plateglove
	name = "Plate Gauntlets"
	recipe_name = "a pair of Plate Gauntlets"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/gloves/plate
	craftdiff = 3

/datum/anvil_recipe/armor/steel/plateboot
	name = "Plated boots"
	recipe_name = "some Plated Boots"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/shoes/boots/armor
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetsall
	name = "Sallet"
	recipe_name = "a Sallet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/helmet/sallet
	craftdiff = 2

/datum/anvil_recipe/armor/steel/bascinet
	name = "Bascinet"
	recipe_name = "a bascinet"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/clothing/head/helmet/bascinet
	craftdiff = 2

/datum/anvil_recipe/armor/steel/scalemail
	name = "Scalemail"
	recipe_name = "a Scalemail"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/medium/scale
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetsallv
	name = "Visored sallet (+Bar)"
	recipe_name = "a Visored Sallet"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel)
	created_item = (/obj/item/clothing/head/helmet/visored/sallet)
	craftdiff = 3

/datum/anvil_recipe/armor/steel/decoratedhelmetknight
	name = "Decorated Knight's Helmet (+Bar, +Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/knight
	craftdiff = 4

/datum/anvil_recipe/armor/steel/decoratedhelmetpig
	name = "Decorated Hounskull Helmet (+Bar x2, +Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel,/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/hounskull
	craftdiff = 4

/datum/anvil_recipe/armor/steel/decoratedhelmetbuc
	name = "Decorated Great Helm (+Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/bucket
	craftdiff = 3

/datum/anvil_recipe/armor/steel/decoratedhelmetbucgold
	name = "Decorated Gold-trimmed Great Helm (+Gold Bar, +Cloth)"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/gold,/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/golden
	craftdiff = 3

/datum/anvil_recipe/armor/steel/decoratedbascinet
	name = "Decorated Bascinet (+Cloth)"
	recipe_name = "a decorated bascinet"
	req_bar = /obj/item/ingot/steel
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/bascinet
	craftdiff = 2

// --------- GOLD -----------
/datum/anvil_recipe/armor/gold/mask
	name = "Gold Mask"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/face/facemask/goldmask
	craftdiff = 1

// --------- BLACKSTEEL -----------
/datum/anvil_recipe/armor/blacksteel/platechest
	name = "Blacksteel Plate Armor (+Bar x3)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/armor/plate/blkknight
	craftdiff = 3

/datum/anvil_recipe/armor/blacksteel/platelegs
	name = "Blacksteel Plate Chausses (+Bar)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/pants/platelegs/blk
	craftdiff = 3

/datum/anvil_recipe/armor/blacksteel/bucket
	name = "Blacksteel Great Helm (+Bar)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/head/helmet/blacksteel/bucket
	craftdiff = 3

/datum/anvil_recipe/armor/blacksteel/plategloves
	name = "Blacksteel Plate Gauntlets"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/gloves/plate/blk
	craftdiff = 3

/datum/anvil_recipe/armor/blacksteel/plateboots
	name = "Blacksteel Plate Boots"
	req_bar = /obj/item/ingot/blacksteel
	created_item = /obj/item/clothing/shoes/boots/armor/blkknight
	craftdiff = 3
