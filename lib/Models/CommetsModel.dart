class Comment
{
  final int id,post,parent,author;
  final String author_name,link,author_url,date,date_gmt,status,type;

  final Content content;
  final Author author_avatar_urls;

  Comment({this.id, this.post, this.parent, this.author, this.author_name,
      this.link, this.author_url, this.date, this.date_gmt, this.status,
      this.type,this.content,this.author_avatar_urls});

  factory Comment.fromJson(Map<String,dynamic>json){
    return Comment(
      id: json['id'],
      post: json['post'] as int,
      parent: json['parent'] as int,
      author: json['author'] as int,
      type: json['type'] as String,
      author_name: json['author_name'] as String,
      link: json['link'] as String,
      author_url: json['author_url'] as String,
      date: json['date'] as String,
      date_gmt: json['date_gmt'] as String,
      status: json['status'] as String,
      content: Content.fromJson(json['content']),
      author_avatar_urls: Author.fromJson(json['author_avatar_urls'])
    );
  }
}
class Content
{
final String rendered;

  Content({this.rendered});

  factory Content.fromJson(Map<String,dynamic>json){
    return Content(
      rendered: json['rendered'] as String
    );
  }
}

class Author
{
  final String s24,s48,s98;

  Author({this.s24, this.s48, this.s98});

  factory Author.fromJson(Map<String,dynamic>json){
    return Author(
      s24: json['24'] as String,
      s48: json['48'] as String,
      s98: json['98'] as String
    );
  }
}