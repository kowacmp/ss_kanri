//共通機能　金額カンマ対応
//input class="money"
$(function () {

    //保存の時に金額はカンマを消す
    $("form").submit(function() {
    	
         	//金額欄のカンマを消す
         	//Application.jsに移行
         	$("input.money").each(function(){
         		var num = new String($(this).val()).replace(/,/g, "");
           		$(this).val(num); 
         	});
         	
    });

    //カンマ編集して表示する
 	$("input.money").each(function(){
	    var num = new String($(this).val()).replace(/,/g, "");
	    while(num != (num = num.replace(/^(-?\d+)(\d{3})/, "$1,$2")));
	    $(this).val(num); 
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

});


//カンマ編集
//set…1:カンマ編集する（デフォルト）
//     以外:カンマを消す
function format_kanma(para_num, para_set) {
    
  	if (para_set == undefined) para_set = 1;
    
   	if (para_set == 1) {
		var num = new String(para_num).replace(/,/g, "");
		if (isNaN(num)) {
			num = "";
		} else {
			if (num != "") {
				num = Number(num);
				//num = Math.floor(num);	
				num = String(num);
			};
		};
           while(num != (num = num.replace(/^(-?\d+)(\d{3})/, "$1,$2")));
           return num; 
   	} else {
       	var num = new String(para_num).replace(/,/g, "");
        return num;
   	}
};
