import '../Response.dart';
import 'dart:io';

void sendHttp(Socket client, Response res) {
  client.write(res.makeHeader());

  if (res.body is List)
    client.add(res.body);
  else
    client.write(res.body);
}
