class WebtoonCategory {
  String imgUrl;
  String title;
  String detail;
  WebtoonCategory(
      {required this.title, required this.detail, required this.imgUrl});
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imgUrl': imgUrl,
      'detail': detail,
    };
  }

  factory WebtoonCategory.fromJson(Map<String, dynamic> json) {
    return WebtoonCategory(
      title: json['title'],
      imgUrl: json['imgUrl'],
      detail: json['detail'],
    );
  }
}
