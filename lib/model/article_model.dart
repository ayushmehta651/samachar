class Article {
  static const tableArticle = 'Article';
  static const colId = 'id';
  static const colTitle = 'title';
  static const colDesc = 'description';
  static const colContent = 'content';
  static const colArticleUrl = 'articleUrl';
  static const colSource = 'source';

  int id;
  String title;
  String description;
  String urlToImage;
  DateTime publishedAt;
  String content;
  String articleUrl;
  String source;

  Article({
    this.id,
    this.title,
    this.description,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.articleUrl,
    this.source,
  });

  Article.formMap(Map<String, dynamic> map) {
    id = map[colId];
    title = map[colTitle];
    description = map[colDesc];
    content = map[colContent];
    articleUrl = map[colArticleUrl];
    source = map[colSource];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colTitle: title,
      colDesc: description,
      colContent: content,
      colArticleUrl: articleUrl,
      colSource: source,
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
