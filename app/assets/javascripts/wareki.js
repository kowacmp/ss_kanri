//共通機能:和暦入力プラグイン
// id :『yyyy/mm/dd』形式のテキストボックスのid
//      ※未入力の場合は空文字列が設定されます。
//      ※不正な日付が入力された場合は9999/99/99が設定されます。
function wareki_input(id) {
	
	// 和暦変換テーブル
	var wareki_table = 
		[
		 {wareki : "明治", begin : "1868/09/08", end : "1912/07/29"},
		 {wareki : "大正", begin : "1912/07/30", end : "1926/12/24"},
		 {wareki : "昭和", begin : "1926/12/25", end : "1989/01/07"},
		 {wareki : "平成", begin : "1989/01/08", end : "2200/12/31"} //最後のendはありえない程の未来日を指定してください。
		];
	
	// 既に和暦入力が開始されている場合は処理しない
	if ($("#" + id).css("display") == "none") {
		return; 
	}
	
	// 和暦入力用のコントロールの名前を設定する
	var cmb_g   = id + "_wareki_g";
	var txt_e   = id + "_wareki_e";
	var txt_m   = id + "_wareki_m";
	var txt_d   = id + "_wareki_d";
	var spn_err = id + "_wareki_err";
	
	// 和暦入力用のhtmlを作成する
	var html = "";
	
	html += "<select id='" + cmb_g + "'>";
	for (var i = 0; i < wareki_table.length; i++) {
		html += "<option value='" + i + "'>" + wareki_table[i].wareki + "</option>";
	}
	html += "</select>&nbsp;";
	
	html += "<input type='text' id='" + txt_e + "' size='2' style='text-align:right; ime-mode:disabled;'>年&nbsp;";
	
	html += "<input type='text' id='" + txt_m + "' size='2' style='text-align:right; ime-mode:disabled;'>月&nbsp;";
	
	html += "<input type='text' id='" + txt_d + "' size='2' style='text-align:right; ime-mode:disabled;'>日&nbsp;";
	
	html += "<span id='" + spn_err + "'style='color:red;'></span>";
	
	// 西暦のテキストボックスを隠す
	$("#" + id).css({display: "none"});
		
	// 西暦のテキストボックスの後に和暦入力欄を追加する
	$("#" + id).after(html);

	var input_s   = $("#" + id);
	var input_g   = $("#" + cmb_g);
	var input_e   = $("#" + txt_e);
	var input_m   = $("#" + txt_m);
	var input_d   = $("#" + txt_d);
	var input_err = $("#" + spn_err);

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
	
	// 和暦年,月,日は数値２桁のみ受け付けする
	var chk_number_emd = function (){
		if ($(this).val() == "" || isNaN($(this).val())) {
			$(this).val("");
			return;
		}
		
		num = Number($(this).val());
		if (num > 0 && num < 100) {
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
	
}