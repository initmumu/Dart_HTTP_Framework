class Request {
  var method;
  var path;

  Request(var originalHttpRequest) {
    final request = String.fromCharCodes(originalHttpRequest);

    final requestLine = request.split("\r\n")[0];
    final components = requestLine.split(' ');

    this.method = components[0];
    this.path = components[1];
  }
}
