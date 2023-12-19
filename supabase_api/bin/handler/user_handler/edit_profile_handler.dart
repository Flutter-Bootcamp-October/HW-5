import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../configuration/supabase_config.dart';

editProfileHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    final supabase = SupabaseConfig.instant;
    final email = supabase?.auth.currentUser?.email;
    // final userid = supabase?.auth.currentUser?.id;

    //id, name, email, bio
    final user_name = await supabase?.from("user").select("name");
    await supabase
        ?.from("info")
        .insert({"bio": body["bio"], "email": email, "name": user_name});
    return Response.ok(
        json.encode({
          "msg": "info added sucesfuly",
          "name": user_name,
          "email": email,
          "bio": body["bio"]
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (e) {
    return Response.badRequest(body: json.encode({"error": e.message}));
  }
}
