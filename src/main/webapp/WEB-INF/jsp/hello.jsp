<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>XPlane Info</title>
    <link href="/css/main.css" rel="stylesheet">
    <script src="/js/main.js"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>



    <style>
       /* Set the size of the div element that contains the map */
      #map {
        height: 600px;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
       }
    </style>

</head>
<body>
    <h2 class="hello-title">Hello <span id="transponder">0</span></h2>
    <p>
    	RPM: <span id="rpms">0</span>
    	<br>
    	Lat: <span id="latitude">0</span>
    	<br>
    	Long: <span id="longitude">0</span>
    	<br>
    	Speed: <span id="speed">0</span>
    	<br>
    	Altitude: <span id="altitude">0</span>
    	<br>
    	Compass: <span id="compass">0</span>
    	<br>
    </p>


<p>
    <div id="map"></div>
</p>

<script type="text/javascript">

var marker;
var map;
var icon = {rotation: 0, };

				// Initialize and add the map
				function initMap() {
				  // The location of Uluru
				  var uluru = {lat: -25.344, lng: 131.036};
				  // The map, centered at Uluru

icon = 

				   map = new google.maps.Map(
				      document.getElementById('map'), {zoom: 4, center: uluru});
				  // The marker, positioned at Uluru
				   marker = new google.maps.Marker({position: uluru, map: map, icon: "airplane_new1.png"});
				};



			  function moveMarker( lat, longt, compass ) {
			  	//console.log("Moving to: " + lat + " :: " + longt + " -- heading: " + compass);

					var icon = marker.getIcon();
			   // var rotation = icon.rotation;

			    //icon.rotation = 0;
			    icon.rotation = compass;

			    marker.setIcon(icon);

			    marker.setPosition( new google.maps.LatLng( lat, longt ) );
			    map.panTo( new google.maps.LatLng( lat, longt ) );
				};



			$(document).ready(function(){
				console.log( "ready!" );

			  setInterval(function () {
			    $.ajax({
					  url: "/data/info",
					  dataType: "json",
					  success: function( info ) {
					    $( "#transponder" ).html(info["transponder"] );
					    $( "#rpms" ).html(info["rpm"] );
					    $( "#latitude" ).html(info["latitude"] );
					    $( "#longitude" ).html(info["longitude"] );
					    $( "#speed" ).html(info["speed"] );
					    $( "#altitude" ).html(info["altitude"] );
					    $( "#compass" ).html(info["compass"] );

					   moveMarker(info["latitude"], info["longitude"], info["compass"]);
					  }
					});
			  }, 1000);
			});

    </script>

    <script async defer
    	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCUV2TuPrHmxE-CiC3jG33oYeZVJtmASlk&callback=initMap">
    </script>

</body>
</html>