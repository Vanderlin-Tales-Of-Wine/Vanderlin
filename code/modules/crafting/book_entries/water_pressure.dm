/datum/book_entry/water_pressure
	name = "Fluid Dynamics"


/datum/book_entry/water_pressure/inner_book_html(mob/user)
	return {"
		<div>
		<h2>How do pipes work?</h2>
		[icon2html(new /obj/structure/water_pipe, user)]<br>
		Water Pipes connect to eachother and pass fluids through them decreasing their pressure with each pipe it travels. <br>
		If 2 pipes pushing different things collide the strongest one continues going. <br>
		Water pressure is based entirely off the thing its taking liquids from. So for pumps higher RPM means higher pressure. <br>
		Boilers pressure builds over time as steam builds up.
		</div>
		<br>

		<div>
		<h2> Why setup pipes? </h2>
		Pipes are the only way to supply things like Steam Chargers, this means you need pressurized pipes delivering steam to recharge tools or armor. <br>
		You can also setup water vents throughout the network to spray liquids on people. Very useful for dousing Beggars in Oil.
		</div>
		<br>

		<div>
		<h2> Things to watch out for </h2>
		Pumps will drain man made lakes over time so you will need to refill it with water. <br>
		Boilers can very quickly overtake your pipe network so its best to seperate them. <br>
		Its better to keep your steam recharging system compact and close together.
		</div>

	"}
