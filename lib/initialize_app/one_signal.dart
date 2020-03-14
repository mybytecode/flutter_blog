
import 'package:flutter_blog/constants/Constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class InitOneSignal
{
  void init()
  {
    OneSignal.shared.init(
        Config.gOneSignalAppId,
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  }
}