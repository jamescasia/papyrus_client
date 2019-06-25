class News {
  String author;
  String title;
  String description;
  String url;
  String publishedDate;

  News({this.author, this.title, this.description, this.url, this.publishedDate});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      publishedDate:json['publishedAt'] as String,
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
    );
  }
}