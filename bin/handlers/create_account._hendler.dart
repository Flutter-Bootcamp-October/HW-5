import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../functions/body_validation.dart';
import '../globals/bodys_keys.dart';
import '../services/supabase_configretion.dart';

createAccount(Request req) async {
  try {
    final supabase = SupabaseConfigretion.supabase;
    final Map body = jsonDecode(await req.readAsString());
    bodyValidation(keysCheck: createAccountKeys, body: body);
    final createAccount =
        await supabase.auth.admin.createUser(AdminUserAttributes(
      email: body['email'],
      password: body['password'],
      emailConfirm: true,
    ));
    createAccount.user!.id;
    await supabase.from('user').insert({
      'id': createAccount.user!.id,
      'email': body['email'],
      'password': body['password'],
      'name': body['name'],
    });
    return Response.ok(
        jsonEncode({
          "email": body['email'],
          "password": body['password'],
          "msg": "'Account created successfully'"
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.ok(jsonEncode({"msg": error.message}),
        headers: {"Content-Type": "application/json"});
  } on AuthException catch (error) {
    return Response.ok(jsonEncode({"msg": error.message}),
        headers: {"Content-Type": "application/json"});
  } catch (error) {
    return Response.ok(jsonEncode({"msg": error.toString()}),
        headers: {"Content-Type": "application/json"});
  }
}
