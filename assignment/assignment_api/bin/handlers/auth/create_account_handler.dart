import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../supabase/supabase.dart';
import '../../utils/helper/check_body.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());

    List<String> keyNames = ["name", "email", "password"];

    await checkBody(body: body, keysCheck: keyNames);

    final supabase = SupabaseIntegration.instant;
    AuthResponse? user;

    final createUserResponse =
        await supabase!.auth.admin.createUser(AdminUserAttributes(
      email: body["email"],
      password: body["password"],
      emailConfirm: true,
    ));

    if (createUserResponse != null) {
      user = await supabase.auth.signInWithPassword(
        password: body["password"],
        email: body["email"],
      );

      body.remove("password");
      Map<dynamic, dynamic> bodyData = {
        "name": body['name'],
        "email": body['email'],
        "user_id": user.user!.id
      };
      await supabase.from('users').insert(bodyData);

      return Response.ok("Account successfully created");
    } else {
      return Response.internalServerError(body: "Failed to create user");
    }
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
