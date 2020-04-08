function compassGuage(){
		var c = document.getElementById("canvasRPM");
		var ctx = c.getContext("2d");
		ctx.beginPath();
		ctx.moveTo(c.width / 2, c.height / 2);
		ctx.lineTo(70, 90);
		ctx.stroke();
}

function rpmGuage(){
		var c = document.getElementById("canvasRPM");
		var ctx = c.getContext("2d");
		ctx.beginPath();
		ctx.moveTo(75, 150);
		ctx.lineTo(70, 90);
		ctx.stroke();
}

function altGuage(){		
		var c = document.getElementById("canvasAlt");
		var ctx = c.getContext("2d");
		
		var altPercent = altitude / topAlt;
		var lineAlt = altPercent * c.height;
		lineAlt = c.height - lineAlt;

		ctx.clearRect(0, 0, c.width, c.height);
		ctx.beginPath();
		ctx.moveTo(0, lineAlt);
		ctx.lineTo( c.width, lineAlt);
		ctx.stroke();


		ctx.fillStyle = "#FF0000";
		ctx.fillRect(0, (c.height * .95), c.width, c.height);

		ctx.fillStyle = "#FF0000";
		ctx.fillRect(0, 0, c.width, (c.height * .05));
}

function drawCompass() {
	var c = document.getElementById("canvasComp");
		var ctx = c.getContext("2d");
	ctx.clearRect(0, 0, 200, 200);

	// Draw the compass onto the canvas
	ctx.drawImage(img, 0, 0);

	// Save the current drawing state
	ctx.save();

	// Now move across and down half the 
	ctx.translate(100, 100);

	// Rotate around this point
	ctx.rotate(compass * (Math.PI / 180));

	// Draw the image back and up
	ctx.drawImage(needle, -100, -100);

	// Restore the previous drawing state
	ctx.restore();
}