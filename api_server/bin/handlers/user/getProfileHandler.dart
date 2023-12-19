import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';

getProfileHandler(Request req) async {
  try {
    final supabase = SupabaseIntegration.instant;
    final auth = await supabase!.auth.getUser(req.headers['token']);
    final id = auth.user!.id;
    final userData = await supabase.from('profile').select().eq('id_user', id);

    return Response.ok(
        json.encode({"msg": "get data successfully", "data": userData}),
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
