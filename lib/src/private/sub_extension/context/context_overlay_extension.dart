import 'package:flutter/material.dart';

/// Extension methods for [BuildContext] to show transient UI.
extension OverlayExtension on BuildContext {
  /// Provides convenient access to snack bars, sheets and dialogs.
  _ContextOverlayExtension get overlay => _ContextOverlayExtension(this);
}

final class _ContextOverlayExtension {
  _ContextOverlayExtension(BuildContext context) : _context = context;

  final BuildContext _context;

  ScaffoldMessengerState get _messenger => ScaffoldMessenger.of(_context);

  /// Shows a [SnackBar] containing [message].
  ///
  /// Returns the controller so the caller can await dismissal or close it
  /// early.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnack(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    SnackBarBehavior? behavior,
  }) => _messenger.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration,
      action: action,
      backgroundColor: backgroundColor,
      behavior: behavior,
    ),
  );

  /// Shows a fully custom [SnackBar].
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackWidget(
    SnackBar snackBar,
  ) => _messenger.showSnackBar(snackBar);

  /// Hides the current snack bar, if one is showing.
  void hideSnack() => _messenger.hideCurrentSnackBar();

  /// Removes the current snack bar immediately, without an exit animation.
  void removeSnack() => _messenger.removeCurrentSnackBar();

  /// Shows [child] in a modal bottom sheet.
  ///
  /// [isScrollControlled] defaults to `true`, unlike
  /// [showModalBottomSheet], because a sheet containing a text field or a long
  /// list is the common case and needs it to size correctly above the keyboard.
  Future<T?> showSheet<T>(
    Widget child, {
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool useSafeArea = true,
    Color? backgroundColor,
    ShapeBorder? shape,
  }) => showModalBottomSheet<T>(
    context: _context,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    useSafeArea: useSafeArea,
    backgroundColor: backgroundColor,
    shape: shape,
    builder: (_) => child,
  );

  /// Shows [child] in a modal dialog.
  Future<T?> showDialogCustom<T>(
    Widget child, {
    bool barrierDismissible = true,
  }) => showDialog<T>(
    context: _context,
    barrierDismissible: barrierDismissible,
    builder: (_) => child,
  );

  /// Shows a two-button confirmation dialog.
  ///
  /// Completes with `true` when confirmed, and `false` when cancelled or
  /// dismissed — never `null`, so the result can be used directly in an `if`.
  Future<bool> showConfirm({
    required String title,
    String? message,
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: _context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: message == null ? null : Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(dialogContext).colorScheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
