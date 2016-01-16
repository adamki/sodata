var geocoder;
var map;
var places;
var markers = [];

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 47.612926, lng: -122.336815},
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false,
  });
  var input = /** @type {!HTMLInputElement} */(
      document.getElementById('pac-input'));

  var types = document.getElementById('type-selector');
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  autocomplete.addListener('place_changed', function() {

    geocode(map);
    destroy()
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("Autocomplete's returned place contains no geometry");
      return;
    }

    // If the place has a geometry, then present it on a map.

    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(14);  // Why 17? Because it looks good.
    }
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });

}

function geocode(map){
  geocoder = new google.maps.Geocoder();
  ////In this case it gets the address from an element on the page, but obviously you  could just pass it to the method instead
  var address = document.getElementById("pac-input").value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var lat  = results[0].geometry.location.lat()
      var lng  = results[0].geometry.location.lng()
      response = getAndPlotCoordinates(lat, lng, map);

      console.log(markers + "from line 35 just after ajax")
      console.log(markers)
      deleteMarkers()
      } else {
      alert("Try searching for another location." + status);
    }
  });
}

var getAndPlotCoordinates = function(lat, lng, map){
  var infowindow =  new google.maps.InfoWindow({
      content: ''
  });

  return $.ajax({
    type: "GET",
    url: "/seattle/bike_thefts",
    data: {lat: lat, lng: lng},
    success: function(response){
      places = response.crimes;
      //addMarkers(results);
      //plotMap(results);
      for (crime in places) {
        tmpLatLng = new google.maps.LatLng( places[crime].location.latitude, places[crime].location.longitude );

        var marker = new google.maps.Marker({
          map: map,
          position: tmpLatLng,
          //title : places[crime].name + "<br>" + places[crime].location
        });
        //bindInfoWindow(marker, map, infowindow, '<b>'+places[p].name + "</b><br>" + places[p].geo_name);
        // not currently used but good to keep track of markers
        markers.push(marker)
      }
    },
    error: function(xhr){
      console.log(xhr.responseText);
    }
  });
}

function destroy(){
  for(var x=0; x<markers.length; x++) {
    markers[x].setMap(null);
  }
}
