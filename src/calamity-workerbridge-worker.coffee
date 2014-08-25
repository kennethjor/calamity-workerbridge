# Ports container.
ports = []

# When new connections are received.
self.addEventListener "connect", (event) ->
	# Add port to register.
	port = event.ports[0]
	ports.push port
	# Attach message handler for this port.
	port.addEventListener "message", do (port) -> (msg) ->
		handleMessage port, msg
		return
	# Send pong to indicate successful load.
	port.postMessage "pong"
	return

# Message handler.
# This will copy the message to all ports, except the port it came from.
handleMessage = (port, msg) ->
	for p in ports
		unless p is port
			p.postMessage msg
	return
