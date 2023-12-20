import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../configration/subabase.dart';
import '../helper/check_body.dart';

editeProfileHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    List<String> KeyName = ["email", "name", "bio"];
    checkBody(Keycheck: KeyName, body: body);
    final supabase = SubabaseIntigraton.instant;

    await supabase!.from("info").insert(body);

    return Response.ok(
        json.encode({
          "msg": "Information has successfully inserted",
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
