import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../database/supabase.dart';

editHandler(Request req) async {
  if (req.headers["token"] != null) {
    final Map body = await jsonDecode(await req.readAsString());
    try {
      UserResponse user =
          await SupaServices().supa.auth.getUser(req.headers["token"]);
      final profile = await SupaServices()
          .supa
          .from("users")
          .select()
          .eq("email", user.user!.email!);
      await SupaServices()
          .supa
          .from("users")
          .update(body)
          .eq("id", profile[0]["id"]);
      print(profile[0]);
      return Response.ok("updated successfuly");
    } catch (error) {
      return Response.badRequest(body: error.toString());
    }
  } else {
    return Response.badRequest(body: "request is missing token");
  }
}
