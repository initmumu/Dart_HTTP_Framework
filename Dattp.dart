import 'dart:io';
import 'Request.dart';
import 'Response.dart';
import 'router/Router.dart';

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
      client.listen(
        (data) {
          final req = Request(data);
          final res = Response();

          switch (req.requestMethod) {
            case "GET":
              this.router.findGetController(req.requestPath)(req, res);
              break;
            case "POST":
              this.router.findPostController(req.requestPath)(req, res);
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
  }

  get(String urlPath, void Function(Request, Response) controller) {
    this.router.registerGetPath(urlPath, controller);
  }

  post(String urlPath, void Function(Request, Response) controller) {
    this.router.registerPostRouter(urlPath, controller);
  }
}
