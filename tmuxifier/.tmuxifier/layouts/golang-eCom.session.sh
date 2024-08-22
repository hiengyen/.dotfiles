# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/go/src/github.com/hiengyen/golang-eCom/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "golang-eCom"; then
	# Create a new window inline within session layout definition.
	new_window "golang-eCom"
	split_v 10
	split_h 50
	# run_cmd "go run "

	select_pane 0
	run_cmd "nvim"

	# Load a defined window layout.
	# load_window ""

	# Select the default active window on session creation.
	select_window 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
