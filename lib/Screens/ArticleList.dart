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

//import 'package:admob_flutter/admob_flutter.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/Models/NewsModesl.dart';
import 'package:flutter_blog/Screens/DisplayArticle.dart';
import 'package:flutter_blog/constants/Constants.dart';
import 'package:flutter_blog/future/ArticleByCategoryId.dart';
import 'package:flutter_blog/utils/CheckInternetConnection.dart';
import 'package:flutter_blog/utils/ImageLoader.dart';
import 'package:flutter_blog/utils/Utils.dart';
import 'package:flutter_blog/widgets/ArticleListPreLoader.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// ignore: must_be_immutable
class NewsLoader extends StatefulWidget {
  var categoryName;

  NewsLoader(this.categoryName);

  @override
  State<StatefulWidget> createState() => NewsList(categoryName);
}

class NewsList extends State<NewsLoader>
    with AutomaticKeepAliveClientMixin<NewsLoader> {
  var categoryName;
  bool _isInterstitialAdLoaded = false;
  var pageNumber = 1;
  List<NewsModel> articleList;
  List<Widget> list;
  ScrollController _scrollController = ScrollController();

  //constructor
  NewsList(this.categoryName);

  bool networkState = true;

  @override
  void initState() {
    //initialize facebook ads
    FacebookAudienceNetwork.init();
    _loadInterstitialAd();

    super.initState();
    CheckInternetState().check().then((value) {
      networkState = value;
    });
    //fetch news
    GetNewsByCategoryName(categoryName, pageNumber).getNews().then((value) {
      if( this.mounted )
        {
          setState(() {
            articleList = value;
            pageNumber++;
          });
        }
    });

    //observe the listview scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    if (articleList == null) {
      return Container(
        child: Center(
          child: ArticleListPreLoader(),
        ),
      );
    } else if (!networkState) {
      return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset('assets/images/nointernet.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Not connected to internet",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ));
    } else {
      return ListView(
        controller: _scrollController,
        children: <Widget>[
          _buildNewsSlider(context),
          SizedBox(
            height: 10,
          ),
          AdmobBanner(
              adUnitId: Config.gBannerTestAds,
              adSize: AdmobBannerSize.BANNER,
              listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                switch (event) {
                  case AdmobAdEvent.loaded:
                    print('Admob banner loaded!');
                    break;

                  case AdmobAdEvent.opened:
                    print('Admob banner opened!');
                    break;

                  case AdmobAdEvent.closed:
                    print('Admob banner closed!');
                    break;

                  case AdmobAdEvent.failedToLoad:
                    print(
                        'Admob banner failed to load. Error code: ${args['errorCode']}');
                    break;
                  case AdmobAdEvent.clicked:
                    // TODO: Handle this case.
                    break;
                  case AdmobAdEvent.impression:
                    // TODO: Handle this case.
                    break;
                  case AdmobAdEvent.leftApplication:
                    // TODO: Handle this case.
                    break;
                  case AdmobAdEvent.completed:
                    // TODO: Handle this case.
                    break;
                  case AdmobAdEvent.rewarded:
                    // TODO: Handle this case.
                    break;
                  case AdmobAdEvent.started:
                    // TODO: Handle this case.
                    break;
                }
              }),
          //facebook banner ads
         /* FacebookBannerAd(
            placementId: Config.gFacebookBannerAd,
            bannerSize: BannerSize.STANDARD,
            listener: (result, value) {
              //print("Banner Ad: $result -->  $value");
            },
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                child: (Text(
                  "Upcoming matches",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ),
            ],
          ),
          Divider(),
          newList(context),
          Divider(),
        ],
      );
    }
  }

//*****************Cards at the top****************//
  Widget _buildNewsSlider(BuildContext context) {
    return Container(
      height: 180,
      child: Swiper(
        onTap: (int index) {
          onItemTap(index);
        },
        physics: ScrollPhysics(),
        itemCount: 2,
        autoplay: true,
        curve: Curves.easeInBack,
        itemBuilder: (BuildContext context, int index) {
          return Stack(children: <Widget>[
            Container(
              height: 190,
              width: double.infinity,
              child: Image.network(
                  articleList[index].embedded.media[0].sourceLink,
                  fit: BoxFit.fill),
            ),
            Container(
              height: 190,
              color: Colors.black.withOpacity(0.4),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                Utils().parseHTML(articleList[index].excerpt.rendered),
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                maxLines: 1,
              ),
            )
          ]);
        },
      ),
    );
  }

  Widget newList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == articleList.length) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.redAccent,
          ));
        }
        return ListTile(
          onTap: () {
            onItemTap(index);
          },
          onLongPress: () {
            showArticlePreview(context, index);
          },
          leading: ImageLoader().articleListImage(
              100.0, 120.0, articleList[index].embedded.media[0].sourceLink),
          title: Text(
            Utils().parseHTML(articleList[index].title.rendered),
            style: TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 5, left: 5),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  Utils().dateParse(articleList[index].date),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        );
      },
      physics: ScrollPhysics(),
      itemCount: articleList == null ? 1 : articleList.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  onItemTap(int index) {
    showAds();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayArticle(
                Utils().parseHTML(articleList[index].title.rendered),
                articleList[index].embedded.media[0].sourceLink,
                articleList[index].categories[0],
                articleList[index].date,
                articleList[index].link,
                articleList[index].content.rendered,
                articleList[index].id)));
  }

  void showArticlePreview(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: ImageLoader().articleListImage(200.0, 200.0,
                        articleList[index].embedded.media[0].sourceLink),
                  ),
                  Container(
                    child: Text(
                      Utils().parseHTML(articleList[index].title.rendered),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      Utils().parseHTML(articleList[index].content.rendered),
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  void getMoreData() {
    GetNewsByCategoryName(categoryName, pageNumber).getNews().then((value) {
      pageNumber++;
      articleList.addAll(value);
      setState(() {});
    });
  }

  void showAds() {
    /*InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: Config.gInterstitialAds,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
*/
      if (_isInterstitialAdLoaded == true)
        FacebookInterstitialAd.showInterstitialAd();
      /*else
        print("Interstial Ad not yet loaded!");*/

  }
  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: Config.gFacebookIntestitialAd,
      listener: (result, value) {
        //print("Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;
        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }
}
