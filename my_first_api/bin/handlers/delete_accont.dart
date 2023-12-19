import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../config/supabase.dart';

deleteAccountHandler(Request req) async {
  try {
    final mybody = jsonDecode(await req.readAsString());
    //if (!mybody.containsKey('session')) throw Exception("Invalid request");
    
    
    final UserResponse user = UserResponse.fromJson(mybody);
    SupaBaseIntegration().deleteUser(user: user);
    return Response.ok("Account Deleted Successfully");
  } catch (err) {
    return Response.badRequest(body: err.toString());
  }
}
