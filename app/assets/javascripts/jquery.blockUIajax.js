(function () {

	// オーバライドする前のjQuery.ajaxを取得
	var org_ajax = jQuery.ajax;

	// jQuery.get をオーバライド
	jQuery.get = function(url,data,handler,dataType) { 

		// ブラウザUI操作を禁止する
		blockUI(true);
		
		// jQuery.ajax を実行
		org_ajax({
					 url      : url
					,type     : "get"
					,data     : data
					,dataType : dataType
					,timeout  : 60000
					,success  : function(data, status, xhr) {
						if ((typeof handler) === "function") {
							handler(data, status);
						}
					 }
					,complete : function(XMLHttpRequest, status){
						blockUI(false);
						if (status != "success") {
							ajaxError(status);
							if ((typeof handler) === "function") {
								handler(null, status);
							}
						}
					 }
				});	
	}

	// jQuery.post をオーバライド
	jQuery.post = function(url,data,handler,dataType) {

		// ブラウザUI操作を禁止する
		blockUI(true);
		
		// jQuery.ajax を実行
		org_ajax({
					 url      : url
					,type     : "post"
					,data     : data
					,dataType : dataType
					,timeout  : 60000
					,success  : function(data, status, xhr) {
						if ((typeof handler) === "function") {
							handler(data, status);
						}
					 }
					,complete : function(XMLHttpRequest, status){
						blockUI(false);
						if (status != "success") {
							ajaxError(status);
							if ((typeof handler) === "function") {
								handler(null, status);
							}
						}
					 }
				});	
	}

	// jQuery.ajax をオーバライド
	jQuery.ajax = function(arg) {
	
		// async = false (同期通信) の場合はBlockUIを適用しない
		if ((!(arg.async == null)) && (arg.async == false)) {
			org_ajax(arg);
			return;
		}
	
		// 引数に含まれるコールバック関数のcompleteにunblockUI()、及び失敗時にアラートを追加する。
		var fnc_complete = arg.complete;
		if (fnc_complete == null) {
			// コールバックcompleteなし
			arg.complete =  function(XMLHttpRequest, status){
								blockUI(false);
								if (status != "success") {
									ajaxError(status);
								}
							}
		} else {
			// コールバックのcomplete有
			arg.complete =  function(XMLHttpRequest, status){
								blockUI(false);
								if (status != "success") {
									ajaxError(status);
								}
								if ((typeof fnc_complete) === "function") {
									fnc_complete(XMLHttpRequest, status);
								}
							}
		}
		
		// ブラウザUI操作を禁止する
		blockUI(true);
		
		// jQuery.ajax を実行
		org_ajax(arg);
	}

// private

	// BlockUI(true/false)
	function blockUI(flg){
		if (flg) {
			jQuery.blockUI({
				// Rails : view/layouts/application.html.erb
				 message: "<div>" + jQuery("div#blockUIajax").html() + "</div>" 
				,css: {
					padding: "25px"
				}
			});				
		} else {
			jQuery.unblockUI();
		}	
	}
	
	// onAjaxError
	function ajaxError(status) {
		// status : error,timeout,etc‥
		alert("AJAX通信に失敗しました(status=" + status + ")");
	}
	
})(jQuery);
