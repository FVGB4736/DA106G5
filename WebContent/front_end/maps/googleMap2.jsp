<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Google Map Demo</title>
<style>
/* Always set the map height explicitly to define the size of the div
 * element that contains the map. */
#map {
  height: 30rem;
  width: 75%;
  float: left;
}
#tableOutput{
  height: 100%;
  width: 40%;
  float: left;
}
/* Optional: Makes the sample page fill the window. */
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}
</style>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.2.1.min.js"></script>

</head>
<body>
	<!-- <div class="col-3">&nbsp&nbsp�ӤH����</div> -->
	<nav aria-label="breadcrumb" class="col-12 my_breadcrumb">
		<ol class="breadcrumb m-0">
			<li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/front_end/member/login.jsp">�n�J�e��</a></li>
			<li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/front_end/member/login.jsp">�ǳ�</a></li>
			<li class="breadcrumb-item active" aria-current="page">�a��</li>
		</ol>
	</nav>

	<div class="w-100"></div>
	<!-- �����e -->
	
    <div id="map" class="ml-4 mr-2"></div>
    <div id="tableOutput m-0">
    
    				<div class="form-check form-check-inline ml-5 my-5">
    					<label for="inlineCheckbox1" class="form-check-label mr-2">�ɤ��I</label>
					    <input id="inlineCheckbox1" class="form-check-input" data-size="lg" type="checkbox" data-toggle="toggle" data-style="mr-1" checked>
					</div></br>
    
     				<div class="form-check form-check-inline ml-5 my-5">
    					<label for="inlineCheckbox1" class="form-check-label mr-2">�B�ʳ�</label>
					    <input id="inlineCheckbox1" class="form-check-input" data-size="lg" type="checkbox" data-toggle="toggle" data-onstyle="success" data-style="mr-1" checked>
					</div></br>
    	
    				<div class="form-check form-check-inline ml-5 my-5">
    					<label for="inlineCheckbox1" class="form-check-label mr-2">�s��~</label>
					    <input id="inlineCheckbox1" class="form-check-input" data-size="lg" type="checkbox" data-toggle="toggle" data-onstyle="secondary" data-style="mr-1" checked>
					</div>
    		
   
    		<tbody id="place">
    		</tbody>
    	</table>
    </div>
    <script>
    var map;
    var markers = [];
    var searchResult;
    var iconBase = "<%= request.getContextPath() %>/img/";
    function initMap() {
      var myLatlng = {lat: 24.9677686, lng: 121.1916822};

      map = new google.maps.Map(document.getElementById('map'), {
        center: myLatlng,
        zoom: 17
      });
      var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: 'Click to zoom'
      });

      // �^���ήɤ�����T
      callback(null, ${locationJSON});
    
      map.addListener('center_changed', function() {
	        	deleteMarkers();
// 	        	getJSON(${locationJSON}, callback);
	        	callback(null, ${locationJSON});
      });
    }
        
    function getJSON(url, callback) {
//       var xhr = new XMLHttpRequest();
//       xhr.open('GET', url, true);
//       xhr.responseType = 'json';
//       xhr.onload = function() {
//         var status = xhr.status;
//         if (status === 200) {
//           callback(null, xhr.response);
//         } else {
//           callback(status, xhr.response);
//         }
//       };
//       xhr.send();
    }

    function callback(err, data) {
      if (err !== null) {
        alert('Something went wrong: ' + err);
      } else {
		searchResult = data;
		var position = ${locationJSON};
        console.log(data[0]);
        $("#place").empty();
        var index = 1;
        for(var i = 0; i < data.length; i++){
//           var lat = data[i].lat;
          var lat = position.lat;
//           var lng = data[i].lng;
          var lng = position.lng;
//           var icon = data[i].icon
          var icon = position.icon
          var latLng = new google.maps.LatLng(data[i].lat, data[i].lng);
//         	if(map.getBounds().contains(latLng)){
        		addMarker(latLng, data[i]);
//         		$("#place").append("<tr><td>"+lat+"</td><td>"+lng+"</td><td>"+icon+"</td></tr>");
//         		index++;
//         	}
        }
      }
    }
    
    // Adds a marker to the map and push to the array.
    function addMarker(latLng, result) {
      var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        icon: iconBase + result.icon
      });
      markers.push(marker);
      var infowindow = new google.maps.InfoWindow({
          content: "<h2>"+result.lat+"</h2><div><p><b>����: </b>"+result.lng+"</p><p><b>�q��: </b>"+result.icon+"</p><p><b>��m: </b>{"+result.lat+","+result.lng+"}</p></div>"
      });
      marker.addListener('click', function() {
          infowindow.open(map, marker);
      });
    }
    
    // Deletes all markers in the array by removing references to them.
    function deleteMarkers() {
  		setMapOnAll(null);
     	markers = [];
    }
    
    // Sets the map on all markers in the array.
    function setMapOnAll(map) {
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
      }
    }

    window.onload = initMap;  //���ե�
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDZv52MGeQchjobQgjXxUNTBzgUmY1qN7g&callback=initMap"></script>
</body>
</html>