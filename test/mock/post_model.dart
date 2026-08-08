import 'package:kartal/kartal.dart';

/// A test fixture matching `test/files/placeholder.json`.
///
/// This previously lived in the example app and was reached through a
/// `../../example/lib/...` relative import, which coupled the package's tests
/// to the demo app's file layout.
class Post extends IAssetModel<Post> {
  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    userId: json['userId'] as int?,
    id: json['id'] as int?,
    title: json['title'] as String?,
    body: json['body'] as String?,
  );

  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  @override
  Post fromJson(Map<String, dynamic> json) => Post.fromJson(json);
}
