package com.ke.webview.ke_flutter_webview;

import android.app.Activity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** KeFlutterWebviewPlugin */
public class KeFlutterWebviewPlugin {

  public static Registrar registrar;
  public Activity activity;
  public static MethodChannel channel;

  protected static final String LOG_TAG = "IABFlutterPlugin";

  public KeFlutterWebviewPlugin(Registrar r, Activity activity) {
    registrar = r;
    this.activity = activity;
    channel = new MethodChannel(registrar.messenger(), "com.ke/flutter_webview");
  }


  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    Activity activity = registrar.activity();

//    final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.ke/flutter_webview");
//    channel.setMethodCallHandler(new KeFlutterWebviewPlugin(registrar, activity));

    registrar
            .platformViewRegistry()
            .registerViewFactory(
                    "com.ke/flutter_webview", new FlutterWebViewFactory(registrar, activity));

  }

}
