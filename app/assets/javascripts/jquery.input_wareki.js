(function($){$.fn.input_wareki = function() {

	// 和暦変換テーブル
	var wareki_table = 
		[
		 {wareki : "明治", begin : "1868/09/08", end : "1912/07/29"},
		 {wareki : "大正", begin : "1912/07/30", end : "1926/12/24"},
		 {wareki : "昭和", begin : "1926/12/25", end : "1989/01/07"},
		 {wareki : "平成", begin : "1989/01/08", end : "2200/12/31"}
		];

	$(this).each( function (){
		// 西暦入力されている要素
		var input_s = $(this);
		
		// 和暦入力用の要素htmlを作成する
		var html = "";
			
		html += "<select>";
		for (var i = 0; i < wareki_table.length; i++) {
			var selected = (i == (wareki_table.length - 1) ? "selected='selected'" : "");
			html += "<option value='" + i + "' " + selected + ">" + wareki_table[i].wareki + "</option>";
		}
		html += "</select>&nbsp;";
		
		for (var i = 0; i < 3; i++) {
			html += "<input type='text' size='2' maxlength='2' style='text-align:right; ime-mode:disabled;'>" + 
				"年月日".substring(i,i+1) + "&nbsp;";
		}
		html += "<span style='color:red;'></span>";
		
		// 西暦の要素の後に和暦入力要素を追加し取得する
		input_s.after(html);
		var input_after = input_s.nextAll();
		var input_g   = $(input_after[0]);
		var input_e   = $(input_after[1]);
		var input_m   = $(input_after[2]);
		var input_d   = $(input_after[3]);
		var input_err = $(input_after[4]);
		input_s.css("display", "none")
		
		// 西暦年月日を和暦年月日に反映する
		var disp_wareki = function() {
			var ymd = input_s.val();
			if (ymd != "") {
				for (var i = 0; i < wareki_table.length; i++) {
					if (ymd >= wareki_table[i].begin && ymd <= wareki_table[i].end) {
						
						var ymds = ymd.split("/");
						
						var e = Number(ymds[0]) - Number(wareki_table[i].begin.split("/")[0]) + 1;
						e = ("0" + e).slice(-2);
						
						input_g.val(i);
						input_e.val(e);
						input_m.val(ymds[1]);
						input_d.val(ymds[2]);
					}
				}
			}
		}
		disp_wareki();
		
		// 和暦年,月,日は数値最大2桁まで受け付け
		var chk_number_emd = function (){
			if ($(this).val().match(/^\d{1,2}?$/)) {
				num = Number($(this).val());
				$(this).val(("0" + num).slice(-2));
			} else {
				$(this).val("");
			}
		}
	
		input_e.change(chk_number_emd);
		input_m.change(chk_number_emd);
		input_d.change(chk_number_emd);
		
		// 和暦年号,年,月,日の更新後に西暦変換を行う
		var change_wareki = function(){ 
			// 西暦及びエラーメッセージを初期化
			input_s.val("");
			input_err.html("");
		
			// e,m,dが全て未入力の場合は、日付入力なしとみなす
			if (input_e.val() == "" && input_m.val() == "" && input_d.val() == "") {
				return;
			}
			
			// e,m,dの一部のみが入力されている場合は、エラーを出す
			if (input_e.val() == "" || input_m.val() == "" || input_d.val() == "") {
				input_s.val("9999/99/99");
				input_err.html("日付を正しく入力してください。");
				return;
			}
		
			// 和暦入力を西暦年,月,日へ変換する。
			var vG = Number(input_g.val());
			var vYear  = Number(wareki_table[vG].begin.split("/")[0]) + Number(input_e.val()) - 1;
			var vMonth = Number(input_m.val());
			var vDay   = Number(input_d.val());
		
			// 西暦年,月,日の妥当性をチェックする。
			var vDt = new Date(vYear, vMonth -1, vDay);
			if(isNaN(vDt)){
				input_s.val("9999/99/99");
				input_err.html("日付を正しく入力してください。");
				return;
			}
			if(!(vDt.getFullYear() == vYear && vDt.getMonth() == (vMonth -1) && vDt.getDate() == vDay)){
				input_s.val("9999/99/99");
				input_err.html("日付を正しく入力してください。");
				return;
			}
			
			// yyyy/mm/dd を取得し西暦年月日をセット
			var ymd = vYear;
			ymd += "/" + ("0" + vMonth).slice(-2);
			ymd += "/" + ("0" + vDay).slice(-2);
			input_s.val(ymd);
		
			// 年号が範囲外の場合は補正する
			if (!(ymd >= wareki_table[vG].begin && ymd <= wareki_table[vG].end)) {
				disp_wareki();
			}
		
		}
		
		input_g.change(change_wareki);
		input_e.change(change_wareki);
		input_m.change(change_wareki);
		input_d.change(change_wareki);
		
	});
	
}})(jQuery);