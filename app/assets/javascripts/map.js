//////////////////////////////////////////////////////////
  // INITIALIZE MAP 
//////////////////////////////////////////////////////////

function initAutocomplete() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 47.612926, lng: -122.336815},
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

//////////////////////////////////////////////////////////
  // Create the search box and link it to the UI element.
//////////////////////////////////////////////////////////
  
  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_CENTER].push(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  var markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener('places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }
    //////////////////////////////////////////////////////////
      // GEOCODERZZZZZZZZZZZZZ 
    //////////////////////////////////////////////////////////
    
    function socrataData(lat, lng){
      return $.ajax({
        type: "GET",
        url: "/seattle/bike_thefts",
        data: {lat: lat, lng: lng},
        success: function(result){
          var results = markers.concat(result);
          addMarkers(results);
        }, 
        error: function(xhr){
          console.log(xhr.responseText)
        }
      })
    }


    geocoder = new google.maps.Geocoder();
    function codeAddress() {
      ////In this case it gets the address from an element on the page, but obviously you  could just pass it to the method instead
      var address = document.getElementById("pac-input").value;

      geocoder.geocode( { 'address': address}, function(results, status) {
        var lat  = results[0].geometry.location.lat()
        var lng = results[0].geometry.location.lng()

        socrataData(lat, lng);

        if (status == google.maps.GeocoderStatus.OK) {

          //In this case it creates a marker, but you can get the lat and lng from the location.LatLng
          map.setCenter(results[0].geometry.location);
          var marker = new google.maps.Marker({
              map: map, 
              position: results[0].geometry.location
          });
        } else {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
    }

    codeAddress();

    // Clear out the old markers.
    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    markers = [];

    // For each place, get the icon, name and location.
    function addMarkers(results){
      for (var k = 0; k < results.length; k++) {
        place = new google.maps.Marker({
          position: new google.maps.LatLng(results[k][1], results[k][2]),
          map: map,
        });

        google.maps.event.addListener(place, 'click', (function(place, k) {
          return function() {
            infowindow.setContent(results[k][0]);
            infowindow.open(map, place);
          }
        })(place, k));
      }
    }
    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
}
