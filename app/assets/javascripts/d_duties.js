$(function () {

    //入力日が変更された場合のイベント
    $("#_input_day_1i, #_input_day_2i")
      .change(function() { 
           	  //Index
           	   $.get(
				    '/d_duties',                 // 送信先
				    { input_day: String($("#_input_day_1i").val()) + ('00' + $("#_input_day_2i").val()).slice(-2) , m_shop_id: $("#head_input_m_shop_id").val(), remote: true},
				    function(data, status) {        // 通信成功時にデータを表示
				       $('#form').empty();
		               $('#form').append(data);
		             },
				    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
		            );
    });
           	
	//バいトの日勤が変更されたら
	$("div#modal :input[id*=_day_work_time], div#modal :input[id*=_night_work_time]")
    .live('change', function(){
    	var get_index;
    	var total;
		var Div_id='';
		var num1;
		var num2;
		
	    if ($("div#modal div.bodyDiv").size() > 0) {
	    	Div_id = 'div.bodyDiv ';
	    };
	        	
	   	//合計をセット
	   	get_index = $(this).attr('id').replace("datas_", "");
	    get_index = get_index.replace("_day_work_time", "");
	    get_index = get_index.replace("_night_work_time", "");
	    
	    num1 = Number($("div#modal " + Div_id + "#datas_" + get_index + "_day_work_time").val());
        if (isNaN(num1)) {num1 = 0};
	    num2 = Number($("div#modal " + Div_id + "#datas_" + get_index + "_night_work_time").val());
        if (isNaN(num2)) {num2 = 0};
        
	    total = num1 + num2;
	    
	    $("div#modal " + Div_id + "#datas_" + get_index + "_all_work_time").text(total);
	    $("div#modal " + Div_id + "input#datas_" + get_index + "_all_work_time").val(total);
    });
      
    //各社員の合計日数が変わったら、合計を再計算する
    $("div.colDiv #col_syain_nisu_kei")
      .live('click', function(){
	     //社員出金日数合計をセット
	     cals_syain_nisu_kei();   	
    });
    //各バイトの合計時間が変わったら、合計を再計算する
    $("div.colDiv #col_baito_jikan_kei")
      .live('click', function(){
	     //バイト時間合計をセット
	     cals_baito_jikan_kei();   	
    });

   
  //社員出金日数合計をセット
  cals_syain_nisu_kei();
  //バイト時間合計をセット
  cals_baito_jikan_kei();
  
  //社員出金日数合計
  function cals_syain_nisu_kei() {
    
    var i=0;
    var num;
    var total=0;  

	var Div_id='';
	
    if ($("div.colDiv").size() > 0) {
    	Div_id = 'div.colDiv ';
    };
    
    //社員ごとの日数計
    $(Div_id + "[id^=syain_nisu_]").each(function(i){
        num = Number($(this).text());
        if (isNaN(num)) {num = 0};
        total = total + num;
    })
    $(Div_id + "#col_syain_nisu_kei").text(total);

    if ($("div.bodyDiv").size() > 0) {
    	Div_id = 'div.bodyDiv ';
    };
    
    var i=1;
    //日繰り返し
    while(i<32){
      
      total=0;
      $(Div_id + "[id^=hiden_syain_" + Number(i) + "_]").each(function(i){
          num = Number($(this).val());
          if (isNaN(num)) {num = 0};
          total = total + num;
      })
      $(Div_id + "#col_syain_nisu_kei_" + Number(i)).text(total);
      i=i+1;
    };
  
  };
  
  //バイト時間数合計
  function cals_baito_jikan_kei() {
    var i=0;
    var num;
    var total=0;  

	var Div_id='';
	
    if ($("div.colDiv").size() > 0) {
    	Div_id = 'div.colDiv ';
    };
    
    //社員ごとの日数計
    $(Div_id + "[id^=baito_jikan_]").each(function(i){
        num = Number($(this).text());
        if (isNaN(num)) {num = 0};
        total = total + (num*10);
    })
    $(Div_id + "#col_baito_jikan_kei").text(total/10);

    if ($("div.bodyDiv").size() > 0) {
    	Div_id = 'div.bodyDiv ';
    };
    
    var i=1;
    //日繰り返し
    while(i<32){
      
      total=0;
      $(Div_id + "[id^=baito_" + Number(i) + "_]").each(function(i){
          num = Number($(this).text());
          if (isNaN(num)) {num = 0};
          total = total + (num*10);
      })
      $(Div_id + "#col_baito_jikan_kei_" + Number(i)).text(total/10);
      i=i+1;
    };  	
  };
  

  
});

//時間入力チェック(false:error true:ok)
function d_duty_validation(val) {
	var num;
  	var suchi;
  	
    num = Number(val);
    if (isNaN(num)) {num = 0};
	
	if (String(num).indexOf('.') == -1) {num = String(num) + ".0"};
		suchi = String(num).split(".");

    if (suchi[0].length > 2 || String(Number(suchi[1])).length > 1 ) {
    	return false;
	}else{
		return true;
	};
};
