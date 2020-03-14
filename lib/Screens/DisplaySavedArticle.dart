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
import 'package:flutter_blog/Models/FavouriteArticleModel.dart';
import 'package:flutter_blog/Models/SavedArticleModel.dart';
import 'package:flutter_blog/Screens/Comments.dart';
import 'package:flutter_blog/database/Database.dart';
import 'package:flutter_blog/utils/SocialShareCOntroller.dart';
import 'package:flutter_blog/utils/Utils.dart';
import 'package:flutter_blog/widgets/AppTheme.dart';
import 'package:flutter_blog/widgets/Colors.dart';
import 'package:flutter_blog/widgets/ThemeProvider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayOfflineArticle extends StatefulWidget {
  final mTitle, mDate, mNewsData, mCategories, mIageUrl, mLink;

  final mArticleId;

  DisplayOfflineArticle(this.mTitle, this.mDate, this.mNewsData,
      this.mCategories, this.mArticleId, this.mLink, this.mIageUrl);

  @override
  State<StatefulWidget> createState() => DisplayOfflineArticleState(
      mTitle, mDate, mNewsData, mCategories, mArticleId, mLink, mIageUrl);
}

class DisplayOfflineArticleState extends State<DisplayOfflineArticle> {
  final String mCategories, mTitle, mDate, mNewsData, mLink, mImageUrl;
  final int mArticleId;
  String category;
  List<FavouriteArticleModel> mFavouriteArticleResponse;
  List<SavedArticlesModel> mSavedArticles;
  bool mFavouriteArticleState = false, mSavedOffline = false;
  bool isDarkMode = false, isLoadImages = false;

  DisplayOfflineArticleState(this.mTitle, this.mDate, this.mNewsData,
      this.mCategories, this.mArticleId, this.mLink, this.mImageUrl) {
    isFavourite().then((val) => setState(() {
          if (val != null) {
            mFavouriteArticleState = val;
          }
        }));
    isSaved().then((val) => setState(() {
          if (val != null) {
            mSavedOffline = val;
          }
        }));
  }

