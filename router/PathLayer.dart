import '../DefaultHandler/notFoundHandler.dart';

class PathLayer {
  var curPath;
  Function controller = notFoundHandler;
  Map<String, PathLayer> subPath = {};

  PathLayer({path = ''}) {
    this.curPath = path;
  }

  setSubPath(String nextPath) {
    this.subPath[nextPath] = PathLayer(path: nextPath);
  }

  setController(controller) {
    this.controller = controller;
  }

  Map<String, PathLayer> getSubPath() {
    return this.subPath;
  }

  Function getController() {
    return this.controller;
  }
}
