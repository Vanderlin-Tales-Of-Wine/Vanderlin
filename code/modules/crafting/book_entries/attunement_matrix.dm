/datum/book_entry/attunement
	name = "Gate Improvements"

/datum/book_entry/attunement/inner_book_html(mob/user)
	var/html = {"
		<div>
		<h2>What are gates?</h2>
		Gates are pathways in your body in which mana travels, every spell has gates where the mana travels.<br>
		The stronger your gate is the more mana that can flow through it and the less is lost travelling.<br>
		</div>
		<br>

		<div>
		<h2> How to improve your gates </h2>
		The simpliest way to improve your gate is through the Attunement Ritual. <br>
		It uses items that have internal energy inside of them and breaks it down infusing it into your body. <br>
		Its not without its drawbacks, since it has strong internal energy it degrades its opposing gates. <br>
		<br>
		The other way is to socket a gem into your griomire which will cause your gateway to strength while studying. <br>
		This doesn't have the downside of breaking down your opposing gates but is slower. <br>
		<br>
		The final way is the god you worship. All the gods bestow their blessing into you improving their respective gates.
		</div>
		<br>

		<div>
		<h2> Items with internal energy </h2>
	"}

	for(var/obj/item/natural/item as anything in subtypesof(/obj/item/natural))
		if(!initial(item.attunement_values))
			continue
		var/obj/item/natural/new_item = new item
		html += "<h3>[new_item.name]</h3><br>"
		html += "[icon2html(new_item, user)]<br>"
		for(var/datum/attunement/attunement as anything in new_item.attunement_values)
			if(new_item.attunement_values[attunement] > 0)
				html += "[initial(attunement.name)] - Increase<br>"
			else
				html += "[initial(attunement.name)] - Decrease<br>"

	for(var/obj/item/natural/item as anything in subtypesof(/obj/item/alch))
		if(!initial(item.attunement_values))
			continue
		var/obj/item/natural/new_item = new item
		html += "<h3>[new_item.name]</h3><br>"
		html += "[icon2html(new_item, user)]<br>"
		for(var/datum/attunement/attunement as anything in new_item.attunement_values)
			if(new_item.attunement_values[attunement] > 0)
				html += "[initial(attunement.name)] - Increase<br>"
			else
				html += "[initial(attunement.name)] - Decrease<br>"

	return html
