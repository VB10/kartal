// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/src/utility/bundle/bundle_decoder.dart';

import '../../example/lib/samples/model/false_model.dart';
import '../../example/lib/samples/model/post.dart';
import '../mock/mock_bundle_asset.dart';

void main() {
  late List<Post>? posts;
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    posts = [];
  });
  // test('try to decode bundle json to expected model', () async {
  //   posts = await BundleDecoder('test/files/placeholder.json')
  //       .crackBundle<Post, List<Post>>(model: Post());
  //   expect(posts, isNotNull);
  // });

  // test('expect not decoding to false model', () async {
  //   posts = await BundleDecoder('test/files/placeholder.json')
  //       .crackBundle<Post, List<Post>>(model: Post());
  //   expect(posts, isNot(FalseModel()));
  // });

  // test('expect decoding to not return empty list', () async {
  //   posts = await BundleDecoder('test/files/placeholder.json')
  //       .crackBundle<Post, List<Post>>(model: Post());
  //   expect(posts, isNotEmpty);
  // });

  // test('expect decoding to return correct number of items', () async {
  //   posts = await BundleDecoder('test/files/placeholder.json')
  //       .crackBundle<Post, List<Post>>(model: Post());
  //   expect(posts?.length, 100);
  // });

  test('expect decoding to return correct number of items', () async {
    posts = await BundleDecoder('test/files/placeholder.json')
        .crackBundle<Post, List<Post>>(
      model: Post(),
      assetBundle: MockAssetBundle(),
    );
    expect(posts?.length, 100);
  });

  test('expect decoding to return correct number of items', () async {
    final item = await BundleDecoder('test/files/place_holder_single.json')
        .crackBundle<Post, Post>(model: Post(), assetBundle: MockAssetBundle());
    expect(item != null, true);
  });
}
