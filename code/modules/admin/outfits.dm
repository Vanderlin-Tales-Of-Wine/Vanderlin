GLOBAL_LIST_EMPTY(custom_outfits) //Admin created outfits

/client/proc/outfit_manager()
	set category = "Debug"
	set name = "Outfit Manager"

	if(!check_rights(R_DEBUG))
		return
	holder.outfit_manager(usr)

/datum/admins/proc/outfit_manager(mob/admin)
	var/list/dat = list("<ul>")
	for(var/datum/outfit/O in GLOB.custom_outfits)
		var/vv = FALSE
		var/datum/outfit/varedit/VO = O
		if(istype(VO))
			vv = length(VO.vv_values)
		dat += "<li>[O.name][vv ? "(VV)" : ""]</li> <a href='?_src_=holder;[HrefToken()];save_outfit=1;chosen_outfit=[REF(O)]'>Save</a> <a href='?_src_=holder;[HrefToken()];delete_outfit=1;chosen_outfit=[REF(O)]'>Delete</a>"
	dat += "</ul>"
	dat += "<a href='?_src_=holder;[HrefToken()];create_outfit_menu=1'>Create</a><br>"
	dat += "<a href='?_src_=holder;[HrefToken()];load_outfit=1'>Load from file</a>"
	var/datum/browser/popup = new(admin, "outfitmanager", "Outfit Manager", 670, 650)
	popup.set_content(dat.Join())
	popup.open()

/datum/admins/proc/save_outfit(mob/admin,datum/outfit/O)
	O.save_to_file(admin)
	outfit_manager(admin)

/datum/admins/proc/delete_outfit(mob/admin,datum/outfit/O)
	GLOB.custom_outfits -= O
	qdel(O)
	to_chat(admin,"<span class='notice'>Outfit deleted.</span>")
	outfit_manager(admin)

/datum/admins/proc/load_outfit(mob/admin)
	var/outfit_file = input("Pick outfit json file:", "File") as null|file
	if(!outfit_file)
		return
	var/filedata = file2text(outfit_file)
	var/json = json_decode(filedata)
	if(!json)
		to_chat(admin,"<span class='warning'>JSON decode error.</span>")
		return
	var/otype = text2path(json["outfit_type"])
	if(!ispath(otype,/datum/outfit))
		to_chat(admin,"<span class='warning'>Malformed/Outdated file.</span>")
		return
	var/datum/outfit/O = new otype
	if(!O.load_from(json))
		to_chat(admin,"<span class='warning'>Malformed/Outdated file.</span>")
		return
	GLOB.custom_outfits += O
	message_admins("[key_name(usr)] loaded an outfit! Name: \"[O.name]\"")
	outfit_manager(admin)

