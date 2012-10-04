(function () {

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
	
	// オーバライドする前のjQuery.ajaxを取得
	var org_ajax = jQuery.ajax;
	
	// jQuery.get をオーバライド
	jQuery.get = function(url,data,handler,dataType) {
		myAjax(url, data, "GET", handler, dataType); 	// handler(data, status)
	}	
	
	// jQuery.post をオーバライド
	jQuery.post = function(url,data,handler,dataType) {
		myAjax(url, data, "POST", handler, dataType);	// handler(data, status)
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
								fnc_complete(XMLHttpRequest, status);
							}
		}
		
		// ブラウザUI操作を禁止する
		blockUI(true);
		
		// jQuery.ajax を実行
		org_ajax(arg);
	}

	// $.get $.post call-ajax
	function myAjax(url, data, type, callback, dataType) {
	
		blockUI(true);
	
		// POSTの場合のみパラメータにCSRFトークン付加(for rails)
		if (type == "POST") {
			var token = jQuery("meta[name='csrf-token']").attr("content");
			switch (classOf(data)) {
				case "string": // jQuery("#form_id").serialize()
					if (data != "") { data += "&"; }
						data += ("authenticity_token=" + token);
				break;
		
				case "array": // jQuery("#form_id").serializeArray()
					data.push({ name: "authenticity_token", value: token});
				break;	
		
				case "hash": // { name1 : value1, name2 : value2 }
					data.authenticity_token = token;
				break;
			}
		}
	
		// ajax
		org_ajax({
				 url      : url
				,type     : type
				,data     : data
				,dataType : dataType
				,timeout  : 30000
				,success  : function(data, status, xhr) {
					callback(data, status);
				}
				,complete : function(XMLHttpRequest, status){
					blockUI(false);
					if (status != "success") {
						ajaxError(status);
						callback(null, status);
					}
				 }
		});	
	}

	// array,hashを区別するtypeof
	function classOf(obj){
		if((typeof obj)=="object"){
			if(obj.length!=undefined) {
				return "array";
			} else { 
				for(t in obj){
					if(obj[t]!=undefined) {
						return "hash";
					} else {
						return "object";
					}
				}
			}
		} else {
			return (typeof obj);
		}
	}	
	
})(jQuery);
