import 'package:flutter/material.dart';

extension ContextDialogExtension on BuildContext {
  void showSnack(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    SnackBarAction? action,
    bool showCloseIcon = false,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actionOverflowThreshold: 0.5,
        showCloseIcon: showCloseIcon,
      ),
    );
  }

  void showSuccessSnack(String message) {
    showSnack(message, backgroundColor: Colors.green);
  }

  void showErrorSnack(String message) {
    showSnack(message, backgroundColor: Colors.red);
  }

  void showInfoSnack(String message) {
    showSnack(message, backgroundColor: Colors.blue);
  }

  Future<bool> showConfirm(
    String title,
    String message, {
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDangerous = false,
  }) async {
    final result = await showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: isDangerous
                ? TextButton.styleFrom(foregroundColor: Colors.red)
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> showAlert(
    String title,
    String message, {
    String buttonText = 'OK',
  }) async {
    await showDialog<void>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  Future<T?> showModalBottom<T>({
    required Widget Function(BuildContext) builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    bool isDismissible = true,
  }) =>
      showModalBottomSheet<T>(
        context: this,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation ?? 8,
        shape: shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
        isDismissible: isDismissible,
        isScrollControlled: true,
      );

  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) =>
      showModalBottom<T>(
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
      );
}
