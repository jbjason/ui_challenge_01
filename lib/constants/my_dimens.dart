import 'dart:developer' as developer;

abstract class MyDimens {
  static void logInfo(String msg) {
    developer.log('\x1B[34m$msg\x1B[0m'); // Blue
  }

  static void logError(String msg) {
    developer.log('\x1B[31m$msg\x1B[0m'); // Red
  }

  
}
