import 'dart:io';
import 'Exception/FileIsNotExist.dart';
import 'Request.dart';
import 'Response.dart';
import 'router/Router.dart';
import 'util/sendHttp.dart';
import 'DefaultHandler/unsupportedFileFormatHandler.dart';
import 'Exception/UnsupportedFileFormat.dart';

class Dattp {
  late Router router;
  String staticResourceDirectory = 'zpublic';

  Dattp() {
    router = Router();
  }

  listen(int port, void Function() callback,
      {String host = "127.0.0.1"}) async {
    final app = await ServerSocket.bind(host, port);

    callback();

    await for (Socket client in app) {
      client.listen((data) {
        final req = Request(data);
        final res = Response();

        switch (req.requestMethod) {
          case "GET":
            try {
              this.router.findStaticResource(req,
                      File(this.staticResourceDirectory + req.requestPath))(req,
                  res, File(this.staticResourceDirectory + req.requestPath));
              break;
            } on FileIsNotExist {
              try {
                this.router.findGetController(req)(req, res);
                break;
              } on UnsupportedFileFormat {
                unsupportedFileFormatHandler(req, res);
                break;
              }
            } on UnsupportedFileFormat {
              unsupportedFileFormatHandler(req, res);
              break;
            }
          case "POST":
            this.router.findPostController(req.requestPath)(req, res);
            break;
        }
        sendHttp(client, res);
        client.close();
      });
    }
  }

  static(String staticResourceDirectory) {
    this.staticResourceDirectory = staticResourceDirectory;
  }

  get(String urlPath, void Function(Request, Response) controller) {
    this.router.registerGetPath(urlPath, controller);
  }

  post(String urlPath, void Function(Request, Response) controller) {
    this.router.registerPostRouter(urlPath, controller);
  }
}
