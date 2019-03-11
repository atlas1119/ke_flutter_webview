/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * @author  wangshaojun004@ke.com
 *
*/

import 'dart:async';
import 'dart:collection';

import 'package:flutter/services.dart';

typedef Future<dynamic> ListenerCallback(MethodCall call);
typedef Future<void> JavaScriptHandlerCallback(List<dynamic> arguments);

class ChannelManager {
  static const MethodChannel channel = const MethodChannel('com.ke/flutter_webview');
  static bool initialized = false;
  static final listeners = HashMap<String, ListenerCallback>();

  static Future<dynamic> _handleMethod(MethodCall call) async {
    String uuid = call.arguments["uuid"];
    return await listeners[uuid](call);
  }

  static void addListener(String key, ListenerCallback callback) {
    if (!initialized)
      init();
    listeners.putIfAbsent(key, () => callback);
  }

  static void init () {
    channel.setMethodCallHandler(_handleMethod);
    initialized = true;
  }
}