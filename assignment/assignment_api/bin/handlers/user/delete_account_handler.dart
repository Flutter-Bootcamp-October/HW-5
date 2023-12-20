import 'package:shelf/shelf.dart';

import '../../supabase/supabase.dart';

deleteAccountHandler(Request req) async {
  try {
    final supabase = SupabaseIntegration.instant;
    final userToken = await supabase!.auth.getUser(req.headers['token']);
    final uuid = userToken.user!.id;
    await supabase.from("users").delete().eq("user_id", uuid);
    await supabase.auth.admin.deleteUser(uuid);
    return Response.ok("Account successfully delete");
  } catch (err) {
    return Response.badRequest(body: err.toString());
  }
}
