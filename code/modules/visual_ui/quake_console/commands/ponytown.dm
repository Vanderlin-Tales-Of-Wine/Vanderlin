/datum/console_command/ponytown
	command_key = "ponytown"
	required_args = 0

/datum/console_command/ponytown/can_execute(mob/anchor, list/arg_list, obj/abstract/visual_ui_element/scrollable/console_output/output, fake = FALSE)
	return TRUE

/datum/console_command/ponytown/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("ponytown - Hello everypony")

/datum/console_command/ponytown/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	var/mob/user = usr
	if(!user.client)
		return

	// Create a simple HTML page that redirects to Pony Town
	user << browse({"
		<!DOCTYPE html>
		<html>
		<head>
			<meta charset="utf-8">
			<title>Redirecting to Pony Town</title>
			<style>
				body {
					font-family: sans-serif;
					text-align: center;
					padding-top: 50px;
					background-color: #f5f5f5;
				}
				.redirect-message {
					margin-bottom: 20px;
				}
				.redirect-button {
					display: inline-block;
					padding: 10px 20px;
					background-color: #7289da;
					color: white;
					text-decoration: none;
					border-radius: 5px;
					font-weight: bold;
				}
				.redirect-button:hover {
					background-color: #5e73bc;
				}
			</style>
			<script>
				// Automatically redirect after a short delay
				window.onload = function() {
					// Redirect to Pony Town
					window.location.href = "https://pony.town/";
				};
			</script>
		</head>
		<body>
			<div class="redirect-message">
				<h2>Redirecting to Pony Town...</h2>
				<p>If you are not automatically redirected, please click the button below:</p>
				<a class="redirect-button" href="https://pony.town/">Go to Pony Town</a>
			</div>
		</body>
		</html>
	"}, "window=ponytown_redirect;size=700x600;can_close=1;can_resize=0;titlebar=1")

	output.add_line("You like playing with ponies dont you?")
