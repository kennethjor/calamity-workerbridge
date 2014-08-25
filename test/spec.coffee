describe "WorkerBridge", ->
	# Set up the bus and bridge. These are global and will not be reset on every test.
	bus = calamity.global()
	bridge = new calamity.WorkerBridge bus

	it "should be supported", ->
		expect(calamity.WorkerBridge.isSupported()).toBe true

	it "should connect with bridge", (done) ->
		if bridge.connected
			expect(bridge.connected).toBe true
			done()
		else
			bridge.on "connect", ->
				expect(bridge.connected).toBe true
				done()

	it "should connect with frame", (done) ->
		bus.subscribe "test.frame.ready", ->
			expect(true).toBe true
			done()
		console.log "sending init"
		bus.publish "test.frame.init", "data"
