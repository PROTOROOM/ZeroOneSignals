var socket;
var modebit;
var bgColor = color(150, 220, 10);

function setup() {
	createCanvas(windowWidth, windowHeight);
	background(bgColor);
	socket = io.connect('http://192.168.1.100:8080');
	
	socket.on('modebit',
		function(data) {
			modebit = data;
		}
	);

}

function draw() {
	background(bgColor);
	println(modebit);
}