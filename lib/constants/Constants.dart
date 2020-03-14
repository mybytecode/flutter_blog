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
class Config {
  static const String gAppName = "Flutter Blog";
  static const String gBaseUrl = "http://sportsfantasyindia.com";
  static const String gAuthorMail = "mybytecode.@gmail.com";
  static const String gFacebookPageUrl =
      "https://www.facebook.com/sportsfantasyindia";
  static const String gInstagramUrl =
      "https://instagram.com/sportsfantasyindia";
  static const String gAdmobAppIdAndroid =
      "ca-app-pub-5920920631626545******";
  static const String gBannerAdUnitId =
      "ca-app-pub-5920920631626545****************";
  static const String gBannerTestAds = "ca-app-pub-3940256099942544/6300978111";
  static const String gInterstitialAds =
      "ca-app-pub-592092063162*****";

  //facebook ads implementations
  static const String gFacebookBannerAd = "171891974026449_171894004026246";
  static const String gFacebookNativeBannerAd =
      "171891974026449_171909534024693";
  static const String gFacebookIntestitialAd =
      "171891974026449_17190853*****";
  static const String gFacebookNativeAd = "171891974026449_********";

  //Name the categories which will be displayed on tabBar
  static const List gCategoriesNamesTab = [
    "Home",
    "Cricket",
    "Football",
    "News"
  ];

  //Name of Tabs as you have added on wordpress and with the sequence of above list of tab names
  static const List gCategoriesId = ["", 2, 20, 21];

  static const gOneSignalAppId = "40c46587-61df-419c-8c*****";
}
