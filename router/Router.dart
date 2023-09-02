import '../Exception/CanNotFoundPathLayer.dart';
import '../Request.dart';
import '../Response.dart';
import '../DefaultHandler/notFoundHandler.dart';
import 'PathLayer.dart';

class Router {
  PathLayer rootGetPathLayer = PathLayer();
  PathLayer rootPostPathLayer = PathLayer();
  var postRouteInfo;

  Router() {
    postRouteInfo = {};
  }

  void registerGetPath(
      String urlPath, void Function(Request, Response) controller) {
    if (this.isRoot(urlPath)) {
      rootGetPathLayer.setController(controller);
      return;
    }

    var urlSplited = urlPath.split('/');
    urlSplited.removeAt(0);

    PathLayer currentPathLayer = this.rootGetPathLayer;
    while (urlSplited.length != 0) {
      if (!currentPathLayer.subPath.containsKey(urlSplited[0]))
        currentPathLayer.setSubPath(urlSplited[0]);
      currentPathLayer = currentPathLayer.subPath[urlSplited[0]]!;
      urlSplited.removeAt(0);
    }
    currentPathLayer.setController(controller);
  }

  PathLayer findGetPathLayer(String urlPath) {
    var urlSplited;
    if (this.isRoot(urlPath))
      urlSplited = [];
    else {
      urlSplited = urlPath.split('/');
      urlSplited.removeAt(0);
    }

    PathLayer currentPathLayer = this.rootGetPathLayer;
    while (urlSplited.length != 0) {
      if (!currentPathLayer.subPath.containsKey(urlSplited[0]))
        throw CanNotFoundPathLayer();
      currentPathLayer = currentPathLayer.subPath[urlSplited[0]]!;
      urlSplited.removeAt(0);
    }
    return currentPathLayer;
  }

  bool isRoot(String urlPath) {
    if (urlPath == '/' || urlPath == '')
      return true;
    else
      return false;
  }

  void registerPostRouter(
      String urlPath, void Function(Request, Response) controller) {
    this.postRouteInfo[urlPath] = controller;
  }

  Function findGetController(String urlPath) {
    try {
      return this.findGetPathLayer(urlPath).getController();
    } on CanNotFoundPathLayer {
      return notFoundHandler;
    }
  }

  Function findPostController(String urlPath) {
    try {
      return this.postRouteInfo[urlPath];
    } catch (e) {
      return notFoundHandler;
    }
  }
}
