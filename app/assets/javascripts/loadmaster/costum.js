/*
$(document).ready(function(){
	
	$(function() {
		$( ".datepicker" ).datepicker();
	});
*/ 
 
// 	 fontDetect.onFontLoaded ('MyCoolFont', function(){
// 			console.log('font loaded	')
// 		}, function(){
// 			console.log('font not loaded')
// 		}, {msTimeout: 3000});
//})

(function($) {
    $(document).ready(function(){
        $(".datepicker").datetimepicker({format: 'yyyy-mm-dd hh:ii', autoclose: true});
    });
})(jQuery);
 
 

