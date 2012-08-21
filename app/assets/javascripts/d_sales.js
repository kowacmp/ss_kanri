$(function () {

    //入力日が変更された場合のイベント
    $("#head_input_day")
      .change(function() { 
           $.get(
			    '/d_sales',                 // 送信先
			    { input_day: $(this).val() , remote: true},
			    function(data, status) {        // 通信成功時にデータを表示
			       //$('#result').html(data);
			       $('#form_d_sale').empty();
                   $('#form_d_sale').append(data);
                   alert(data);
			    },
			    "html"                          // 応答データ形式 xml, html, script, json, jsonp, text
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
    	
    	yokujitu_out_calc();//翌日出を計算
    	tucyo_money_calc();//通帳預金額を計算
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
	};
    
    //ASSを計算
    function sale_ass_calc() {
    	var num1 = Number(format_kanma($("#d_sale_sale_ass").val(), 2));
    	var total;
    	
    	if (isNaN(num1)) {num1 = 0};
    	total = num1;
    	$("#sale_ass").text(format_kanma(total));
    	
    	total_calc();//合計を計算
    	yokujitu_out_calc();//翌日出を計算
    	tucyo_money_calc();//通帳預金額を計算
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
		yokujitu_out_calc();//翌日出を計算
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

    };
    
    //翌日出を計算
    function yokujitu_out_calc() {
    	//小計ー当日出＋ASS
    	var num = new Array(3);
    	var total=0;

    	num[0]=Number(format_kanma($("#syo_total").text(), 2));
    	num[1]=Number(format_kanma($("#sale_today_out2").text(), 2));
    	num[2]=Number(format_kanma($("#sale_ass").text(), 2));

		var i=0;
      	while(i<3){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};    	

		total = num[0] - num[1] + num[2];
		
		$("#yokujitu_out").text(format_kanma( total ));  	
    	
    };
    
    //通帳預金額
    function tucyo_money_calc() {
    	//前日出＋当日出ーASS
    	var num = new Array(3);
    	var total=0;

    	num[0]=Number(format_kanma($("#zenjitu_today_out").text(), 2));
    	num[1]=Number(format_kanma($("#sale_today_out2").text(), 2));
    	num[2]=Number(format_kanma($("#sale_ass").text(), 2));

		var i=0;
      	while(i<3){
        	if (isNaN(num[i])) {num[i] = 0};
        	i=i+1;
     	};    	

		total = num[0] + num[1] - num[2];
		
		$("#tucyo_money").text(format_kanma( total ));  	
    	
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

