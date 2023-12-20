import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../functions/body_validation.dart';
import '../globals/bodys_keys.dart';
import '../services/supabase_configretion.dart';

editProfile(Request req) async {
  try {
    final supabase = SupabaseConfigretion.supabase;
    final body = jsonDecode(await req.readAsString());
    bodyValidation(keysCheck: editProfileKeys, body: body);
    await supabase.from('user').update({
      'name': body['name'],
      'bio': body['bio'],
    }).eq('id', supabase.auth.currentUser!.id);
    // await supabase.auth.admin.updateUserById(supabase.auth.currentUser!.id,
    //     attributes:
    //         AdminUserAttributes(email: body['email'], emailConfirm: true));

    return Response.ok(
        jsonEncode({
          "email": body['email'],
          "name": body['name'],
          "bio": body['bio'],
          "msg": "Profile edited successfully"
        }),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.ok(jsonEncode({"msg": error.message}),
        headers: {"Content-Type": "application/json"});
    // ignore: unused_catch_clause
  } on AuthException catch (error) {
    return Response.ok(jsonEncode({"msg": error.message.toString()}),
        headers: {"Content-Type": "application/json"});
  } catch (error) {
    return Response.ok(jsonEncode({"msg": "Error!"}),
        headers: {"Content-Type": "application/json"});
  }
}
