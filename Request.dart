import 'util/BodyParser.dart';

class Request {
  var header = {};
  var body;
  var query;
  var requestMethod;
  var requestPath;
  Map<String?, String> params = {};

  Request(var originalHttpRequest) {
    final dividedRequest =
        String.fromCharCodes(originalHttpRequest).split("\r\n\r\n");

    final requestHeader = dividedRequest[0].split("\r\n");
    final requestBody = dividedRequest[1];

    parseRequestLine(requestHeader[0]);
    parseHeader(requestHeader);
    parseBody(requestBody);
  }

  parseRequestLine(requestLine) {
    final requestLineElems = requestLine.split(' ');

    this.requestMethod = requestLineElems[0];

    var path = requestLineElems[1].split('?');
    this.requestPath = path[0];

    try {
      this.query = BodyParser.urlEncodedDataParser(path[1]);
    } catch (e) {
      this.query = null;
    }
  }

  parseHeader(requestHeader) {
    for (int i = 1; i < requestHeader.length; i++) {
      var currentLineSplited = requestHeader[i].split(": ");
      this.header[currentLineSplited[0]] = currentLineSplited[1];
    }
  }

  parseBody(requestBody) {
    switch (this.header['Content-Type']) {
      case "application/json":
        this.body = BodyParser.jsonParser(requestBody);
        break;
      case "application/x-www-form-urlencoded":
        this.body = BodyParser.urlEncodedDataParser(requestBody);
        break;
    }
  }

  void printHeader() {
    print(this.header);
  }
}
