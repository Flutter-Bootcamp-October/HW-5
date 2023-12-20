import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../supabase/supabase.dart';
import '../../utils/helper/check_body.dart';

loginHandler(Request req) async {
  try {
    final body = json.decode(await req.readAsString());

    List<String> keyNames = ["email", "password"];
    checkBody(body: body, keysCheck: keyNames);

    final supabase = SupabaseIntegration.instant;
    AuthResponse? user;

    user = await supabase!.auth
        .signInWithPassword(password: body["password"], email: body["email"]);

    String? token = user.session?.accessToken;

    print(token);
    return Response.ok(
        json.encode({
          "msg": "Login successfully",
          "token": token,
          "refreshToken": user.session?.refreshToken,
        }),
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
