import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../configration/supabase.dart';

loginHandler(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());
    final user = await SupabaseIntegration.instance!.auth
        .signInWithPassword(email: body['email'], password: body['password']);
    return Response.ok(
        'token: ${user.session!.accessToken}, refresh_token: ${user.session!.refreshToken}');
  } catch (e) {
    return Response.badRequest(body: e.toString());
  }
}
