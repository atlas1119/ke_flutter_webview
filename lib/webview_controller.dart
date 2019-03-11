/// Controls an [WebView] widget instance.
///
/// @author  wangshaojun004@ke.com
/// 
///
/// 
import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'channel_manager.dart';
import 'ke_flutter_webview.dart';

class WebViewController {

  KeFlutteWebView _widget;
  MethodChannel _channel;
  Map<String, List<JavaScriptHandlerCallback>> javaScriptHandlersMap = HashMap<String, List<JavaScriptHandlerCallback>>();
  bool _isOpened = false;
  int _id;

  WebViewController(int id, KeFlutteWebView widget) {
    _id = id;
    _channel = MethodChannel('com.ke/flutter_webview_$id');
    _channel.setMethodCallHandler(_handleMethod);
    _widget = widget;
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch(call.method) {
      case "onLoadStart":
        String url = call.arguments["url"];
        if (_widget != null)
          _widget.onLoadStart(this, url);

        break;
      case "onLoadStop":
        String url = call.arguments["url"];
        if (_widget != null)
          _widget.onLoadStop(this, url);

        break;
      case "onLoadError":
        String url = call.arguments["url"];
        int code = call.arguments["code"];
        String message = call.arguments["message"];
        if (_widget != null)
          _widget.onLoadError(this, url, code, message);

        break;
      case "onProgressChanged":
        int progress = call.arguments["progress"];
        if (_widget != null)
          _widget.onProgressChanged(this, progress);
        break;
      case "shouldOverrideUrlLoading":
        String url = call.arguments["url"];
        if (_widget != null)
          _widget.shouldOverrideUrlLoading(this, url);
        break;

      case "onScrollChanged":
        int x = call.arguments["x"];
        int y = call.arguments["y"];
        if (_widget != null)
          _widget.onScrollChanged(this, x, y);
          
        break;
      case "onCallJsHandler":
        String handlerName = call.arguments["handlerName"];
        List<dynamic> args = jsonDecode(call.arguments["args"]);
        if (javaScriptHandlersMap.containsKey(handlerName)) {
          for (var handler in javaScriptHandlersMap[handlerName]) {
            handler(args);
          }
        }
        break;
      default:
        throw UnimplementedError("Unimplemented ${call.method} method");
    }
  }

  /// 获取当前url
  Future<String> getUrl() async {
    Map<String, dynamic> args = <String, dynamic>{};

    return await _channel.invokeMethod('getUrl', args);
  }

  /// 获取当前title
  Future<String> getTitle() async {
    Map<String, dynamic> args = <String, dynamic>{};

    return await _channel.invokeMethod('getTitle', args);
  }

  /// 当前页的进度 0~100
  Future<int> getProgress() async {
    Map<String, dynamic> args = <String, dynamic>{};

    return await _channel.invokeMethod('getProgress', args);
  }

  /// 加载页面
  Future<void> loadUrl(String url, {Map<String, String> headers = const {}}) async {
    assert(url != null && url.isNotEmpty);
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('url', () => url);
    args.putIfAbsent('headers', () => headers);
    await _channel.invokeMethod('loadUrl', args);
  }

  /// post url
  Future<void> postUrl(String url, Uint8List postData) async {
    assert(url != null && url.isNotEmpty);
    assert(postData != null);
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('url', () => url);
    args.putIfAbsent('postData', () => postData);
    await _channel.invokeMethod('postUrl', args);
  }

  /// 加载数据
  Future<void> loadData(String data, {String mimeType = "text/html", String encoding = "utf8", String baseUrl = "about:blank"}) async {
    assert(data != null);
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('data', () => data);
    args.putIfAbsent('mimeType', () => mimeType);
    args.putIfAbsent('encoding', () => encoding);
    args.putIfAbsent('baseUrl', () => baseUrl);
    await _channel.invokeMethod('loadData', args);
  }

  /// reload
  Future<void> reload() async {
    Map<String, dynamic> args = <String, dynamic>{};

    await _channel.invokeMethod('reload', args);
  }

  /// 后退
  Future<void> goBack() async {
    Map<String, dynamic> args = <String, dynamic>{};

    await _channel.invokeMethod('goBack', args);
  }

  /// 是否可以后退
  Future<bool> canGoBack() async {
    Map<String, dynamic> args = <String, dynamic>{};

    return await _channel.invokeMethod('canGoBack', args);
  }

  /// 前进
  Future<void> goForward() async {
    Map<String, dynamic> args = <String, dynamic>{};

    await _channel.invokeMethod('goForward', args);
  }

