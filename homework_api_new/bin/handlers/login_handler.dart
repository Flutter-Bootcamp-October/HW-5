import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../database/supabase.dart';

loginHandler(Request req) async {
  final Map body = await jsonDecode(await req.readAsString());
  if (body["email"] != null && body["password"] != null) {
    try {
      AuthResponse user = await SupaServices()
          .supa
          .auth
          .signInWithPassword(password: body["password"], email: body["email"]);
      return Response.ok(
          json.encode({
            "token": user.session!.accessToken,
            "refreshToken": user.session!.refreshToken,
            "expires_at": user.session!.expiresAt
          }),
          headers: {"Content-Type": "application/json"});
    } on AuthException catch (error) {
      return Response(int.parse(error.statusCode.toString()),
          body: error.message);
    } catch (error) {
      return Response.badRequest(body: "rejected login attempt");
    }
  } else {
    return Response.badRequest(body: "request is incomplete");
  }
}
