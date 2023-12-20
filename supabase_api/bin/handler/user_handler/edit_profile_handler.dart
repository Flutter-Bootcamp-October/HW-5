import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../configuration/supabase_config.dart';

editProfileHandler(Request req) async {
  //done
  try {
    final Map body = json.decode(await req.readAsString());
    final supabase = SupabaseConfig.instant;

    //id, name, email, bio
    final userName = await supabase?.from("users").select("name");
    final userEmail = await supabase?.from("users").select("email");

    await supabase
        ?.from("info")
        .insert({"bio": body["bio"], "email": userEmail, "name": userName});
    return Response.ok(
        json.encode({
          "msg": "info added sucesfuly",
          "name": userName,
          "email": userEmail,
          "bio": body["bio"]
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (e) {
    return Response.badRequest(body: json.encode({"error": e.message}));
  }
}
