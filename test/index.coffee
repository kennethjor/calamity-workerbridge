window.onload = ->
	textarea = document.getElementById "log"
	log = (msg) ->
		textarea.value += "#{msg}\n"
		return

	# Report support.
	log "Supported: #{calamity.WorkerBridge.isSupported()}"

	# Ghetto tests.
	tests =
		connect: false

	# Prepare bus.
	bus = calamity.global()

	# Log all messages.
	bus.subscribe "*", (msg) =>
		log "#{msg.address}: #{msg.data}"
		return
	log "Bus created"

	# Setup bridge.
	bridge = new calamity.WorkerBridge bus
	console.log bridge
	bridge.on "*", (msg) -> log "bridge event:", msg
	bridge.on "connect", ->
		log "Bridge connected"
		tests.connect = true
		return
	log "Bridge created"



	return
