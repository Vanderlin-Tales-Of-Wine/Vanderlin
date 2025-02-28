
/datum/crafting_recipe
	var/name = "" //in-game display name
	var/reqs[] = list() //type paths of items consumed associated with how many are needed
	var/blacklist[] = list() //type paths of items explicitly not allowed as an ingredient
	var/result //type path of item resulting from this craft
	var/tools[] = list() //type paths of items needed but not consumed
	var/time = 0 //time in deciseconds
	var/parts[] = list() //type paths of items that will be placed in the result
	var/chem_catalysts[] = list() //like tools but for reagents
	var/category = CAT_NONE //where it shows up in the crafting UI
	var/subcategory = CAT_NONE
	var/always_availible = TRUE //Set to FALSE if it needs to be learned first.
	var/ontile = FALSE		//crafted on our tile instead of in front of us
	var/req_table = FALSE
	var/skillcraft = /datum/skill/craft/crafting
	var/verbage = "craft"
	var/verbage_tp = "crafts" // Third person of verbage var
	var/craftsound = 'sound/foley/bandage.ogg'
	var/subtype_reqs = FALSE	// If FALSE this does not allow Subtypes of the ingridients. Set it to TRUE to allow crafting with say, fur/gote and fur/volf interchangeably. Has drawbacks & advantages.
	var/structurecraft = null
	var/buildsame = FALSE //allows palisades to be built on top of each other just not the same dir
	var/wallcraft = FALSE
	var/craftdiff = 1
	var/sellprice = 0
	//crafting diff, every diff removes 25% chance to craft
