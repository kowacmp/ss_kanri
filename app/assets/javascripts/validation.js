$(function () {
	var msgs;
	var setError = function (elem, msg) {
		msgs.push('<li>' + msg + '</li>');
		$(elem)
		  .addClass('error_field')
		  .after('<span class="error_mark">*</span>');
	};
	
	$('#fm').submit(function (e) {
		msgs = [];
		$('.error_mark', this).remove();
		$('.valid', this)
		  .removeClass('error_field')
		  .filter('.range')
		  .each(function () {
		  	var v = parseFload($(this).val());
		  	if (v < $(this).data('min') || v > $(this).data('max')) {
		  		setError(this,
		  			$(this).prev('label').text() + 'は' + 
		  			$(this).data('min') + '～' + $(this).data('max') +
		  			'の範囲で入力してください。');
		  	}
		  })
		  .end()

	if(msgs.length === 0 ) {
		$('#error_summary').css('display','none');
	} else {
		$('#error_summary')
		  .css('display','block')
		  .html(msgs.join(''));
		e.preventDefault();
	}
	});
});
