import 'dart:convert';

class Response {
  var statusCode;
  var httpVersion;
  var contentType;
  var contentLength;
  var contentBody;
  var response;

  Response(
      {String contentBody = "TEMP",
      String statusCode = "200 OK",
      String httpVersion = "HTTP/1.1",
      String contentType = "text/plain; charset=utf-8"}) {
    this.statusCode = statusCode;
    this.httpVersion = httpVersion;
    this.contentType = contentType;
    this.contentBody = contentBody;
  }

  void text(String contentBody) {
    this.contentBody = contentBody;
  }

  void calcContentLength() {
    List<int> contentUtf8 = utf8.encode(contentBody);
    this.contentLength = contentUtf8.length;
  }

  void makeResponse() {
    final response = StringBuffer();
    this.calcContentLength();

    response.write('${this.httpVersion} ${this.statusCode}\r\n');
    response.write('Content-Type: ${this.contentType}\r\n');
    response.write('Content-Length: ${this.contentLength}\r\n');
    response.write('\r\n');
    response.write('${contentBody}');

    this.response = response.toString();
  }
}
