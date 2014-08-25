/*! Calamity Worker Bridge 0.0.1 - MIT license */
(function(){
// Import calamity if necessary.
if (typeof calamity === "undefined" && typeof require === "function") {
	calamity = require("calamity");
}
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

calamity.WorkerBridge = (function(_super) {
  __extends(WorkerBridge, _super);

  WorkerBridge.version = "0.0.1";

  calamity.emitter(WorkerBridge.prototype);

  WorkerBridge.prototype._workerUrl = null;

  WorkerBridge.prototype._worker = null;

  WorkerBridge.prototype.connected = false;

  function WorkerBridge(bus, workerUrl) {
    if (workerUrl == null) {
      workerUrl = "calamity-workerbridge-worker.js";
    }
    if (!calamity.WorkerBridge.isSupported()) {
      throw new Error("Shared workers not supported");
    }
    WorkerBridge.__super__.constructor.call(this, bus);
    this._workerUrl = workerUrl;
    this._initWorker();
  }

  WorkerBridge.prototype._initWorker = function() {
    var port, worker;
    worker = this._worker = new SharedWorker(this._workerUrl);
    port = worker.port;
    port.addEventListener("message", ((function(_this) {
      return function(msg) {
        return _this.handleWorkerMessage(msg);
      };
    })(this)), false);
    port.postMessage("");
    return port.start();
  };

  WorkerBridge.prototype.handleWorkerMessage = function(msg) {
    var data;
    data = msg.data;
    if (!this.connected && data === "pong") {
      this.connected = true;
      this.trigger("connect");
      return;
    }
    return console.log("Message:", typeof data, data);
  };

  WorkerBridge.isSupported = function() {
    return !!window.SharedWorker;
  };

  return WorkerBridge;

})(calamity.Bridge);
}).call(this);
//# sourceMappingURL=calamity-workerbridge.js.map