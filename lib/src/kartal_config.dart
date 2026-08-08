import 'package:kartal/src/constants/responsibility_constants.dart';
import 'package:kartal/src/date_extension.dart';

/// Global defaults for the parts of kartal that are opinionated.
///
/// Breakpoints and relative-time labels previously had values baked in with no
/// way to change them, which forced apps with a different design system or
/// language to avoid those helpers entirely. Configure once during startup:
///
/// ```dart
/// void main() {
///   KartalConfig.instance.configure(
///     breakpoints: const KartalBreakpoints(
///       small: 480,
///       medium: 768,
///       large: 1200,
///     ),
///     dateLabel: const DateLocalizationLabel.tr(),
///   );
///   runApp(const MyApp());
/// }
/// ```
///
/// Everything has a default, so configuring is optional.
final class KartalConfig {
  KartalConfig._();

  static final KartalConfig _instance = KartalConfig._();

  /// The single shared configuration.
  static KartalConfig get instance => _instance;

  KartalBreakpoints _breakpoints = const KartalBreakpoints();
  DateLocalizationLabel _dateLabel = const DateLocalizationLabel();

  /// The screen width thresholds used by `context.device`.
  KartalBreakpoints get breakpoints => _breakpoints;

  /// The default labels used by `DateTime.ext.differenceTime`.
  DateLocalizationLabel get dateLabel => _dateLabel;

  /// Overrides one or more global defaults.
  ///
  /// Arguments left null keep their current value.
  void configure({
    KartalBreakpoints? breakpoints,
    DateLocalizationLabel? dateLabel,
  }) {
    _breakpoints = breakpoints ?? _breakpoints;
    _dateLabel = dateLabel ?? _dateLabel;

    ResponsibilityConstants.instance().breakpoints = _breakpoints;
  }

  /// Restores every default. Intended for use in test `setUp`.
  void reset() {
    _breakpoints = const KartalBreakpoints();
    _dateLabel = const DateLocalizationLabel();

    ResponsibilityConstants.instance().breakpoints = _breakpoints;
  }
}

/// Screen width thresholds, in logical pixels.
///
/// The bands they produce are `[0, small)`, `[small, medium)`,
/// `[medium, large)` and `[large, ...)`.
final class KartalBreakpoints {
  /// Creates a set of breakpoints.
  ///
  /// The defaults match the values kartal has always used.
  const KartalBreakpoints({
    this.small = 300,
    this.medium = 600,
    this.large = 900,
  }) : assert(
         small < medium && medium < large,
         'Breakpoints must increase: small < medium < large',
       );

  /// The upper bound of the small band.
  final double small;

  /// The upper bound of the medium band.
  final double medium;

  /// The upper bound of the expanded band, and the lower bound of large.
  final double large;
}
