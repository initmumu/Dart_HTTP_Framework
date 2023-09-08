import '../DefaultHandler/staticFileTransfer.dart';
import '../Exception/CanNotFoundPathLayer.dart';
import '../Exception/FileIsNotExist.dart';
import '../Exception/ParameterError.dart';
import '../Request.dart';
import '../Response.dart';
import '../DefaultHandler/notFoundHandler.dart';
import 'PathLayer.dart';
import 'dart:io';

class Router {
  PathLayer rootGetPathLayer = PathLayer();
  PathLayer rootPostPathLayer = PathLayer();
  var postRouteInfo;

  Router() {
    postRouteInfo = {};
  }

  Function findStaticResource(Request req, File resource) {
    if (resource.existsSync()) {
      return staticFileTransferHandler;
    } else {
      throw FileIsNotExist();
    }
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

  PathLayer findGetPathLayer(Request req) {
    String urlPath = req.requestPath;
    if (this.isRoot(urlPath)) return this.rootGetPathLayer;

    var urlSplited = urlPath.split('/');
    urlSplited.removeAt(0);

    PathLayer currentPathLayer = this.rootGetPathLayer;
    while (urlSplited.length != 0) {
      String? nextPath;
      if (!currentPathLayer.subPath.containsKey(urlSplited[0]) &&
          !currentPathLayer.hasVariableLayer) {
        throw CanNotFoundPathLayer();
      }
      if (currentPathLayer.hasVariableLayer) {
        nextPath = ":${currentPathLayer.variableLayerName}";
        req.params[currentPathLayer.variableLayerName] = urlSplited[0];
      } else {
        nextPath = urlSplited[0];
      }
      currentPathLayer = currentPathLayer.subPath[nextPath]!;

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

  Function findGetController(Request req) {
    try {
      return this.findGetPathLayer(req).getController();
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
