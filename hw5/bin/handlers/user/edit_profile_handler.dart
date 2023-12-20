import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../config/supabase_config.dart';

editHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    final supabase = SupabaseIntegration.instant;
    await supabase!.from("users").update({
      "name": body["name"],
      "email": body["email"],
      "bio": body["bio"]
    }).eq("id", supabase.auth.currentUser!.id);
    return Response.ok("Your account update successfully");
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
