var ws;
var modebit;
var bgColor;
var d, alpha;
var isSimulation;
var isDebug;

function setup() {
	createCanvas(windowWidth, windowHeight);
	isSimulation = false;
	isDebug = false;
	
	bgColor = color(150, 220, 10);
	background(bgColor);
	modebit = 0;

	if (!isSimulation) {
		ws = new WebSocket("ws://localhost:8080/modehub");
	
		ws.onopen = function() {
			console.log("connected");
		};
	
		ws.onmessage = function(evt) {
			var data = evt.data;
			if (isDebug) { console.log(data); }
			modebit = Number(data);
		};
	
		ws.onclose = function() {
			console.log("closed...");
		};
	}
	
	d = 200;
	alpha = 200;
}

function draw() {
	background(bgColor);
	noStroke();
	
	
	if (modebit == 1) {
		fill(color(0, 200, 0));	
		d = min(200, d + 20);
		alpha = 255;
	} else {
		alpha = alpha - 5;
		fill(color(200, 220, 200, max(0, alpha)));
		d = max(50, d - 10);
	}
	
	ellipse(width/2, height/2, d, d);
	
	
	if (isSimulation) simulateBits(60);

}

function simulateBits(t) {
	if (frameCount % t < (t/2)) {
			modebit = 1;
	} else {
		modebit = 0;
	}
}