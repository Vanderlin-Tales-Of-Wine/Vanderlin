/obj/item/reagent_containers/food/snacks/meat
	var/subjectname = ""
	var/subjectjob = null

/obj/item/reagent_containers/food/snacks/meat/slab
	name = "meat"
	desc = ""
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = 3) //Meat has fats that a food processor can process into cooking oil
	slices_num = 3
	filling_color = "#FF0000"
	tastes = list("meat" = 1)
	foodtype = MEAT | RAW

