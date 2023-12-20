import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../supabase/supabase.dart';
import '../../utils/helper/check_body.dart';

editProfleHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());
    List<String> keyNames = ["name", "email", "bio"];
    checkBody(keysCheck: keyNames, body: body);
    final supabase = SupabaseIntegration.instant;

    final userToken = await supabase!.auth.getUser(req.headers['token']);
    final uuid = userToken.user!.id;

    final resultUpdate =
        await supabase.from("users").update(body).eq("user_id", uuid);
    if (resultUpdate == null) {
      return Response.ok("The profile has been successfully modified");
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
