import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../configuration/supabase_config.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    final supabase = SupabaseConfig.instant;

    List<String> keyNames = ["email", "password", "name"];
    checkBody(
        keyMap: keyNames,
        body: body,
        errorMsg: "body must have name, email, and password");

    await supabase?.auth.admin
        .createUser(AdminUserAttributes(
            email: body["email"],
            password: body["password"],
            emailConfirm: true))
        .then((value) async {
      try {
        body.remove("password");
        print(body);
        await supabase.from("users").insert(body);
      } catch (e) {
        throw FormatException(e.toString());
      }
    });

    return Response.ok(json.encode({"message": "user created succesfuly"}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response(int.parse(error.statusCode.toString()),
        body: error.message);
  } on PostgrestException catch (error) {
    String msgError = '';
    if (error.code == "PGRST204") {
      msgError = "there is error with password";
    }
    return Response.badRequest(body: msgError);
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
