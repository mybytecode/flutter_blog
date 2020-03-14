import 'dart:io';
//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_blog/constants/Constants.dart';
//import 'package:admob_flutter/admob_flutter.dart';


/*
//TODO - Un-comment admob all credentials and classes for enabling admob
@Author - Akshay Galande
@Date - 25 Jan 2020
@Reason -We have removed admob for V-2.4 as google has restricted the
ads serving so all the classes and methods of admob are commented
for optimizing app size
 */

class InitAdmob {
  init() {

    //Uncomment this when enable-ling google admob,also don't forget
    //to uncomment packages from pubspec.yaml
    // FirebaseAdMob.instance.initialize(appId: getAppId());
   // Admob.initialize(getAppId());
  }

  String getAppId() {
    if (Platform.isIOS) {
      return '';
    } else if (Platform.isAndroid) {
      return Config.gAdmobAppIdAndroid;
    }
    return null;
  }
}
