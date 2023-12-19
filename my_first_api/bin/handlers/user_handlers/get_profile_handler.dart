import 'package:shelf/shelf.dart';
import 'dart:convert';
import 'package:supabase/supabase.dart';
import '../../config/supabase.dart';

getProfileHandler(Request req) async {
  try {
    final UserResponse user = await SupaBaseIntegration()
        .getUserByToken(token: req.headers['token']!);

    final List<Map<String, dynamic>> res = await SupaBaseIntegration()
        .getFromTable(tableName: 'profile', user: user);

    final List<Map<String, dynamic>> userName = await SupaBaseIntegration()
        .getFromTable(tableName: 'users', user: user);

    res.first.remove('user_id');
    res.first.addAll({
      'name': userName.first['name'],
      'email': user.user!.email,
    });

    return Response.ok(jsonEncode(res.first));
  } catch (err) {
    return Response.ok(err.toString());
  }
}
