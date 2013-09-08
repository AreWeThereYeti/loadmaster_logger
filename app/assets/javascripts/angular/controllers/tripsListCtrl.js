function tripsListCtrl($scope,$element,$attrs) {
	
	$scope.selectTableRow = function(id){
		$scope.$broadcast('showTripDetails',id)
	} 
	
	
}
