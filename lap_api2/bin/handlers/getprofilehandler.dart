import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../configuration/supabase.dart';

Future<Response> getProfileHandler(Request req) async {
  try {
    final supabase = SupabaseIntegration.instant;

    final String? authToken = req.headers['Authorization'];

    if (authToken == null) {
      return Response.badRequest(body: 'Authorization token is required');
    }

    final user = await supabase!.auth.getUser(authToken);


    final Map<String, String?> queryParams = req.url.queryParameters;
    final String? emailToFetch = queryParams['email'];

    if (emailToFetch == null) {
      return Response.badRequest(body: 'Email is required in the query parameters');
    }

    
    final userInfo = await supabase.from('userr').select().eq('email', emailToFetch).single();

 
    if (userInfo == null) {
      return Response.badRequest(body: 'User not found');
    }


    return Response.ok(json.encode({
      'name': userInfo['name'],
      'email': userInfo['email'],
      'age': userInfo['age'],
      'university': userInfo['university'],
    }), headers: {'Content-Type': 'application/json'});
  } catch (e) {
    return Response.badRequest(body: 'Something went wrong: ${e.toString()}');
  }
}
