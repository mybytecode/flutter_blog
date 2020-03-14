import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog/Models/UserData.dart';
import 'package:flutter_blog/constants/Constants.dart';
import 'package:flutter_blog/widgets/UserMetaDataProvider.dart';
import 'package:http/http.dart'as http;
class PostComment
{
  Future<String> postComment(String content,String post) async
  {
    //getting user metadata
    UserDataModel metadata = await UserData().getData();

    String url =Config.gBaseUrl+"/wp-json/wp/v2/comments";
    var response = await http.post(url,
    body: {
      'author_email':metadata.email,
      'author_name':metadata.name,
      'content':content,
      'post':post
    });

    return response.body;
  }
}