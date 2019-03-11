package com.ke.webview.ke_flutter_webview;

import android.webkit.JavascriptInterface;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class JavaScriptBridgeInterface {
    private static final String LOG_TAG = "JSBridgeInterface";
    public static final String name = "flutter_inappbrowser";
    private FlutterWebView flutterWebView;

    public static final String flutterInAppBroserJSClass = "window." + name + ".callHandler = function(handlerName, ...args) {" +
            "window." + name + "._callHandler(handlerName, JSON.stringify(args));" +
            "}";

    public JavaScriptBridgeInterface(Object obj) {
        if (obj instanceof FlutterWebView)
            this.flutterWebView = (FlutterWebView) obj;
    }

    @JavascriptInterface
    public void _callHandler(String handlerName, String args) {
        Map<String, Object> obj = new HashMap<>();
        obj.put("handlerName", handlerName);
        obj.put("args", args);
        getChannel().invokeMethod("onCallJsHandler", obj);
    }

    private MethodChannel getChannel() {
        return flutterWebView.channel;
    }
}