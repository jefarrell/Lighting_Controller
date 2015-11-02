
$(document).ready(function(){
	var lis = $('#container ul').children().length;
	for (var i=0; i <= lis; i++ ) {
		$('#'+i).click(function(){
			questID = $(this).attr('id');
			console.log("id clicked: " + questID);
			$.get(questID+'/sendVals')
		});
	}
});