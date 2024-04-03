import 'package:kartal/src/utility/bundle/asset_model_interface.dart';

class FalseModel extends IAssetModel<FalseModel> {
  FalseModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });
  factory FalseModel.fromJson(Map<String, dynamic> json) => FalseModel(
        albumId: json['albumId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        url: json['url'] as String?,
        thumbnailUrl: json['thumbnailUrl'] as String?,
      );
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  @override
  FalseModel fromJson(Map<String, dynamic> json) => FalseModel.fromJson(json);

  @override
  Map<String, dynamic>? toJson() => _toJson();

  Map<String, dynamic> _toJson() => {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbnailUrl': thumbnailUrl,
      };
}
