var PORT = 6000;
var HOST = '127.0.0.1';

var dgram = require('dgram');

var t=0;

var randBit = function(tt, d) {
    if (d == 0) return 0;

    if (tt % d == 0) return 1;
    else return 0;
}

var b1 = new Toggle();
var b2 = new Toggle();
var b3 = new Toggle();
var b4 = new Toggle();
var b5 = new Toggle();
var b6 = new Toggle();
var b7 = new Toggle();
var b8 = new Toggle();

setInterval(function() {
    t = t + 1;
    // console.log(t);
    // var bits = [randBit(t, 0), randBit(t, 1), randBit(t, 2), randBit(t, 3), 
    //             randBit(t, 32), randBit(t, 32), randBit(t, 16), randBit(t, 4)];
    // bits = [b1.p(t, 21), b2.p(t, 12), b3.p(t, 3), b4.p(t, 24),
            // b5.p(t, 8), b6.p(t, 36), b7.p(t, 2), b8.p(t, 4)];
    bits = [0, 0, 0, 0, 0, b6.p(t, 5), 0, 0];

    var b = new Uint8Array(2);
    b[0] = 9;
    for (var i=0; i<bits.length; i++) {
        b[1] = b[1] << 1;
        if(bits[i] == 1) {
            b[1] |= 1;
        }
    }

    var message = new Buffer(b);
    var client = dgram.createSocket('udp4');
    client.send(message, 0, message.length, PORT, HOST, function(err, bytes) {
        if(err) {
            console.log(err);
            throw err;
        }
        // console.log('message sent:' + HOST + ':' + PORT);
        client.close();
    });
}, 25);



function Toggle() {
    this.v = true;
}
Toggle.prototype.t = function() {
    if (this.v) this.v = false;
    else this.v = true;
    return this.v;
}
Toggle.prototype.p = function(tt, d) {
    if (tt % d == 0) this.t();
    if (this.v) return 1;
    else return 0;
}
