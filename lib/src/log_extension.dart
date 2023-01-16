import 'dart:developer' as developer show log;

extension Log on Object {
  void log() => developer.log(toString());
}
