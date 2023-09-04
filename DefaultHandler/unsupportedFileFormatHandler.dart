import '../Request.dart';
import '../Response.dart';

void unsupportedFileFormatHandler(Request req, Response res) {
  res.status(500);
  res.send("[500] Internal Server Error");
}
