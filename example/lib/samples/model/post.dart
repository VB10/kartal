import 'package:kartal/src/utility/bundle/network_model_interface.dart';

class Post extends IAssetModel<Post> {
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
      );
  int? userId;
  int? id;
  String? title;
  String? body;

  @override
  Post fromJson(Map<String, dynamic> json) => Post.fromJson(json);

  @override
  Map<String, dynamic>? toJson() => _toJson();

  Map<String, dynamic> _toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
