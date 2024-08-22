# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "/run/media/hiengyen/D1/1-Code/1_NodeJS/Nodejs-BE-eCom"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "node-eComs"; then
	# Create a new window inline within session layout definition.
	new_window "Nodejs-BE-eCom"
	split_v 10
	split_h 50
	run_cmd "yarn dev"

	select_pane 0
	run_cmd "nvim"

	# Load a defined window layout.
	load_window "test"
	# load_window ""

	# Select the default active window on session creation.
	select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
