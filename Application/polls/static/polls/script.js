
$(document).ready(function(){
	var lis = $('#container ul').children().length;
	$(':button').each(function(index){
		var bClass = $(this).attr('value');
		var targetVal = 'Intensity';
		if (bClass.match(targetVal)){
			$(this).attr('class', 'intensity');
		}
	})
	for (var i=0; i <= lis; i++ ) {
		$('#'+i).click(function(){
			questID = $(this).attr('id');
			console.log("id clicked: " + questID);
			$.get(questID+'/sendVals')
		});
		
	}

});