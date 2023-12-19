import 'package:shelf/shelf.dart';
import 'dart:convert';
import 'package:supabase/supabase.dart';
import '../../config/supabase.dart';
import 'auth_logic.dart';

signUpHandler(Request req) async {
  try {
    final Map<String, dynamic> body = jsonDecode(await req.readAsString());

    checkBody(body: body, keys: ['email', 'password', 'phone', 'name']);

    final SupabaseClient client = SupaBaseIntegration.subaInstance;
    final String email = body['email'];
    final String password = body['password'];

    late AuthResponse user;

    await client.auth.admin
        .createUser(AdminUserAttributes(
            email: email, password: password, emailConfirm: true))
        .then((value) async {
      try {
        user = await client.auth
            .signInWithPassword(email: email, password: password);
        body.remove('password');
        body.addAll({'user_id': user.user!.id});

        await client.from('users').insert(body);
      } catch (e) {
        return Response.badRequest(body: e);
      }
    });
    return Response.ok(jsonEncode({
      "message": "Account Created Successfully",
      "token": user.session!.accessToken,
      "expires_at": user.session!.expiresAt,
      "refresh_token": user.session!.refreshToken,
      "token_type": user.session!.tokenType,
    }));
  } on AuthException catch (e) {
    return Response.badRequest(body: e.message);
  } catch (e) {
    return Response.badRequest(body: e.toString());
  }
}
