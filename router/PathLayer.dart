import '../DefaultHandler/notFoundHandler.dart';

class PathLayer {
  var curPath;
  Function controller = notFoundHandler;
  Map<String, PathLayer> subPath = {};
  bool hasVariableLayer = false;
  String? variableLayerName;

  PathLayer({path = '', String? pathVariableName = null}) {
    this.curPath = path;
    this.variableLayerName = pathVariableName;
  }

  setSubPath(String nextPath) {
    PathLayer nextLayer;
    if (nextPath[0] == ":") {
      this.hasVariableLayer = true;
      this.variableLayerName = nextPath.substring(1);
    }
    nextLayer = PathLayer(path: nextPath);

    this.subPath[nextPath] = nextLayer;
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
