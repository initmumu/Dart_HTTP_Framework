import 'dart:io';
import 'Response.dart';
import 'Router.dart';
import 'Request.dart';

void handleClient(Socket client, Router router) {
  client.listen(
    (data) {
      final req = Request(data);
      final res = Response();

      switch (req.method) {
        case "GET":
          router.findGetController(req.path)(req, res);
          break;
      }

      client.write(res.makeResponse());
      if (res.header["contentType"] == "image/jpeg") client.add(res.body);
      client.close();
    },
    onError: (error) {
      print(error);
      client.close();
    },
    onDone: () {},
  );
}
