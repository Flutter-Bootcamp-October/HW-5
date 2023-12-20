import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../config/supabase_config.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    // print(body);
    final supabase = SupabaseIntegration.instant;
    await supabase!.auth.admin
        .createUser(AdminUserAttributes(
            email: body["email"],
            password: body["password"],
            userMetadata: {"name": body["name"]},
            emailConfirm: true))
        .then((value) async {
      try {
        await supabase.from("users").insert(body);
      } catch (error) {
        return Response.badRequest(body: error.toString());
      }
    });

    return Response.ok("Create account successfully");
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
