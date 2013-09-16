function loadmasterCtrl($scope,$element,$attrs) {
	
	$scope.IS_MOBILE=false
	
	$scope.selectTableRow = function(controller,id){
		window.location.href="/"+controller+"/"+id
	}
	
	$scope.preventDefault = function($event){
		$event.preventDefault();
		$event.stopImmediatePropagation();
	}
	
}