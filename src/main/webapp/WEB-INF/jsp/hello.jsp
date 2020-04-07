<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>XPlane Info</title>
    <link href="/css/main.css" rel="stylesheet">
    <script src="/js/main.js"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
    <h2 class="hello-title">Hello ${transponder}!</h2>
    <p>
    	RPMs: ${rpms}
    	<br>
    	Lat: <span id="latitude">0</span>
    	<br>
    	Long: ${longitude}
    	<br>
    	Speed: ${speed}
    	<br>
    	Altitude: ${altitude}
    	<br>
    	Compass: ${compass}
    	<br>
    </p>


<button>Update</button>

<script type="text/javascript">
$(document).ready(function(){
 console.log( "ready!" );


  setInterval(function () {
    $.ajax({
		  url: "/data/latitude",
		  success: function( latitude ) {
		    $( "#latitude" ).html(latitude );
		  }
		});
  }, 1000);
});


</script>

</body>
</html>