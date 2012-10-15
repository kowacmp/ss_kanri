$(function() { 
	setModal();
})
 
function setModal() {
 
	//HTML読み込み時にモーダルウィンドウの位置をセンターに調整
	adjustCenter("div#modal div.container");
 
	//ウィンドウリサイズ時にモーダルウィンドウの位置をセンターに調整
	$(window).resize(function() {
		adjustCenter("div#modal div.container");
	});
 
	//背景がクリックされた時にモーダルウィンドウを閉じる
	$("div#modal div.background").click(function() {
		displayModal(false);
	});
 
	//リンクがクリックされた時にAjaxでコンテンツを読み込む
	$("a.modal").live('click', function(){
		//$("div#modal div.container").load($(this).attr("href"), data="html", onComplete);
       $.ajax({url: $(this).attr("href"),
	    cache: false,
	    success: function(html) {
	    $("div#modal div.container").css("overflow", "hidden");
		$("div#modal div.container").html(html);
		onComplete();
	    }
        });
		return false;
	});
 
	//コンテンツの読み込み完了時にモーダルウィンドウを開く
	function onComplete() {
		displayModal(true);
		$("div#modal").css("z-index", "1000");
		$("div#modal div.container a.close").click(function() {
			displayModal(false);
			return false;
		});
	}
}
 
//モーダルウィンドウを開く
function displayModal(sign) {
	if (sign) {
		//UPDATE BEGIN 2012.10.11 モーダル展開時に初期フォーカスをセットする
		//$("div#modal").fadeIn(500);
		$("div#modal").fadeIn(500, firstFocus($("div#modal div.container")));
		//UPDATE END
	} else {
		$("div#modal").fadeOut(250);
		$("div#modal div.container").empty();
	}
}
 
//ウィンドウの位置をセンターに調整
function adjustCenter(target) {
	var margin_top = ($(window).height()-$(target).height())/2;
	var margin_left = ($(window).width()-$(target).width())/2;
	$(target).css({top:margin_top+"px", left:margin_left+"px"});
}

// フォーカスを先頭にセット (container: jQuery(#ID))
function firstFocus(container) { return function () {

	// コンテナ内の利用可能なオブジェクトを取得
	var obj = container.find(":enabled");
	if (obj.length == 0) { return true; } 

	// tabindexを持つものを取得
	var objtab = obj.filter("[tabindex]");
	
	if (objtab.length == 0) {
		// tabindexなし、最初に見つかったオブジェクトをフォーカス
		obj.filter(":first").focus();
	} else {
		// tabindex>0 && 一番若いtabindexを持つオブジェクトを取得
		var objFocus;
		objtab.each( function() {
			if (this.tabIndex > 0) { 
				if (objFocus == null) {
					objFocus = this;
				} else {
					if (Number(this.tabIndex) < Number(objFocus.tabIndex)) {
						objFocus = this;
					}
				}
			}
		});
		
		if (objFocus == null) {
			objtab.filter(":first").focus(); //all.tabIndex = 0
		} else {
			objFocus.focus();
		}
	}

	return true;
}}
