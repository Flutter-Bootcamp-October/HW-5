import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../configuration/supabase.dart';

Future<Response> profileHandler(Request req) async {
  try {
    final supabase = SupabaseIntegration.instant;

    final Map<String, dynamic> body = json.decode(await req.readAsString());

    final String? authToken = req.headers['Authorization'];

    if (authToken == null) {
      return Response.badRequest(body: 'Authorization token is required');
    }

    final user = await supabase!.auth.getUser(authToken);

    if (!body.containsKey('email')) {
      return Response.badRequest(body: 'Email is required in the request body');
    }

    final emailToMatch = body['email'];
    final existingUser = await supabase
        .from('userr')
        .update({'age': body['age'], 'university': body['university']}).eq(
            'email', emailToMatch);

    if (existingUser == null) {
      return Response.ok("Profile added successfully");
    }

    if (existingUser.error != null) {
      return Response.badRequest(body: 'Error update: ${existingUser.error}');
    }

    return Response.ok('Profile updated successfully');
  } catch (e) {
    return Response.badRequest(body: 'Something went wrong: ${e.toString()}');
  }
}

