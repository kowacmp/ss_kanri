$(function () {

    //入力日が変更された場合のイベント
    $("#head_input_day")
      .change(function() { 
      	   //店舗種別があるときは、INDEXメソッドを実行、以外はNEWメソッドを実行、
           if ($("#head_from_view").val() == 'index'){
           	  //Index
           	   $.get(
				    '/d_sales',                 // 送信先
				    { input_day: $(this).val() , input_shop_kbn: $("#head_input_shop_kbn").val(), remote: true},
				    function(data, status) {        // 通信成功時にデータを表示
				       $('#result').empty();
		               $('#result').append(data);
		             },
				    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
		            );
           }else{
			   //New
		       $.get(
				    '/d_sales/new',                 // 送信先
				    { input_day: $(this).val() , m_shop_id: $("#m_shop_id").val(), remote: true},
				    function(data, status) {        // 通信成功時にデータを表示
				       $('#form_d_sale').empty();
		               $('#form_d_sale').append(data);
		             },
				    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
		            );
           };
           });
    //店舗種別が変更された場合のイベント
    $("#head_input_shop_kbn")
      .change(function() { 
	      	$.get(
			    '/d_sales',                 // 送信先
			    { input_day: $("#head_input_day").val() , input_shop_kbn: $(this).val(), remote: true},
			    function(data, status) {        // 通信成功時にデータを表示
			       $('#result').empty();
	               $('#result').append(data);
	             },
			    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
	            );
      	});
      	
    //全てロック／解除が変更された場合のイベント
    $("#all_lock")
	    .live('click', function(){
	    		var msg;
	    		if ($(this).attr('checked') == "checked") {
	    			msg = "すべてロックします。よろしいですか？"
	    		}else{
	    			msg = "すべて解除します。よろしいですか？"
	    		};
	    		
	    		if(confirm(msg)){
	    			$.get(
		    			'/d_sales/all_lock/',
		    			{ kakutei_flg: $(this).attr('checked'), input_day: $("#head_input_day").val(), input_shop_kbn: $("#head_input_shop_kbn").val() },
					    function(data, status) {        // 通信成功時にデータを表示
					       $('#result').empty();
			               $('#result').append(data);
			               
			             },
					    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
		    		);
					//return true;
				}else{
					return false;	
				};
				
	    	});
    
	//ロック／解除が変更された場合のイベント
	$(":checkbox[id^=data_kakutei_flg]")
	    .live('click', function(){
	    		$.get(
	    			'/d_sales/lock/',
	    			{ kakutei_flg: $(this).attr('checked'), id: $(this).parent().find(":hidden[id^=data_id]").val() },
	    			//function(data, status) {        // 通信成功時にデータを表示
	    			//alert($(this).parent().find(":hidden[id^=data_id]").val());
	    			//},
	    		    "script"
	    		);
	    	});
       
    //金額のカンマ編集
    $("input.money")
   		.live('focusout', function () { 
            $(this).val(format_kanma($(this).val()));
   		})
   		.live('focus', function () {
            $(this).val(format_kanma($(this).val(), 2)); 
            $(this).select();
  		});
  
    //値がかわったら再計算
    //売上１、売上２、売上３
    $(":input[id^=d_sale_sale_money]").live('change', function(){ sale_money_total_calc(); });
	//プリカ
	$('#d_sale_sale_purika').live('change', function(){ sale_purika_calc(); });
	//当日出
	$('#d_sale_sale_today_out').live('change', function(){ sale_today_out_calc(); });
	//翌日出前
    $('#d_sale_sale_am_out').live('change', function(){ sale_am_out_calc(); });
	//翌日出後
	$('#d_sale_sale_pm_out').live('change', function(){ sale_pm_out_calc(); });
	//釣銭機１、釣銭機２、釣銭機３
	$(":input[id^=d_sale_sale_change]").live('change', function(){ sale_change_total_calc(); });
	//ASS
	$("#d_sale_sale_ass").live('change', function(){ sale_ass_calc(); });
	//入金
	$("div.sData table#recive_table :input[id*=_item_money]").live('change', function(){ recive_money_total_calc(); });
	//出金
	$("div.sData table#pay_table :input[id*=_item_money]").live('change', function(){ pay_money_total_calc(); });
	
    //売上合計を計算
    function sale_money_total_calc(){
	 	var num1 = Number(format_kanma($("#d_sale_sale_money1").val(), 2));
  		var num2 = Number(format_kanma($("#d_sale_sale_money2").val(), 2));
  		var num3 = Number(format_kanma($("#d_sale_sale_money3").val(), 2));
  		var total;
  		
  		if (isNaN(num1)) {num1 = 0};
  		if (isNaN(num2)) {num2 = 0};
  		if (isNaN(num3)) {num3 = 0};
  		
  		total = num1 + num2 + num3;
  		
  		$("#sale_money_total").text(format_kanma(total));
  		$("#sale_money_total2").text(format_kanma(total));
  		
  		syo_total_calc();//小計計算
    };
    
    //プリカを計算
    function sale_purika_calc() {
    	var num1 = Number(format_kanma($("#d_sale_sale_purika").val(), 2));
    	var total;
    	
    	if (isNaN(num1)) {num1 = 0};
    	total = num1;
    	$("#sale_purika2").text(format_kanma(total));
    	
    	syo_total_calc();//小計計算
    };
    
    //当日出を計算
    function sale_today_out_calc() {
    	var num1 = Number(format_kanma($("#d_sale_sale_today_out").val(), 2));
    	var total;
    	
    	if (isNaN(num1)) {num1 = 0};
    	total = num1;
    	$("#sale_today_out2").text(format_kanma(total));
    	
    	tucyo_money_calc();//通帳預金額を計算
    	changebox_aridaka2_calc(); //釣銭有高2を計算
    	cash_aridaka_calc();//現金有高を計算
    };
    
    //翌日出前
    function sale_am_out_calc() {
    	var num1 = Number(format_kanma($("#d_sale_sale_am_out").val(), 2));
    	var total;
    	
    	if (isNaN(num1)) {num1 = 0};
    	total = num1;
    	$("#sale_am_out2").text(format_kanma(total));
    	
    	cash_aridaka_calc();//現金有高を計算
        tucyo_money_calc(); //通帳預金額

    };
    
    //翌日出後
    function sale_pm_out_calc() {
    	var num1 = Number(format_kanma($("#d_sale_sale_pm_out").val(), 2));
    	var total;
    	
    	if (isNaN(num1)) {num1 = 0};
    	total = num1;
    	$("#sale_pm_out2").text(format_kanma(total));
    	
    	cash_aridaka_calc();//現金有高を計算
    };
    
    //釣銭合計を計算
	function sale_change_total_calc() {
	 	var num1 = Number(format_kanma($("#d_sale_sale_change1").val(), 2));
  		var num2 = Number(format_kanma($("#d_sale_sale_change2").val(), 2));
  		var num3 = Number(format_kanma($("#d_sale_sale_change3").val(), 2));
  		var total;
  		
  		if (isNaN(num1)) {num1 = 0};
  		if (isNaN(num2)) {num2 = 0};
  		if (isNaN(num3)) {num3 = 0};
  		
  		total = num1 + num2 + num3;
  		
  		$("#sale_change_total").text(format_kanma(total));
  		
  		changebox_aridaka2_calc(); //釣銭有高2を計算
	};
    
    //ASSを計算
    function sale_ass_calc() {
    	var num1 = Number(format_kanma($("#d_sale_sale_ass").val(), 2));
    	var total;
    	
    	if (isNaN(num1)) {num1 = 0};
    	total = num1;
    	$("#sale_ass").text(format_kanma(total));
    	
    	total_calc();//合計を計算
    	tucyo_money_calc();//通帳預金額を計算
    	changebox_aridaka2_calc(); //釣銭有高2を計算
    };
    
    //出金合計を計算
    function pay_money_total_calc() {
		var i=0;
		var num;
		var total=0;
		
		$("div.sData table#pay_table :input[id*=_item_money]").each(function(i){
		    num = Number(format_kanma($(this).val(), 2));
		    if (isNaN(num)) {num = 0};
		    total = total + num;
		})

      	$("#d_sale_pay_money").val(format_kanma(total));    
      	$("#pay_money_total").text(format_kanma(total));
      	$("#pay_money_total2").text(format_kanma(total));  
      	
      	syo_total_calc();//小計計算	
    };
    
    //入金合計を計算
    function recive_money_total_calc() {
		var i=0;
		var num;
		var total=0;
		
		$("div.sData table#recive_table :input[id*=_item_money]").each(function(i){
		    num = Number(format_kanma($(this).val(), 2));
		    if (isNaN(num)) {num = 0};
		    total = total + num;
		})

      	$("#d_sale_recive_money").val(format_kanma(total));    
      	$("#recive_money_total").text(format_kanma(total));
      	$("#recive_money_total2").text(format_kanma(total)); 
      	
      	syo_total_calc();//小計計算 	
    };
    
    //小計を計算
    function syo_total_calc() {
    	//売上＋プリカ＋入金ー出金
    	var num = new Array(4);
    	var total=0;
    	
    	num[0]=Number(format_kanma($("#sale_money_total2").text(), 2));
    	num[1]=Number(format_kanma($("#sale_purika2").text(), 2));
    	num[2]=Number(format_kanma($("#recive_money_total2").text(), 2));
    	num[3]=Number(format_kanma($("#pay_money_total2").text(), 2));
    	
		var i=0;
      	while(i<4){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};
     	
		total = num[0] + num[1] + num[2] - num[3];
		
		$("#syo_total").text(format_kanma( total ));  	
		
		total_calc();//合計を計算
		changebox_aridaka2_calc(); //釣銭有高2を計算
    };
    
    //合計を計算
    function total_calc() {
    	//小計＋金庫＋釣銭機＋ASS
    	var num = new Array(4);
    	var total=0;
    	
    	num[0]=Number(format_kanma($("#syo_total").text(), 2));
    	num[1]=Number(format_kanma($("#zenjitu_cashbox").text(), 2));
    	num[2]=Number(format_kanma($("#zenjitu_change").text(), 2));
    	num[3]=Number(format_kanma($("#sale_ass").text(), 2));

		var i=0;
      	while(i<4){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};    	

		total = num[0] + num[1] + num[2] + num[3];
		
		$("#total").text(format_kanma( total ));  	

		kabusoku_calc(); //過不足を計算    	
    };
    
    
    //通帳預金額
    function tucyo_money_calc() {
    	//前日出＋当日出ーASS＋翌日出（前）
    	var num = new Array(4);
    	var total=0;

    	num[0]=Number(format_kanma($("#zenjitu_sale_pm_out").text(), 2));
    	num[1]=Number(format_kanma($("#sale_today_out2").text(), 2));
    	num[2]=Number(format_kanma($("#sale_ass").text(), 2));
		num[3]=Number(format_kanma($("#sale_am_out2").text(), 2));

		var i=0;
      	while(i<4){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};    	

		total = num[0] + num[1] - num[2] + num[3];
		
		$("#tucyo_money").text(format_kanma( total ));  	
    	
    };
    
    //釣銭有高2
    function changebox_aridaka2_calc() {
    	//前日出＋当日出＋釣銭合計ー小計ーASSー前日出
    	var num = new Array(6);
    	var total=0;

    	num[0]=Number(format_kanma($("#zenjitu_sale_pm_out").text(), 2));
    	num[1]=Number(format_kanma($("#sale_today_out2").text(), 2));
    	num[2]=Number(format_kanma($("#sale_change_total").text(), 2));
    	num[3]=Number(format_kanma($("#syo_total").text(), 2));
    	num[4]=Number(format_kanma($("#sale_ass").text(), 2));
    	num[5]=Number(format_kanma($("#zenjitu_sale_pm_out").text(), 2));

		var i=0;
      	while(i<6){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};    	
    	
    	total = num[0] + num[1] + num[2] - num[3] - num[4] - num[5];
    	
    	$("#changebox_aridaka2").text(format_kanma( total ));  
    	$("#d_sale_sale_changebox").val(total);
    	cash_aridaka_calc();//現金有高を計算
    };
    
    //現金有高
    function cash_aridaka_calc() {
    	//釣銭有高１＋釣銭有高２＋当日出＋翌日出前＋翌日出後
    	var num = new Array(5);
    	var total=0;

    	num[0]=Number(format_kanma($("#m_fix_money_total_cash_box2").text(), 2));
     	num[1]=Number(format_kanma($("#changebox_aridaka2").text(), 2));
     	num[2]=Number(format_kanma($("#sale_today_out2").text(), 2));
     	num[3]=Number(format_kanma($("#sale_am_out2").text(), 2));
     	num[4]=Number(format_kanma($("#sale_pm_out2").text(), 2));
     	
		var i=0;
      	while(i<5){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};    	
    	
    	total = num[0] + num[1] + num[2] + num[3] + num[4];
    	
    	$("#cash_aridaka").text(format_kanma( total )); 
    	
    	kabusoku_calc(); //過不足を計算    	
    };
    
    //過不足
    function kabusoku_calc() {
    	//現金有高ー合計
    	var num = new Array(2);
    	var total=0;

    	num[0]=Number(format_kanma($("#cash_aridaka").text(), 2));
     	num[1]=Number(format_kanma($("#total").text(), 2));

     	
		var i=0;
      	while(i<2){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};  
     	total = num[0] - num[1];
     	
     	$("#kabusoku").text(format_kanma( total ));  	
    };
    
    //カンマ編集
    //set…1:カンマ編集する（デフォルト）
    //     以外:カンマを消す
    function format_kanma(para_num, para_set) {
    
    	if (para_set == undefined) para_set = 1;

    	if (para_set == 1) {
			var num = new String(para_num).replace(/,/g, "");
            while(num != (num = num.replace(/^(-?\d+)(\d{3})/, "$1,$2")));
            return num; 
    	} else {
        	var num = new String(para_num).replace(/,/g, "");
            return num;
    	}
    	
    };
})();

