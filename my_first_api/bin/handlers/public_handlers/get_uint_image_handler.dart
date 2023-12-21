import 'dart:convert';

import 'package:shelf/shelf.dart';

getUintImageHandler(Request req) async {
  try {
    final bytes = await req.read().toList();
    print(bytes);
    return Response.ok(bytes.first.toString());
  } catch (err) {
    return Response.badRequest(body: err);
  }
}
