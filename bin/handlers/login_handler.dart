import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../functions/body_validation.dart';
import '../globals/bodys_keys.dart';
import '../services/supabase_configretion.dart';

login(Request req) async {
  try {
    final body = jsonDecode(await req.readAsString());
    bodyValidation(keysCheck: loginKeys, body: body);
    final supabase = SupabaseConfigretion.supabase;
    await supabase.auth
        .signInWithPassword(email: body['email'], password: body['password']);
    final token = supabase.auth.currentSession!.accessToken;
    final refreshToken = supabase.auth.currentSession!.refreshToken;
    return Response.ok(
        jsonEncode({
          "token": token,
          "refresh_token": refreshToken,
          "msg": "'Logged in successfully'"
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.ok(jsonEncode({"msg": error.message}),
        headers: {"Content-Type": "application/json"});
    // ignore: unused_catch_clause
  } on AuthException catch (error) {
    return Response.ok(jsonEncode({"msg": "Email or password incorrect!"}),
        headers: {"Content-Type": "application/json"});
  } catch (error) {
    return Response.ok(jsonEncode({"msg": error.toString()}),
        headers: {"Content-Type": "application/json"});
  }
}
