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

import 'package:flutter/material.dart';
import 'package:flutter_blog/widgets/Colors.dart';

class DefaultTheme {
  static MaterialColor primarySwatch = CustomColors().black;
  static const Color defaultColor = Colors.redAccent;

  static const Color secondaryColor = Colors.black;
  static const Color textColor = Colors.white;
  static const Color iconColor = Colors.blueGrey;
}

class DarkTheme {
  static TextStyle defaultTextStyle = TextStyle(color: Colors.white);
  ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      cardColor: Colors.black45,
      hintColor: Colors.black54,
      textTheme: TextTheme(
        title: defaultTextStyle,
        display1: defaultTextStyle,
        display2: defaultTextStyle,
        display3: defaultTextStyle,
        display4: defaultTextStyle,
        headline: defaultTextStyle,
        subtitle: defaultTextStyle,
        subhead: defaultTextStyle,
        caption: defaultTextStyle,
        body1: defaultTextStyle,
        button: defaultTextStyle,
        overline: defaultTextStyle,
      ),
      primaryTextTheme: TextTheme(
        title: defaultTextStyle,
        display1: defaultTextStyle,
        display2: defaultTextStyle,
        display3: defaultTextStyle,
        display4: defaultTextStyle,
        headline: defaultTextStyle,
        subtitle: defaultTextStyle,
        subhead: defaultTextStyle,
        caption: defaultTextStyle,
        body1: defaultTextStyle,
        button: defaultTextStyle,
        overline: defaultTextStyle,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      primarySwatch: DefaultTheme.primarySwatch,
      hoverColor: Colors.black45,
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.black12),
      scaffoldBackgroundColor: Colors.black54,
      bottomAppBarColor: Colors.black,
      backgroundColor: Colors.black12);
}

class LightTheme {
  ThemeData light = ThemeData(primaryColor: Colors.redAccent);
}
