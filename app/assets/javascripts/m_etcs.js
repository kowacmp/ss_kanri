$(function () {

	if ($("#m_etc_kansa_flg").val() == 1) {
  		//実績の場合、最大数に１を入力し変更不可にする。
		$("#m_etc_max_num").val(1);
		$("#m_etc_max_num").attr('readonly',true);
	}else{
		//監査の場合、最大数を変更可能にする。
		$("#m_etc_max_num").attr('readonly',false);
	};

    //監査フラグが変更された場合のイベント
    $("#m_etc_kansa_flg")
      .change(function() { 
      	
      	if ($("#m_etc_kansa_flg").val() == 1) {
      		//実績の場合、最大数に１を入力し変更不可にする。
			$("#m_etc_max_num").val(1);
			$("#m_etc_max_num").attr('readonly',true);
		}else{
			//監査の場合、最大数を変更可能にする。
			$("#m_etc_max_num").attr('readonly',false);
		};
      	
     });
	     
})();