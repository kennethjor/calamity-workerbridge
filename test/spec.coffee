$ ->
	# Set up the bus and bridge. These are global and will not be reset on every test.
	bus = calamity.global()
	bus.subscribe "*", (msg) => console.debug "Message received:", msg.address, msg.data
	bridge = new calamity.WorkerBridge bus

	describe "WorkerBridge", ->
		it "should connect", (done) ->
			_.delay (->
				expect(bridge.connected).toBe true
				done()
			), 50
