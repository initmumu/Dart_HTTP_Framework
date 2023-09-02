import '../Request.dart';
import '../Response.dart';

void notFoundHandler(Request req, Response res) {
  res.status(404);
  res.text("[404] Not Found");
}
