import 'package:shelf/shelf.dart';
import 'dart:convert';
import 'package:supabase/supabase.dart';
import '../../config/supabase.dart';

getPublicDataHandler(Request req) async {
  try {
    final List<Map<String, dynamic>> res =
        await SupaBaseIntegration().getFromPublicTable(tableName: 'teacher');

    return Response.ok(jsonEncode(res),
        headers: {"Content-Type": "application/json"});
  } catch (err) {
    return Response.ok(err.toString());
  }
}
