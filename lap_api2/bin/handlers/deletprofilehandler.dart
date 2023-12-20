
import 'package:shelf/shelf.dart';
import '../configuration/supabase.dart';

Future<Response> deleteProfileHandler(Request req) async {
  try {
    final supabase = SupabaseIntegration.instant;

    final String? authToken = req.headers['Authorization'];

    if (authToken == null) {
      return Response.badRequest(body: 'Authorization token is required');
    }

    // Check if the 'email' field is present in the request query parameters
    final Map<String, String?> queryParams = req.url.queryParameters;
    final String? emailToDelete = queryParams['email'];

    if (emailToDelete == null) {
      return Response.badRequest(
          body: 'Email is required in the parameters');
    }

 
    final deleteResult =
        await supabase?.from('userr').delete().eq('email', emailToDelete);

 
    return Response.ok('Profile deleted successfully');
  } catch (e) {
    return Response.badRequest(body: 'Something went wrong');
  }
}


