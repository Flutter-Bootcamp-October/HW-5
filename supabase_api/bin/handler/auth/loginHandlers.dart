import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../configuration/supabase_config.dart';
import 'create_account_handler.dart';

loginHandler(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    List<String> keyNames = ["email", "password"];
    checkBody(keyMap: keyNames, body: body, errorMsg: 'login invalid');

    final supabase = SupabaseConfig.instant;
    AuthResponse? user;

    user = await supabase?.auth
        .signInWithPassword(password: body["password"], email: body["email"]);

    return Response.ok(
        json.encode({
          "token": user?.session?.accessToken,
          "refreshToken": user?.session?.refreshToken,
          "msg": "sucsess login",
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
