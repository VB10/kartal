import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

final class _Person {
  const _Person(this.name, this.city, this.age);

  final String name;
  final String city;
  final int age;
}

const _people = <_Person>[
  _Person('Veli', 'Istanbul', 34),
  _Person('Ayse', 'Ankara', 28),
  _Person('Mehmet', 'Istanbul', 41),
  _Person('Zeynep', 'Izmir', 19),
];

void main() {
  group('chunked', () {
    test('splits into fixed size chunks and keeps the remainder', () {
      expect([1, 2, 3, 4, 5].ext.chunked(2), [
        [1, 2],
        [3, 4],
        [5],
      ]);
      expect([1, 2, 3, 4].ext.chunked(2), [
        [1, 2],
        [3, 4],
      ]);
    });

    test('handles a chunk size larger than the collection', () {
      expect([1, 2].ext.chunked(10), [
        [1, 2],
      ]);
    });

    test('returns nothing for an empty collection', () {
      expect(<int>[].ext.chunked(3), isEmpty);
    });

    test('rejects a non positive size instead of hanging', () {
      expect(() => [1, 2].ext.chunked(0), throwsRangeError);
      expect(() => [1, 2].ext.chunked(-1), throwsRangeError);
    });

    test('works the same on a non-list Iterable', () {
      final iterable = [1, 2, 3, 4, 5].map((e) => e);

      expect(iterable.ext.chunked(2), [
        [1, 2],
        [3, 4],
        [5],
      ]);
    });
  });

  group('groupBy', () {
    test('groups elements under their key', () {
      final byCity = _people.ext.groupBy((p) => p.city);

      expect(byCity.keys, containsAll(['Istanbul', 'Ankara', 'Izmir']));
      expect(byCity['Istanbul']!.map((p) => p.name), ['Veli', 'Mehmet']);
      expect(byCity['Izmir']!.single.name, 'Zeynep');
    });

    test('returns an empty map for an empty collection', () {
      expect(<_Person>[].ext.groupBy((p) => p.city), isEmpty);
    });
  });

  group('distinctBy', () {
    test('keeps the first occurrence and preserves order', () {
      final unique = _people.ext.distinctBy((p) => p.city);

      expect(unique.map((p) => p.name), ['Veli', 'Ayse', 'Zeynep']);
    });

    test('leaves an already unique collection untouched', () {
      expect([1, 2, 3].ext.distinctBy((e) => e), [1, 2, 3]);
    });
  });

  group('sortedBy', () {
    test('sorts ascending without mutating the receiver', () {
      final source = [3, 1, 2];
      final sorted = source.ext.sortedBy((e) => e);

      expect(sorted, [1, 2, 3]);
      expect(source, [3, 1, 2], reason: 'the receiver must not be mutated');
    });

    test('sorts by a derived key', () {
      expect(_people.ext.sortedBy((p) => p.age).map((p) => p.name), [
        'Zeynep',
        'Ayse',
        'Veli',
        'Mehmet',
      ]);
    });

    test('sortedByDescending reverses the order', () {
      expect(_people.ext.sortedByDescending((p) => p.age).first.name, 'Mehmet');
      expect([1, 3, 2].ext.sortedByDescending((e) => e), [3, 2, 1]);
    });

    test('sorts strings lexicographically', () {
      expect(['c', 'a', 'b'].ext.sortedBy((e) => e), ['a', 'b', 'c']);
    });
  });

  group('sumBy and averageBy', () {
    test('sums a derived value', () {
      expect(_people.ext.sumBy((p) => p.age), 122);
      expect([1, 2, 3].ext.sumBy((e) => e), 6);
    });

    test('sums to zero for an empty collection', () {
      expect(<int>[].ext.sumBy((e) => e), 0);
    });

    test('averages a derived value', () {
      expect(_people.ext.averageBy((p) => p.age), 30.5);
      expect([2, 4].ext.averageBy((e) => e), 3.0);
    });

    test('averages to null for an empty collection, not NaN', () {
      // Distinguishes "no data" from a genuine zero average.
      expect(<int>[].ext.averageBy((e) => e), isNull);
    });
  });

  group('partition', () {
    test('splits on the predicate', () {
      final (adults, minors) = _people.ext.partition((p) => p.age >= 18);

      expect(adults.length, 4);
      expect(minors, isEmpty);

      final (over30, under30) = _people.ext.partition((p) => p.age > 30);
      expect(over30.map((p) => p.name), ['Veli', 'Mehmet']);
      expect(under30.map((p) => p.name), ['Ayse', 'Zeynep']);
    });

    test('handles an empty collection', () {
      final (matching, rest) = <int>[].ext.partition((e) => true);

      expect(matching, isEmpty);
      expect(rest, isEmpty);
    });
  });

  group('mapIndexed', () {
    test('supplies the index alongside the element', () {
      expect(['a', 'b', 'c'].ext.mapIndexed((i, e) => '$i:$e'), [
        '0:a',
        '1:b',
        '2:c',
      ]);
    });
  });

  group('firstWhereOrNull', () {
    test('returns null instead of throwing when nothing matches', () {
      expect([1, 2, 3].ext.firstWhereOrNull((e) => e > 10), isNull);
      expect([1, 2, 3].ext.firstWhereOrNull((e) => e > 1), 2);
    });
  });

  group('randomOrNull', () {
    test('returns null for an empty collection', () {
      expect(<int>[].ext.randomOrNull(), isNull);
    });

    test('is deterministic for a given seed', () {
      const source = [1, 2, 3, 4, 5];

      expect(
        source.ext.randomOrNull(seed: 7),
        source.ext.randomOrNull(seed: 7),
      );
    });

    test('always returns a member of the collection', () {
      const source = [1, 2, 3, 4, 5];

      for (var seed = 0; seed < 30; seed++) {
        expect(source, contains(source.ext.randomOrNull(seed: seed)));
      }
    });
  });

  group('paged', () {
    test('keys the chunks by page index', () {
      expect([1, 2, 3, 4, 5].ext.paged(2), {
        0: [1, 2],
        1: [3, 4],
        2: [5],
      });
    });
  });

  group('list specific helpers', () {
    test('swap exchanges two positions without mutating', () {
      final source = [1, 2, 3];

      expect(source.ext.swap(0, 2), [3, 2, 1]);
      expect(source, [1, 2, 3]);
    });

    test('swap rejects out of range indices', () {
      expect(() => [1, 2].ext.swap(0, 5), throwsRangeError);
      expect(() => [1, 2].ext.swap(-1, 0), throwsRangeError);
    });

    test('takeLast returns the tail, clamped to the length', () {
      expect([1, 2, 3, 4, 5].ext.takeLast(2), [4, 5]);
      expect([1, 2].ext.takeLast(10), [1, 2]);
      expect([1, 2].ext.takeLast(0), isEmpty);
      expect([1, 2].ext.takeLast(-1), isEmpty);
    });

    test('separatedBy interleaves without a trailing separator', () {
      expect([1, 2, 3].ext.separatedBy(0), [1, 0, 2, 0, 3]);
      expect([1].ext.separatedBy(0), [1]);
      expect(<int>[].ext.separatedBy(0), isEmpty);
    });

    test('replaceAt swaps one element without mutating', () {
      final source = [1, 2, 3];

      expect(source.ext.replaceAt(1, 9), [1, 9, 3]);
      expect(source, [1, 2, 3]);
      expect(() => source.ext.replaceAt(5, 9), throwsRangeError);
    });

    test('elementAtOrNull is bounds safe', () {
      expect([1, 2, 3].ext.elementAtOrNull(1), 2);
      expect([1, 2, 3].ext.elementAtOrNull(5), isNull);
      expect([1, 2, 3].ext.elementAtOrNull(-1), isNull);
    });
  });

  group('null list handling', () {
    test('the helpers treat a null list as empty', () {
      const List<int>? nullList = null;

      expect(nullList.ext.chunked(2), isEmpty);
      expect(nullList.ext.sumBy((e) => e), 0);
      expect(nullList.ext.averageBy((e) => e), isNull);
      expect(nullList.ext.takeLast(2), isEmpty);
      expect(nullList.ext.elementAtOrNull(0), isNull);
      expect(nullList.ext.isNullOrEmpty, isTrue);
    });
  });

  group('existing behaviour is preserved', () {
    test('exts.makeSafe still strips nulls', () {
      final Iterable<int?> source = [1, 2, null, 4];

      expect(source.exts.makeSafe(), [1, 2, 4]);
    });

    test('exts.makeSafeCustom still filters', () {
      final Iterable<int?> source = [-1, 1, null, 2];

      expect(source.exts.makeSafeCustom((e) => e != null && e > 0), [1, 2]);
    });

    test('list isNullOrEmpty and indexOrNull are unchanged', () {
      const List<int>? nullList = null;

      expect(nullList.ext.isNullOrEmpty, isTrue);
      expect(<int>[].ext.isNullOrEmpty, isTrue);
      expect([1].ext.isNotNullOrEmpty, isTrue);
      expect([1, 2, 3].ext.indexOrNull((e) => e == 2), 1);
      expect([1, 2, 3].ext.indexOrNull((e) => e == 9), isNull);
    });
  });
}
