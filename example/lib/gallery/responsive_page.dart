import 'package:example/gallery/gallery_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Live responsive playground.
///
/// On the web the most convincing demo is simply resizing the window, so this
/// page reports the live width, band and derived metrics as they change.
class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = KartalConfig.instance.breakpoints;

    return GalleryBody(
      children: [
        DemoSection(
          title: 'Current band',
          description:
              'Resize the window and watch this update. The bands are '
              'contiguous, so exactly one is ever true.',
          snippet:
              'context.device.breakpoint;  '
              '// DeviceBreakpoint.${context.device.breakpoint.name}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BandIndicator(
                width: context.sized.width,
                breakpoints: breakpoints,
                current: context.device.breakpoint,
              ),
              const SizedBox(height: 16),
              ResultRow(
                label: 'width',
                value: '${context.sized.width.toStringAsFixed(1)} px',
              ),
              ResultRow(
                label: 'breakpoint',
                value: 'DeviceBreakpoint.${context.device.breakpoint.name}',
              ),
              ResultRow(
                label: 'isSmallScreen',
                value: '${context.device.isSmallScreen}',
              ),
              ResultRow(
                label: 'isMediumScreen',
                value: '${context.device.isMediumScreen}',
              ),
              ResultRow(
                label: 'isExpandedScreen',
                value: '${context.device.isExpandedScreen}',
              ),
              ResultRow(
                label: 'isLargeScreen',
                value: '${context.device.isLargeScreen}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'responsive()',
          description:
              'Wider bands fall back to the next narrower value supplied, so '
              'you only specify the breakpoints you care about.',
          snippet:
              'final columns = context.device.responsive(\n'
              '  small: 1, medium: 2, large: 4,\n'
              ');  // $_columnsSnippetPlaceholder',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultRow(
                label: 'small:1 medium:2 large:4',
                value:
                    '${context.device.responsive(
                      small: 1,
                      medium: 2,
                      large: 4,
                    )}',
              ),
              ResultRow(
                label: 'small:1 large:4 only',
                value: '${context.device.responsive(small: 1, large: 4)}',
              ),
              ResultRow(
                label: 'small only',
                value: context.device.responsive(small: 'always this'),
              ),
              const SizedBox(height: 16),
              Text(
                'A grid driven by responsive():',
                style: context.general.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              _ResponsiveGrid(
                columns: context.device.responsive(
                  small: 1,
                  medium: 2,
                  expanded: 3,
                  large: 4,
                ),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Derived metrics',
          description:
              'Sizes and paddings are fractions of the viewport, so they track '
              'the window too.',
          snippet:
              'context.sized.dynamicHeight(0.1);\n'
              'context.padding.normal;\n'
              'context.border.normalRadius;',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultRow(
                label: 'sized.lowValue',
                value: context.sized.lowValue.toStringAsFixed(2),
              ),
              ResultRow(
                label: 'sized.normalValue',
                value: context.sized.normalValue.toStringAsFixed(2),
              ),
              ResultRow(
                label: 'sized.mediumValue',
                value: context.sized.mediumValue.toStringAsFixed(2),
              ),
              ResultRow(
                label: 'sized.highValue',
                value: context.sized.highValue.toStringAsFixed(2),
              ),
              ResultRow(
                label: 'padding.normal',
                value: context.padding.normal.toString(),
              ),
              ResultRow(
                label: 'border.normalRadius',
                value: context.border.normalRadius.x.toStringAsFixed(2),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Environment',
          snippet:
              'context.general.isDarkMode;\n'
              'context.general.orientation;\n'
              'context.general.safePadding;',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultRow(
                label: 'isDarkMode',
                value: '${context.general.isDarkMode}',
              ),
              ResultRow(
                label: 'orientation',
                value: context.general.orientation.name,
              ),
              ResultRow(
                label: 'isLandscape',
                value: '${context.general.isLandscape}',
              ),
              ResultRow(label: 'locale', value: '${context.general.locale}'),
              ResultRow(
                label: 'safePadding',
                value: context.general.safePadding.toString(),
              ),
              ResultRow(
                label: 'devicePixelRatio',
                value: context.general.devicePixelRatio.toStringAsFixed(2),
              ),
              ResultRow(
                label: 'isKeyBoardOpen',
                value: '${context.general.isKeyBoardOpen}',
              ),
              ResultRow(
                label: 'platform',
                value: _platformLabel(context),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Configured thresholds',
          description:
              'These come from KartalConfig, so an app on a different design '
              'system can move them once at startup.',
          snippet:
              'KartalConfig.instance.configure(\n'
              '  breakpoints: KartalBreakpoints(\n'
              '    small: 480, medium: 768, large: 1200,\n'
              '  ),\n'
              ');',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultRow(
                label: 'small',
                value: '< ${breakpoints.small.toStringAsFixed(0)}',
              ),
              ResultRow(
                label: 'medium',
                value:
                    '${breakpoints.small.toStringAsFixed(0)} .. '
                    '${breakpoints.medium.toStringAsFixed(0)}',
              ),
              ResultRow(
                label: 'expanded',
                value:
                    '${breakpoints.medium.toStringAsFixed(0)} .. '
                    '${breakpoints.large.toStringAsFixed(0)}',
              ),
              ResultRow(
                label: 'large',
                value: '>= ${breakpoints.large.toStringAsFixed(0)}',
              ),
            ],
          ),
        ),
      ],
    );
  }

  static const _columnsSnippetPlaceholder = '1, 2 or 4 by width';

  String _platformLabel(BuildContext context) {
    final device = context.device;
    if (device.isAndroidDevice) return 'android';
    if (device.isIOSDevice) return 'ios';
    if (device.isMacOSDevice) return 'macos';
    if (device.isWindowsDevice) return 'windows';
    if (device.isLinuxDevice) return 'linux';

    return 'web or unknown';
  }
}

/// A bar showing every band with the active one highlighted.
class _BandIndicator extends StatelessWidget {
  const _BandIndicator({
    required this.width,
    required this.breakpoints,
    required this.current,
  });

  final double width;
  final KartalBreakpoints breakpoints;
  final DeviceBreakpoint current;

  @override
  Widget build(BuildContext context) {
    final scheme = context.general.colorScheme;

    Widget band(DeviceBreakpoint value, String label) {
      final isActive = value == current;

      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? scheme.primary : scheme.surfaceContainerHighest,
          ),
          child: Column(
            children: [
              Text(
                value.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? scheme.primary.ext.contrastText()
                      : scheme.onSurfaceVariant,
                ),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'monospace',
                  color: isActive
                      ? scheme.primary.ext.contrastText()
                      : scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          band(DeviceBreakpoint.small, '<${breakpoints.small.toInt()}'),
          band(
            DeviceBreakpoint.medium,
            '${breakpoints.small.toInt()}-${breakpoints.medium.toInt()}',
          ),
          band(
            DeviceBreakpoint.expanded,
            '${breakpoints.medium.toInt()}-${breakpoints.large.toInt()}',
          ),
          band(DeviceBreakpoint.large, '>=${breakpoints.large.toInt()}'),
        ],
      ),
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({required this.columns});

  final int columns;

  @override
  Widget build(BuildContext context) {
    final scheme = context.general.colorScheme;

    // chunked() from the collection helpers turns a flat list into rows.
    final rows = List.generate(8, (index) => index + 1).ext.chunked(columns);

    return Column(
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                for (final item in row)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: scheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '$item',
                            style: TextStyle(
                              color: scheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                // Keep the last row aligned with the others.
                for (var missing = 0; missing < columns - row.length; missing++)
                  const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
      ],
    );
  }
}
