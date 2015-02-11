$(function() {

	//	Show product menu
	$('#productNav, #productList').hover(function () {
		$('#productNav').addClass('selected');
		$('#productList').show();
	}, function() {
		$('#productNav').removeClass('selected');
		$('#productList').hide();
	});
	
});



