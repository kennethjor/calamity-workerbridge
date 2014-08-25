/*! Calamity Worker Bridge (worker) 0.0.1 - MIT license */
(function(){
var handleMessage, ports;

ports = [];

self.addEventListener("connect", function(event) {
  var port;
  port = event.ports[0];
  ports.push(port);
  port.addEventListener("message", (function(port) {
    return function(msg) {
      handleMessage(port, msg);
    };
  })(port));
  port.postMessage("pong");
});

handleMessage = function(port, msg) {
  var p, _i, _len;
  for (_i = 0, _len = ports.length; _i < _len; _i++) {
    p = ports[_i];
    if (p !== port) {
      p.postMessage(msg);
    }
  }
};
}).call(this);
//# sourceMappingURL=calamity-workerbridge-worker.js.map