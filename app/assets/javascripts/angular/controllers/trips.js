function tripsCtrl($scope,$element,$attrs) {
	 
	$scope.selectTrip = function(id){
		console.log('you have selected a trip with id: ' + id)
		window.location.href="/trips/"+id
	}
	
}

