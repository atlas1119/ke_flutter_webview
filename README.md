# ke_flutter_webview
轻量级的webview插件，支持很多接口调用

## 支持情况
目前只支持 android ， ios后续更新

## 属性和方法
- initialUrl    传入的url
- initialHeaders  自定义headers
- initialOptions  自定义选项，后面是默认值
    - useShouldOverrideUrlLoading = true;
    - useOnLoadResource = false;
    - clearCache = false;
    - userAgent = "";
    - javaScriptEnabled = true;
    - javaScriptCanOpenWindowsAutomatically = false;
    - clearSessionCache = false;
    - builtInZoomControls = false;
    - supportZoom = true;
    - databaseEnabled = false;
    - domStorageEnabled = false;
    - useWideViewPort = true;
    - safeBrowsingEnabled = true;

- onWebViewCreated  view创建完后的callback
- onLoadStart       开始加载时的callback
- onLoadStop        结束加载时的callback
- onLoadError       加载错误时的callback
- onProgressChanged 进度变化时的callback
- shouldOverrideUrlLoading  
- onScrollChanged
- gestureRecognizers


## 更新日志
```
2019-03-12 v1.1
更加文档接口，修改一个bug

2019-03-10 v1.0
第一个版本发布，增加android的一些实用接口

```
