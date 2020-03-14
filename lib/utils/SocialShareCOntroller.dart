/*
 * Copyright 2019 mybytecode
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/services.dart';

class NativeShare {
  static const platform = const MethodChannel('com.mybytecode.Wp-Blog/share');

  Future<void> whatsApp(String title, String newsData, String link) async {
    String data =
        "*" + title + "*" + "\n\n" + newsData.substring(0, 130) + "\n\n" + link;
    try {
      await platform.invokeMethod('whatsapp', {"data": data});
    } on PlatformException catch (e) {}
  }

  Future<void> systemShare(String title, String newsData, String link) async {
    String data =
        "*" + title + "*" + "\n\n" + newsData.substring(0, 130) + "\n\n" + link;
    try {
      await platform.invokeMethod('system', {"data": data});
    } on PlatformException catch (e) {}
  }

  Future<void> twitterShare(String title, String newsData, String link) async {
    String data =
        "*" + title + "*" + "\n\n" + newsData.substring(0, 130) + "\n\n" + link;
    try {
      await platform.invokeMethod('twitter', {"data": data});
    } on PlatformException catch (e) {}
  }

  Future<void> facebookShare(String title, String newsData, String link) async {
    String data =
        "*" + title + "*" + "\n\n" + newsData.substring(0, 130) + "\n\n" + link;
    try {
      await platform.invokeMethod('facebook', {"data": data});
    } on PlatformException catch (e) {}
  }
}
