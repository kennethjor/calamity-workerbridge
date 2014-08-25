# Set up bus and bridge.
bus = calamity.global()
bridge = new calamity.WorkerBridge bus

# Wait for init signal.
init = false
bus.subscribe "test.frame.init", ->
	return if init
	bus.publish "test.frame.ready"
	init = true
