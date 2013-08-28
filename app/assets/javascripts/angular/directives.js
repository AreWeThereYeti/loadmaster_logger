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
	
	