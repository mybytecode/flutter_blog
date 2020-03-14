import 'package:flutter/material.dart';
import 'package:flutter_blog/Models/UserData.dart';
import 'package:flutter_blog/future/CommentByArticle.dart';
import 'package:flutter_blog/future/PostComment.dart';
import 'package:flutter_blog/utils/FirebaseGoogleSignIn.dart';
import 'package:flutter_blog/utils/Utils.dart';
import 'package:flutter_blog/widgets/ArticleListPreLoader.dart';
import 'package:flutter_blog/widgets/UserMetaDataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Comment extends StatefulWidget {
  final int articleId;

  Comment(this.articleId);

  @override
  State<StatefulWidget> createState() => CommentsState(articleId);
}

class CommentsState extends State<Comment> {
  int articleId;
  String name, photo;
  bool issignin;

  TextEditingController _controller = TextEditingController();

  CommentsState(this.articleId);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: CommentByArticle().getComment(articleId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: ArticleListPreLoader(),
              );
            } else if (snapshot.data.length == 0) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 35, left: 10),
                            child: Text(
                              "Comments",
                              style: TextStyle(
                                  fontSize: 20,
                                  //color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            )),
                        Divider(),
                        Container(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Column(
                              children: <Widget>[
                                /*Image.asset('assets/images/comment.png'),*/
                                Icon(
                                  Icons.comment,
                                  size: 300,
                                ),
                                Text(
                                  "No comments yet..",
                                  style: TextStyle(
                                      /*color: Colors.black54, */
                                      fontSize: 20),
                                ),
                                Text(
                                  "Be the first one to comment",
                                  style: TextStyle(
                                      /*color: Colors.black54*/),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  _buildBottomBar(context)
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 35, left: 10),
                            child: Text(
                              "Comments",
                              style: TextStyle(
                                  fontSize: 20,
                                  /*color: Colors.black54,*/
                                  fontWeight: FontWeight.bold),
                            )),
                        Divider(),
                        ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(snapshot
                                              .data[index]
                                              .author_avatar_urls
                                              .s48),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                top: 5,
                                                left: 10,
                                                right: 8,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xffF0EFEF)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  snapshot
                                                      .data[index].author_name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(Utils()
                                                            .parseHTML(snapshot
                                                                .data[index]
                                                                .content
                                                                .rendered)
                                                            .length >
                                                        40
                                                    ? Utils()
                                                        .parseHTML(snapshot
                                                            .data[index]
                                                            .content
                                                            .rendered)
                                                        .substring(0, 40)
                                                    : Utils().parseHTML(snapshot
                                                        .data[index]
                                                        .content
                                                        .rendered))
                                              ],
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                  _buildBottomBar(context)
                ],
              );
            }
          }),
    );
  }

  //TODO REFERENCE -snapshot.data[index].author_name
  //TODO data: snapshot.data[index].content.rendered
  //TODO snapshot.data[index].author_name

  Container _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Write comment"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.blueAccent,
            onPressed: () {
              postComment(context);
            },
          )
        ],
      ),
    );
  }

  void postComment(BuildContext context) async {
    UserDataModel metadata = await UserData().getData();

    if (metadata.isSignedIn) {
      await PostComment().postComment(_controller.text, articleId.toString());
      _controller.clear();
    } else {
      showDialog(
          context: context,
          builder: (cont) {
            return AlertDialog(
              title: Text("SignIn to comment"),
              actions: <Widget>[
                RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                Container(
                  child: new RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          MYSignIn().handleSignIn().then((val) {
                            UserData().setData(
                                val.displayName, val.photoUrl, val.email, true);
                          });
                        });
                        /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));*/
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("SignIn")
                          /*Image.asset('assets/images/google.png')*/,
                        ],
                      )),
                )
              ],
            );
          });
    }
  }
}
