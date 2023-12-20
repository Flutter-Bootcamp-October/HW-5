import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../configuration/supabase_config.dart';

profileHandler(Request req) async {
  try {
    final supabase = SupabaseConfig.instant;

    //id, name, email, bio
    final user_name = await supabase?.from("user").select("name");
    final info = await supabase?.from("info").select("*");
    return Response.ok(json.encode({"info": info}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (e) {
    return Response.badRequest(body: json.encode({"error": e.message}));
  }
}
