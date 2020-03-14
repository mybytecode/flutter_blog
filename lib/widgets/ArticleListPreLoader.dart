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
 * Date Created- 9/11/19 1:49 AM.
 * Author - Akshay Galande
 * Mail - mybytecode@gmail.com
 */

/*
 * Date Created- 9/11/19 1:47 AM.
 * Author - Akshay Galande
 * Mail - mybytecode@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_blog/widgets/AppTheme.dart';
import 'package:flutter_blog/widgets/Preloaders.dart';
import 'package:flutter_blog/widgets/ThemeProvider.dart';
import 'package:provider/provider.dart';

class ArticleListPreLoader extends StatefulWidget {
  _ArticleListPreLoaderState createState() => _ArticleListPreLoaderState();
}

class _ArticleListPreLoaderState extends State<ArticleListPreLoader> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return theme.getTheme() == DarkTheme().dark
        ? DarkCardListSkeleton()
        : CardListSkeleton(
            length: 5,
          );
  }
}
