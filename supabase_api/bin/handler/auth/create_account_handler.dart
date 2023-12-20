import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../configuration/supabase_config.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    final supabase = SupabaseConfig.instant;

    List<String> keyNames = ["name", "email", "password"];
    checkBody(
        keyMap: keyNames,
        body: body,
        errorMsg: "body must have name, email, and password");

    await supabase?.auth.admin.createUser(AdminUserAttributes(
        data: {"name": body["name"]},
        email: body["email"],
        password: body["password"],
        emailConfirm: true));

    body.remove("password");
    await supabase?.from("users").insert(body);
    return Response.ok(json.encode({"message": "user created succesfuly"}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}

checkBody(
    {required List<String> keyMap,
    required Map body,
    required String errorMsg}) {
  if (body.keys.length != keyMap.length) {
    throw FormatException(errorMsg);
  }
}
