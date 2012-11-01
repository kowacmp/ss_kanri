$(function () {
    //確定チェックボックスのイベント(10日迄)
    $(":input[id^=d_duty_kakutei_10_flg_]")
	    .live('click', function(){
	    		var msg;
	    		if ($(this).attr('checked') == "checked") {
	    			msg = "確定します。よろしいですか？"
	    		}else{
	    			msg = "確定を解除します。よろしいですか？"
	    		};
	    		if(confirm(msg)){
	    			var get_shop_id = $(this).attr('id').replace("d_duty_kakutei_10_flg_", "");
	    			$.get(
		    			'/d_duty_lists/kakutei_check/',
		    			{ kakutei_flg: $(this).attr('checked'), input_day: $("#input_ym").val(), day1: 1, day2: 10, m_shop_id: get_shop_id }
		    		);
					//return true;
				}else{
					return false;	
				};
				
	    	}); 
    //確定チェックボックスのイベント(20日迄)
    $(":input[id^=d_duty_kakutei_20_flg_]")
	    .live('click', function(){
	    		var msg;
	    		if ($(this).attr('checked') == "checked") {
	    			msg = "確定します。よろしいですか？"
	    		}else{
	    			msg = "確定を解除します。よろしいですか？"
	    		};
	    		if(confirm(msg)){
	    			var get_shop_id = $(this).attr('id').replace("d_duty_kakutei_20_flg_", "");
	    			$.get(
		    			'/d_duty_lists/kakutei_check/',
		    			{ kakutei_flg: $(this).attr('checked'), input_day: $("#input_ym").val(), day1: 11, day2: 20, m_shop_id: get_shop_id }
		    		);
					//return true;
				}else{
					return false;	
				};
				
	    	}); 
    //確定チェックボックスのイベント(月末迄)
    $(":input[id^=d_duty_kakutei_30_flg_]")
	    .live('click', function(){
	    		var msg;
	    		if ($(this).attr('checked') == "checked") {
	    			msg = "確定します。よろしいですか？"
	    		}else{
	    			msg = "確定を解除します。よろしいですか？"
	    		};
	    		
	    		if(confirm(msg)){
	    			var get_shop_id = $(this).attr('id').replace("d_duty_kakutei_30_flg_", "");
	    			$.get(
		    			'/d_duty_lists/kakutei_check/',
		    			{ kakutei_flg: $(this).attr('checked'), input_day: $("#input_ym").val(), day1: 21, day2: 31, m_shop_id: get_shop_id }
		    		);
					//return true;
				}else{
					return false;	
				};
				
	    	}); 

    //確定チェックボックス（全て）のイベント
    $(":input[id^=all_lock_]")
	    .live('click', function(){
	    		var msg;
	    		if ($(this).attr('checked') == "checked") {
	    			msg = "確定します。よろしいですか？"
	    		}else{
	    			msg = "確定を解除します。よろしいですか？"
	    		};
	    		if(confirm(msg)){
	    			var get_val = $(this).attr('id').replace("all_lock_", "");
	    			switch(get_val)
	    				{case 10:
	    					var day1=1;
	    					var day2=10;
	    				 	break;
						 case 20:
	    					var day1=11;
	    					var day2=20;
	    				 	break;
						 default:
	    					var day1=21;
	    					var day2=31;
	    				}
	    			$.get(
		    			'/d_duty_lists/kakutei_check_all/',
		    			{  kakutei_flg : $(this).attr('checked')
		    			  ,input_day   : $("#input_ym").val()
		    			  ,day1        : day1
		    			  ,day2        : day2
		    			  ,shop_kbn    : $("#shop_kbn").val() 
		    			}
		    		);
					//return true;
				}else{
					return false;	
				};
	    	}); 

});
