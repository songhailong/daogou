(function () {
  window.AppURLScheme = "webapp";//url types中一定要有这个配置

  function ParseParam(obj) {
    var params = [];
    for (var p in obj) {
      if (typeof (obj[p]) == "undefined" || obj[p] == "undefined") {
        obj[p] = "";
      }
      params.push(p + "=" + encodeURIComponent(obj[p]));
    }
    params = params.join('&');
    return params;
  }

  function openPath(path, params) {
    var fullPath = AppURLScheme + "://" + path + "?" + ParseParam(params);
    _createQueueReadyIframe(document, fullPath);
  }

  function _createQueueReadyIframe(doc, src) {
    messagingIframe = doc.createElement('iframe')
    messagingIframe.style.display = 'none'
    messagingIframe.src = src; //CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE
    doc.documentElement.appendChild(messagingIframe);
    doc.documentElement.removeChild(messagingIframe);
  }
 
  function prepareWebViewJavascriptBridge(callback) {
 
    if (window.WebViewJavascriptBridge) {

      return callback(WebViewJavascriptBridge);
    }
    if (window.WVJBCallbacks) {
      return window.WVJBCallbacks.push(callback);
    }

    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function () {
      document.documentElement.removeChild(WVJBIframe)
    }, 0)
  }
 
  if (window.goods) {
    return;
  };
  // 如果不支持WebViewJavascriptBridge 则使用老的方式
  window.GoodsBridge = {
    callHandler: function (handlerName, data, responseCallback) {
      prepareWebViewJavascriptBridge(function () { });

      if (window.WebViewJavascriptBridge) {
        var parameters = data;
        if (typeof (data) === "string") {
          parameters = JSON.parse(data);
        }
        if (responseCallback) {
          window.WebViewJavascriptBridge.callHandler(handlerName, parameters, responseCallback);
        } else {
          window.WebViewJavascriptBridge.callHandler(handlerName, parameters, function (result) {
            var callback = parameters["callback"];
            if (callback) {
              eval(callback)(result);
            }
          });
        }
      } else {
        openPath(handlerName, data);
      }
    }
  };

  window.goods = {
    ready: function (callback) {
      prepareWebViewJavascriptBridge(callback);
    },
    common:function(action,params,callback){
        if(params==null||params==undefined){
            params={};
        }
        var plugin={};
        plugin[action]=function (action,params,responseCallback) {GoodsBridge.callHandler(action, params, responseCallback);}
        goods.installPlugin(plugin);
        goods.ready(function(){
            goods[action](action,params,callback);
        });
    },
    goback: function (params,responseCallback) {
        GoodsBridge.callHandler('goback', params, responseCallback)
    },
    openurl: function (params,responseCallback) {
        GoodsBridge.callHandler('web', params, responseCallback);
    },
    close: function (params,responseCallback) {
      GoodsBridge.callHandler('close', params, responseCallback)
    },
    copy: function (params,responseCallback) {
        GoodsBridge.callHandler('copy', params, responseCallback);
    },
    openPage: function (params,responseCallback) {
        GoodsBridge.callHandler("page", params, responseCallback);
    },
    showNotify: function (params) {
      GoodsBridge.callHandler('showNotify', params, null);
    },
    canOpenURL: function (params, responseCallback) {
      GoodsBridge.callHandler('canOpenURL', params, responseCallback)
    },
    tocken: function (params, responseCallback) {
    GoodsBridge.callHandler('tocken', params, responseCallback)
    },
    orderDetail: function (params, responseCallback) {
    GoodsBridge.callHandler('orderDetail', params, responseCallback)
    },
    installPlugin: function (plugin) {
    for (var item in plugin) {
        goods[item] = plugin[item];
      }
    }
  };
 

 window.JavaJs={
    cheOrderSuccess:function(){
        goods.common("cheOrderSuccess",null,null);
    },
    cheOrderSuccess3:function(showMenu,jsonExtra){
        goods.common("cheOrderSuccess3",{"showMenu":showMenu,"jsonExtra":jsonExtra},null);
    },
    onCallPhone:function(param){
        goods.common("onCallPhone",param,null);
    },
    shareObj:function(param){
        goods.common("share",param,null);
    },
    back:function(){
        goods.close({},null);
    }
 

 };
 
 
 window.CarStatus={
    onBackActivity:function(){
        goods.common("onBackActivity",null,null);
    }
 }
 
 
} ());
 
 (function () {
  var ev = document.createEvent("Event");
  ev.initEvent("goodsReady", true, true);
  document.dispatchEvent(ev);
  } ());
 
 
 
 
