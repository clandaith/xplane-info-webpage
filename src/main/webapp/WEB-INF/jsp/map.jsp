<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>XPlane Info</title>

    <link href="/css/main.css" rel="stylesheet">
		<link href="/css/leaflet.css" rel="stylesheet">

    <script src="/js/main.js"></script>
		<script src="/js/leaflet-src.js" ></script>
		<script src="/js/leaflet.rotatedMarker.js" ></script>
		<script src="/js/speedometer.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <style>
       /* Set the size of the div element that contains the map */
      #mapid { height: 600px; }
      table {
      	width: 100%;
      }
      th, td {
      	text-align: center;
      }
    </style>

</head>
<body>
    <h2 class="hello-title">Hello <span id="transponder">0</span></h2>
  

<table>
	<tr>
			<th>RPM: <span id="rpm">0</span></th>
			<th>Speed: <span id="speed">0</span></th>
			<th>Altitude: <span id="altitude">0</span></th>
			<th>Compass: <span id="compass">0</span></th>
	</tr>
<tr>
	<td><canvas id="canvasRPM" width="150" height="150" style="border:1px solid #d3d3d3;"></canvas></td>
	<td><canvas id="canvasSpeed" width="150" height="150" style="border:1px solid #d3d3d3;"></canvas></td>
	<td><canvas id="canvasAlt" width="150" height="150" style="border:1px solid #d3d3d3;"></canvas></td>
	<td><canvas id="canvasComp" width="150" height="150" style="border:1px solid #d3d3d3;"></canvas></td>
</tr>

<!--

	<tr>
			<th>Lat:</th>
			<th>Long:</th>
	</tr>
<tr>
	<td><span id="latitude">0</span></td>
	<td><span id="longitude">0</span></td>
</tr>

-->

</table>

<br>
    <div id="mapid"></div>

<script type="text/javascript">

		var lat = 0;
		var longt = 0;
		var transp = 0;
		var altAGL = 0;
		var altitude = 0;
		var rpm = 0;
		var compass = 0;

		var topAlt = 20000;

		var img = null, needle = null, degrees = 0;

	var mymap = L.map('mapid').setView([lat, longt], 13);

	var iconAirplane = L.icon({
    iconUrl: 'airplane.svg', iconSize: [30, 30], iconAnchor: [15, 15]
});

	var iconDot = L.icon({
    iconUrl: 'dot.png', iconSize: [2, 2], iconAnchor: [1, 1]
});

	L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
	    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
	    maxZoom: 18,
	    id: 'mapbox/streets-v11',
	    tileSize: 512,
	    zoomOffset: -1,
	    accessToken: 'pk.eyJ1IjoiY2xhbmRhaXRoIiwiYSI6ImNrOHFpc3Y1dTAzZXAzaXAxNGdrN284cDIifQ.OMlOIwRO0eA58Xf-7GS9Fg'
	}).addTo(mymap);

var layerGroup = L.layerGroup().addTo(mymap);
var layerPath = L.layerGroup().addTo(mymap);

draw();

		
			$(document).ready(function(){

			  setInterval(function () {
			    $.ajax({
					  url: "/data/info",
					  dataType: "json",
					  success: function( info ) {
					    $( "#transponder" ).html(info["transponder"] );
					    $( "#rpm" ).html(info["rpm"] );
					    //$( "#latitude" ).html(info["latitude"] );
					    //$( "#longitude" ).html(info["longitude"] );
					    $( "#speed" ).html(info["speed"] );
					    $( "#altitude" ).html(info["altitude"] );
					    $( "#compass" ).html(info["compass"] );

							transp = info["transponder"];
							lat = info["latitude"];
							longt = info["longitude"];

							rpm = info["rpm"];
							altitude = info["altitude"];
							compass = info["compass"];

							altAGL = info["altAGL"];

							mymap.panTo(L.latLng(lat, longt));
							layerGroup.clearLayers();

							L.marker([lat, longt], {icon: iconAirplane, rotationAngle: info["compass"]}).addTo(layerGroup);
							L.marker([lat, longt], {icon: iconDot}).addTo(layerPath);


							altGuage();
							rpmGuage();
							compassGuage();

							drawCompass();
							drawWithInputValue(info["speed"]);

					  }
					});
			  }, 1000);


	// Grab the compass element
	var canvas = document.getElementById('canvasComp');

	// Canvas supported?
	if (canvas.getContext('2d')) {
		ctx = canvas.getContext('2d');

		// Load the needle image
		needle = new Image();
		needle.src = '/compass/needle.png';

		// Load the compass image
		img = new Image();
		img.src = '/compass/compass.png';
	} else {
		alert("Canvas not supported!");
	}


			});









</script>



</body>
</html>