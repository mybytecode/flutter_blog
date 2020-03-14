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

class NewsModel {
  final List<int> categories;
  final int id;
  final int author;
  final int featuredMedia;
  final bool sticky;
  final String date;

  //final String dateGmt;
  final String link;
  final Title title;
  final Content content;
  final Excerpt excerpt;
  final Embedded embedded;

  NewsModel(
      {this.categories,
      this.id,
      this.author,
      this.featuredMedia,
      this.sticky,
      this.date,
      //this.dateGmt,
      this.title,
      this.content,
      this.excerpt,
      this.embedded,
      this.link});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        id: json['id'] as int,
        link: json['link'] as String,
        author: json['author'] as int,
        featuredMedia: json['featured_media'] as int,
        sticky: json['sticky'] as bool,
        date: json['date'] as String,
        //dateGmt: json['date_gmt'] as String,
        title: Title.fromJson(json['title']),
        content: Content.fromJson(json['content']),
        excerpt: Excerpt.fromJson(json['excerpt']),
        categories: (json['categories'] as List)
            .map((map) => int.parse("$map"))
            .toList(),
        embedded: Embedded.fromJson(json['_embedded']));
  }
}

//Excerpt PODO class for news excerpt
class Excerpt {
  final String rendered;
  final bool protected;

  Excerpt({this.rendered, this.protected});

  factory Excerpt.fromJson(Map<String, dynamic> json) {
    return Excerpt(
        rendered: json['rendered'] as String,
        protected: json['protected'] as bool);
  }
}

//PODO class for news content
class Content {
  final String rendered;
  final bool protected;

  Content({this.rendered, this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        rendered: json['rendered'] as String,
        protected: json['protected'] as bool);
  }
}

//Title PODO class of news
class Title {
  final String rendered;

  Title({this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(rendered: json['rendered'] as String);
  }
}

//Categories Model class
class Categories {
  final int id;
  final int count;
  final String name;

  Categories({this.id, this.count, this.name});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        id: json['id'] as int,
        count: json['count'] as int,
        name: json['name'] as String);
  }
}

//Embed meta data for post model class

class Embedded {
  final List<Media> media;

  Embedded({this.media});

  factory Embedded.fromJson(Map<String, dynamic> json) {
    return Embedded(
        media: (json['wp:featuredmedia'] as List)
            .map((map) => Media.fromJson(map))
            .toList());
  }
}

//Media class to get featured image or thumbnails related to news or post article
class Media {
  //final int id;
  //final String date;
  //final String mediaType;
  final String sourceLink;

  //final MediaDetails mediaDetails;

  Media({
    /*this.id, this.date, this.mediaType,*/ this.sourceLink,
    /*this.mediaDetails*/
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      //id: json['id'] as int,
      //date: json['date'] as String,
      //mediaType: json['media_type'] as String,
      sourceLink: json['source_url'] as String,
      // mediaDetails: MediaDetails.fromJson(json['media_details']));
    );
  }
}

class MediaDetails {
  final int height, width;
  final String file;
  final SizesOfMedia sizesOfMedia;

  MediaDetails({this.height, this.width, this.file, this.sizesOfMedia});

  factory MediaDetails.fromJson(Map<String, dynamic> json) {
    return MediaDetails(
        height: json['height'] as int,
        width: json['width'] as int,
        file: json['file'] as String,
        sizesOfMedia: SizesOfMedia.fromJson(json['sizes']));
  }
}

class SizesOfMedia {
  final ThumnailOfMedia thumnailOfMedia;
  final MediumImage mediumImage;
  final MediumLargeImage mediumLargeImage;
  final LargeImage largeImage;

  SizesOfMedia(
      {this.thumnailOfMedia,
      this.mediumImage,
      this.mediumLargeImage,
      this.largeImage});

  factory SizesOfMedia.fromJson(Map<String, dynamic> json) {
    return SizesOfMedia(
      thumnailOfMedia: ThumnailOfMedia.fromJson(json['thumbnail']),
      mediumImage: MediumImage.fromJson(json['medium']),
      //mediumLargeImage: MediumLargeImage.fromJson(json['medium_large']),
      //largeImage: LargeImage.fromJson(json['large'])
    );
  }
}

class ThumnailOfMedia {
  final String file, mimeType, sourceUrl;
  final int width, height;

  ThumnailOfMedia(
      {this.file, this.mimeType, this.sourceUrl, this.width, this.height});

  factory ThumnailOfMedia.fromJson(Map<String, dynamic> json) {
    return ThumnailOfMedia(
        //file: json['file'] as String,
        mimeType: json['mime_type'] as String,
        sourceUrl: json['source_url'] as String,
        height: json['height'] as int,
        width: json['width'] as int);
  }
}

class MediumImage {
  final String file, mimeType, sourceUrl;
  final int width, height;

  MediumImage(
      {this.file, this.mimeType, this.sourceUrl, this.width, this.height});

  factory MediumImage.fromJson(Map<String, dynamic> json) {
    return MediumImage(
        file: json['file'] as String,
        mimeType: json['mime_type'] as String,
        sourceUrl: json['source_url'] as String,
        height: json['height'] as int,
        width: json['width'] as int);
  }
}

class MediumLargeImage {
  final String file, mimeType, sourceUrl;
  final int width, height;

  MediumLargeImage(
      {this.file, this.mimeType, this.sourceUrl, this.width, this.height});

  factory MediumLargeImage.fromJson(Map<String, dynamic> json) {
    return MediumLargeImage(
        file: json['file'] as String,
        mimeType: json['mime_type'] as String,
        sourceUrl: json['source_url'] as String,
        height: json['height'] as int,
        width: json['width'] as int);
  }
}

class LargeImage {
  final String file, mimeType, sourceUrl;
  final int width, height;

  LargeImage(
      {this.file, this.mimeType, this.sourceUrl, this.width, this.height});

  factory LargeImage.fromJson(Map<String, dynamic> json) {
    return LargeImage(
        file: json['file'] as String,
        mimeType: json['mime_type'] as String,
        sourceUrl: json['source_url'] as String,
        height: json['height'] as int,
        width: json['width'] as int);
  }
}
