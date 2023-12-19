import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../database/supabase.dart';

createHandler(Request req) async {
  final Map body = await jsonDecode(await req.readAsString());
  if (body["name"] != null &&
      body["email"] != null &&
      body["password"] != null) {
    try {
      await SupaServices().supa.auth.admin.createUser(AdminUserAttributes(
          email: body["email"],
          password: body["password"],
          emailConfirm: true));
      body.remove("password");
      await SupaServices().supa.from('users').insert(body);
      return Response.ok("account was created successfuly");
    } catch (error) {
      return Response.badRequest(body: "could not create account");
    }
  } else {
    return Response.badRequest(body: "request is incomplete");
  }
}
