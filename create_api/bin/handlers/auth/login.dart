import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../configs/supabase.dart';
import '../../helper/check_auth.dart';

login(Request request) async {
  try {
    final body = jsonDecode(await request.readAsString());
    List<String> key = ["email", "password"];
    await checkAuth(key: key, body: body);
    AuthResponse? user;
    final base = SupabaseNet.supabases;
    user = await base!.auth
        .signInWithPassword(password: body["password"], email: body["email"]);

    return Response.ok(
        json.encode({
          "token": user.session?.accessToken,
          "refreshToken": user.session?.refreshToken,
          "expires_at": user.session?.expiresAt
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (e) {
    return Response.badRequest(body: "ERROR!!!");
  }
}
