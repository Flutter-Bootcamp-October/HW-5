import 'package:shelf/shelf.dart';

import '../database/supabase.dart';

homeHandler(Request req) async {
  print("here");
  try {
    final x = await SupaServices().supa.from("todos").insert("").select();
    print(x);
    return Response.ok(req.requestedUri.toString());
  } catch (error) {
    print("here");
    print(error.toString());
    return Response.badRequest();
  }
}
