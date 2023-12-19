import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../database/supabase.dart';

profileHandler(Request req) async {
  if (req.headers["token"] != null) {
    try {
      UserResponse user =
          await SupaServices().supa.auth.getUser(req.headers["token"]);

      final profile = await SupaServices()
          .supa
          .from("users")
          .select()
          .eq("email", user.user!.email!);
      print(profile[0]);
      return Response.ok(json.encode({
        "name": profile[0]["name"],
        "email": profile[0]["email"],
        "bio": profile[0]["bio"]
      }));
    } catch (error) {
      return Response.badRequest(body: error.toString());
    }
  } else {
    return Response.badRequest(body: "request is missing token");
  }
}
