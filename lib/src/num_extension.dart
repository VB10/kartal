import 'package:kartal/src/private/mixin/num/num_core_mixin.dart';

/// Provides convenient access to commonly used properties from [num].
///
/// For `int` receivers the more specific `IntegerExtension` wins, but both
/// wrappers mix in [NumCoreMixin], so the same members are available either
/// way.
extension NumExtension on num {
  /// Provides convenient access to commonly used properties from [num].
  _NumExtension get ext => _NumExtension(this);
}

final class _NumExtension with NumCoreMixin {
  _NumExtension(this.value);

  @override
  final num value;
}
