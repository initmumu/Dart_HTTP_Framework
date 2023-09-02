import 'dart:convert';
import 'dart:typed_data';
import 'httpStatusCode.dart';

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

  void send(var body) {
    this.body = body;
    this.header['contentType'] = "image/jpeg";

    this.header['contentLength'] = body.length;
  }

  void text(String body) {
    this.body = body;
    this.header['contentType'] = "text/plain; charset=utf-8";

    this.calcContentLength();
  }

  void calcContentLength() {
    List<int> contentUtf8 = utf8.encode(this.body);
    this.header['contentLength'] = contentUtf8.length;
  }

  String makeStartLine() {
    final startLine =
        '${this.httpVersion} ${this.statusCode} ${httpStatusCode[this.statusCode]}';
    return startLine;
  }

  String makeResponse() {
    final response = StringBuffer();

    response.write('${this.makeStartLine()}\r\n');
    response.write('Content-Type: ${this.header["contentType"]}\r\n');
    response.write('Content-Length: ${this.header["contentLength"]}\r\n');
    response.write('\r\n');

    if (this.header['contentType'] != "image/jpeg")
      response.write('${this.body}');

    return response.toString();
  }
}
