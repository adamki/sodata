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
  var input = ( document.getElementById('pac-input'));
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
    destroy();
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
      map.setZoom(14);
    }
    marker.setIcon(({
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
  var address = document.getElementById("pac-input").value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {

      var lat  = results[0].geometry.location.lat();
      var lng  = results[0].geometry.location.lng();

      getAndPlotCoordinates(lat, lng, map);
      } else {
      alert("Try searching for another location." + status);
    }
  });
}

var getAndPlotCoordinates = function(lat, lng, map){
  return $.ajax({
    type: "GET",
    url: "/seattle/bike_thefts",
    data: {lat: lat, lng: lng},
    success: function(response){

      renderGraph(response);

      var crimes = response.crimes;
      var racks  = response.racks;

      addCrimesToMap(crimes, map);
      addRacksToMap(racks, map);
    },
    error: function(xhr){
      console.log(xhr.responseText);
    }
  });
};

function addCrimesToMap(places, map){
  var infowindow =  new google.maps.InfoWindow({
    content: ''
	});

	var bindInfoWindow = function(crimeMarker, map, infowindow, html) {
    google.maps.event.addListener(crimeMarker, 'click', function() {
      infowindow.setContent(html);
      infowindow.open(map, crimeMarker);
    });
	};

  for(x in places) {
    var crimeLatLng = new google.maps.LatLng( places[x].location.latitude, places[x].location.longitude );
    var crimeMarker = new google.maps.Marker({
      map: map,
      animation: google.maps.Animation.DROP,
      position: crimeLatLng,
      title: places[x].offense_type,
    });
    bindInfoWindow(crimeMarker,
                   map,
                   infowindow,
                   "<b>"+ places[x].date_reported +
                   "</b><br>" + places[x].offense_type +
                   "</b><br>" + places[x].hundred_block_location +
                   "</b><br>" + places[x].date_reported + "</b>");
    markers.push(crimeMarker);
  }

}

function addRacksToMap(racks, map){
  var star = {
    path: 'M 125,5 155,90 245,90 175,145 200,230 125,180 50,230 75,145 5,90 95,90 z',
    fillColor: 'darkblue',
    fillOpacity: 0.8,
    scale: .05,
    strokeColor: 'limegreen',
    strokeWeight: 1
  };

  for(rack in racks){
    var rackLatLng = new google.maps.LatLng(racks[rack].latitude, racks[rack].longitude);
    var rackMarker = new google.maps.Marker({
      map: map,
      position: rackLatLng,
      icon: star
    });
    markers.push(rackMarker);
  }
}

function destroy(){
  for(var x=0; x<markers.length; x++) {
    markers[x].setMap(null);
  }
}
