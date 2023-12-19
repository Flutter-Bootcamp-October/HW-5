import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';

editProfileHandler(Request req) async {
  try {
    final body = jsonDecode(await req.readAsString());
    final supabase = SupabaseIntegration.instant;
    

    final auth = await supabase!.auth.getUser(req.headers['token']);
    final id = auth.user!.id;
    await supabase
        .from('profile')
        .update(body)
        .eq('id_user', id)
        .select();

    return Response.ok(
      json.encode({'msg': 'updated successfully'}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response(int.parse(error.statusCode.toString()),
        body: error.message);
  } on PostgrestException catch (error) {
    String msgError = '';
    if (error.code == 'PGRST204') {
      msgError = 'There is an error with the password';
    }
    return Response.badRequest(body: msgError);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
