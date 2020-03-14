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

/*
 * Date Created- 14/11/19 4:20 AM.
 * Author - Akshay Galande
 * Mail - mybytecode@gmail.com
 */

/*
 * Date Created- 9/11/19 2:17 AM.
 * Author - Akshay Galande
 * Mail - mybytecode@gmail.com
 */

/*
 * Date Created- 9/11/19 1:49 AM.
 * Author - Akshay Galande
 * Mail - mybytecode@gmail.com
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/Screens/ArticleList.dart';
import 'package:flutter_blog/constants/Constants.dart';
import 'package:flutter_blog/initialize_app/admob.dart';
import 'package:flutter_blog/initialize_app/database.dart';
import 'package:flutter_blog/initialize_app/one_signal.dart';
import 'package:flutter_blog/utils/MySharedPreferences.dart';
import 'package:flutter_blog/widgets/AppTheme.dart';
import 'package:flutter_blog/widgets/Drawer.dart';
import 'package:flutter_blog/widgets/SearchIcon.dart';
import 'package:flutter_blog/widgets/ThemeProvider.dart';
import 'package:flutter_blog/widgets/UserMetaDataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    initApp();
    List<Widget> tabViewContainer = [];
    for (var i = 0; i < Config.gCategoriesId.length; i++) {
      tabViewContainer.add(NewsLoader(Config.gCategoriesId[i]));
    }
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          //setting shared preferences of user metadata
          UserData().setData(snapshot.data.displayName, snapshot.data.photoUrl,
              snapshot.data.email, true);

          return ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(LightTheme().light),
              child: DashBoard());
        } else {
          UserData().setData("", "", "", false);
          return ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(LightTheme().light),
              child: DashBoard());
        }
      },
    );
  }

  void initApp() {
    InitAdmob().init();
    InitOneSignal().init();
    InitDatabase().initDb();
  }
}

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //getting theme
    final themeData = Provider.of<ThemeProvider>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return MaterialApp(
        theme: themeData.getTheme(),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: Config.gCategoriesNamesTab.length,
          child: Scaffold(
              key: _scaffoldKey,
              drawer: DrawerBarState(),
              appBar: AppBar(
                elevation: 2,
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.bars),
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                ),
                actions: <Widget>[
                  SearchIcon(),
                  /*Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.notifications),
              ),*/
                  popUp(context, themeData, _scaffoldKey),
                ],
                title: Text(
                  Config.gAppName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottom: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12),
                    isScrollable: true,
                    tabs: Config.gCategoriesNamesTab
                        .map((title) => Tab(text: title))
                        .toList()),
              ),
              body: TabBarView(
                children:
                    Config.gCategoriesId.map((id) => NewsLoader(id)).toList(),
              )),
        ));
  }

  Widget popUp(BuildContext context, ThemeProvider themeData,
      GlobalKey<ScaffoldState> scaffoldKey) {
    return PopupMenuButton(
      onSelected: (val) {
        switch (val) {
          case 0:
            lightModeAlert(scaffoldKey.currentState.context, themeData);
            break;
          case 1:
            darkModeAlert(scaffoldKey.currentState.context, themeData);
            break;
          case 2:
            Toast.show("Hello", context);
            break;
        }
      },
      itemBuilder: (context) {
        context = scaffoldKey.currentState.context;
        var list = List<PopupMenuEntry<Object>>();
        list.add(PopupMenuItem(
          child: Text("Dark Mode"),
          value: 1,
        ));
        list.add(PopupMenuItem(
          child: Text("Light Mode"),
          value: 0,
        ));
        list.add(PopupMenuDivider());
        list.add(PopupMenuItem(
          child: Text("Text Size"),
          value: 2,
        ));
        return list;
      },
    );
  }

  popUpSelectAction() {}

  void darkModeAlert(BuildContext context, ThemeProvider themeData) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Dark Mode"),
            content: Text("For better readability at night"),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 24, 20),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () {
                  themeData.setTheme(DarkTheme().dark);
                  MyShredPreferences().enableDarkModePref();
                  Navigator.pop(context);
                },
                child: Text("Yes"),
              )
            ],
          );
        });
  }

  void lightModeAlert(BuildContext context, ThemeProvider themeData) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Light Mode"),
            content: Text("For better readability at Day"),
            contentPadding: EdgeInsets.fromLTRB(20, 5, 24, 20),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () {
                  themeData.setTheme(LightTheme().light);
                  MyShredPreferences().enableDarkModePref();
                  Navigator.pop(context);
                },
                child: Text("Yes"),
              )
            ],
          );
        });
  }
}
