import '../httpStatusCode.dart';

class writeHeader {
  static void addStatusLine(
      StringBuffer header, String httpVersion, int statusCode) {
    header.write("${httpVersion} ${statusCode} ${httpStatusCode[statusCode]}");
  }

  static void addHeader(StringBuffer header, String property, dynamic value) {
    header.write("${property}: ${value}\r\n");
  }

  static void end(StringBuffer header) {
    header.write("\r\n");
  }
}
