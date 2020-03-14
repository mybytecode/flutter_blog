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
import 'package:flutter_blog/Models/NewsModesl.dart';
import 'package:flutter_blog/future/SearchPost.dart';
import 'package:flutter_blog/utils/Utils.dart';

import 'DisplayArticle.dart';

class SearchArticle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchArticleState();
}

class SearchArticleState extends State<SearchArticle> {
  final textController = TextEditingController();
  String searchTerm;
  bool queryState = false;
  List<NewsModel> articleList;
  bool progress = false;

/*

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: new AppBar(
        title: TextField(
          controller: textController,
          style: TextStyle(color: Colors.white),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              hintText: "Search News , Author , Articles..."),
          cursorColor: Colors.white,
          onSubmitted: (v) {
            searchNews();
          },
          onChanged: (v) {
            if (v.length < 2) {
              articleList = null;
            }
          },
        ),
      ),
      body: Container(
        child: textController.text.length > 2
            ? _newsLoader()
            : Container(
                margin: EdgeInsets.only(top: 200),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 100,
                      color: Colors.redAccent,
                    ),
                    Text(
                      "Search Articles",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              ),
      ),
    ));
  }

  searchNews() {
    if (textController.text.length > 2) {
      setState(() {
        progress = true;
      });
      SearchPost(textController.text).getNews().then((value) {
        setState(() {
          articleList = value;
          progress = false;
        });
      });
    }
    if (textController.text.length < 2) {
      setState(() {
        articleList = null;
      });
    }
  }

  Widget _newsLoader() {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text(
            "Search result for - " + textController.text,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(),
        ListView.separated(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: articleList != null ? articleList.length : 1,
          itemBuilder: (BuildContext context, int index) {
            if (progress) {
              return Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            } else {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisplayArticle(
                              Utils()
                                  .parseHTML(articleList[index].title.rendered),
                              articleList[index].embedded.media[0].sourceLink,
                              articleList[index].categories[0],
                              articleList[index].date,
                              articleList[index].link,
                              Utils().parseHTML(
                                  articleList[index].content.rendered),
                              articleList[index].id)));
                },
                leading: Image.network(
                  articleList[index].embedded.media[0].sourceLink,
                  width: 80,
                  height: 120,
                ),
                title: Text(
                  Utils().parseHTML(articleList[index].title.rendered),
                  style: TextStyle(fontWeight: FontWeight.bold),
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
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
