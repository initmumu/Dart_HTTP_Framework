import '../Request.dart';
import '../Response.dart';

void notFoundHandler(Request req, Response res) {
  res.status(404);
  res.send("[404] Not Found");
}
