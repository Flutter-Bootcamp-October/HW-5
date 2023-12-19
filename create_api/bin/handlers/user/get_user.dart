import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../configs/supabase.dart';

users(Request request) async {
  try {
    final user = SupabaseNet.supabases;
    final body =
        await SupabaseNet.supabases!.auth.getUser(request.headers["token"]);
    final getUser = await user
        ?.from("user_api")
        .select()
        .eq("id_auth", body.user!.id.toString());
    print(getUser);
    return Response.ok(jsonEncode(getUser),
        headers: {"Content-Type": "application/json"});
  } catch (e) {
    return Response.badRequest(
        body: jsonEncode({"meg": "token is invalid"}),
        headers: {"Content-Type": "application/json"});
  }
}
