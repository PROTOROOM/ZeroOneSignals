var socket;
var modebit;
var bgColor;
var d;

function setup() {
	createCanvas(windowWidth, windowHeight);
	bgColor = color(150, 220, 10);
	background(bgColor);
	modebit = 0;
// 	socket = io.connect('http://192.168.1.100:8080');
// 	
// 	socket.on('modebit',
// 		function(data) {
// 			modebit = data;
// 		}
// 	);
	d = 200;
}

function draw() {
	background(bgColor);
	noStroke();
	
	
	if (modebit == 1) {
		fill(color(0, 200, 0));	
		d = min(200, d + 9);
	} else {
		fill(color(200, 220, 200));
		d = max(100, d - 3);
	}
	
	ellipse(width/2, height/2, d, d);
	
	
	simulateBits(20);

}

function simulateBits(t) {
	if (frameCount % t < (t/2)) {
			modebit = 1;
	} else {
		modebit = 0;
	}
}