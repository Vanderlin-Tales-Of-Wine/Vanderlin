/datum/anvil_recipe/valuables
	appro_skill = /datum/skill/craft/blacksmithing
	abstract_type = /datum/anvil_recipe/valuables
	i_type = "Valuables"
//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate
//////////////////////////////////////////////////////////////////////////////////////////////
// --------- IRON -----------

/datum/anvil_recipe/valuables/iron
	req_bar = /obj/item/ingot/iron
	abstract_type = /datum/anvil_recipe/valuables/iron
	craftdiff = 1
///////////////////////////////////////////////
/datum/anvil_recipe/valuables/iron/statue
	name = "Iron Statue"
	recipe_name = "an Iron Statue"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/statue/iron

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- STEEL -----------

/datum/anvil_recipe/valuables/steel
	abstract_type = /datum/anvil_recipe/valuables/steel
	req_bar = /obj/item/ingot/steel
	craftdiff = 2
///////////////////////////////////////////////

/datum/anvil_recipe/valuables/steel/statue
	name = "Steel Statue"
	recipe_name = "a Steel Statue"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/statue/steel

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- SILVER -----------
/datum/anvil_recipe/valuables/silver
	abstract_type = /datum/anvil_recipe/valuables/silver
	req_bar = /obj/item/ingot/silver
	craftdiff = 3
///////////////////////////////////////////////

/datum/anvil_recipe/valuables/silver/statue
	name = "Silver Statue"
	recipe_name = "a Silver Statue"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/statue/silver
	craftdiff = 3

/datum/anvil_recipe/valuables/silver/rings
	name = "3x Silver Rings"
	recipe_name = "three Silver Rings"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/clothing/ring/silver
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 3

/datum/anvil_recipe/valuables/silver/dorpel
	name = "Silver Dorpel Ring"
	recipe_name = "a Silver Dorpel Ring"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/gem/diamond)
	created_item = /obj/item/clothing/ring/silver/dorpel
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/blortz
	name = "Silver Blortz Ring"
	recipe_name = "a Silver Blortz Ring"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/gem/blue)
	created_item = /obj/item/clothing/ring/silver/blortz
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/saffira
	name = "Silver Saffira Ring"
	recipe_name = "a Silver Saffira Ring"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/gem/violet)
	created_item = /obj/item/clothing/ring/silver/saffira
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/gemerald
	name = "Silver Gemerald Ring"
	recipe_name = "a Silver Gemerald Ring"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/gem/green)
	created_item = /obj/item/clothing/ring/silver/gemerald
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/toper
	name = "Silver Toper Ring"
	recipe_name = "a Silver Toper Ring"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/gem/yellow)
	created_item = /obj/item/clothing/ring/silver/toper
	craftdiff = 4

/datum/anvil_recipe/valuables/silver/rontz
	name = "Silver Rontz Ring"
	recipe_name = "a Silver Rontz Ring"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/gem)
	created_item = /obj/item/clothing/ring/silver/rontz
	craftdiff = 4

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- GOLD -----------

/datum/anvil_recipe/valuables/gold
	req_bar = /obj/item/ingot/gold
	abstract_type = /datum/anvil_recipe/valuables/gold
	craftdiff = 4
///////////////////////////////////////////////
/datum/anvil_recipe/valuables/gold/statue
	name = "Golden Statue"
	recipe_name = "a Golden Statue"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/statue/gold
	craftdiff = 4

/datum/anvil_recipe/valuables/gold/rings
	name = "Golden Circlet"
	recipe_name = "a golden circlet"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/head/crown/circlet
	craftdiff = 4

/datum/anvil_recipe/valuables/gold/rings
	name = "3x Gold Rings"
	recipe_name = "three Rings" // For the Elven kings under the sky...
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/head
	createmultiple = TRUE
	createditem_num = 2
	craftdiff = 4

/datum/anvil_recipe/valuables/gold/dorpel
	name = "Golden Dorpel Ring"
	recipe_name = "a Golden Dorpel Ring"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/gem/diamond)
	created_item = /obj/item/clothing/ring/gold/dorpel
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/blortz
	name = "Golden Blortz Ring"
	recipe_name = "a Golden Blortz Ring"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/gem/blue)
	created_item = /obj/item/clothing/ring/gold/blortz
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/saffira
	name = "Golden Saffira Ring"
	recipe_name = "a Golden Saffira Ring"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/gem/violet)
	created_item = /obj/item/clothing/ring/gold/saffira
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/gemerald
	name = "Golden Gemerald Ring"
	recipe_name = "a Golden Gemerald Ring"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/gem/green)
	created_item = /obj/item/clothing/ring/gold/gemerald
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/toper
	name = "Golden Toper Ring"
	recipe_name = "a Golden Toper Ring"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/gem/yellow)
	created_item = /obj/item/clothing/ring/gold/toper
	craftdiff = 5

/datum/anvil_recipe/valuables/gold/rontz
	name = "Golden Rontz Ring"
	recipe_name = "a Golden Rontz Ring"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/gem)
	created_item = /obj/item/clothing/ring/gold/rontz
	craftdiff = 5
