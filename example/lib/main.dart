import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:ke_flutter_webview/ke_flutter_webview.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("测试111"),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text("测试webvie1111w"),
          ),
          
          Expanded(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: KeFlutteWebView(
            initialUrl: "https://www.baidu.com/",
            initialHeaders: {},
            initialOptions: {},
            onWebViewCreated: (WebViewController controller) {
              webView = controller;
            },
            onLoadStart: (WebViewController controller, String url) {
              print("started $url");
              setState(() {
                this.url = url;
              });
            },
            onProgressChanged:
                (WebViewController controller, int progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
          ),
        ),
      ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  if (webView != null) {
                    webView.goBack();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (webView != null) {
                    webView.goForward();
                  }
                },
              ),
              RaisedButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  if (webView != null) {
                    webView.reload();
                  }
                },
              ),
            ],
          ),
      ]),
    ),)
    
  );}
}
