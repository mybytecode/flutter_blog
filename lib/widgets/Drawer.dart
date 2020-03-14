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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blog/Screens/AboutUs.dart';
import 'package:flutter_blog/Screens/ArticlesListByCategoryHolder.dart';
import 'package:flutter_blog/Screens/FavouriteArticleList.dart';
import 'package:flutter_blog/Screens/OfflineArticlesList.dart';
import 'package:flutter_blog/future/Categories.dart';
import 'package:flutter_blog/utils/FirebaseGoogleSignIn.dart';
import 'package:flutter_blog/widgets/AppTheme.dart';
import 'package:flutter_blog/widgets/UserMetaDataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import 'ArticleListPreLoader.dart';

class DrawerBarState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerBar();
}

class DrawerBar extends State<DrawerBarState> {
  String name, photo;
  bool issignin;

  @override
  void initState() {
    super.initState();
    UserData().getData().then((value) {
      this.name = value.name;
      this.photo = value.photoUrl;
      this.issignin = value.isSignedIn;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
      body: FutureBuilder(
        future: GetCategories().getCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: ArticleListPreLoader(),
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(color: DefaultTheme.defaultColor),
                    child: issignin
                        ? Column(
                            children: <Widget>[
                              Center(
                                child: Image.asset(
                                  'assets/images/logo_bg.png',
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(photo,
                                        height: 50, width: 50),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        name,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Center(
                                child: (Image.asset(
                                  'assets/images/logo_bg.png',
                                  height: 70,
                                  width: 100,
                                )),
                              ),
                              googleButton()
                            ],
                          )),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidHeart,
                    color: DefaultTheme.iconColor,
                  ),
                  title: Text(
                    "Favourite Articles",
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavouriteArticleList()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.solidBookmark,
                    color: DefaultTheme.iconColor,
                  ),
                  title: Text("Saved Offline"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfflineArticles()));
                  },
                ),
                Divider(),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ArticlesByCategoryHolder(
                                          snapshot.data[index].id,
                                          snapshot.data[index].name)));
                        },
                        leading: Icon(
                          FontAwesomeIcons.link,
                          color: DefaultTheme.iconColor,
                        ),
                        title:
                            Container(child: Text(snapshot.data[index].name)),
                      );
                    }),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                  leading: Icon(
                    FontAwesomeIcons.infoCircle,
                    color: DefaultTheme.iconColor,
                  ),
                  title: Text(
                    "About Us",
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    UserData().removeSignIn();
                    UserData().setData("", "", "", false);

                    setState(() {
                      UserData().getData().then((val) {
                        //print(val.isSignedIn);
                        issignin = val.isSignedIn;
                      });
                    });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  leading: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: DefaultTheme.iconColor,
                  ),
                  title: Text(
                    "Logout",
                  ),
                ),
              ],
            );
          }
        },
      ),
    ));
  }

  Widget googleButton() {
    return Container(
      child: new RaisedButton(
          color: const Color(0xFF4285F4),
          onPressed: () {
            setState(() {
              MYSignIn().handleSignIn().then((val) {
                this.name = val.displayName;
                this.photo = val.photoUrl;
                this.issignin = true;
                UserData().setData(name, photo, val.email, true);
              });
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
            },
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset('assets/images/google.png'),
              new Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Text(
                    "Sign in with Google",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          )),
    );
  }
}
