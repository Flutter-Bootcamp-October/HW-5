import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../config/supabase_config.dart';

loginHandler(Request req) async {
  try {
    final body = json.decode(await req.readAsString());

    final supabase = SupabaseIntegration.instant;
    AuthResponse? user;

    user = await supabase?.auth
        .signInWithPassword(email: body["email"], password: body["password"]);

    return Response.ok(json.encode({
      "msg": "Login successfully",
      "token": user?.session?.accessToken,
      "refreshToken": user?.session?.refreshToken,
    }));
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
