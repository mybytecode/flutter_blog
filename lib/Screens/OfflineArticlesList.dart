import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/Models/SavedArticleModel.dart';
import 'package:flutter_blog/Screens/DisplaySavedArticle.dart';
import 'package:flutter_blog/database/Database.dart';
import 'package:flutter_blog/utils/Utils.dart';
import 'package:flutter_blog/widgets/ArticleListPreLoader.dart';
import 'package:flutter_blog/widgets/ThemeProvider.dart';
import 'package:provider/provider.dart';

class OfflineArticles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OfflineArticleState();
}

class OfflineArticleState extends State<OfflineArticles> {
  @override
  Widget build(BuildContext context) {
    //get new which are saved offline
    getSavedOffline();
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Offline Articles"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
            child: FutureBuilder(
          future: getSavedOffline(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return ArticleListPreLoader();
            }else if ( snapshot.data.length == 0 ) {
              return Container(
                child: Center(
                  child: Image.asset('assets/images/no-result-found.png'),
                ),
              );
            }  else {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      onItemTap(snapshot, index);
                    },
                    leading: Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                      height: 120,
                    ),
                    title: Text(
                      Utils().parseHTML(snapshot.data[index].title),
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Text(
                            Utils().dateParse(snapshot.data[index].date),
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Utils().getRandomColor(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(snapshot.data[index].category)),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }
          },
        )),
      ),
    );
  }

  Future<List<SavedArticlesModel>> getSavedOffline() async {
    return await DatabaseManagerForSavedOffline.databaseManager
        .getSavedArticles();
  }

  onItemTap(AsyncSnapshot snapshot, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayOfflineArticle(
                Utils().parseHTML(snapshot.data[index].title),
                snapshot.data[index].date,
                snapshot.data[index].content,
                snapshot.data[index].category,
                snapshot.data[index].articleId,
                snapshot.data[index].link,
                snapshot.data[index].image_url
            )));
  }
}
