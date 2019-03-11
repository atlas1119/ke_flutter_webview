package com.ke.webview.ke_flutter_webview;

public class InAppWebViewOptions extends Options {

    static final String LOG_TAG = "InAppWebViewOptions";

    public boolean useShouldOverrideUrlLoading = true;
    public boolean useOnLoadResource = false;
    public boolean clearCache = false;
    public String userAgent = "";
    public boolean javaScriptEnabled = true;
    public boolean javaScriptCanOpenWindowsAutomatically = false;


    public boolean clearSessionCache = false;
    public boolean builtInZoomControls = false;
    public boolean supportZoom = true;
    public boolean databaseEnabled = false;
    public boolean domStorageEnabled = false;
    public boolean useWideViewPort = true;
    public boolean safeBrowsingEnabled = true;
}
