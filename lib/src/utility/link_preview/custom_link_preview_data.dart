/// It is used to store the data of the link preview.
final class CustomLinkPreviewData {
  CustomLinkPreviewData({
    required this.title,
    required this.description,
    required this.image,
  });

  /// The title of the link preview.
  final String? title;

  /// The description of the link preview.
  final String? description;

  /// The image of the link preview.
  final String? image;
}
