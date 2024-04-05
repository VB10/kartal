export 'app_file_extension.dart'
    if (dart.library.html) 'web_file_extension.dart';
export 'web_file_extension.dart' if (dart.library.io) 'app_file_extension.dart';
