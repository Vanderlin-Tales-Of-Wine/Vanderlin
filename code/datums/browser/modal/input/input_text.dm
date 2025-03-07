/proc/browser_input_text(mob/user, message = "", title = "VANDERLIN", default, max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = TRUE, timeout = 0)
	if(!user)
		user = usr
	if(!istype(user))
		if(isclient(user))
			var/client/client = user
			user = client.mob
		else
			return null

	if(isnull(user.client))
		return null

	var/datum/browser/modal/input_text/input = new(user, message, title, default, max_length, multiline, encode, timeout)
	input.open()
	input.wait()
	if(input)
		. = input.choice
		qdel(input)

/datum/browser/modal/input_text
	/// If TRUE, this input will encode its choice upon being set.
	var/encode = TRUE
	/// If set, the output cannot be longer than this.
	var/max_length = INFINITY

/datum/browser/modal/input_text/New(mob/user, message, title, default, max_length, multiline, encode, timeout)
	if(!user)
		closed = TRUE
		return

	src.encode = encode

	// JavaScript to make the textarea submit on enter instead of making a newline
	set_head_content({"
	<script type="text/javascript">
		addEventListener("DOMContentLoaded", function(){
			const textEntry = document.querySelector("#entry");
			const submitButton = document.querySelector("#submitButton");
			const cancelButton = document.querySelector("#cancelButton");

			[NULLABLE(!multiline) && {"
				textEntry.addEventListener('keydown', function(event){
					switch(event.which){
						case 13: [/* ENTER */]
							event.preventDefault();
							if(!event.shiftKey){
								submitButton.click();
							}
							break;

						case 27: [/* ESCAPE */]
							cancelButton.click();
							break;
					}
				})
			"}]

			[NULLABLE(isnum(max_length)) && {"
				const charCount = document.querySelector("#charCount");
				const maxChars = document.querySelector("#maxChars");
				maxChars.innerHTML = [max_length]

				textEntry.addEventListener('input', function(event){
					charCount.innerHTML = event.target.value.length;
				})
			"}]
		});
	</script>
	"})

	var/window_height = multiline ? 300 : 125

	..(user, ckey("[user]-[message]-[title]-[world.time]-[rand(1,10000)]"), title, 350, window_height, src, TRUE, timeout)

	set_content({"
	<form style="display: flex; flex-direction: column; height: 100%;" action="byond://">
		<input type="hidden" name="src" value="[REF(src)]">

		<center><b>[message]</b></center>

		<textarea
			id="entry"
			style="
				overflow-y: auto;
				margin: auto 0;
				[multiline ? "flex-grow: [TRUE]" : "height: 1rem"];"
			name="choice"
			[NULLABLE(isnum(max_length)) && "maxlength=[max_length]"]
			placeholder="WE AWAIT YOUR COMMAND..."
			autofocus>[html_encode(default)]</textarea>

		<div style="display: flex; justify-content: space-between; align-items: center; text-align: center;">
			<button id="submitButton" type="submit" name="submit" value="[TRUE]">[CHOICE_CONFIRM]</button>
			[NULLABLE(isnum(max_length)) && {"
			<div>
				<span id="charCount">[length(default)]</span>
				/
				<span id="maxChars">[max_length]</span>
			</div>
			"}]
			<button id="cancelButton" type="submit" name="cancel" value="[TRUE]" formnovalidate>[CHOICE_CANCEL]</button>
		</div>
	</form>
	"})

/datum/browser/modal/input_text/Topic(href, list/href_list)
	. = ..()
	if(href_list["submit"])
		set_choice(href_list["choice"])

	closed = TRUE
	close()

/datum/browser/modal/input_text/set_choice(choice)
	var/processed_choice = encode ? html_encode(choice) : choice
	src.choice = trim(processed_choice, PREVENT_CHARACTER_TRIM_LOSS(max_length))
