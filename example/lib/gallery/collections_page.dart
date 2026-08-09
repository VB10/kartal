import 'package:example/gallery/gallery_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

final class _Person {
  const _Person(this.name, this.city, this.age);

  final String name;
  final String city;
  final int age;

  @override
  String toString() => name;
}

const _people = <_Person>[
  _Person('Veli', 'Istanbul', 34),
  _Person('Ayşe', 'Ankara', 28),
  _Person('Mehmet', 'Istanbul', 41),
  _Person('Zeynep', 'İzmir', 19),
  _Person('Can', 'Ankara', 52),
  _Person('Elif', 'Istanbul', 23),
];

/// Collection and async playground.
class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  var _chunkSize = 2;

  // Rate limiter demo state.
  late final Debouncer _debouncer;
  late final Throttler _throttler;
  final _search = TextEditingController();
  var _debouncedQuery = '';
  var _rawKeystrokes = 0;
  var _debouncedCalls = 0;
  var _throttleAttempts = 0;
  var _throttlePasses = 0;

  // Retry demo state.
  var _retryLog = <String>[];
  var _isRetrying = false;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(const Duration(milliseconds: 400));
    _throttler = Throttler(const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _throttler.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numbers = List.generate(9, (index) => index + 1);
    final (adults, minors) = _people.ext.partition((p) => p.age >= 30);

    return GalleryBody(
      children: [
        DemoSection(
          title: 'chunked',
          description:
              'The final chunk holds the remainder, so nothing is '
              'dropped.',
          snippet: '$numbers.ext.chunked($_chunkSize);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('size', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      value: _chunkSize.toDouble(),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: '$_chunkSize',
                      onChanged: (value) =>
                          setState(() => _chunkSize = value.round()),
                    ),
                  ),
                ],
              ),
              ResultRow(
                label: 'chunked($_chunkSize)',
                value: '${numbers.ext.chunked(_chunkSize)}',
              ),
              ResultRow(
                label: 'paged($_chunkSize)',
                value: '${numbers.ext.paged(_chunkSize)}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'groupBy and distinctBy',
          snippet:
              'people.ext.groupBy((p) => p.city);\n'
              'people.ext.distinctBy((p) => p.city);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final entry in _people.ext.groupBy((p) => p.city).entries)
                ResultRow(label: entry.key, value: '${entry.value}'),
              const Divider(height: 20),
              ResultRow(
                label: 'distinctBy(city)',
                value: '${_people.ext.distinctBy((p) => p.city)}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'sortedBy, sumBy and averageBy',
          description:
              'sortedBy does not mutate the receiver. averageBy returns null '
              'for an empty collection rather than NaN.',
          snippet:
              'people.ext.sortedBy((p) => p.age);\n'
              'people.ext.averageBy((p) => p.age);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultRow(
                label: 'sortedBy(age)',
                value: '${_people.ext.sortedBy((p) => p.age)}',
              ),
              ResultRow(
                label: 'sortedByDescending',
                value: '${_people.ext.sortedByDescending((p) => p.age)}',
              ),
              ResultRow(
                label: 'sumBy(age)',
                value: '${_people.ext.sumBy((p) => p.age)}',
              ),
              ResultRow(
                label: 'averageBy(age)',
                value: '${_people.ext.averageBy((p) => p.age)}',
              ),
              ResultRow(
                label: 'empty averageBy',
                value: '${<_Person>[].ext.averageBy((p) => p.age)}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'partition',
          description: 'Returns a record, so both halves are named.',
          snippet:
              'final (adults, minors) = '
              'people.ext.partition((p) => p.age >= 30);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultRow(label: '30 and over', value: '$adults'),
              ResultRow(label: 'under 30', value: '$minors'),
            ],
          ),
        ),
        DemoSection(
          title: 'List helpers',
          description: 'None of these mutate the receiver.',
          snippet:
              '$numbers.ext.takeLast(3);\n'
              '$numbers.ext.swap(0, 8);\n'
              '[1, 2, 3].ext.separatedBy(0);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResultRow(
                label: 'takeLast(3)',
                value: '${numbers.ext.takeLast(3)}',
              ),
              ResultRow(
                label: 'swap(0, 8)',
                value: '${numbers.ext.swap(0, 8)}',
              ),
              ResultRow(
                label: 'separatedBy(0)',
                value: '${[1, 2, 3].ext.separatedBy(0)}',
              ),
              ResultRow(
                label: 'replaceAt(1, 99)',
                value: '${numbers.ext.replaceAt(1, 99)}',
              ),
              ResultRow(
                label: 'elementAtOrNull(99)',
                value: '${numbers.ext.elementAtOrNull(99)}',
              ),
              ResultRow(
                label: 'randomOrNull(seed: 7)',
                value: '${numbers.ext.randomOrNull(seed: 7)}',
              ),
              ResultRow(
                label: 'mapIndexed',
                value: '${numbers.ext.mapIndexed((i, e) => '$i:$e')}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Debouncer',
          description:
              'Type quickly: only the last keystroke in each burst runs the '
              'search. Compare the two counters.',
          snippet:
              'final _debouncer =\n'
              '    Debouncer(const Duration(milliseconds: 400));\n'
              '\n'
              'void onChanged(String q) => _debouncer.call(() => search(q));',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _search,
                onChanged: (value) {
                  setState(() => _rawKeystrokes++);
                  _debouncer.call(
                    () => setState(() {
                      _debouncedQuery = value;
                      _debouncedCalls++;
                    }),
                  );
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 16),
              ResultRow(label: 'keystrokes', value: '$_rawKeystrokes'),
              ResultRow(label: 'debounced calls', value: '$_debouncedCalls'),
              ResultRow(label: 'last query', value: _debouncedQuery),
              ResultRow(label: 'isPending', value: '${_debouncer.isPending}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _debouncer.cancel();
                      setState(() {});
                    },
                    child: const Text('cancel()'),
                  ),
                  OutlinedButton(
                    onPressed: () => setState(() {
                      _rawKeystrokes = 0;
                      _debouncedCalls = 0;
                      _debouncedQuery = '';
                      _search.clear();
                    }),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Throttler',
          description:
              'Tap repeatedly: the first call in each 500ms window runs and '
              'the rest are dropped.',
          snippet:
              'final _throttler =\n'
              '    Throttler(const Duration(milliseconds: 500));\n'
              '\n'
              'void onScroll() => _throttler.call(updateHeader);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilledButton.tonal(
                onPressed: () {
                  setState(() => _throttleAttempts++);
                  _throttler.call(() => setState(() => _throttlePasses++));
                },
                child: const Text('Tap me fast'),
              ),
              const SizedBox(height: 12),
              ResultRow(label: 'attempts', value: '$_throttleAttempts'),
              ResultRow(label: 'accepted', value: '$_throttlePasses'),
              ResultRow(
                label: 'dropped',
                value: '${_throttleAttempts - _throttlePasses}',
              ),
              ResultRow(
                label: 'isThrottled',
                value: '${_throttler.isThrottled}',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'kartalRetry',
          description:
              'A top level function rather than a future member, because a '
              'Future can only be awaited once and retrying needs a fresh one '
              'per attempt. This demo fails twice then succeeds.',
          snippet:
              'final data = await kartalRetry(\n'
              '  () => api.fetch(),\n'
              '  attempts: 4,\n'
              '  delay: const Duration(milliseconds: 300),\n'
              '  exponentialBackoff: true,\n'
              ');',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilledButton.tonal(
                onPressed: _isRetrying ? null : _runRetryDemo,
                child: Text(_isRetrying ? 'Running…' : 'Run retry'),
              ),
              const SizedBox(height: 12),
              for (final line in _retryLog) ResultRow(label: '', value: line),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _runRetryDemo() async {
    setState(() {
      _isRetrying = true;
      _retryLog = <String>['starting…'];
    });

    var attempt = 0;

    try {
      final result = await kartalRetry(
        () async {
          attempt++;
          setState(() => _retryLog = [..._retryLog, 'attempt $attempt']);

          if (attempt < 3) throw Exception('transient failure');

          return 'succeeded on attempt $attempt';
        },
        attempts: 4,
        delay: const Duration(milliseconds: 300),
        exponentialBackoff: true,
      );

      if (!mounted) return;
      setState(() => _retryLog = [..._retryLog, result]);
    } on Exception catch (error) {
      if (!mounted) return;
      setState(() => _retryLog = [..._retryLog, 'gave up: $error']);
    } finally {
      if (mounted) setState(() => _isRetrying = false);
    }
  }
}
