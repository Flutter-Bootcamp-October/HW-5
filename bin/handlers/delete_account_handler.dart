import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../functions/body_validation.dart';
import '../globals/bodys_keys.dart';
import '../services/supabase_configretion.dart';

deleteAccount(Request req) async {
  try {
    final body = jsonDecode(await req.readAsString());
    bodyValidation(keysCheck: deleteAccountKeys, body: body);
    print(body);
    final supabase = SupabaseConfigretion.supabase;
    final userId = supabase.auth.currentUser!.id;
    if (body['email'] == supabase.auth.currentUser!.email) {
      await supabase.from('user').delete().eq('id', userId);
      await supabase.auth.admin.deleteUser(userId);
      print(supabase.auth.currentUser!.id);
      return Response.ok(jsonEncode({"msg": "Account deleted successfully"}),
          headers: {"Content-Type": "application/json"});
    } else {
      return Response.unauthorized(body);
    }
  } on FormatException catch (error) {
    return Response.ok(jsonEncode({"msg": error.message}),
        headers: {"Content-Type": "application/json"});
    // ignore: unused_catch_clause
  } on AuthException catch (error) {
    return Response.ok(jsonEncode({"msg": error.message.toString()}),
        headers: {"Content-Type": "application/json"});
  } catch (error) {
    return Response.ok(
        jsonEncode(
            {"msg": "You do not have the authority to delete another email!"}),
        headers: {"Content-Type": "application/json"});
  }
}
