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

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_blog/Models/NewsModesl.dart';
import 'package:flutter_blog/constants/Constants.dart';

//Initialize configuration class
var config = Config();

class SearchPost {
  var searchTerm;

  SearchPost(this.searchTerm);

  // ignore: missing_return
  Future<List<NewsModel>> getNews() async {
    List<NewsModel> data;
    var url =
        Config.gBaseUrl + "/wp-json/wp/v2/posts?search=$searchTerm&_embed&";
    var response = await http.get(url);

    List<NewsModel> parseJson(String response) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<NewsModel>((json) => NewsModel.fromJson(json)).toList();
    }

    if (response.statusCode == 200) {
      data = parseJson(response.body);
    }
    return data;
  }
}
