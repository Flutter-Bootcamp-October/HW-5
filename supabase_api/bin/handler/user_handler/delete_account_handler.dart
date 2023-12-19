import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../configuration/supabase_config.dart';

deleteAccountHandler(Request req) async {
  try {
    final supabase = SupabaseConfig.instant;
    final userid = supabase?.auth.currentUser?.id;

    await supabase?.from("users").delete().eq('id', userid!);
    await supabase?.auth.admin.deleteUser(userid!);
    return Response.ok(json.encode({"message": "user deleted succesfuly"}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  }
}
