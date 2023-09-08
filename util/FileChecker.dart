import 'dart:io';

class FileChecker {
  static bool isTextFile(File file) {
    List<int> bytes = file.readAsBytesSync();

    for (int byte in bytes) {
      if (byte < 8 || (byte > 13 && byte < 32) && byte != 27) {
        // 고려: ESC (27), Tab (9), CR (13), LF (10), FF (12)
        return false; // 인쇄 불가능한 문자 발견
      }
    }
  }
}
