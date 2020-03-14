import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/Models/NewsModesl.dart';
import 'package:flutter_blog/future/ArticleByCategoryId.dart';
import 'package:flutter_blog/utils/Utils.dart';
import 'package:flutter_blog/widgets/ArticleDetailsPreLoader.dart';

class ArticleListLazy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ArticleListLazyState();
}

class ArticleListLazyState extends State<ArticleListLazy> {
  List<NewsModel> articleList;
  ScrollController _listScrollController = ScrollController();

  var pageNumber = 1;

  @override
  void initState() {
    super.initState();
    GetNewsByCategoryName("", pageNumber).getNews().then((value) {
      setState(() {
        articleList = value;
      });
      _listScrollController.addListener(() {
        if (_listScrollController.position.pixels ==
            _listScrollController.position.maxScrollExtent) {
          pageNumber++;
          getMoreArticles();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        controller: _listScrollController,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          if (articleList == null) {
            return ArticleDetailsPreLoader();
          } else {
            return ListTile(
              onTap: () {
                //onItemTap(snapshot, index);
              },
              onLongPress: () {
                //showArticlePreview(context, snapshot, index);
              },
              leading: Image.network(
                articleList[index].embedded.media[0].sourceLink,
                width: 100,
                height: 120,
              ),
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
                  /*Container(
                margin: EdgeInsets.only(top: 5, left: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Utils().getRandomColor(),
                    borderRadius: BorderRadius.circular(10)),
                child: FutureBuilder(
                  future: GetCategoriesById(snapshot.data[index].categories[0])
                      .getCategories(),
                  builder: (BuildContext context, AsyncSnapshot snapshotC) {
                    if (snapshotC.data == null) {
                      return Text("India",
                          style: TextStyle(color: Colors.white, fontSize: 10));
                    } else {
                      return Text(
                        snapshotC.data,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      );
                    }
                  },
                ),
              ),*/
                ],
              ),
            );
          }
        },
        itemCount: articleList == null ? 1 : articleList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  void getMoreArticles() {
    GetNewsByCategoryName("", pageNumber).getNews().then((value) {
      setState(() {
        articleList.addAll(value);
      });
    });
  }
}
