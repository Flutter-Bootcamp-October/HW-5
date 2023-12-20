import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../configration/subabase.dart';
import '../helper/check_body.dart';

deleteAccountHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    List<String> KeyName = ["email"];
    checkBody(Keycheck: KeyName, body: body);
    AuthResponse? user;
SubabaseIntigraton.instant!.from("users").select().eq("email", user!.user!.email!);

    await SubabaseIntigraton.instant!.auth.admin.deleteUser(user.user!.id).then((value) async {
      try {
        await SubabaseIntigraton.instant!.from('users').delete().eq("email", user.user!.email!);
      } catch (error) {
        print(error);
        throw FormatException("here is error");
      }
    });

    return Response.ok(
        json.encode({
          "msg": "Account has successfully deleted",
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
