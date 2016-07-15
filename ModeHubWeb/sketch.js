var ws;
var modebit;
var bgColor;
var d, alpha;
var isSimulation;
var isDebug;
var colorCount=0;
var changeColor = true;

function setup() {
	createCanvas(windowWidth, windowHeight);
	isSimulation = false;
	isDebug = false;
	
	bgColor = color(255);
	background(bgColor);
	modebit = 0;

	if (!isSimulation) {
		setupWebsocketClient();
	}
	
	d = 200;
	alpha = 200;
	
	rectMode(CENTER);
}


function draw() {
	background(bgColor);
	noStroke();

// 	var mode = checkCurrentMode(modebit);	
	
	if (modebit == 1) {
		fill(color(0));	
		d = 200;
		alpha = 255;
		
		rect(width/2, height/2, d, d);
		
	} else if (modebit == 2) {

// 		if (colorCount > 300) {
// 			fill(color(random(150, 255), random(150, 255), random(150, 255)));
// 			colorCount = 0;
// 		}
		if (changeColor) {
			circleColor = color(random(150, 255), random(150, 255), random(150, 255));
			changeColor = false;
		}
		d = 200;	
		fill(circleColor);	
		ellipse(width/2, height/2, d, d);
// 		colorCount++;
		
	} else {
		d = 150;
		changeColor = true;
	}
	

	
	
	if (isSimulation) simulateBits(60);

}


function checkCurrentMode(bit) {

	
}


function setupWebsocketClient() {
// 	ws = new WebSocket("ws://192.168.0.14:8080/modehub");
	ws = new WebSocket("ws://localhost:8080/modehub");
	ws.onopen = function() {
		if (isDebug) { console.log("connected"); }
	};

	ws.onmessage = function(evt) {
		var data = evt.data;
		if (isDebug) { console.log(data); }
		modebit = Number(data);
	};

	ws.onclose = function() {
		if (isDebug) { console.log("closed..."); }
	};
}


function simulateBits(t) {
	if (frameCount % t < (t/2)) {
			modebit = 1;
	} else {
		modebit = 0;
	}
}