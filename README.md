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

### WebViewController方法说明
方法调用参考example
- getUrl()         获取当前url
- getTitle()       获取当前页面的title
- getProgress()    获取当前页面的进度0~100
- loadUrl(String url, {Map<String, String> headers = const {}})  加载url
- reload()         重新加载地址
- goBack()         后退
- canGoBack()      是否能够后退
- goForward()
- canGoForward()
- goBackOrForward(int step)  前进 或者 后退 到 哪一步
- canGoBackOrForward()
- isLoading()
- stopLoading()
- injectScriptCode(String code)
- injectScriptFile(String file)
- injectStyleCode(String code)
- setOptions(Map<String, dynamic> options)
- getOptions()


## 更新日志
```
2019-03-12 v1.0.2
增加controller方法说明

2019-03-12 v1.0.1
增加文档接口，修改一个bug

2019-03-10 v1.0.0
第一个版本发布，增加android的一些实用接口

```
