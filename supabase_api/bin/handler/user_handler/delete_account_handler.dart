import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../configuration/supabase_config.dart';

deleteAccountHandler(Request req) async {
  try {
    final supabase = SupabaseConfig.instant;
    final userid = await supabase?.from("users").select("id");
    final email = userid?.first[0];

    print(email);

    await supabase?.from("users").delete().eq('id', userid!);
    await supabase?.auth.admin.deleteUser(email);
    return Response.ok(json.encode({"message": "user deleted succesfuly"}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (e) {
    return Response.badRequest(body: e.toString());
  }
}
