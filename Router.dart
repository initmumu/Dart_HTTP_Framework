import 'dart:convert';

import 'Request.dart';
import 'Response.dart';

class Router {
  var getRouteInfo;

  Router() {
    this.getRouteInfo = {};
  }

  void registerGetRouter(
      String urlPath, void Function(Request, Response) controller) {
    this.getRouteInfo[urlPath] = controller;
  }

  Function findGetController(String urlPath) {
    if (this.getRouteInfo.containsKey(urlPath)) {
      return this.getRouteInfo[urlPath];
    }
    return (req, res) {
      res.status(404);
      res.text("1234");
    };
  }
}
