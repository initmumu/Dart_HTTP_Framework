import 'dart:io';
import 'Request.dart';
import 'Response.dart';
import 'Router.dart';
import 'handleClient.dart';

class Dattp {
  var router;

  Dattp() {
    router = Router();
  }

  listen(int port, void Function() callback,
      {String host = "127.0.0.1"}) async {
    final app = await ServerSocket.bind(host, port);

    callback();

    await for (Socket client in app) {
      handleClient(client, this.router);
    }
  }

  get(String urlPath, void Function(Request, Response) controller) {
    this.router.registerGetRouter(urlPath, controller);
  }
}
