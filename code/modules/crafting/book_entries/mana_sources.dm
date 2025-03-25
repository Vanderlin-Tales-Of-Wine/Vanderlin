/datum/book_entry/mana_sources
	name = "Mana Sources"

/datum/book_entry/mana_sources/inner_book_html(mob/user)
	return {"
		<div>
		<h2>What are ways you can get mana passively?</h2>
		For a regular person they do not have any way to passively absorb mana.<br>
		For a mage they can passively absorb the mana from leylines by being near them. <br>
		For liches they need to absorb souls to regain mana. <br>
		Foci restore mana by being near either Pylons or Leylines.
		</div>
		<br>

		<div>
		<h2> What are mana pylons </h2>
		[icon2html(new /obj/structure/mana_pylon, user)]<br>
		Mana Pylons are ways to move mana from leylines to a central point, they can store more mana then a leyline can so its good to set them up. <br>
		They will automatically push mana out into arcyne structures like the Mana Fountain. <br>
		If you have a foci on you they will absorb mana from the Leyline on your behalf, so making a loop around your domain is ideal.
		</div>
		<br>

		<div>
		<h2> Mana Fountain </h2>
		[icon2html(new /obj/structure/well/fountain/mana, user)]<br>
		The Mana Fountain converts mana in the air into Liquid Mana. <br>
		This is most useful for performing a Mana Baptism on someone so they can absorb mana from leyline passively. <br>
		They also act as a source of Weak Mana Potions.
		</div>
	"}
