import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'Exception/FileIsNotExist.dart';
import 'Exception/ParameterError.dart';
import 'Exception/UnsupportedFileFormat.dart';
import 'util/MimeTypeChecker.dart';
import 'httpStatusCode.dart';
import 'util/writeHeader.dart';

class Response {
  var header;
  var body;
  var statusCode;
  var httpVersion;

  Response({String httpVersion = "HTTP/1.1"}) {
    this.header = {};
    this.statusCode = 200;
    this.httpVersion = httpVersion;
  }

  void status(int status) {
    this.statusCode = status;
  }

  void send(dynamic body) {
    if (body is String)
      this._text(body);
    else if (body is Map) this._json(body);
  }

  void sendFile(String filePath) {
    File file = File(filePath);
    var fileType = MimeTypeChecker.checkMimeType(file);

    switch (fileType) {
      case "JPEG":
        this.body = file.readAsBytesSync();
        this.header['Content-Type'] = "image/jpeg";
        this.header['Content-Length'] = this.body.length;
        break;
      case "PNG":
        this.body = file.readAsBytesSync();
        this.header['Content-Type'] = "image/png";
        this.header['Content-Length'] = file.lengthSync();
        break;
      case "Unsupported":
        throw UnsupportedFileFormat();
    }
  }

  void download(String filePath) {
    File file = File(filePath);
    if (!file.existsSync()) throw FileIsNotExist();
    String fileName = filePath.split('/').last;

    this.body = file.readAsBytesSync();
    this.header['Content-Type'] = "application/octet-stream";
    this.header['Content-Length'] = file.lengthSync();
    this.header['Content-Disposition'] = 'attachment; filename="$fileName"';
  }

  void _json(Map jsonData) {
    String jsonString = jsonEncode(jsonData);
    this.body = jsonString;
    this.header['Content-Type'] = "application/json";

    this.calcContentLength();
  }

  void _text(String? body) {
    this.body = body;
    this.header['Content-Type'] = "text/plain; charset=utf-8";

    this.calcContentLength();
  }

  void calcContentLength() {
    List<int> contentUtf8 = utf8.encode(this.body);
    this.header['contentLength'] = contentUtf8.length;
  }

  String makeHeader() {
    final responseHeader = StringBuffer();

    writeHeader.addStatusLine(
        responseHeader, this.httpVersion, this.statusCode);
    for (var entry in this.header.entries)
      writeHeader.addHeader(responseHeader, entry.key, entry.value);
    writeHeader.end(responseHeader);

    return responseHeader.toString();
  }
}
