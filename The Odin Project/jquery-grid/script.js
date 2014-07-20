$(document).ready(function(){
	$('#btn1').click(function(){
		start(1);
	})
	$('#btn2').click(function(event) {
		/* Act on the event */
		start(2);
	});
	$('#btn3').click(function(event) {
		/* Act on the event */
		start(3);
	});
})

var start = function(option){
	$('#wrapper').html("");
	var input = prompt("Type an integre between 1 and 128");

	if(input >= 1 && input <= 128){
		var square_size = $("#wrapper").width()/input - 2;

		for(var i = 1; i <= input; i++){
			for(var j = 1; j <= input; j++){
				$("#wrapper").append('<div class="grid_square"></div>');
			}
			$('#wrapper').append('<div class="new_row></div>');
		}
		$('.grid_square').width(square_size);
		$('.grid_square').height(square_size);

		$('.grid_square').mouseenter(function(event) {
			/* Act on the event */
			switch(option){
				case 1:
					$(this).addClass('grid_square_lit');
				break;
				case 2:
					var currentOpacity = $(this).css('opacity');
					if(currentOpacity > 0){
						$(this).css('opacity', currentOpacity - 0.1);
					}
				break;
				case 3:
					$(this).fadeTo('slow', 0);
					$(this).mouseleave(function(event) {
						/* Act on the event */
						$(this).fadeTo(400, 1);
					});
				break;
			}
		});
	}else{
		alert("No. You are crazy.");
	}
}