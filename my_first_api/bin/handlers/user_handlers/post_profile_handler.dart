import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../config/supabase.dart';
import '../auth_handlers/logic/check_body.dart';

postProfileHandler(Request req) async {
  try {
    final Map<String, dynamic> body = jsonDecode(await req.readAsString());
    checkBody(keys: ['skills', 'bio'], body: body);

    //Get user object
    final UserResponse user = await SupaBaseIntegration()
        .getUserByToken(token: req.headers['token']!);

    //update user profile in [profile] table
    SupaBaseIntegration()
        .updateFromTable(tableName: 'profile', body: body, user: user);

    return Response.ok("Profile Updated");
  } on PostgrestException catch (err) {
    return Response.badRequest(
        body: "${err.message} -- try making the field [skills] as list");
  } catch (err) {
    return Response.ok(err.toString());
  }
}
