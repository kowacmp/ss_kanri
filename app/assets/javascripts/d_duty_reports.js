$(function () {
	
    //入力日が変更された場合のイベント 
    //出力する区分のラジオボタンが変更されたときのイベント
    //ユーザ表示区分のラジオボタンが変更されたときのイベント
    $("#_input_day_1i, #_input_day_2i, input[name='head_output_kbn']:radio, input[name='user_disp']:radio")
      .live('change', function(){
      			output_kbn_name = "input:radio[name='head_output_kbn']:checked";
				user_disp_name  = "input:radio[name='user_disp']:checked";
				
           	   //show
           	   $.get(
				    '/d_duty_reports/show',                 // 送信先
				    { input_day: String($("#_input_day_1i").val()) + ('00' + $("#_input_day_2i").val()).slice(-2) , 
				      head_input_m_shop_id: $("#head_input_m_shop_id").val(), 
				      head_output_kbn: $(output_kbn_name).val(), 
				      from_view:$("#head_from_view").val(), 
				      user_disp:$(user_disp_name).val(), 
				      remote: true},
				    function(data, status) {        // 通信成功時にデータを表示
				       $('#form').empty();
		               $('#form').append(data);
					   
					   calc_jinken_kei();//人件費合計を計算しセット
					   calc_y_sisu();//実績Y指数を求める
					   calc_win();//WIN金額を求める
					   calc_avg_y_sisu();//平均Y指数を求める
					   calc_pace();//人件費ペース、売上ペース、WINペース
		             },
				    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
		            );
    });	

		
   //人件費合計を計算しセット
  calc_jinken_kei();
  //実績Y指数を求める
  calc_y_sisu();
  //WIN金額を求める
  calc_win();
  //平均Y指数を求める
  calc_avg_y_sisu();
  //人件費ペース、売上ペース、WINペース
  calc_pace();
  
  //人件費合計合計
  function calc_jinken_kei() {
    
    var i=0;
    var num;
    var total=0;  

    var Div_id='';
  
    if ($("div.colDiv").size() > 0) {
      Div_id = 'div.colDiv ';
    };
    
    //累計
    $(Div_id + "[id^=syain_total_]").each(function(i){
        num = Number(format_kanma($(this).text(),2));
        if (isNaN(num)) {num = 0};
        total = total + num;
    })
    $(Div_id + "[id^=baito_total_]").each(function(i){
        num = Number(format_kanma($(this).text(),2));
        if (isNaN(num)) {num = 0};
        total = total + num;
    })    
    $(Div_id + "#col_jinken_kei").text(format_kanma(total));

    if ($("div.bodyDiv").size() > 0) {
      Div_id = 'div.bodyDiv ';
    };
    
    var i=1;
    //日繰り返し
    while(i<32){
      
      total=0;
      
      $(Div_id + "[id^=syain_all_money_" + Number(i) + "_]").each(function(i){
          num = Number(format_kanma($(this).text(),2));
          if ($(this).text() == '') {num = Number(format_kanma($(this).val(),2));};
          if (isNaN(num)) {num = 0};
          total = total + num;
      });
      
      $(Div_id + "[id^=baito_all_money_" + Number(i) + "_]").each(function(i){
          num = Number(format_kanma($(this).text(),2));
          if ($(this).text() == '') {num = Number(format_kanma($(this).val(),2));};
          if (isNaN(num)) {num = 0};
          total = total + num;
      });
           
      $(Div_id + "#col_jinken_kei_" + Number(i)).text(format_kanma(total));
      i=i+1;
    };
  
  };

  //実績Y指数を求める
  function calc_y_sisu() {
    var i=0;
    var num1;
    var num2;  
    var val;
    
    var Div_id='';

    if ($("div.bodyDiv").size() > 0) {
      Div_id = 'div.bodyDiv ';
    };
    
    var i=1;
    //日繰り返し
    while(i<32){
      
      val=0;
      num1 = Number(format_kanma($(Div_id + "#col_result_" + Number(i)).text(),2));
      num2 = Number(format_kanma($(Div_id + "#col_jinken_kei_" + Number(i)).text(),2));
      if (isNaN(num1)) {num1 = 0};
      if (isNaN(num2)) {num2 = 0};
      
      if (num2 == 0){
        val = 0;
      }else{
        val = Math.round(num1 / num2 * 1000)/10; //少数第一位まで表示
      };
      $(Div_id + "#col_y_sisu_" + Number(i)).text(format_kanma(val));      
  
      i=i+1;
    };    
  };
  
  //WIN金額を求める
  function calc_win() {
    var i=0;
    var num1;
    var num2;  
    var val;
    
    var Div_id='';
  
    if ($("div.colDiv").size() > 0) {
      Div_id = 'div.colDiv ';
    };
    
    //累計
    num1 = Number(format_kanma($(Div_id + "#col_result_kei").text(),2));
    num2 = Number(format_kanma($(Div_id + "#col_jinken_kei").text(),2));
    if (isNaN(num1)) {num1 = 0};
    if (isNaN(num2)) {num2 = 0};
    
    if (num2 == 0){
      val = 0;
    }else{
      val = num1 - num2;
    };
    $(Div_id + "#col_win_kei").text(format_kanma(val));

    if ($("div.bodyDiv").size() > 0) {
      Div_id = 'div.bodyDiv ';
    };
    
    var i=1;
    //日繰り返し
    while(i<32){
      
      val=0;
      num1 = Number(format_kanma($(Div_id + "#col_result_" + Number(i)).text(),2));
      num2 = Number(format_kanma($(Div_id + "#col_jinken_kei_" + Number(i)).text(),2));
      if (isNaN(num1)) {num1 = 0};
      if (isNaN(num2)) {num2 = 0};
      
      if (num2 == 0){
        val = 0;
      }else{
        val = num1 - num2;
      };
      $(Div_id + "#col_win_" + Number(i)).text(format_kanma(val));      
      
      
      
  
      i=i+1;
    };   
  };
  
  //平均Y指数を求める
  function calc_avg_y_sisu() {
    var i=0;
    var num1;
    var num2;
    var total1=0;
    var total2=0;
    var val;
    
    var Div_id='';

    if ($("div.bodyDiv").size() > 0) {
      Div_id = 'div.bodyDiv ';
    };
    
    var i=1;
    //日繰り返し
    while(i<32){
      
      val=0;
      num1 = Number(format_kanma($(Div_id + "#col_result_" + Number(i)).text(),2));
      num2 = Number(format_kanma($(Div_id + "#col_jinken_kei_" + Number(i)).text(),2));
      if (isNaN(num1)) {num1 = 0};
      if (isNaN(num2)) {num2 = 0};
      
      total1 = total1 + num1;
      total2 = total2 + num2;
      
      if (total2 == 0){
        val = 0;
      }else{
        val = Math.round(total1 / total2 * 1000)/10; //少数第一位まで表示
      };
      $(Div_id + "#col_avg_y_sisu_" + Number(i)).text(format_kanma(val));      
  
      i=i+1;
    };     
  };
  
  //人件費ペース、売上ペース、WINペース
  function calc_pace() {
  	var Div_id='';
    if ($("div.colDiv").size() > 0) {
      Div_id = 'div.colDiv ';
    };
    var total;
    var calc;
    var last_day = Number($("#last_day").val());
  	var day_cnt = Number($("#output_day_cnt").val());
  	
  	if (day_cnt == 0) {
    	$(Div_id + "#col_jinken_pace").text("");
		$(Div_id + "#col_result_pace").text("");
		$(Div_id + "#col_win_pace").text("");
  		return
  	};
  	//人件費ペース
    total = Number(format_kanma($(Div_id + "#col_jinken_kei").text(),2));
 	calc = Math.round((total / day_cnt) * last_day);
 	$(Div_id + "#col_jinken_pace").text(format_kanma(calc));
  	//売上ペース
  	total = Number(format_kanma($(Div_id + "#col_result_kei").text(),2));
 	calc = Math.round((total / day_cnt) * last_day);
 	$(Div_id + "#col_result_pace").text(format_kanma(calc));  	
  	//WINペース
  	total = Number(format_kanma($(Div_id + "#col_win_kei").text(),2));
 	calc = Math.round((total / day_cnt) * last_day);
 	$(Div_id + "#col_win_pace").text(format_kanma(calc));  	
  };
  
});