import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

import 'webview_controller.dart';

export 'webview_controller.dart';

typedef onWebViewCreatedCallback = void Function(WebViewController controller);
typedef onWebViewLoadStartCallback = void Function(WebViewController controller, String url);
typedef onWebViewLoadStopCallback = void Function(WebViewController controller, String url);
typedef onWebViewLoadErrorCallback = void Function(WebViewController controller, String url, int code, String message);
typedef onWebViewProgressChangedCallback = void Function(WebViewController controller, int progress);

typedef shouldOverrideUrlLoadingCallback = void Function(WebViewController controller, String url);
typedef onWebViewScrollChangedCallback = void Function(WebViewController controller, int x, int y);

class WebViewInitialData {
  String data;
  String mimeType;
  String encoding;
  String baseUrl;

  WebViewInitialData(this.data, {this.mimeType = "text/html", this.encoding = "utf8", this.baseUrl = "about:blank"});

  Map<String, String> toMap() {
    return {
      "data": data,
      "mimeType": mimeType,
      "encoding": encoding,
      "baseUrl": baseUrl
    };
  }
}

class KeFlutteWebView extends StatefulWidget{

  /// 
  final onWebViewCreatedCallback onWebViewCreated;

  /// 开始加载url时 Event
  final onWebViewLoadStartCallback onLoadStart;

  ///
  final onWebViewLoadStopCallback onLoadStop;

  ///
  final onWebViewLoadErrorCallback onLoadError;

  ///
  final onWebViewProgressChangedCallback onProgressChanged;

  ///
  ///
  final shouldOverrideUrlLoadingCallback shouldOverrideUrlLoading;

  /// 滚动时触发 
  final onWebViewScrollChangedCallback onScrollChanged;

  /// url
  final String initialUrl;
  ///
  final String initialFile;

  final WebViewInitialData initialData;
  ///
  final Map<String, String> initialHeaders;
  ///
  final Map<String, dynamic> initialOptions;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  const KeFlutteWebView({
    Key key,
    this.initialUrl = "about:blank",
    this.initialFile,
    this.initialData,
    this.initialHeaders = const {},
    this.initialOptions = const {},
    this.onWebViewCreated,
    this.onLoadStart,
    this.onLoadStop,
    this.onLoadError,
    this.onProgressChanged,
    this.shouldOverrideUrlLoading,
    this.onScrollChanged,
    this.gestureRecognizers,
  }) : super(key: key);

  @override
  _KeFlutteWebViewState createState() => _KeFlutteWebViewState();

}


class _KeFlutteWebViewState extends State<KeFlutteWebView> {

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return GestureDetector(
        onLongPress: () {},
        child: AndroidView(
          viewType: 'com.ke/flutter_webview',
          onPlatformViewCreated: _onPlatformViewCreated,
          gestureRecognizers: widget.gestureRecognizers,
          layoutDirection: TextDirection.rtl,
          creationParams: <String, dynamic>{
              'initialUrl': widget.initialUrl,
              'initialFile': widget.initialFile,
              'initialData': widget.initialData?.toMap(),
              'initialHeaders': widget.initialHeaders,
              'initialOptions': widget.initialOptions
            },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'com.ke/flutter_webview',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: <String, dynamic>{
          'initialUrl': widget.initialUrl,
          'initialFile': widget.initialFile,
          'initialData': widget.initialData?.toMap(),
          'initialHeaders': widget.initialHeaders,
          'initialOptions': widget.initialOptions
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text(
        '$defaultTargetPlatform is not yet supported by the webview plugin');
  }

  @override
  void didUpdateWidget(KeFlutteWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.webview_dispose();
      _controller = null;
    }
  }

  void _onPlatformViewCreated(int id) {
    _controller = WebViewController(id, widget);
    if (widget.onWebViewCreated != null) {
      widget.onWebViewCreated(_controller);
    }
  }

}


