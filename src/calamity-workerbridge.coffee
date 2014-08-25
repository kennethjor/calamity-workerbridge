class calamity.WorkerBridge extends calamity.Bridge
	@version: "%version%"
	calamity.emitter @prototype

	_workerUrl: null
	_worker: null
	connected: false

	constructor: (bus, workerUrl = "calamity-workerbridge-worker.js") ->
		throw new Error "Shared workers not supported" unless calamity.WorkerBridge.isSupported()
		super bus
		@_workerUrl = workerUrl
		@_initWorker()

	# Initialises the worker.
	_initWorker: ->
		worker = @_worker = new SharedWorker @_workerUrl
		port = worker.port
		# Attach message handler.
		port.addEventListener "message", (msg) => @handleWorkerMessage msg
		# Start port.
		port.start()

	# Handles a message coming in from the worker.
	handleWorkerMessage: (msg) ->
		{data} = msg
		# Register a live connection when a pong is received.
		if !@connected and data is "pong"
			@connected = true
			@trigger "connect"
			return
		# Handle normal messages.
		console.log "Message:", typeof data, data

	# Returns true is shared web workers are supported.
	@isSupported = -> return !!window.SharedWorker
