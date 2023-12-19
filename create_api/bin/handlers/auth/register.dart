import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configs/supabase.dart';
import '../../helper/check_auth.dart';

register(Request request) async {
  try {
    final Map body = jsonDecode(await request.readAsString());
    List<String> key = ["email", "password", "phone", "username"];
    await checkAuth(key: key, body: body);

    final base = SupabaseNet.supabases;
    await base?.auth.admin
        .createUser(AdminUserAttributes(
            email: body["email"],
            password: body["password"],
            emailConfirm: true))
        .then((value) async {
      body.remove("password");
      await base.from('user_api').insert({...body, "id_auth": value.user!.id});
    });

    return Response.ok(jsonEncode({"msg": "Success create account "}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (e) {
    print(e);
    return Response.badRequest(body: e.toString());
  }
}
