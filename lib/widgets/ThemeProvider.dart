import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/widgets/AppTheme.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData _themeData = LightTheme().light;
  double textSize=18;

  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData data)
  {
    _themeData = data;
    notifyListeners();
  }

  getTextSize()=>textSize;

  setTextSize(double size)
  {
    textSize = size;
  }
}
