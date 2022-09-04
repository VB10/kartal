import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/src/utility/bundle/bundle_decoder.dart';

import '../../example/lib/samples/model/false_model.dart';
import '../../example/lib/samples/model/post.dart';

void main() {
  late List<Post>? posts;
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    posts = [];
  });
  test('try to decode bundle json to expected model', () async {
    posts = await BundleDecoder('assets/placeholder.json').crackBundle<Post, List<Post>>(model: Post());
    expect(posts, isNotNull);
  });

  test('expect not decoding to false model', () async {
    posts = await BundleDecoder('assets/placeholder.json').crackBundle<Post, List<Post>>(model: Post());
    expect(posts, isNot(FalseModel()));
  });

  test('expect decoding to not return empty list', () async {
    posts = await BundleDecoder('assets/placeholder.json').crackBundle<Post, List<Post>>(model: Post());
    expect(posts, isNotEmpty);
  });

  test('expect decoding to return correct number of items', () async {
    posts = await BundleDecoder('assets/placeholder.json').crackBundle<Post, List<Post>>(model: Post());
    expect(posts?.length, 100);
  });
}