  var mCustomColors = CustomColors();

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: Scaffold(
            body: Stack(
          children: <Widget>[
            Container(
                foregroundDecoration: BoxDecoration(color: Colors.black26),
                height: 320,
                child: Image.network(mImageUrl, fit: BoxFit.fill,
                    loadingBuilder:
                        (BuildContext ctx, Widget child, ImageChunkEvent pre) {
                  if (pre == null) {
                    return Container(
                      height: 320,
                      child: child,
                    );
                  } else {
                    return Container(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                      ),
                    );
                  }
                })),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      mTitle,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 16.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          mCategories,
                          style: TextStyle(color: Colors.white, fontSize: 13.0),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        color: Colors.white,
                        icon: mFavouriteArticleState
                            ? Icon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.redAccent,
                              )
                            : Icon(FontAwesomeIcons.heart),
                        onPressed: () {
                          _addToFavourite();
                        },
                      ),
                      //Save offline icon button
                      IconButton(
                        color: Colors.white,
                        icon: mSavedOffline
                            ? Icon(Icons.cloud_download,
                                color: Colors.redAccent)
                            : Icon(Icons.cloud_download),
                        onPressed: () {
                          _addToSavedArticles();
                        },
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    color: theme.getTheme() == DarkTheme().dark
                        ? Colors.black87
                        : Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(FontAwesomeIcons.facebook,
                                            color: Colors.blue, size: 24),
                                        onPressed: () {
                                          NativeShare().facebookShare(
                                              mTitle, mNewsData, "");
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(FontAwesomeIcons.twitter,
                                            color: Colors.blue, size: 22),
                                        onPressed: () {
                                          NativeShare().twitterShare(
                                              mTitle, mNewsData, "");
                                        },
                                      ),
                                      IconButton(
                                          icon: Icon(FontAwesomeIcons.whatsapp,
                                              color: Colors.green, size: 22),
                                          onPressed: () {
                                            NativeShare().whatsApp(
                                                mTitle, mNewsData, "");
                                          }),
                                      IconButton(
                                          icon: Icon(
                                            FontAwesomeIcons.share,
                                            color: Colors.deepPurpleAccent,
                                            size: 22,
                                          ),
                                          onPressed: () {
                                            NativeShare().systemShare(
                                                mTitle, mNewsData, "");
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          Utils().dateParse(mDate),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        Html(
                          data: mNewsData,
                          useRichText: true,
                          showImages: isLoadImages ? true : false,
                          defaultTextStyle: isDarkMode
                              ? TextStyle(
                                  /*color: Colors.white,*/
                                  fontSize: theme.getTextSize())
                              : TextStyle(fontSize: theme.getTextSize()),
                          onLinkTap: (url) {
                            launch(url);
                          },
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: bottomNavigationBar(theme),
            )
          ],
        )));
  }

  void _addToFavourite() async {
    var data = FavouriteArticleModel(articleId: mArticleId);
    await DatabaseManagerForFavourites.databaseManager
        .insertFavouriteArticle(data);

    if (mFavouriteArticleState) {
      DatabaseManagerForFavourites.databaseManager
          .deleteFavouriteArticle(mArticleId);
      setState(() {
        mFavouriteArticleState = false;
      });
    }

    isFavourite();
  }

  Future isFavourite() async {
    mFavouriteArticleResponse = await DatabaseManagerForFavourites
        .databaseManager
        .getFavouriteArticles();
    for (FavouriteArticleModel id in mFavouriteArticleResponse) {
      if (id.articleId.toString() == mArticleId.toString()) {
        setState(() {
          mFavouriteArticleState = true;
        });
        return true;
      } else {}
    }
  }

  _addToSavedArticles() async {
    var data = SavedArticlesModel(
      articleId: mArticleId,
      title: mTitle,
      content: mNewsData,
      category: category,
      date: mDate,
      image_url: mImageUrl,
      link: mLink,
    );
    await DatabaseManagerForSavedOffline.databaseManager
        .insertSavedArticle(data);

    mSavedArticles =
        await DatabaseManagerForSavedOffline.databaseManager.getSavedArticles();

    if (mSavedOffline) {
      DatabaseManagerForSavedOffline.databaseManager
          .deleteSavedArticle(mArticleId);
      setState(() {
        mSavedOffline = false;
      });
    }
    isSaved();
  }

  Future isSaved() async {
    mSavedArticles =
        await DatabaseManagerForSavedOffline.databaseManager.getSavedArticles();
    for (SavedArticlesModel id in mSavedArticles) {
      if (id.articleId.toString() == mArticleId.toString()) {
        setState(() {
          mSavedOffline = true;
        });
        return true;
      } else {}
    }
  }

  Widget bottomNavigationBar(ThemeProvider theme) {
    return BottomNavigationBar(
      //backgroundColor: Colors.white54,
      onTap: (index) {
        _incrementTab(index);
        bottomNavigationActions(index, theme);
      },
      currentIndex: _cIndex,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up), title: Text("Reaction")),
        BottomNavigationBarItem(
            icon: Icon(Icons.comment), title: Text("Comments")),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text("Settings")),
      ],
    );
  }

  bottomNavigationActions(int index, ThemeProvider theme) {
    switch (index) {
      case 0:
        break;
      case 1:
        comments();
        break;
      case 2:
        settings(theme);
        break;
    }
  }

  Future comments() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        builder: (context) {
          return Container(
            child: Center(
              child: Comment(mArticleId),
            ),
          );
        });
  }

  Future settings(ThemeProvider theme) {
    return showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Wrap(
              children: <Widget>[
                Text(
                  "Set Font Size",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.font, size: 14),
                  title: Slider(
                    onChanged: (double value) {
                      setState(() {
                        theme.setTextSize(value);
                      });
                    },
                    min: 12,
                    divisions: 4,
                    max: 28,
                    value: theme.getTextSize(),
                    activeColor: Colors.redAccent,
                    inactiveColor: Colors.black12,
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.font,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(FontAwesomeIcons.solidStar),
                  title: Text("Night Mode"),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text("For better readability at night"),
                  ),
                  trailing: Switch(
                    value: theme.getTheme() == DarkTheme().dark ? true : false,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      value
                          ? theme.setTheme(DarkTheme().dark)
                          : theme.setTheme(LightTheme().light);
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.images,
                  ),
                  title: Text("Load Images"),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text("Turn this of to save data"),
                  ),
                  trailing: Switch(
                    value: isLoadImages,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        isLoadImages = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
