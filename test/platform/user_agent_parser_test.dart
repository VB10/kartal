import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/src/private/platform/user_agent_parser.dart';

void main() {
  group('UserAgentPlatform.from', () {
    // Real user agent strings. The overlapping ones are the point of this
    // test: Android reports "Linux" and iOS reports "like Mac OS X", so a
    // naive contains() chain in the wrong order misclassifies both.
    const agents = <String, UserAgentPlatform>{
      'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) '
              'AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 '
              'Mobile/15E148 Safari/604.1':
          UserAgentPlatform.ios,
      'Mozilla/5.0 (iPad; CPU OS 17_5 like Mac OS X) AppleWebKit/605.1.15':
          UserAgentPlatform.ios,
      'Mozilla/5.0 (iPod touch; CPU iPhone OS 17_5 like Mac OS X)':
          UserAgentPlatform.ios,
      'Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, '
              'like Gecko) Chrome/126.0.0.0 Mobile Safari/537.36':
          UserAgentPlatform.android,
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 '
              '(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36':
          UserAgentPlatform.macOS,
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, '
              'like Gecko) Chrome/126.0.0.0 Safari/537.36':
          UserAgentPlatform.windows,
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) '
              'Chrome/126.0.0.0 Safari/537.36':
          UserAgentPlatform.linux,
      'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:127.0) Gecko/20100101 '
              'Firefox/127.0':
          UserAgentPlatform.linux,
    };

    for (final entry in agents.entries) {
      final agent = entry.key;
      final expected = entry.value;

      test('classifies ${expected.name} from ${agent.substring(0, 32)}...', () {
        expect(UserAgentPlatform.from(agent), expected);
      });
    }

    test('an iOS agent is not reported as macOS despite "like Mac OS X"', () {
      const iphone =
          'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) Safari/604.1';

      expect(UserAgentPlatform.from(iphone), UserAgentPlatform.ios);
      expect(
        UserAgentPlatform.from(iphone),
        isNot(UserAgentPlatform.macOS),
        reason: 'iOS user agents contain the substring "Mac OS X"',
      );
    });

    test('an Android agent is not reported as Linux', () {
      const pixel = 'Mozilla/5.0 (Linux; Android 14; Pixel 8) Safari/537.36';

      expect(UserAgentPlatform.from(pixel), UserAgentPlatform.android);
      expect(
        UserAgentPlatform.from(pixel),
        isNot(UserAgentPlatform.linux),
        reason: 'Android user agents contain the substring "Linux"',
      );
    });

    test('falls back to unknown for null, empty, and unrecognised input', () {
      expect(UserAgentPlatform.from(null), UserAgentPlatform.unknown);
      expect(UserAgentPlatform.from(''), UserAgentPlatform.unknown);
      expect(UserAgentPlatform.from('curl/8.4.0'), UserAgentPlatform.unknown);
    });

    test('is case insensitive', () {
      expect(
        UserAgentPlatform.from('MOZILLA/5.0 (WINDOWS NT 10.0; WIN64)'),
        UserAgentPlatform.windows,
      );
    });
  });
}
