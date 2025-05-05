/datum/console_command/doom
	command_key = "doom"
	required_args = 0
	notify_admins = FALSE

/datum/console_command/doom/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("doom - Opens Doom in a new window")
	output.add_line("   Controls: Arrows to move, S to fire, Alt to strafe")
	output.add_line("   Press Enter to start")

/datum/console_command/doom/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	var/mob/user = usr
	if(!user.client)
		return

	user << browse({"
		<!DOCTYPE html>
		<html>
		<head>
			<meta charset="utf-8">
			<title>DOOM in SS13</title>
			<style>
				html,body{
					min-height:100%
				}
				body {
					font-family:sans-serif;
					text-align: center;
					background: #111 url(https://i.imgur.com/c9IEImz.jpeg) center no-repeat;
					background-size:cover;
					color:#aaa
				}
				#dosbox:hover .dosbox-start{
					opacity:1
				}
				#dosbox .dosbox-start {
					background:url(https://i.imgur.com/c9IEImz.jpeg) center no-repeat;
					background-size:150px;
					height:100%;
					image-rendering:pixelated;
					top:4% !important;
					color: rgba(0,0,0,0);
					filter: drop-shadow(0px 0px 8px rgba(255,255,255,.95));
				}
				.dosbox-powered {
					opacity: 0;
				}
				.dosbox-container {
					background: #000 url(https://goo.gl/aZVGdQ) center no-repeat;
					margin: 10% auto 0 auto;
					width: 640px;
					height: 400px;
				}
				.dosbox-container > .dosbox-overlay {
					background: url(https://js-dos.com/cdn/doom_2.png);
				}
				button{
					background:#a00;
					border:0;
					padding:5px 15px;
					cursor:pointer;
					font-weight:700
				}
				p{
					font-size:11px
				}
				a{
					color:#aaa
				}
				#loading-status {
					color: #0f0;
					margin: 10px;
					padding: 5px;
					background: rgba(0,0,0,0.5);
					display: inline-block;
				}
			</style>
		</head>
		<body>
			<div id="loading-status">Loading Doom emulator...</div>
			<div id="dosbox"></div>
			<script src="https://js-dos.com/cdn/js-dos-api.js"></script>
			<script>
				// Show loading status
				const statusEl = document.getElementById('loading-status');

				// Initialize DOSBox with the older API
				window.dosbox = new Dosbox({
					id: "dosbox",
					onload: function(dosbox) {
						statusEl.textContent = "Downloading Doom...";
						dosbox.run("https://js-dos.com/cdn/upload/DOOM-@evilution.zip", "./DOOM/DOOM.EXE");
					},
					onrun: function(dosbox, app) {
						statusEl.textContent = "Doom loaded! Press Enter to start";
						setTimeout(() => statusEl.style.display = 'none', 3000);
						console.log("App '" + app + "' is running");
					},
					onerror: function(error) {
						statusEl.textContent = "Error loading Doom: " + error;
						statusEl.style.color = "#f00";
						console.error("Doom loading error:", error);
					}
				});

			</script>
		</body>
		</html>
	"}, "window=doom;size=700x600;can_close=1;can_resize=1;titlebar=1")

	output.add_line("Doom window opened - game may take a moment to load")
