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

class FavouriteArticleModel {
  final int articleId;
  final String title, content, category, date, link, image_url;

  @override
  String toString() {
    return 'FavouriteArticleModel{articleId: $articleId, title: $title, content: $content, category: $category, date: $date, link: $link, image_url: $image_url}';
  }

  FavouriteArticleModel(
      {this.articleId,
      this.image_url,
      this.link,
      this.content,
      this.date,
      this.category,
      this.title});

  Map<String, dynamic> toMap() {
    return {
      'article_id': articleId,
      'title': title,
      'category': category,
      'date': date,
      'content': content,
      'link': link,
      'image_url': image_url
    };
  }
}
