$(function () {

		if ($("#m_approval_approval_id1").val() == "") {
      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
			$("#m_approval_approval_name1").val("");
			$("#m_approval_approval_name1").attr('readonly',true);
		}else{
			//承認者が選択された場合、承認者名を変更可能にする。
			$("#m_approval_approval_name1").attr('readonly',false);
		};

		if ($("#m_approval_approval_id2").val() == "") {
      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
			$("#m_approval_approval_name2").val("");
			$("#m_approval_approval_name2").attr('readonly',true);
		}else{
			//承認者が選択された場合、承認者名を変更可能にする。
			$("#m_approval_approval_name2").attr('readonly',false);
		};
		
		if ($("#m_approval_approval_id3").val() == "") {
      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
			$("#m_approval_approval_name3").val("");
			$("#m_approval_approval_name3").attr('readonly',true);
		}else{
			//承認者が選択された場合、承認者名を変更可能にする。
			$("#m_approval_approval_name3").attr('readonly',false);
		};
		
		if ($("#m_approval_approval_id4").val() == "") {
      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
			$("#m_approval_approval_name4").val("");
			$("#m_approval_approval_name4").attr('readonly',true);
		}else{
			//承認者が選択された場合、承認者名を変更可能にする。
			$("#m_approval_approval_name4").attr('readonly',false);
		};
		
		if ($("#m_approval_approval_id5").val() == "") {
      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
			$("#m_approval_approval_name5").val("");
			$("#m_approval_approval_name5").attr('readonly',true);
		}else{
			//承認者が選択された場合、承認者名を変更可能にする。
			$("#m_approval_approval_name5").attr('readonly',false);
		};


	    //承認者1が変更された場合のイベント
	    $("#m_approval_approval_id1")
	      .change(function() { 
	      	if ($("#m_approval_approval_id1").val() == "") {
	      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
				$("#m_approval_approval_name1").val("");
				$("#m_approval_approval_name1").attr('readonly',true);
			}else{
				//承認者が選択された場合、承認者名を変更可能にする。
				$("#m_approval_approval_name1").attr('readonly',false);
			};
	     });
	     
	     //承認者2が変更された場合のイベント
	    $("#m_approval_approval_id2")
	      .change(function() { 
	      	if ($("#m_approval_approval_id2").val() == "") {
	      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
				$("#m_approval_approval_name2").val("");
				$("#m_approval_approval_name2").attr('readonly',true);
			}else{
				//承認者が選択された場合、承認者名を変更可能にする。
				$("#m_approval_approval_name2").attr('readonly',false);
			};
	     });
	     
	     //承認者3が変更された場合のイベント
	    $("#m_approval_approval_id3")
	      .change(function() { 
	      	if ($("#m_approval_approval_id3").val() == "") {
	      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
				$("#m_approval_approval_name3").val("");
				$("#m_approval_approval_name3").attr('readonly',true);
			}else{
				//承認者が選択された場合、承認者名を変更可能にする。
				$("#m_approval_approval_name3").attr('readonly',false);
			};
	     });
	     
	     //承認者4が変更された場合のイベント
	    $("#m_approval_approval_id4")
	      .change(function() { 
	      	if ($("#m_approval_approval_id4").val() == "") {
	      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
				$("#m_approval_approval_name4").val("");
				$("#m_approval_approval_name4").attr('readonly',true);
			}else{
				//承認者が選択された場合、承認者名を変更可能にする。
				$("#m_approval_approval_name4").attr('readonly',false);
			};
	     });
	     
	     //承認者5が変更された場合のイベント
	    $("#m_approval_approval_id5")
	      .change(function() { 
	      	if ($("#m_approval_approval_id5").val() == "") {
	      		//承認者が未選択の場合、承認者名を空にして、変更不可にする。
				$("#m_approval_approval_name5").val("");
				$("#m_approval_approval_name5").attr('readonly',true);
			}else{
				//承認者が選択された場合、承認者名を変更可能にする。
				$("#m_approval_approval_name5").attr('readonly',false);
			};
	     });
	     
});