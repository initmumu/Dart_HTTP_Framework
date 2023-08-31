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
      res.makeResponse();

      client.write(res.response);
      client.close();
    },
    onError: (error) {
      print(error);
      client.close();
    },
    onDone: () {
      print('Client disconnected');
    },
  );
}