/datum/admins/proc/create_outfit(mob/admin)
	var/list/headwear = typesof(/obj/item/clothing/head)
	var/list/masks = typesof(/obj/item/clothing/face)
	var/list/necks = typesof(/obj/item/clothing/neck)
	var/list/cloaks = typesof(/obj/item/clothing/cloak)
	var/list/backs = typesof(/obj/item/storage/backpack)
	var/list/rings = typesof(/obj/item/clothing/ring)
	var/list/wrists = typesof(/obj/item/clothing/wrists)
	var/list/gloves = typesof(/obj/item/clothing/gloves)
	var/list/shirts = typesof(/obj/item/clothing/shirt)
	var/list/armors = typesof(/obj/item/clothing/armor)
	var/list/pants = typesof(/obj/item/clothing/pants)
	var/list/belts = typesof(/obj/item/storage/belt)
	var/list/shoes = typesof(/obj/item/clothing/shoes)

	var/heads_select = "<select name=\"outfit_head\"><option value=\"\">None</option>"
	for(var/path in headwear)
		heads_select += "<option value=\"[path]\">[path]</option>"
	heads_select += "</select>"

	var/masks_select = "<select name=\"outfit_mask\"><option value=\"\">None</option>"
	for(var/path in masks)
		masks_select += "<option value=\"[path]\">[path]</option>"
	masks_select += "</select>"

	var/necks_select = "<select name=\"outfit_neck\"><option value=\"\">None</option>"
	for(var/path in necks)
		necks_select += "<option value=\"[path]\">[path]</option>"
	necks_select += "</select>"

	var/cloaks_select = "<select name=\"outfit_cloak\"><option value=\"\">None</option>"
	for(var/path in cloaks)
		cloaks_select += "<option value=\"[path]\">[path]</option>"
	cloaks_select += "</select>"

	var/backsr_select = "<select name=\"outfit_backr\"><option value=\"\">None</option>"
	for(var/path in backs)
		backsr_select += "<option value=\"[path]\">[path]</option>"
	backsr_select += "</select>"

	var/backsl_select = "<select name=\"outfit_backl\"><option value=\"\">None</option>"
	for(var/path in backs)
		backsl_select += "<option value=\"[path]\">[path]</option>"
	backsl_select += "</select>"

	var/rings_select = "<select name=\"outfit_ring\"><option value=\"\">None</option>"
	for(var/path in rings)
		rings_select += "<option value=\"[path]\">[path]</option>"
	rings_select += "</select>"

	var/wrists_select = "<select name=\"outfit_wrists\"><option value=\"\">None</option>"
	for(var/path in wrists)
		wrists_select += "<option value=\"[path]\">[path]</option>"
	wrists_select += "</select>"

	var/gloves_select = "<select name=\"outfit_gloves\"><option value=\"\">None</option>"
	for(var/path in gloves)
		gloves_select += "<option value=\"[path]\">[path]</option>"
	gloves_select += "</select>"

	var/shirts_select = "<select name=\"outfit_shirt\"><option value=\"\">None</option>"
	for(var/path in shirts)
		shirts_select += "<option value=\"[path]\">[path]</option>"
	shirts_select += "</select>"

	var/armors_select = "<select name=\"outfit_armor\"><option value=\"\">None</option>"
	for(var/path in armors)
		armors_select += "<option value=\"[path]\">[path]</option>"
	armors_select += "</select>"

	var/pants_select = "<select name=\"outfit_pants\"><option value=\"\">None</option>"
	for(var/path in pants)
		pants_select += "<option value=\"[path]\">[path]</option>"
	pants_select += "</select>"

	var/belts_select = "<select name=\"outfit_belt\"><option value=\"\">None</option>"
	for(var/path in belts)
		belts_select += "<option value=\"[path]\">[path]</option>"
	belts_select += "</select>"

	var/shoes_select = "<select name=\"outfit_shoes\"><option value=\"\">None</option>"
	for(var/path in shoes)
		shoes_select += "<option value=\"[path]\">[path]</option>"
	shoes_select += "</select>"

	var/dat = {"
	<html><head><title>Create Outfit</title></head><body>
	<form name="outfit" action="byond://?src=[REF(src)];[HrefToken()]" method="get">
	<input type="hidden" name="src" value="[REF(src)]">
	[HrefTokenFormField()]
	<input type="hidden" name="create_outfit_finalize" value="1">
	<table>
		<tr>
			<th>Name:</th>
			<td>
				<input type="text" name="outfit_name" value="Custom Outfit">
			</td>
		</tr>
		<tr>
			<th>Head:</th>
			<td>
				[heads_select]
			</td>
		</tr>
		<tr>
			<th>Mask:</th>
			<td>
				[masks_select]
			</td>
		</tr>
		<tr>
			<th>Neck:</th>
			<td>
				[necks_select]
			</td>
		</tr>
		<tr>
			<th>Cloak:</th>
			<td>
				[cloaks_select]
			</td>
		</tr>
		<tr>
			<th>BackR:</th>
			<td>
				[backsr_select]
			</td>
		</tr>
		<tr>
			<th>BackL:</th>
			<td>
				[backsl_select]
			</td>
		</tr>
		<tr>
			<th>Ring:</th>
			<td>
				[rings_select]
			</td>
		</tr>
		<tr>
			<th>Wrists:</th>
			<td>
				[wrists_select]
			</td>
		</tr>
		<tr>
			<th>Gloves:</th>
			<td>
				[gloves_select]
			</td>
		</tr>
		<tr>
			<th>Shirt:</th>
			<td>
				[shirts_select]
			</td>
		</tr>
		<tr>
			<th>Armor:</th>
			<td>
				[armors_select]
			</td>
		</tr>
		<tr>
			<th>Pants:</th>
			<td>
				[pants_select]
			</td>
		</tr>
		<tr>
			<th>Belt:</th>
			<td>
				[belts_select]
			</td>
		</tr>
		<tr>
			<th>Shoes:</th>
			<td>
				[shoes_select]
			</td>
		</tr>
	</table>
	<br>
	<input type="submit" value="Save">
	</form></body></html>
	"}
	admin << browse(dat, "window=dressup;size=550x600")


/datum/admins/proc/create_outfit_finalize(mob/admin, list/href_list)
	var/datum/outfit/O = new

	O.name = href_list["outfit_name"]
	O.head = text2path(href_list["outfit_head"])
	O.mask = text2path(href_list["outfit_mask"])
	O.neck = text2path(href_list["outfit_neck"])
	O.cloak = text2path(href_list["outfit_cloak"])
	O.backl = text2path(href_list["outfit_backl"])
	O.backr = text2path(href_list["outfit_backr"])
	O.ring = text2path(href_list["outfit_ring"])
	O.wrists = text2path(href_list["outfit_wrists"])
	O.gloves = text2path(href_list["outfit_gloves"])
	O.shirt = text2path(href_list["outfit_shirt"])
	O.armor = text2path(href_list["outfit_armor"])
	O.pants = text2path(href_list["outfit_pants"])
	O.belt = text2path(href_list["outfit_belt"])
	O.shoes = text2path(href_list["outfit_shoes"])

	GLOB.custom_outfits.Add(O)
	message_admins("[key_name(usr)] created \"[O.name]\" outfit!")
