import 'package:shelf/shelf.dart';

import '../../config/supabase_config.dart';

profilleHandler(Request req) async {
  try {
    final supabase = SupabaseIntegration.instant;

    final profileData = await supabase!
        .from("users")
        .select("*")
        .eq("id", supabase.auth.currentUser!.id);
    return Response.ok("$profileData");
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
