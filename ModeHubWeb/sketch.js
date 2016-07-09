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
		setupWebsocketClient();
	}
	
	d = 200;
	alpha = 200;
}


function draw() {
	background(bgColor);
	noStroke();

// 	var mode = checkCurrentMode(modebit);	
	
	if (modebit == 1) {
		bgColor = color(150, 220, 10);
		fill(color(0, 200, 0));	
		d = min(200, d + 20);
		alpha = 255;
	} else if (modebit == 2) {
		bgColor = color(10, 150, 220);
		fill(color(0, 0, 200));
		d = min(200, d + 20);
		alpha = 255;		
	} else {
		bgColor = color(220, 10);
		alpha = alpha - 5;
		fill(color(200, 220, 200, max(0, alpha)));
		d = max(50, d - 10);
	}
	
	ellipse(width/2, height/2, d, d);
	
	
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