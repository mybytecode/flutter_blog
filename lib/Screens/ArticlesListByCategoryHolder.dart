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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/Screens/ArticleListByCategory.dart';
import 'package:flutter_blog/widgets/ThemeProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ArticlesByCategoryHolder extends StatefulWidget {
  int categoryId;
  String categoryName;

  ArticlesByCategoryHolder(this.categoryId, this.categoryName);

  @override
  State<StatefulWidget> createState() =>
      ArticlesByCategoryHolderState(this.categoryId, this.categoryName);
}

class ArticlesByCategoryHolderState extends State<ArticlesByCategoryHolder> {
  int mCategoryId;
  String mCategoryName;

  ArticlesByCategoryHolderState(this.mCategoryId, this.mCategoryName);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(mCategoryName),
            ),
            body: ArticleByCategory(mCategoryId)),
      ),
    );
  }
}
