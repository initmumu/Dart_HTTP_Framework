import 'dart:io';

import 'isEqual.dart';

class MimeTypeChecker {
  static String checkMimeType(File file) {
    if (MimeTypeChecker.isJpeg(file))
      return "JPEG";
    else if (MimeTypeChecker.isPng(file)) return "PNG";
    return "Unsupported";
  }

  static bool isJpeg(File file) {
    RandomAccessFile f = file.openSync(mode: FileMode.read);

    List<int> buffer = List.filled(3, 0);
    f.readIntoSync(buffer, 0, 3);
    return (isListsEqual(buffer, [255, 216, 255]));
  }

  static bool isPng(File file) {
    RandomAccessFile f = file.openSync(mode: FileMode.read);

    List<int> buffer = List.filled(8, 0);
    f.readIntoSync(buffer, 0, 8);
    return (isListsEqual(buffer, [137, 80, 78, 71, 13, 10, 26, 10]));
  }
}
