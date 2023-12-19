import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../configration/supabase.dart';

profileHandler(Request req) async {
  try {
    final jwt = JWT.decode(req.headers['token'].toString());
    final info = await SupabaseIntegration.instance!
        .from('users')
        .select()
        .eq('email', jwt.payload['email']);
    return Response.ok(
        'name: ${info.first['name']}, email: ${info.first['email']}, bio: ${info.first['bio']}');
  } catch (e) {
    return Response.badRequest(body: "Something went wrong ${e.toString()}");
  }
}
