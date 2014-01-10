$(function () {

    //入力日が変更された場合のイベント
    $("#_input_day_1i, #_input_day_2i")
      .change(function() { 
           	  //Index
           	   $.get(
				    '/d_duties',                 // 送信先
				    //2012/10/16 入力状況用パラメタ追加 nishimura
				    //{ input_day: String($("#_input_day_1i").val()) + ('00' + $("#_input_day_2i").val()).slice(-2) , m_shop_id: $("#head_input_m_shop_id").val(), remote: true},
				    { input_day: String($("#_input_day_1i").val()) + ('00' + $("#_input_day_2i").val()).slice(-2) , m_shop_id: $("#head_input_m_shop_id").val(), mode: $("#mode").val(), remote: true},
				    function(data, status) {        // 通信成功時にデータを表示
				       $('#form').empty();
		               $('#form').append(data);
		             },
				    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
		            );
    });
 

    //入力済みチェックボックスのイベント
    $(":input[id^=d_duty_input_flg_]")
	    .live('click', function(){
	    		var msg;
	    		var err_msg="";
	    		if ($(this).attr('checked') == "checked") {
	    			msg = "入力済みにします。よろしいですか？"
	    			
	    			//社員の入力が済んでいない場合はエラーにする
				    var Div_id = "";
				    if ($("div.bodyDiv").size() > 0) {
				    	Div_id = 'div.bodyDiv ';
				    };
				    var get_day = $(this).attr('id').replace("d_duty_input_flg_", "");
				    
				    $(Div_id + "[id^=hiden_syain_" + Number(get_day) + "_]").each(function(i){
			            if ($(this).val() == ""){
			            	err_msg = "社員の勤怠を入力してください。"; 
			            	return false;
			            };
			        })
			        if (err_msg != "") {
			        	alert(err_msg); 
			            return false;
			        };
			        
	    		}else{
	    			msg = "入力済みを解除します。よろしいですか？"
	    		};
	    		
	    		if(confirm(msg)){
	    			var get_day = $(this).attr('id').replace("d_duty_input_flg_", "");
	    			$.get(
		    			'/d_duties/input_check/',
		    			{ input_flg: $(this).attr('checked'), input_day: $("#head_input_day").val(), day: get_day, m_shop_id: $("#head_m_shop_id").val() }
		    		);
					//return true;
				}else{
					return false;	
				};
				
	    	}); 
           	
    //確定チェックボックスのイベント
    $(":input[id^=d_duty_kakutei_flg_]")
	    .live('click', function(){
	    		var msg;
	    		if ($(this).attr('checked') == "checked") {
	    			msg = "確定します。よろしいですか？"
	    		}else{
	    			msg = "確定を解除します。よろしいですか？"
	    		};
	    		
	    		if(confirm(msg)){
	    			var get_day = $(this).attr('id').replace("d_duty_kakutei_flg_", "");
	    			$.get(
		    			'/d_duties/kakutei_check/',
		    			{ kakutei_flg: $(this).attr('checked'), input_day: $("#head_input_day").val(), day: get_day, m_shop_id: $("#head_m_shop_id").val() }
		    		);
					//return true;
				}else{
					return false;	
				};
				
	    	}); 
	    	
	//バいトの日勤が変更されたら
	$("div#modal :input[id*=_day_work_time], div#modal :input[id*=_day_over_time], div#modal :input[id*=_night_work_time], div#modal :input[id*=_night_over_time]")
    .live('change', function(){
    	var get_index;
    	var total;
		var Div_id='';
		var num1;
		var num2;
		var num3;
		var num4;
		
	    if ($("div#modal div.bodyDiv").size() > 0) {
	    	Div_id = 'div.bodyDiv ';
	    };
	        	
	   	//合計をセット
	   	get_index = $(this).attr('id').replace("datas_", "");
	    get_index = get_index.replace("_day_work_time", "");
	    get_index = get_index.replace("_day_over_time", "");
	    get_index = get_index.replace("_night_work_time", "");
	    get_index = get_index.replace("_night_over_time", "");
	    
	    num1 = Number($("div#modal " + Div_id + "#datas_" + get_index + "_day_work_time").val());
        if (isNaN(num1)) {num1 = 0};
	    num2 = Number($("div#modal " + Div_id + "#datas_" + get_index + "_night_work_time").val());
        if (isNaN(num2)) {num2 = 0};
	    num3 = Number($("div#modal " + Div_id + "#datas_" + get_index + "_night_over_time").val());
        if (isNaN(num3)) {num3 = 0};
	    num4 = Number($("div#modal " + Div_id + "#datas_" + get_index + "_day_over_time").val());
        if (isNaN(num4)) {num4 = 0};

        
	    total = ((num1*100) + (num2*100) + (num3*100) + (num4*100)) / 100;
	    
	    $("div#modal " + Div_id + "#l_datas_" + get_index + "_all_work_time").text(total);
	    $("div#modal " + Div_id + "#datas_" + get_index + "_all_work_time").val(total);
	    
	    //合計を咲く計算
	    if ($(this).attr('id').match('_day_work_time')){calc_total("_day_work_time", "day_work_time_total")};
		if ($(this).attr('id').match('_day_over_time')){calc_total("_day_over_time", "day_over_time_total")};
		if ($(this).attr('id').match('_night_work_time')){calc_total("_night_work_time", "night_work_time_total")};
		if ($(this).attr('id').match('_night_over_time')){calc_total("_night_over_time", "night_over_time_total")};
		
		calc_total("_all_work_time", "all_work_time_total");
    });
    
    //バイトの手当て関係の数値が変更されたら合計を再計算
    $("div#modal :input[id*=_get_money1], div#modal :input[id*=_get_money2], div#modal :input[id*=_get_money3], div#modal :input[id*=_get_money4]")
    .live('change', function(){
		if ($(this).attr('id').match('_get_money1')){calc_total("_get_money1", "get_money1_total")};
		if ($(this).attr('id').match('_get_money2')){calc_total("_get_money2", "get_money2_total")};
		if ($(this).attr('id').match('_get_money3')){calc_total("_get_money3", "get_money3_total")};
		if ($(this).attr('id').match('_get_money4')){calc_total("_get_money4", "get_money4_total")};    	
    });
    
    //各社員の合計日数が変わったら、合計を再計算する
    $("div.colDiv #col_syain_nisu_kei")
      .live('click', function(){
	     //社員出金日数合計をセット
	     calc_syain_nisu_kei();   	
    });
    //各バイトの合計時間が変わったら、合計を再計算する
    $("div.colDiv #col_baito_jikan_kei")
      .live('click', function(){
	     //バイト時間合計をセット
	     calc_baito_jikan_kei();   	
    });
  
  //社員出金日数合計
  function calc_syain_nisu_kei() {
    
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
  function calc_baito_jikan_kei() {
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

//バイトの合計を計算する
function calc_total(taerget_id, total_id){
	var Div_id;
	var num;
	var total=0;
	
    if ($("div.bodyDiv").size() > 0) {
    	Div_id = 'div.bodyDiv ';
    };
    taerget_id = "div#modal " + Div_id + "[id*=" + taerget_id + "]";
    $(taerget_id).each(function(i){
    		//id名の先頭が'datas_'の分のみ
    		if ($(this).attr('id').substring(0,6) == 'datas_') {
	    		//num = Number($(this).text());
	    		num = Number(String($(this).text()).replace(/,/g, ""));
	    		//if ($(this).text() == '') {num = Number($(this).val());};
	    		if ($(this).text() == '') {num = Number(String($(this).val()).replace(/,/g, ""));};
	        	if (isNaN(num)) {num = 0};
	        	total = total + (num*10);
       		};
    });
    $("div#modal " + Div_id +  "#" + total_id).text(format_kanma(total/10));	
};
