
import 'dart:convert';

import 'package:flutter_blog/Models/CommetsModel.dart';
import 'package:flutter_blog/constants/Constants.dart';
import 'package:http/http.dart' as http;
class CommentByArticle
{
  Future<List<Comment>> getComment(int articleId)
  async{
    List<Comment> data;

    var response = await http.get(Config.gBaseUrl+"/wp-json/wp/v2/comments?post=$articleId");
    //parse response
    List<Comment> parseJson(String response) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
    }

    if (response.statusCode == 200) {
      data = parseJson(response.body);
      return data;
    }
  }
}