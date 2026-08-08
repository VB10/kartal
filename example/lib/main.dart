import 'package:example/gallery/collections_page.dart';
import 'package:example/gallery/colors_page.dart';
import 'package:example/gallery/formatters_page.dart';
import 'package:example/gallery/overlay_page.dart';
import 'package:example/gallery/responsive_page.dart';
import 'package:example/gallery/validators_page.dart';
import 'package:example/gallery/widgets_page.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Demonstrates the one-time configuration hook. Breakpoints are left at
  // their defaults so the responsive page shows the documented bands.
  KartalConfig.instance.configure(dateLabel: const DateLocalizationLabel());

  runApp(const KartalGalleryApp());
}

/// One page per feature set, each an interactive playground.
const _pages = <_GalleryPage>[
  _GalleryPage(
    label: 'Validators',
    icon: Icons.verified_outlined,
    builder: ValidatorsPage.new,
  ),
  _GalleryPage(
    label: 'Formatters',
    icon: Icons.numbers_outlined,
    builder: FormattersPage.new,
  ),
  _GalleryPage(
    label: 'Colours',
    icon: Icons.palette_outlined,
    builder: ColorsPage.new,
  ),
  _GalleryPage(
    label: 'Responsive',
    icon: Icons.devices_outlined,
    builder: ResponsivePage.new,
  ),
  _GalleryPage(
    label: 'Collections',
    icon: Icons.list_alt_outlined,
    builder: CollectionsPage.new,
  ),
  _GalleryPage(
    label: 'Widgets',
    icon: Icons.widgets_outlined,
    builder: WidgetsPage.new,
  ),
  _GalleryPage(
    label: 'Overlays',
    icon: Icons.layers_outlined,
    builder: OverlayPage.new,
  ),
];

final class _GalleryPage {
  const _GalleryPage({
    required this.label,
    required this.icon,
    required this.builder,
  });

  final String label;
  final IconData icon;
  final Widget Function() builder;
}

class KartalGalleryApp extends StatefulWidget {
  const KartalGalleryApp({super.key});

  @override
  State<KartalGalleryApp> createState() => _KartalGalleryAppState();
}

class _KartalGalleryAppState extends State<KartalGalleryApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'kartal gallery',
    debugShowCheckedModeBanner: false,
    themeMode: _themeMode,
    theme: _themeFor(Brightness.light),
    darkTheme: _themeFor(Brightness.dark),
    home: _GalleryShell(
      onToggleTheme: () => setState(
        () => _themeMode = _themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
    ),
  );

  ThemeData _themeFor(Brightness brightness) => ThemeData(
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F51B5),
      brightness: brightness,
    ),
  );
}

class _GalleryShell extends StatefulWidget {
  const _GalleryShell({required this.onToggleTheme});

  final VoidCallback onToggleTheme;

  @override
  State<_GalleryShell> createState() => _GalleryShellState();
}

class _GalleryShellState extends State<_GalleryShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // The shell itself is the live demo of context.device.responsive: a bottom
    // bar on phones, a rail on tablets, an extended rail on desktop. Resize
    // the browser window to watch it switch.
    final navigationStyle = context.device.responsive(
      small: _NavigationStyle.bottom,
      medium: _NavigationStyle.bottom,
      expanded: _NavigationStyle.rail,
      large: _NavigationStyle.extendedRail,
    );

    final page = _pages[_index];

    return Scaffold(
      appBar: AppBar(
        title: Text(page.label),
        actions: [
          IconButton(
            tooltip: context.general.isDarkMode ? 'Light mode' : 'Dark mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(
              context.general.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (navigationStyle != _NavigationStyle.bottom)
            _SideNavigation(
              index: _index,
              extended: navigationStyle == _NavigationStyle.extendedRail,
              onSelected: (value) => setState(() => _index = value),
            ),
          Expanded(child: page.builder()),
        ],
      ),
      bottomNavigationBar: navigationStyle == _NavigationStyle.bottom
          ? _BottomNavigation(
              index: _index,
              onSelected: (value) => setState(() => _index = value),
            )
          : null,
    );
  }
}

enum _NavigationStyle { bottom, rail, extendedRail }

class _SideNavigation extends StatelessWidget {
  const _SideNavigation({
    required this.index,
    required this.extended,
    required this.onSelected,
  });

  final int index;
  final bool extended;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => NavigationRail(
    selectedIndex: index,
    extended: extended,
    onDestinationSelected: onSelected,
    destinations: [
      for (final page in _pages)
        NavigationRailDestination(
          icon: Icon(page.icon),
          label: Text(page.label),
        ),
    ],
  );
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.index, required this.onSelected});

  final int index;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: index,
    onDestinationSelected: onSelected,
    destinations: [
      for (final page in _pages)
        NavigationDestination(icon: Icon(page.icon), label: page.label),
    ],
  );
}
