// import 'dart:convert';

import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../services/supabase_configretion.dart';

Middleware checkAuthority() => ((innerHandler) => (Request req) async {
      try {
        final token =
            SupabaseConfigretion.supabase.auth.currentSession!.accessToken;
        if (req.headers['token'] != null && req.headers['token'] == token) {
          return innerHandler(req);
        }
        return Response.unauthorized(
            jsonEncode(
                {"msg": "You do not have an authority for this endpoint"}),
            headers: {"Content-Type": "application/json"});
      } catch (error) {
        return Response.unauthorized('ERROR!!');
      }
    });
