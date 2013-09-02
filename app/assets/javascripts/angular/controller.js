function loadmasterCtrl($scope,$element,$attrs) {
	
	$scope.selectTableRow = function(controller,id){
		console.log('selectTableRow ran')
		window.location.href="/"+controller+"/"+id
	}
	
}