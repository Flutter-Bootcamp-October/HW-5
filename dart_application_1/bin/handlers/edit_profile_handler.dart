import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../configration/supabase.dart';

editProfileHandler(Request req) async {
  try {
    final body = jsonDecode(await req.readAsString());
    final jwt = JWT.decode(req.headers['token'].toString());
    final userid = await SupabaseIntegration.instance!
        .from('users')
        .select('uuid')
        .eq('email', jwt.payload['email']);

    await SupabaseIntegration.instance!
        .from('users')
        .update(body)
        .eq('email', jwt.payload['email']);
    await SupabaseIntegration.instance!.auth.admin.updateUserById(
        userid.first['uuid'].toString(),
        attributes: AdminUserAttributes(email: body['email']));
    return Response.ok("seccessfully updated");
  } catch (e) {
    return Response.badRequest(body: "something went wrong");
  }
}
