import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../configration/supabase.dart';

deleteAccountHandler(Request req) async {
  try{final jwt = JWT.decode(req.headers['token'].toString());
  final userid = await SupabaseIntegration.instance!
      .from('users')
      .select('uuid')
      .eq('email', jwt.payload['email']);

  await SupabaseIntegration.instance!
      .from('users')
      .delete()
      .eq('email', jwt.payload['email']);

  await SupabaseIntegration.instance!.auth.admin
      .deleteUser(userid.first['uuid'].toString());

  return Response.ok("${jwt.payload['email']} has deleted successfully");} catch(e) {
    return Response.badRequest(body: "Something went wrong");
  }
}
