import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../config/supabase.dart';

Middleware checkToken() => (innerHandler) => (Request req) async {
      try {
        final SupabaseClient client = SupaBaseIntegration.subaInstance;
        await client.auth.getUser(req.headers['token']);
        return innerHandler(req);
      } catch (err) {
        return Response.unauthorized(
            "Token is Not Correct or Unavailable -- Try Adding [token] in Headers");
      }
    };
