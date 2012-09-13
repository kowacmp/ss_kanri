/*
$(function () {

    //油種が変更された場合のイベント
    $("#m_oil_m_oil_id")
      .change(function() { 
	      	$.get(
			    '/m_meters',                 // 送信先
			    { m_oil_id: $(this).val(),m_shop_id: $("#m_shop_m_shop_id").val(), remote: true},
			    function(data, status) {        // 通信成功時にデータを表示
			       $('#result').empty();
	               $('#result').append(data);
	             },
			    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
	            );
      	});
      	
})();
*/
