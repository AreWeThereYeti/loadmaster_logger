function mapCtrl($scope,$element,$attrs) {

	$scope.reInit = function(position){
		console.log("reinit map")
		$scope.gps_found = null;
		$scope.initialize()
	}
	/* 			Initialize map */
  $scope.initialize = function(latitude, longitude) {
		if(!latitude){var latitude=55.724355}
		if(!longitude){var longitude=12.268982}
		$scope.bounds=new google.maps.LatLngBounds()
		
    $scope.mapOptions = {
      center: new google.maps.LatLng(latitude, longitude),
      zoom: 0,
      streetViewControl: false,
      zoomControl: true,
      zoomControlOptions: {
      	style: google.maps.ZoomControlStyle.LARGE
    	},
      maptypecontrol :false,
      disableDefaultUI: false,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
		/* 	Add map to #map_canvas */
    $scope.map = new google.maps.Map($element.find('.map-container')[0], $scope.mapOptions);
  }
  
  $scope.drawCurrentPosition = function(){
  	navigator.geolocation.getCurrentPosition(function success(position){
			$scope.$apply(function(scope){
				scope.initialize(position.coords.latitude, position.coords.longitude)
		  })
	  }, 
	  function error(error){
		  $scope.$apply(function(scope){
			  console.log('couldnt get current position')
		  })
	  }, { maximumAge: 5000, timeout: 15000, enableHighAccuracy: true });
  }

	$scope.drawMarker = function(lat,lon){
		var markerPosition = new google.maps.LatLng(lat,lon);
		$scope.bounds.extend(markerPosition)
		var marker = new google.maps.Marker({
		   position: markerPosition,
		   draggable:false,
		   animation: google.maps.Animation.DROP,
		   map: $scope.map,
		   title: "Start Position"
		});
	}
  
	$scope.centerOnMarkers = function(){
		$scope.map.fitBounds($scope.bounds);
		if($scope.map.getZoom()>15){
			console.log('setting zoom level')
			$scope.map.setZoom(14)
		}
	}

  // $scope.gpsStateUndefined = function(){
  // 		return $scope.gps_found==null;
  // }
  // 
  // $scope.gpsFound = function(){
  // 		return $scope.gps_found==true
  // }
  // 
  // $scope.gpsNotFound = function(){
  // 		return $scope.gps_found==false;
  // }

	$scope.refreshMap = function(){
		window.the_scope=$scope
		setTimeout(function(){ 
			google.maps.event.trigger($scope.map, 'resize'); 
			$scope.centerOnMarkers()
		}, 20)
	}
	
	$scope.$on('resfreshMap',function(){
		$scope.refreshMap()
	})
  
}