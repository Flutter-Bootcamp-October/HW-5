import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../configration/subabase.dart';
import '../helper/check_body.dart';

loginHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    List<String> KeyName = [
      "email",
      "password",
    ];
    checkBody(Keycheck: KeyName, body: body);
    final supabase = SubabaseIntigraton.instant;
    AuthResponse? user;
    user = await supabase?.auth
        .signInWithPassword(password: body["password"], email: body["email"]);

    return Response.ok(
        json.encode({
          "msg": "Login has successfully",
          "token": user?.session?.accessToken,
          "refreshToken": user?.session?.refreshToken,
          "expiresAt": user?.session?.expiresAt
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
