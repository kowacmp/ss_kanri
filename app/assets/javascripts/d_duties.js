$(function () {
	
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
    });
      
  //各社員の合計日数が変わったら、合計を再計算する
  $("div.colDiv #col_syain_nisu_kei")
    .live('click', function(){
	   //社員出金日数合計をセット
	   cals_syain_nisu_kei();   	
    });

   
  //社員出金日数合計をセット
  cals_syain_nisu_kei();
  
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
  
});
