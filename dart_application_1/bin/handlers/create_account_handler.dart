import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../configration/supabase.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());
    final UserResponse user = await SupabaseIntegration.instance!.auth.admin
        .createUser(AdminUserAttributes(
            email: body['email'],
            password: body['password'],
            emailConfirm: true));

    await SupabaseIntegration.instance!.from('users').insert(
        {"name": body['name'], "email": body['email'], "uuid": user.user!.id});
    return Response.ok("Account created successfully");
  } catch (e) {
    return Response.badRequest(body: "Somthing went wrong");
  }
}


// create account => ez
// log in => ez
// add personal info
// view personal info
// delete account

//deployment
