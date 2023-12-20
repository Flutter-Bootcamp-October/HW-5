import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../configration/subabase.dart';
import '../helper/check_body.dart';

createHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    List<String> KeyName = [
      "email",
      "password",
      "phone",
      "first_name",
      "last_name"
    ];
    checkBody(Keycheck: KeyName, body: body);
    final supabase = SubabaseIntigraton.instant;
    AuthResponse? user;
    await supabase!.auth.admin
        .createUser(AdminUserAttributes(
            password: body["password"],
            email: body["email"],
            emailConfirm: true))
        .then((value) async {
      try {
        user = await supabase.auth.signInWithPassword(
            password: body["password"], email: body["email"]);

        // body.remove("password");

        await supabase.from('users').insert(body);
      } catch (error) {
        print(error);
        throw FormatException("here is error");
      }
    });

    return Response.ok(
        json.encode({
          "msg": "Account successfully created",
          "token": user?.session?.accessToken,
          "refreshToken": user?.session?.refreshToken,
          "expiresAt": user?.session?.expiresAt
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