  /// 是否可以前进
  Future<bool> canGoForward() async {
    Map<String, dynamic> args = <String, dynamic>{};

    return await _channel.invokeMethod('canGoForward', args);
  }

  /// 前进 或者 后退 到 哪一步
  Future<void> goBackOrForward(int steps) async {
    assert(steps != null);

    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('steps', () => steps);
    await _channel.invokeMethod('goBackOrForward', args);
  }

  ///
  Future<bool> canGoBackOrForward(int steps) async {
    assert(steps != null);

    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('steps', () => steps);
    return await _channel.invokeMethod('canGoBackOrForward', args);
  }


  /// 是否在加载中
  Future<bool> isLoading() async {
    Map<String, dynamic> args = <String, dynamic>{};

    return await _channel.invokeMethod('isLoading', args);
  }

  /// 停止加载
  Future<void> stopLoading() async {
    Map<String, dynamic> args = <String, dynamic>{};

    await _channel.invokeMethod('stopLoading', args);
  }

  /// 注入 js代码
  Future<String> injectScriptCode(String source) async {
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('source', () => source);
    return await _channel.invokeMethod('injectScriptCode', args);
  }

  /// 注入js文件
  Future<void> injectScriptFile(String urlFile) async {
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('urlFile', () => urlFile);
    await _channel.invokeMethod('injectScriptFile', args);
  }

  /// 注入 css
  Future<void> injectStyleCode(String source) async {
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('source', () => source);
    await _channel.invokeMethod('injectStyleCode', args);
  }

  ///注入css文件
  Future<void> injectStyleFile(String urlFile) async {
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('urlFile', () => urlFile);
    await _channel.invokeMethod('injectStyleFile', args);
  }

  ///Adds/Appends a JavaScript message handler [callback] ([JavaScriptHandlerCallback]) that listen to post messages sent from JavaScript by the handler with name [handlerName].
  ///Returns the position `index` of the handler that can be used to remove it with the [removeJavaScriptHandler()] method.
  ///
  ///The Android implementation uses [addJavascriptInterface](https://developer.android.com/reference/android/webkit/WebView#addJavascriptInterface(java.lang.Object,%20java.lang.String)).
  ///The iOS implementation uses [addScriptMessageHandler](https://developer.apple.com/documentation/webkit/wkusercontentcontroller/1537172-addscriptmessagehandler?language=objc)
  ///
  ///The JavaScript function that can be used to call the handler is `window.flutter_inappbrowser.callHandler(handlerName <String>, ...args);`, where `args` are [rest parameters](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters).
  ///The `args` will be stringified automatically using `JSON.stringify(args)` method and then they will be decoded on the Dart side.
  int addJavaScriptHandler(String handlerName, JavaScriptHandlerCallback callback) {
    this.javaScriptHandlersMap.putIfAbsent(handlerName, () => List<JavaScriptHandlerCallback>());
    this.javaScriptHandlersMap[handlerName].add(callback);
    return this.javaScriptHandlersMap[handlerName].indexOf(callback);
  }

  ///Removes a JavaScript message handler previously added with the [addJavaScriptHandler()] method in the [handlerName] list by its position [index].
  ///Returns `true` if the callback is removed, otherwise `false`.
  bool removeJavaScriptHandler(String handlerName, int index) {
    try {
      this.javaScriptHandlersMap[handlerName].removeAt(index);
      return true;
    }
    on RangeError catch(e) {
      print(e);
    }
    return false;
  }

  ///Takes a screenshot (in PNG format) of the WebView's visible viewport and returns a `Uint8List`. Returns `null` if it wasn't be able to take it.
  ///
  ///**NOTE for iOS**: available from iOS 11.0+.
  Future<Uint8List> takeScreenshot() async {
    Map<String, dynamic> args = <String, dynamic>{};

    return await _channel.invokeMethod('takeScreenshot', args);
  }

  ///Sets the [WebView] options with the new [options] and evaluates them.
  Future<void> setOptions(Map<String, dynamic> options) async {
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('options', () => options);
    args.putIfAbsent('optionsType', () => "InAppBrowserOptions");
    await _channel.invokeMethod('setOptions', args);
  }

  ///
  Future<Map<String, dynamic>> getOptions() async {
    Map<String, dynamic> args = <String, dynamic>{};

    args.putIfAbsent('optionsType', () => "InAppBrowserOptions");
    Map<dynamic, dynamic> options = await ChannelManager.channel.invokeMethod('getOptions', args);
    options = options.cast<String, dynamic>();
    return options;
  }

  Future<void> webview_dispose() async {
    await _channel.invokeMethod('dispose');
  }

}