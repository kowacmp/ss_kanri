// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//=# require_tree .
//= require jquery-ui
//= require modal
//= require jquery-ui-1.8.22.custom.min
//= require jquery.ui.datepicker.js
//= require jquery.ui.datepicker-ja
//= require ddsmoothmenu
//= require jquery.tablefix
//= require jquery.blockUI.js
//= require jquery.blockUIajax.js
//= require jquery.input_wareki.js

$(function(){
$('#prefecture_id').change(function(){
var pref_id = $("#prefecture_id").val();
$.get("city_select?pref_id=" + pref_id);
});

// EnterキーでSubmitされるのを禁止する
$('input[type!="submit"][type!="button"]').live("keypress",function(e){
  if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
    return false;
  }else{
    return true;
  }
});

// textareaのmaxlength属性を未対応ブラウザ(ie)でも有効にする
$("textarea[maxlength]").live("change", function() {
  var maxlength = Number($(this).attr("maxlength"));	
  if (!isNaN(maxlength)) {
    if ($(this).val().length > maxlength ) {
      $(this).val( $(this).val().substr(0, maxlength) );
    }
  }
});

});

//モーダルウィンドウ　STARTーーーーーーーーーーーーーーーーー
//$(function() {
//	setModal();
//})
// 
//function setModal() {
// 
//	//HTML読み込み時にモーダルウィンドウの位置をセンターに調整
//	adjustCenter("div#modal div.container");
// 
//	//ウィンドウリサイズ時にモーダルウィンドウの位置をセンターに調整
//	$(window).resize(function() {
//		adjustCenter("div#modal div.container");
//	});
// 
//	//背景がクリックされた時にモーダルウィンドウを閉じる
//	$("div#modal div.background").click(function() {
//		displayModal(false);
//	});
// 
//	//リンクがクリックされた時にAjaxでコンテンツを読み込む
//	$("a.modal").click(function() {
//		//$("div#modal div.container").load($(this).attr("href"), data="html", onComplete);
//       $.ajax({url: $(this).attr("href"),
//	    cache: false,
//	    success: function(html) {
//		$("div#modal div.container").html(html);
//		onComplete();
//	    }
//        });
//		return false;
//	});
// 
//	//コンテンツの読み込み完了時にモーダルウィンドウを開く
//	function onComplete() {
//		displayModal(true);
//		$("div#modal div.container a.close").click(function() {
//			displayModal(false);
//			return false;
//		});
//	}
//}
// 
////モーダルウィンドウを開く
//function displayModal(sign) {
//	if (sign) {
//		$("div#modal").fadeIn(500);
//	} else {
//		$("div#modal").fadeOut(250);
//	}
//}
// 
////ウィンドウの位置をセンターに調整
//function adjustCenter(target) {
//	var margin_top = ($(window).height()-$(target).height())/2;
//	var margin_left = ($(window).width()-$(target).width())/2;
//	$(target).css({top:margin_top+"px", left:margin_left+"px"});
//}

//モーダルウィンドウ　ENDーーーーーーーーーーーーーーーーーー
