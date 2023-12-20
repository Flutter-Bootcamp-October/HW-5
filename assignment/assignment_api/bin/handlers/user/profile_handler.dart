import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../supabase/supabase.dart';

profleHandler(Request req) async {
  //select from database
//take token

  try {
    final supabase = SupabaseIntegration.instant;

    final userToken = await supabase!.auth.getUser(req.headers['token']);
    final uuid = userToken.user!.id;

    final resultUpdate =
        await supabase.from("users").select().eq("user_id", uuid);
    print(resultUpdate.remove(resultUpdate.first['user_id']));
    print(resultUpdate);
    if (resultUpdate.isNotEmpty) {
      return Response.ok(
          json.encode({
            "name": resultUpdate.first['name'],
            "email": resultUpdate.first['email'],
            "bio": resultUpdate.first['bio'],
          }),
          headers: {"Content-Type": "application/json"});
    } else {
      return Response.badRequest(body: "You are not authorized");
    }
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException {
    return Response.badRequest(body: "You are not authorized");
  } catch (error) {
    return Response.badRequest(body: "error $error");
  }
}
