import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../configration/subabase.dart';

profileHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    await SubabaseIntigraton.instant!.from("info").select();

    return Response.ok(
        json.encode({
          "bio": body[0],
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
