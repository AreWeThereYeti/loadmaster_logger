angular.module('loadmaster', [])
  .directive('ngLoadmaster',function(){
		return {
		  controller:'loadmasterCtrl',
		  link:function(scope,element,attrs){
		  }
		}
	})
	.directive('ngTrips',function(){
	   return {
       controller:'tripsCtrl',
       link:function(scope,element,attrs){
       }
		 }
   })
	.directive('ngTripsList',function(){
   	return {
	   	controller:'tripsListCtrl',
	   	link:function(scope,element,attrs){
	   	}
		}
	})
	.directive('ngTripsListItem',function(){
   	return {
	   	controller:'tripsListItemCtrl',
			scope:{
        id:"=tripid"
      },
	   	link:function(scope,element,attrs){
				console.log('made trip list item with id: ' + scope.id)
	   	}
		}
	})
	
	