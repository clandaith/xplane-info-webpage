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
        height: 300px;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
       }
    </style>

</head>
<body>
    <h2 class="hello-title">Hello <span id="transponder">0</span></h2>
    <p>
    	RPM: <span id="rpms">0</span><br>
    	Lat: <span id="latitude">0</span><br>
    	Long: <span id="longitude">0</span><br>
    	Speed: <span id="speed">0</span><br>
    	Altitude: <span id="altitude">0</span><br>
    	Compass: <span id="compass">0</span><br>
    </p>


<p>
    <div id="map"></div>
</p>

<script type="text/javascript">

		var marker;
		var map;

		var lat;
		var longt;
		var transp;
		var infowindow;

		var icon = {path: "M 3.44105426,177.573221 L132.618495,104.481306 C132.618495,82.359187 132.618495,61.1411336 132.618495,40.8271456 C132.618495,24.141874 141.694936,11.8547749 150.238685,11.8547749 C158.782435,11.8547749 167.306716,25.1349875 167.306716,40.8271456 C167.306716,61.4541775 167.306716,82.672231 167.306716,104.481306 L297.036317,177.573221 L297.036317,205.38198 L167.306716,169.214028 L167.306716,219.768622 L166.144498,236.262393 L208.254757,274.744564 L208.254757,291.021145 L158.340873,280.628348 C155.681103,287.556879 152.980374,291.021145 150.238685,291.021145 C147.496997,291.021145 144.736021,287.556879 141.955758,280.628348 L92.1914103,291.021145 L92.1914103,274.744564 L133.932991,236.262393 L132.618495,219.768622 L132.618495,169.214028 L3.44105426,205.38198 L3.44105426,177.573221 Z",
		    fillColor: 'black',
		    fillOpacity: 0.8,
		    scale: .1};

				// Initialize and add the map
				function initMap() {
				  // The location of Uluru
				  var uluru = {lat: -25.344, lng: 131.036};
				  // The map, centered at Uluru

				   map = new google.maps.Map(
				      document.getElementById('map'), {zoom: 4, center: uluru});
				  // The marker, positioned at Uluru
				   marker = new google.maps.Marker({position: uluru, map: map, icon: icon});

		        marker.addListener('click', function() {
		          infowindow.open(map, marker);
		        });
				};


			  function moveMarker( lat, longt, compass ) {
			  	marker.setIcon(icon);
					marker.setPosition( new google.maps.LatLng( lat, longt ) );

					infowindow = new google.maps.InfoWindow({content: transp + " " + lat + " " + longt});

			    map.panTo( new google.maps.LatLng( lat, longt ) );
				};

			$(document).ready(function(){

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

transp = info["transponder"];
lat = info["latitude"];
longt = info["longitude"];

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